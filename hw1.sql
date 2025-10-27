CREATE TABLE students (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    birthday DATETIME NULL
);

CREATE TABLE subjects (
    id    INT AUTO_INCREMENT PRIMARY KEY,
    name  VARCHAR(30) NOT NULL,
    hours SMALLINT NULL
);

CREATE TABLE marks (
    stud_id  INT,
    subj_id  INT,
    ddate    datetime default NOW(),
    mark     TINYINT CHECK (mark > 1 AND mark <= 5),
    FOREIGN KEY (stud_id) REFERENCES students(id),
    FOREIGN KEY (subj_id) REFERENCES subjects(id)
);
