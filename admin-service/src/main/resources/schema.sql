CREATE TABLE IF NOT EXISTS admin.administrator (
    admin_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    role CHAR(5) NOT NULL ,
    name VARCHAR(16) NOT NULL ,
    email VARCHAR(100) NOT NULL,
    login_id VARCHAR(100) NOT NULL,
    login_pw VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS admin.inquire (
    inquire_id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    inquirer_id BIGINT NOT NULL ,
    inquire_type TINYINT(1) NOT NULL ,
    inquire_text TEXT NOT NULL,
    is_completed BOOLEAN NOT NULL ,
    created_at TIMESTAMP NOT NULL ,
    updated_at TIMESTAMP NULL
);

CREATE TABLE IF NOT EXISTS admin.reply (
    inquire_id BIGINT NOT NULL PRIMARY KEY ,
    admin_id BIGINT NOT NULL,
    reply TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NULL
);