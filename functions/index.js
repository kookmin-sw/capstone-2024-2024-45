const functions = require("firebase-functions");
const admin = require("firebase-admin");
const auth = require('firebase-auth');

var serviceAccount = require("./kepstone-9eb20-firebase-adminsdk-ede2s-2e983bc917.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

 exports.createCustomToken = functions.https.onRequest(async(request, response) => {
    const user = request.body;
    pinrt(user.id);
    // firbase에 user가 추가되고 userid를 가지고 token을 만들어줌.
    const uid = 'kakao:${user.uid}';
    const updateParams = {
        email : user.email,
        displayName : user.displayName,
    }
    try{
    // 기존 user들은 정보 업데이트만
        await admin.auth().updateUser(uid, updateParams);
    }catch (e){
    // id 없는 user들은 여기로
        updateParams['uid'] = uid ;
        await admin.auth().createUser(updateParams);
    }

    // uid로 등록된 사용자의 token을 만들어줌
    const token = await admin.auth().createCustomToken(uid);
    response.send(token);
 });
