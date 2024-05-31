CREATE TABLE IF NOT EXISTS transaction_history.transactionhistory (
      trans_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      sender_account_id CHAR(36) NOT NULL ,
      receiver_account_id CHAR(36) NOT NULL ,
      amount INT NOT NULL ,
      sender_user_id CHAR(36) NOT NULL ,
      sender_balance_after INT NOT NULL ,
      receiver_balance_after INT NOT NULL ,
      created_at TIMESTAMP NOT NULL,
      is_success TINYINT(1) NOT NULL
);

CREATE TABLE IF NOT EXISTS transaction_history.remittancemanage (
    trans_id BIGINT NOT NULL PRIMARY KEY ,
    admin_id INT NOT NULL ,
    comment TEXT NOT NULL
);

