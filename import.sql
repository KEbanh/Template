-- Amazing SQL
-- http://amazing-sql.com
-- Datensaetze fuer die beiden Ansichten "Freie Eingabe" und "Uebungen"

CREATE TABLE professoren(
  id          INT         NOT NULL PRIMARY KEY,
  nachname    VARCHAR(32) NOT NULL,
  vorname     VARCHAR(32),
  raum        VARCHAR(8),
  email       VARCHAR(50)
);

CREATE TABLE vorlesungen(
  id                INT         NOT NULL PRIMARY KEY,
  titel             VARCHAR(50) NOT NULL,
  semester          SMALLINT,
  vorlesungsstunden SMALLINT,
  projektstunden    SMALLINT,
  ects              SMALLINT,
  verantwortlicher  INT,
  CONSTRAINT  verantwortlicher_fkey FOREIGN KEY(verantwortlicher) REFERENCES professoren(id)
  ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT  semesteranzahl CHECK (semester > 0 AND semester <= 8)
);

CREATE TABLE assistenten(
  id                     INT         NOT NULL PRIMARY KEY,
  nachname               VARCHAR(32) NOT NULL,
  vorname                VARCHAR(32),
  raum                   VARCHAR(8) ,
  email                  VARCHAR(50),
  verantwortungsbereich  VARCHAR(50),
  arbeitet_fuer          INT,
  CONSTRAINT  assistenten_arbeitet_fuer_fk FOREIGN KEY(arbeitet_fuer) REFERENCES professoren(id)
  ON UPDATE NO ACTION ON DELETE SET NULL
);

CREATE TABLE studenten(
  id          INT         NOT NULL PRIMARY KEY,
  nachname    VARCHAR(32) NOT NULL,
  vorname     VARCHAR(32),
  semester    SMALLINT,
  email       VARCHAR(50),
  geboren     DATE,
  CONSTRAINT studenten_semester_check CHECK (semester > 0 AND semester < 30)
);

CREATE TABLE hoeren(
  student    INT   NOT NULL,
  vorlesung  INT   NOT NULL,
  CONSTRAINT hoeren_student_fk FOREIGN KEY(student) REFERENCES studenten(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT hoeren_vorlesung_fk FOREIGN KEY(vorlesung) REFERENCES vorlesungen(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  UNIQUE(student, vorlesung)
);

CREATE TABLE pruefungen(
  student    INT   NOT NULL,
  vorlesung  INT   NOT NULL,
  note       float,
  terminiert date  NOT NULL,
  CONSTRAINT pruefungen_student_fk FOREIGN KEY(student) REFERENCES studenten(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT pruefungen_vorlesung_fk FOREIGN KEY(vorlesung) REFERENCES  vorlesungen(id)
  ON UPDATE RESTRICT ON DELETE NO ACTION,
  CONSTRAINT gueltige_deutsche_note CHECK (note = 1.0 OR note = 1.3 OR note = 1.7 OR note = 2.0 OR note = 2.3 OR note = 2.7 OR note = 3.0 OR note = 3.3 OR note = 3.7 OR note = 4.0 OR note = 4.3 OR note = 4.7 OR note = 5.0),
  UNIQUE(student, vorlesung, terminiert)
);

CREATE TABLE  thesis(
  student        INT          NOT NULL UNIQUE,
  betreuer       INT          NOT NULL,
  titel          VARCHAR(255),
  dokumenttyp    VARCHAR(4),
  dokumentname   VARCHAR(255),
  dokumentquelle VARCHAR(255),
  CONSTRAINT thesis_student_fk FOREIGN KEY(student) REFERENCES studenten(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT thesis_betreuer_fk FOREIGN KEY(betreuer) REFERENCES professoren(id)
  ON UPDATE RESTRICT ON DELETE NO ACTION
);

CREATE TABLE vorlesungs_reihenfolge(
  pre  INT     NOT NULL,
  post INT     NOT NULL,
  CONSTRAINT vorlesungs_reihenfolge_pre_fk FOREIGN KEY(pre) REFERENCES vorlesungen(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT vorlesungs_reihenfolge_post_fk FOREIGN KEY(post) REFERENCES vorlesungen(id)
  ON UPDATE RESTRICT ON DELETE CASCADE,
  UNIQUE(pre, post)
);

INSERT INTO professoren (id, nachname, vorname, raum, email)
VALUES (1001, 'Permanent', 'Gerald', 'A513', 'permanent@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email)
VALUES (1002, 'Foerster', 'Ulrike', 'E215', 'foerster.jaeger@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email)
VALUES (1003, 'Donut', 'Jürgen', 'E209', 'donut@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1004, 'Winkel', 'Jörg', 'A317', 'winkel@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1006, 'Ballert', 'Kurt', 'A217', 'kurt.ballert@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1009, 'Bunz', 'Tomas', 'E215', 'bunz@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1010, 'Rick', 'M. A. Stephen', 'Z115', 'rick@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1011, 'Baumann', 'Hans', 'A114', 'baumann@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1012, 'Boeller', 'H.', 'A304', 'boeller@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1013, 'Pferdfluesterer', 'Reinhard', 'C049', 'pferdfluesterer@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1016, 'Titan', 'Volker', 'E209', 'titan@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1017, 'Beck', 'Christine', 'E210', 'beck@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1018, 'Reinz', 'Alois', 'E210', 'reinz@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1019, 'Mars', 'Nicola', 'A317', 'mars@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1020, 'Jungberg', 'Dominikus', 'E206', 'jungberg@fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1021, 'Tichykowski', 'Barbara', NULL ,NULL);

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1022, 'Mansche', 'Uli', NULL, 'mansche@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1023, 'Völler', 'Miriam', NULL, 'voeller@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1024, 'Runder', 'Christoph', NULL, 'runder@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1050, 'Sange', 'Livia', 'B200', 'sange@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1051, 'Krausse', 'Tobias', NULL, 'krausse@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1052, 'Bass', 'Roland', NULL, 'bass@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1053, 'Schach', 'Steffen', NULL, 'schach@external.fh-heiligenbrunn.de');

INSERT INTO professoren (id, nachname, vorname, raum, email) 
VALUES (1054, 'Rom', 'Marcus', NULL, 'rom@external.fh-heiligenbrunn.de');

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261001, 'Grundlagen der Informatik 1', 1, 2, 0, 2, 1018);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261002, 'Grundlagen der Informatik 2', 1, 4, 0, 4, 1020);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261003, 'Interaktive Programme', 1, 2, 4, 8, 1002);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261004, 'Komplexe Programme', 2, 2, 2, 6, 1018);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261005, 'Grundlagen des Software Engineering 1', 1, 4, 0, 4, 1001);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261006, 'Grundlagen des Software Engineering 2', 2, 4, 0, 4, 1001);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261007, 'Betriebssysteme', 2, 2, 0, 2, 1018);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261009, 'Logik und Künstliche Intelligenz', 2, 4, 0, 4, 1006);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261012, 'IT-Englisch', 1, 4, 0, 4, 1010);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261013, 'Signalverarbeitung 1', 2, 4, 2, 6, 1003);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261014, 'Grundlagen betriebswirtschaftlicher Prozesse', 1, 4, 0, 4, 1009);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261017, 'Arbeitstechniken IT', 1, 2, 0, 2, 1019);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261024, 'Datensicherheit und Kryptographie', 2, 2, 0, 2, 1051);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261026, 'Weiterführende Programmiersprachen', 2, 2, 2, 4, 1001);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261028, 'Media Basics', 2, 4, 0, 4, 1052);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261034, 'Ethik in der IT', 1, 2, 0, 2, 1019);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261051, 'Personal Productivity', 3, 2, 2, 4, 1020);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261052, 'Algorithmen und Datenstrukturen', 3, 2, 2, 4, 1018);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261055, 'Grundlagen verteilter Systeme', 4, 2, 4, 6, 1004);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261056, 'Lineare Algebra und Computergrafik', 3, 4, 0, 6, 1016);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261057, 'Signalverarbeitung 2', 3, 2, 0, 2, 1003);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261058, 'Datenbanken 1', 3, 2, 2, 4, 1002);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261061, 'Software Engineering komplexer Systeme', 3, 4, 0, 4, 1020);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261063, 'Projektmanagement und Tools des SE', 3, 4, 2, 8, 1001);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261072, 'Teambetreuung', 7, 2, 0, 2, 1019);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261074, 'Recht in der IT', 7, 2, 0, 2, 1054);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261075, 'Moderationstraining', 7, 2, 0, 2, 1019);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261081, 'Labor für Software-Projekte', 4, 2, 8, 10, 1001);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261124, 'Business Applications', 6, 4, 0, 4, 1017);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261143, 'System- und Netzwerk-Management', 4, 2, 0, 2, 1023);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261146, 'Moderne verteilte Systeme', 6, 2, 2, 4, 1004);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261159, 'Bachelor Kolloquium', 7, 2, 0, 4, 1017);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261163, 'Groupware', 6, 2, 0, 2,1053);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261164, 'Ausgewählte Kapitel des SE', 6, 4, 0, 6, 1020);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261168, 'Management in der Software-Entwicklung', 7, 2, 0, 2, 1019);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261179, 'Datenbank-Spezialisierungen', 7, 4, 0, 4, 1002);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261180, 'Datenbanktechnologie', 4, 2, 0, 2, 1002);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261196, 'Mathematische Modellierung und Simulation', 4, 4, 2, 6, 1003);

INSERT INTO vorlesungen (id, titel, semester, vorlesungsstunden, projektstunden, ects, verantwortlicher)
VAlUES (261197, 'Mustererkennung', 6, 6, 0, 6, 1016);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261001, 261002);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261005, 261006);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261004);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261007);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261052);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261004, 261052);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261058);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261005, 261061);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261006, 261061);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261005, 261063);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261006, 261063);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261009, 261056);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261058, 261180);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261081);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261004, 261081);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261003, 261055);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261004, 261055);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261055, 261146);

INSERT INTO vorlesungs_reihenfolge (pre, post)
VALUES (261058, 261179);

INSERT INTO assistenten (id, nachname, vorname, raum, email, verantwortungsbereich, arbeitet_fuer)
VALUES (2001, 'Ballert', 'Martin', 'A106', 'martin.ballert@fh-heiligenbrunn.de', 'Pool-Admin', 1001);

INSERT INTO assistenten (id, nachname, vorname, raum, email, verantwortungsbereich, arbeitet_fuer)
VALUES (2002, 'Schmied', 'Jochen', 'A106', 'jochen.schmied@fh-heiligenbrunn.de', 'Programmiersprachen, Datenbanken', 1002);

INSERT INTO assistenten (id, nachname, vorname, raum, email, verantwortungsbereich, arbeitet_fuer)
VALUES (2003, 'Brunwald', 'Sven', 'C052', 'sven.brunwald@fh-heiligenbrunn.de', 'ECommerce Labor', 1017); 

INSERT INTO assistenten (id, nachname, vorname, raum, email, verantwortungsbereich, arbeitet_fuer)
VALUES (2004, 'Fehn', 'Holger', 'C052', 'holger.fehn@fh-heiligenbrunn.de', 'Labor Elektronik, DSP', 1003);

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4001, 'Yoannides', 'Yannis', 5, 'yy@stud.fh-heiligenbrunn.de', '1978-09-29');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4002, 'Da Vinci', 'Bernhardo', 5, 'davinci@stud.fh-heiligenbrunn.de', '1981-09-14');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4003, 'Schwiders', 'Scarlet', 5, 'schwieder@stud.fh-heiligenbrunn.de', '1981-02-04');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4004, 'Widom', 'Jennifer', 5, 'widom@stud.fh-heiligenbrunn.de', '1986-03-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4005, 'Finklstein', 'Robert', 5, 'finkel@stud.fh-heiligenbrunn.de', '1981-05-20');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4006, 'Asmuss', 'Marie', 7, 'asmussen@stud.fh-heiligenbrunn.de', '1982-02-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4007, 'Jablonsky', 'Stefan', 5, 'jablonsk@stud.fh-heiligenbrunn.de', '1979-01-16');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4008, 'Bergmann', 'Ludwig', 5, 'lb@stud.fh-heiligenbrunn.de', '1981-07-20');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4009, 'Bechtle', 'Adam', 5, 'bechtle@stud.fh-heiligenbrunn.de', '1979-10-04');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4010, 'Schmidt', 'Karl-Heinz', 5, 'schmidtk@stud.fh-heiligenbrunn.de', '1986-06-17');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4011, 'Schmied', 'Susanne', 5, 'schmieds@stud.fh-heiligenbrunn.de', '1982-10-17');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4012, 'Köhler', 'Bernhard', 5, 'koel@stud.fh-heiligenbrunn.de', '1985-02-02');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4013, 'Behrends', 'Helge', 7, 'behrends@stud.fh-heiligenbrunn.de', '1977-07-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4014, 'Laube', 'Winfried', 7, 'laube@stud.fh-heiligenbrunn.de', '1976-06-03');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4015, 'Schäfer', 'Franz', 7, 'schaefer@stud.fh-heiligenbrunn.de', '1986-11-24');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4016, 'Klupper', 'Bernd', 7, 'klup@stud.fh-heiligenbrunn.de', '1975-06-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4017, 'Van der Brugge', 'Pieter', 7, 'vdbrugge@stud.fh-heiligenbrunn.de', '1978-05-10');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4019, 'Pereia', 'Carlos', 7, 'pereia@stud.fh-heiligenbrunn.de', '1987-01-06');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4020, 'Müller', 'Caroline', 7, 'muellerc@stud.fh-heiligenbrunn.de', '1975-10-27');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4021, 'Jakobson', 'Angelika', 7, 'jakobson@stud.fh-heiligenbrunn.de', '1983-10-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4022, 'Massmann', 'Maria', 7, 'massmann@stud.fh-heiligenbrunn.de', '1985-07-20');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4023, 'Dehner', 'Johann', 7, 'dehner@stud.fh-heiligenbrunn.de', '1985-04-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4024, 'Ziegler', 'Hans', 2, 'ziegler@stud.fh-heiligenbrunn.de', '1982-08-06');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4025, 'Herrmann', 'Raimund', 7, 'herrmann@stud.fh-heiligenbrunn.de', '1984-09-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4026, 'Ostner', 'Gertrude', 2, 'ostner@stud.fh-heiligenbrunn.de', '1977-08-20');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4027, 'Schmitt', 'Gerhard', 1, 'gschmitt@stud.fh-heiligenbrunn.de', '1978-04-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4028, 'Krause', 'Sieglinde', 2, 'krauses@stud.fh-heiligenbrunn.de', '1981-07-02');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4029, 'Saumberger', 'Robert', 7, 'saumberg@stud.fh-heiligenbrunn.de', '1982-11-28');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4043, 'Pratt', 'Philipp', 7, 'pppp@stud.fh-heiligenbrunn.de', '1988-07-08');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4711, 'Amthor', 'Bernd', 4, 'amthor@stud.fh-heiligenbrunn.de', '1975-04-19');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (4712, 'Kerner', 'Johanna', 4, 'jkerner@stud.fh-heiligenbrunn.de', '1986-01-20');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5001, 'Dodrecht', 'Christine', 3, 'dodrecht@stud.fh-heiligenbrunn.de', '1984-04-04');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5002, 'Ygit', 'Fatima', 3, 'ygit@stud.fh-heiligenbrunn.de', '1981-01-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5003, 'Hauser', 'Otto', 3, 'ohauser@stud.fh-heiligenbrunn.de', '1982-04-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5004, 'Brecht', 'Luisa', 3, 'brecht@stud.fh-heiligenbrunn.de', '1985-08-21');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5005, 'Föhning', 'Hans', 3, 'foehning@stud.fh-heiligenbrunn.de', '1988-12-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5006, 'Polze', 'Frank', 3, 'polze@stud.fh-heiligenbrunn.de', '1987-08-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5007, 'Weber', 'Jan', 1, 'weberj@stud.fh-heiligenbrunn.de', '1986-09-10');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5030, 'Birnbaum', 'Helene', 6, 'birnbaum@stud.fh-heiligenbrunn.de', '1986-03-28');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5031, 'Grabner', 'Frauke', 6, 'grabner@stud.fh-heiligenbrunn.de', '1980-08-23');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5032, 'Bauer', 'Elisabeth', 6, 'ebauer@stud.fh-heiligenbrunn.de', '1987-03-07');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5033, 'Rupert', 'Lukas', 6, 'rupert@stud.fh-heiligenbrunn.de', '1987-07-03');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5034, 'Kaya', 'Deniz', 6, 'kaya@stud.fh-heiligenbrunn.de', '1988-02-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5100, 'Oezenir', 'Aise', 1, 'aoezenir@stud.fh-heiligenbrunn.de', '1979-09-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5101, 'Sontag', 'Manuel', 1, 'msontag@stud.fh-heiligenbrunn.de', '1982-07-23');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5550, 'Fernandez', 'Raimondo', 4, 'fernandez@stud.fh-heiligenbrunn.de', '1981-07-25');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5551, 'Petrosillo', 'Maria', 4, 'petrosillo@stud.fh-heiligenbrunn.de', '1981-07-30');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5552, 'Ullmann', 'Peter', 4, 'ullmann@stud.fh-heiligenbrunn.de', '1978-04-24');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5553, 'Reisig', 'Wolfgang', 4, 'reisig@stud.fh-heiligenbrunn.de', '1980-08-02');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5555, 'Gans', 'Gustav', 4, 'gans@stud.fh-heiligenbrunn.de', '1986-10-23');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5556, 'Gruber', 'Angelika', 1, 'gruber@stud.fh-heiligenbrunn.de', '1978-07-17');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5557, 'Kraus', 'Martin', 4, 'kraus@stud.fh-heiligenbrunn.de', '1986-05-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5558, 'Bergmann', 'Ernst', 4, 'berg@stud.fh-heiligenbrunn.de', '1976-11-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5559, 'Bayer', 'Hans', 4, 'bayer@stud.fh-heiligenbrunn.de', '1975-04-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5560, 'Freytag', 'Christoph', 4, 'freytag@stud.fh-heiligenbrunn.de', '1988-10-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5561, 'Liebermann', 'Franz', 4, 'liebermann@stud.fh-heiligenbrunn.de', '1979-08-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5562, 'Zabert', 'Manfred', 4, 'zabert@stud.fh-heiligenbrunn.de', '1987-04-14');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5563, 'Dohrer', 'Karl', 4, 'gans@stud.fh-heiligenbrunn.de', '1988-10-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5564, 'Tobler', 'Anna', 4, 'tobler@stud.fh-heiligenbrunn.de', '1988-09-14');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5565, 'Tauber', 'Gerlinde', 1, 'tauber@stud.fh-heiligenbrunn.de', '1984-08-21');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5566, 'Hartmeier', 'Friedemann', 4, 'hartmeier@stud.fh-heiligenbrunn.de', '1978-06-23');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5567, 'Brauer', 'Johannes', 4, 'brauer@stud.fh-heiligenbrunn.de', '1975-04-29');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5568, 'Wartberg', 'Christine', 1, 'wartberg@stud.fh-heiligenbrunn.de', '1986-11-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5569, 'Kiel', 'Friedrich', 4, 'kiel@stud.fh-heiligenbrunn.de', '1989-01-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5570, 'Spoleto', 'Chiara', 4, 'spoleto@stud.fh-heiligenbrunn.de', '1980-10-06');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5571, 'Johannsen', 'Sven', 4, 'johannsen@stud.fh-heiligenbrunn.de', '1975-09-16');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5572, 'Abelson', 'Henriette', 4, 'abelson@stud.fh-heiligenbrunn.de', '1983-07-25');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5573, 'Melville', 'Ismael', 4, 'melville@stud.fh-heiligenbrunn.de', '1987-07-15');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5574, 'Büchner', 'Georg', 4, 'buechner@stud.fh-heiligenbrunn.de', '1980-05-26');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5575, 'Güntherode', 'Daniela', 4, 'guenther@stud.fh-heiligenbrunn.de', '1986-07-23');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5576, 'Rauer', 'Ulrich', 4, 'rauer@stud.fh-heiligenbrunn.de', '1978-02-17');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5577, 'Kern', 'Alexander', 4, 'kern@stud.fh-heiligenbrunn.de', '1987-01-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5578, 'Steyer', 'Susanne', 4, 'steyer@stud.fh-heiligenbrunn.de', '1982-02-24');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5579, 'Meier', 'Daniel', 4, 'meier@stud.fh-heiligenbrunn.de', '1984-07-13');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5580, 'Svenson', 'Jan', 4, 'svenson@stud.fh-heiligenbrunn.de', '1987-06-13');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5581, 'Kerner', 'Franz', 4, 'fkerner@stud.fh-heiligenbrunn.de', '1977-10-03');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5582, 'Bauer', 'Margarete', 4, 'bauer@stud.fh-heiligenbrunn.de', '1987-10-03');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5583, 'Meyer', 'Lukas', 4, 'meyer@stud.fh-heiligenbrunn.de', '1985-05-31');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5584, 'Müller', 'Dagmar', 4, 'dmueller@stud.fh-heiligenbrunn.de', '1987-02-14');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5585, 'Bartl', 'Petra', 4, 'bartl@stud.fh-heiligenbrunn.de', '1979-01-19');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5586, 'Müller', 'Volker', 4, 'vmueller@stud.fh-heiligenbrunn.de', '1983-01-08');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5587, 'Hauser', 'Veit', 4, 'hauser@stud.fh-heiligenbrunn.de', '1980-11-27');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5588, 'Hinterseer', 'Maximilian', 4, 'hinters@stud.fh-heiligenbrunn.de', '1975-04-16');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5589, 'Neumann', 'Elisabeth', 4, 'neumann@stud.fh-heiligenbrunn.de', '1979-12-21');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5590, 'Seliger', 'Hanna', 2, 'seliger@stud.fh-heiligenbrunn.de', '1988-11-03');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5591, 'Lockemann', 'Albert', 2, 'locke@stud.fh-heiligenbrunn.de', '1982-03-31');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5592, 'Carrington', 'Calvin', 2, 'carring@stud.fh-heiligenbrunn.de', '1983-08-31');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5593, 'Flasza', 'Miroslav', 2, 'miro@stud.fh-heiligenbrunn.de', '1987-05-18');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5594, 'Staller', 'Michael', 2, 'staller@stud.fh-heiligenbrunn.de', '1978-04-29');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5595, 'Dericke', 'Verena', 2, 'vderi@stud.fh-heiligenbrunn.de', '1975-12-24');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5596, 'Foerster', 'Meike', 2, 'foerster@stud.fh-heiligenbrunn.de', '1981-09-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5597, 'Zandvoort', 'Stefanie', 2, 'zand@stud.fh-heiligenbrunn.de', '1984-09-19');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5598, 'Bergen', 'Herman', 2, 'bergen@stud.fh-heiligenbrunn.de', '1976-02-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5599, 'Hase', 'Fred', 2, 'hase@stud.fh-heiligenbrunn.de', '1981-11-19');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5600, 'Friedberg', 'Bernd', 2, 'fried@stud.fh-heiligenbrunn.de', '1980-10-27');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5601, 'Homberger', 'Daniel', 2, 'homberg@stud.fh-heiligenbrunn.de', '1986-10-16');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5602, 'Stauffen', 'Karla', 2, 'stauff@stud.fh-heiligenbrunn.de', '1977-04-26');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5603, 'Zahn', 'Christine', 2, 'zahl@stud.fh-heiligenbrunn.de', '1985-09-17');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5604, 'Quedlin', 'Adrian', 2, 'quedl@stud.fh-heiligenbrunn.de', '1976-01-06');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5605, 'Neuker', 'Martin', 2, 'neuker@stud.fh-heiligenbrunn.de', '1976-02-12');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5606, 'Obermaier', 'Mario', 2, 'oberm@stud.fh-heiligenbrunn.de', '1976-10-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5607, 'Olling', 'Werner', 2, 'olli@stud.fh-heiligenbrunn.de', '1980-12-21');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5608, 'Lambert', 'John', 2, 'lamb@stud.fh-heiligenbrunn.de', '1982-09-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5609, 'Coffin', 'Peter', 2, 'coffin@stud.fh-heiligenbrunn.de', '1987-03-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5610, 'Unterberg', 'Xaver', 2, 'unterb@stud.fh-heiligenbrunn.de', '1980-01-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5611, 'Brauer', 'Bernhilde', 2, 'brauer@stud.fh-heiligenbrunn.de', '1981-12-29');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5612, 'Aul', 'Nadja', 2, 'aul@stud.fh-heiligenbrunn.de', '1976-07-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5613, 'Ehrmann', 'Jan', 2, 'ehrm@stud.fh-heiligenbrunn.de', '1984-12-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5614, 'Illig', 'Adam', 2, 'illig@stud.fh-heiligenbrunn.de', '1986-06-02');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5615, 'Strauss', 'Raimund', 2, 'strauss@stud.fh-heiligenbrunn.de', '1976-08-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5616, 'Voss', 'Benjamin', 2, 'voss@stud.fh-heiligenbrunn.de', '1985-08-26');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5617, 'Kolbe', 'Stefanie', 2, 'kolbe@stud.fh-heiligenbrunn.de', '1983-02-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5618, 'Magold', 'Stefan', 2, 'magold@stud.fh-heiligenbrunn.de', '1975-04-10');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5619, 'Magold', 'Veronika', 2, 'vmagold@stud.fh-heiligenbrunn.de', '1978-10-26');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5620, 'Schwarz', 'Jakob', 2, 'schwarz@stud.fh-heiligenbrunn.de', '1988-11-09');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5621, 'Malakov', 'Vladimir', 2, 'malakov@stud.fh-heiligenbrunn.de', '1983-05-01');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5961, 'Duft', 'Florian', 1, 'fduft@stud.fh-heiligenbrunn.de', '1987-07-05');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5962, 'Waas', 'Fabrice', 2, 'fwaas@stud.fh-heiligenbrunn.de', '1975-05-08');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5966, 'Schleier', 'Florian', 1, 'schleier@stud.fh-heiligenbrunn.de', '1986-11-06');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5968, 'Dunst', 'Florian', 3, 'fdunst@stud.fh-heiligenbrunn.de', '1975-10-11');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5985, 'Kolbe', 'Octavian', 1, 'kolbe@stud.fh-heiligenbrunn.de', '1977-11-14');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5988, 'Pemberton', 'August Bernhard Christoph', 1, 'pemberton@stud.fh-heiligenbrunn.de', '1982-05-22');

INSERT INTO studenten (id, nachname, vorname, semester, email, geboren)
VALUES (5989, 'Bauer', 'Margit', 1, 'bauer@stud.fh-heiligenbrunn.de', '1977-09-11');

INSERT INTO thesis (student, betreuer, titel, dokumenttyp, dokumentname, dokumentquelle)
VALUES (4006, 1018, 'Linux', 'pdf', 'Linux.pdf', 'http://de.wikipedia.org/wiki/Linux');

INSERT INTO thesis (student, betreuer, titel, dokumenttyp, dokumentname, dokumentquelle)
VALUES (4013, 1018, 'Enigma', 'pdf', 'Enigma.pdf', 'http://de.wikipedia.org/wiki/Enigma_(Maschine)');

INSERT INTO thesis (student, betreuer, titel, dokumenttyp, dokumentname, dokumentquelle)
VALUES (4014, 1004, 'Streaming Audio', 'pdf', 'Streaming_Audio.pdf', 'http://de.wikipedia.org/wiki/Streaming_Audio');

INSERT INTO thesis (student, betreuer, titel, dokumenttyp, dokumentname, dokumentquelle)
VALUES (4015, 1002, 'Topologische Sortierung', 'doc', 'Topologische Sortierung.doc', 'http://de.wikipedia.org/wiki/Topologische_Sortierung');

INSERT INTO thesis (student, betreuer, titel, dokumenttyp, dokumentname, dokumentquelle)
VALUES (4016, 1004, 'Schwellwertverfahren', 'pdf', 'Schwellwertverfahren.pdf', 'http://de.wikipedia.org/wiki/Schwellenwertverfahren');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261003, 1.7, '2007-07-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261005, 2.7, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261005, 2, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261012, 1, '2007-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261012, 1.7, '2008-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261012, 1.7, '2007-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261014, 3.3, '2008-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261014, 3.7, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261014, 1, '2008-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261014, 2.7, '2008-02-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261017, 1.3, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261017, 3, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261017, 1.3, '2007-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261017, 1, '2008-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261001, 4, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261001, 2.7, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5593, 261002, 2.3, '2007-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261002, 2.3, '2008-02-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261002, 2.3, '2008-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261002, 1, '2008-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261002, 1.7, '2008-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261002, 4, '2007-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261002, 2.3, '2008-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261002, 1.3, '2008-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5617, 261002, 3.3, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261002, 1.7, '2008-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5001, 261002, 1.7, '2008-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261002, 1.7, '2008-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5006, 261002, 1.3, '2008-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261002, 1.7, '2008-07-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261006, 1.7, '2008-07-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261006, 1.7, '2008-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261006, 1.7, '2008-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261006, 1, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5611, 261006, 4, '2007-07-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261006, 3, '2007-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5617, 261006, 1.7, '2008-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261006, 1.7, '2008-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261006, 2, '2008-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261004, 4, '2008-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261004, 3.3, '2007-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261004, 3, '2008-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261004, 1.7, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261004, 2.7, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261004, 3.7, '2008-07-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261004, 1.7, '2008-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261004, 1.7, '2007-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261004, 1, '2008-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261004, 2.7, '2007-07-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5611, 261004, 2.7, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261004, 1, '2007-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5615, 261004, 1, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5003, 261004, 2.7, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261004, 1.3, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261007, 5, '2007-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261007, 5, '2007-07-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261007, 4.3, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5602, 261007, 4.7, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261007, 1, '2007-07-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261007, 5, '2007-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261007, 2.7, '2007-02-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5614, 261007, 3.7, '2008-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5594, 261009, 3.7, '2007-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261009, 2.3, '2008-02-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261009, 1, '2007-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261009, 1, '2008-07-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5605, 261009, 2.3, '2008-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261009, 1.3, '2008-02-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261009, 2.7, '2008-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261009, 3.3, '2007-07-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261009, 2.7, '2008-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261013, 3.7, '2008-07-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261013, 2, '2008-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261013, 2.7, '2008-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5602, 261013, 1, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261013, 3.7, '2007-07-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5605, 261013, 1.3, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261013, 1.7, '2008-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261013, 3.7, '2007-07-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5612, 261013, 1.7, '2008-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261013, 1.3, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5621, 261013, 1.3, '2008-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261013, 3.7, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261052, 2, '2007-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261052, 2.3, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261052, 1.7, '2008-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261052, 2.3, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261052, 1.7, '2008-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261052, 3.7, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261052, 4, '2008-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261052, 3.3, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4012, 261052, 1.7, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261058, 4.3, '2007-07-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261058, 2, '2007-02-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261058, 3.7, '2007-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261058, 2.7, '2007-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261058, 2.3, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261058, 1.7, '2007-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5612, 261058, 3.3, '2008-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261058, 1.3, '2008-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261058, 1.7, '2008-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5621, 261058, 1.3, '2007-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261061, 4, '2007-07-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261061, 1.7, '2008-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261061, 4, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261061, 4, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261061, 1.7, '2007-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261061, 3, '2008-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261061, 4.3, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261061, 1.7, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261061, 1.3, '2008-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261061, 1.7, '2007-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261061, 2.7, '2008-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5553, 261063, 2.7, '2008-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261063, 1.7, '2007-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5567, 261063, 1.3, '2008-07-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261063, 3.7, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261063, 1.7, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261063, 4, '2008-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261063, 1.7, '2008-07-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261063, 1.3, '2008-02-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261063, 1.7, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261063, 1.7, '2007-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261063, 3.7, '2007-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5550, 261056, 3.3, '2007-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261056, 1.3, '2008-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261056, 3.3, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5555, 261056, 2.7, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5559, 261056, 2, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261056, 3.3, '2008-07-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261056, 3, '2008-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261056, 2.3, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261056, 3.7, '2007-07-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261056, 4, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261056, 4, '2008-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261056, 1.7, '2007-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261056, 1.3, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261056, 3.7, '2007-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261056, 2.7, '2008-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4005, 261056, 1.7, '2008-07-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261056, 2, '2007-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261056, 4.3, '2008-07-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261051, 4.3, '2007-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261051, 2.3, '2008-07-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261051, 4, '2007-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261051, 3.7, '2008-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261051, 1.7, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261051, 3, '2007-02-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261051, 2.3, '2008-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261051, 1.3, '2007-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261051, 1.3, '2007-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261051, 3.7, '2007-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261051, 3.7, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261051, 3.7, '2007-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261051, 2.7, '2007-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261051, 1, '2008-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261051, 1.7, '2007-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261051, 1.7, '2008-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4005, 261196, 3.7, '2008-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261196, 2.3, '2007-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4012, 261196, 4, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5030, 261196, 1, '2007-07-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261196, 2.7, '2008-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261196, 1.7, '2007-07-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261180, 2.7, '2007-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261180, 2, '2007-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4012, 261180, 3.7, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5031, 261180, 1.3, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261180, 1.3, '2008-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261180, 2.3, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261180, 3.3, '2007-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261081, 4, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261081, 4, '2008-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261081, 4.3, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261081, 2.3, '2007-02-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261081, 1, '2007-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261081, 1.7, '2007-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261081, 2.7, '2008-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261081, 3.3, '2008-07-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261081, 1.7, '2008-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261055, 4, '2007-02-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5550, 261055, 1.7, '2007-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5553, 261055, 3.7, '2008-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5558, 261055, 2.3, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261055, 1.7, '2008-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261055, 4.7, '2007-02-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261055, 3.7, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261055, 4, '2007-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261055, 4.7, '2008-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261055, 4, '2007-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261055, 3.7, '2008-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261055, 4.7, '2008-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261055, 5, '2008-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261055, 4.7, '2008-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261055, 5, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261143, 1.3, '2008-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4003, 261143, 3.7, '2008-02-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5031, 261143, 3.3, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261197, 5, '2007-07-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261197, 3.3, '2007-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4016, 261197, 3.3, '2008-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4019, 261197, 4, '2008-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261197, 1.7, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261197, 4.3, '2008-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261146, 2.7, '2007-07-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261146, 2.7, '2007-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261146, 1.3, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4025, 261146, 1.7, '2008-07-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261146, 1.3, '2007-02-08');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261124, 3.3, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4019, 261124, 4.3, '2008-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261124, 2.7, '2007-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261124, 3.7, '2007-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261124, 4, '2008-02-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261179, 2.7, '2007-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261179, 1, '2008-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261179, 3.7, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5562, 261179, 2.7, '2008-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261179, 3.7, '2008-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261179, 3.7, '2007-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261179, 1.7, '2007-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261179, 4.3, '2007-02-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261179, 3.7, '2007-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261179, 1.7, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261179, 4.3, '2008-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261179, 3.7, '2008-02-14');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261179, 1.7, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261179, 1.3, '2007-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4005, 261179, 3.7, '2007-02-10');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261179, 2.3, '2007-07-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261072, 2.3, '2007-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5553, 261072, 3.3, '2007-02-17');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261072, 2.7, '2008-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261072, 3.7, '2008-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261072, 1.7, '2007-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261072, 2, '2007-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261072, 1, '2008-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261072, 1.3, '2008-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261072, 1.7, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261072, 1, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261072, 2.7, '2007-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261168, 1, '2007-07-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4016, 261168, 2.3, '2008-02-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261168, 3, '2007-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4019, 261168, 1.3, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4025, 261168, 3.7, '2007-02-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261075, 3.3, '2008-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261075, 2.3, '2008-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261075, 1, '2008-02-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261075, 1.7, '2008-07-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261075, 1, '2007-02-16');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261075, 2.7, '2008-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261159, 1.7, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261159, 2, '2008-07-18');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261159, 1.3, '2007-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261159, 3.3, '2008-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261057, 3.7, '2007-02-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261057, 2.7, '2007-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261057, 2.7, '2008-07-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261026, 2, '2008-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261026, 1.7, '2008-02-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5557, 261026, 2.3, '2007-02-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5559, 261026, 1.7, '2007-02-05');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5562, 261026, 1.7, '2008-07-15');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261026, 4, '2007-02-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261026, 3.7, '2008-07-06');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261026, 3, '2008-07-02');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261026, 3, '2008-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261026, 3.3, '2007-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261026, 2.7, '2008-07-04');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261026, 1.3, '2008-07-20');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261026, 3, '2007-07-09');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261026, 1.7, '2008-07-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261026, 3, '2008-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261026, 1, '2008-02-07');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261026, 3.3, '2007-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261003, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261003, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261005, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261012, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261014, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261014, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261014, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261017, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261017, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261017, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261001, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261001, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261001, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261002, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5619, 261002, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5003, 261002, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5004, 261002, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261006, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261006, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5602, 261006, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261006, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261006, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261004, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261007, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261007, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261007, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5612, 261007, 2, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261007, 3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261007, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261009, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261009, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5604, 261009, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261009, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261009, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5614, 261009, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261013, 3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261013, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261013, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5550, 261052, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5558, 261052, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261052, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261052, 3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261052, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261052, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261052, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261052, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261052, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261052, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261058, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5602, 261058, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261058, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261058, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261061, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5553, 261061, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261061, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261061, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261061, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261061, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261061, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261061, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261061, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261063, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261063, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261063, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261063, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261063, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261063, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261063, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261063, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261056, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5569, 261056, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261056, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261056, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261056, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261056, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5557, 261051, 3.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261051, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261051, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261196, 2, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4003, 261180, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4005, 261180, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4003, 261081, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4005, 261081, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261081, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261055, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5567, 261055, 5, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261055, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261055, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261197, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261197, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261146, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261146, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261124, 4.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261124, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5557, 261179, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261179, 2, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5569, 261179, 2, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261179, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261179, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261072, 1, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261072, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261072, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261072, 1.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261159, 3.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4043, 261159, 1.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261057, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4025, 261057, 3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261026, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261026, 2.3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261026, 3, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261026, 4, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261026, 2.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261026, 4.7, '2010-02-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261003, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261003, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261005, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261005, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261005, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261012, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261014, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261017, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261001, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5597, 261001, 3.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261001, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5591, 261002, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261002, 3.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261002, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5611, 261002, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5615, 261002, 3.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261002, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261002, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261006, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261006, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261006, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261006, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261006, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261004, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261004, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261004, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5617, 261004, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261004, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261004, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261007, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261009, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261009, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261009, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5602, 261009, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5612, 261009, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261009, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261013, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5594, 261013, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261013, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261013, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261013, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261013, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261052, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261052, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5567, 261052, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261052, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261052, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5575, 261052, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261052, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261052, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261052, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261058, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5614, 261058, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261058, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261061, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5550, 261061, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5558, 261061, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5567, 261061, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261061, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261061, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261063, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261063, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261063, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261063, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261063, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261063, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261063, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261063, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5562, 261056, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261056, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261056, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261056, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261056, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261056, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4008, 261056, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261051, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261051, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5566, 261051, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261051, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261051, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261051, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261051, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261051, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261051, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4004, 261196, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5032, 261196, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261180, 4.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5034, 261180, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261055, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261055, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261055, 5, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261055, 5, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5575, 261055, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261055, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261055, 4.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261055, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261055, 5, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261055, 5, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261143, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4004, 261143, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261143, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261143, 3.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261143, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261146, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5555, 261179, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5559, 261179, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261179, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261072, 2, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261072, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261072, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261072, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5584, 261072, 2.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261072, 3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261072, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261168, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4014, 261075, 1, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261075, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261159, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4025, 261159, 4.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261057, 1.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4013, 261057, 1.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261057, 4, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261026, 3.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261026, 3.3, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261026, 2.7, '2009-08-12');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5100, 261003, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5101, 261005, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5596, 261005, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261012, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261012, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261017, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5592, 261001, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5595, 261002, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5608, 261002, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5609, 261002, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5593, 261006, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5598, 261006, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5600, 261006, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261006, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261006, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261006, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5590, 261004, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5593, 261004, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5606, 261004, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261004, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5593, 261007, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5594, 261007, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261007, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5603, 261007, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5613, 261007, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261007, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5620, 261007, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261007, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5607, 261009, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5610, 261009, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5621, 261009, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261009, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261009, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5599, 261013, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5607, 261013, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5614, 261013, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5002, 261013, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5005, 261013, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261052, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4712, 261052, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5553, 261052, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261052, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261052, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261052, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5585, 261052, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261052, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261052, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5594, 261058, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5601, 261058, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5616, 261058, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5618, 261058, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261058, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261061, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261061, 4, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261061, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261061, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261061, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261061, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261061, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5550, 261063, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5558, 261063, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5560, 261063, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261063, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5577, 261063, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261063, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261063, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5557, 261056, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5563, 261056, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261056, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261056, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5564, 261051, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261051, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261051, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261051, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261196, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4002, 261196, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261196, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261196, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5031, 261196, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261180, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261180, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5031, 261081, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261055, 5, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261055, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261055, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261055, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5582, 261055, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5589, 261055, 4.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261055, 5, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261197, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261197, 4.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261146, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4014, 261146, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4015, 261146, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4017, 261146, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261124, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4016, 261124, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4020, 261124, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261124, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4711, 261179, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5551, 261179, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261179, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261179, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261179, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5574, 261179, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5576, 261179, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5578, 261179, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261179, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5581, 261179, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261179, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4010, 261179, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261072, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5570, 261072, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5571, 261072, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5573, 261072, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5586, 261072, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5587, 261072, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261168, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261168, 1, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4023, 261168, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4029, 261168, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4016, 261075, 3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4021, 261075, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4006, 261159, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4022, 261057, 4.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5552, 261026, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5555, 261026, 2, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261026, 4.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5572, 261026, 3.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5579, 261026, 2.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5580, 261026, 2.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5583, 261026, 1.7, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4007, 261026, 3.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261026, 1.3, '2010-02-03');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5561, 261026, 3, '2006-07-13');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4001, 261179, 4, '2006-07-19');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4009, 261055, 4.3, '2009-02-11');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (4011, 261055, 2.7, '2007-02-01');

INSERT INTO pruefungen (student, vorlesung, note, terminiert)
VALUES (5588, 261055, 5, '2005-07-10');

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261003);

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261005);

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261012);

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261014);

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261017);

INSERT INTO hoeren (student, vorlesung)
VALUES (5100, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5101, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261001);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5593, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5611, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5615, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5617, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5619, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5001, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5003, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5004, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5006, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261002);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5593, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5602, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5611, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5617, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261006);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5593, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5611, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5615, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5617, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5003, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261004);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5593, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5594, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5597, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5602, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5612, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5614, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261007);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5594, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5602, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5605, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5607, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5612, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5614, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5621, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261009);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5591, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5592, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5594, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5596, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5602, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5605, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5607, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5608, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5612, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5614, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5621, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5002, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261013);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5550, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5553, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5558, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5567, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5575, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (4012, 261052);

INSERT INTO hoeren (student, vorlesung)
VALUES (5590, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5594, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5595, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5598, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5599, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5600, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5601, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5602, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5603, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5604, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5606, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5609, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5610, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5612, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5613, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5614, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5616, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5618, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5620, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5621, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5005, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261058);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5550, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5553, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5558, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5567, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261061);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5550, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5553, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5558, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5567, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261063);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5550, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5555, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5557, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5559, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5562, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5569, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4005, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261056);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5557, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261051);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4004, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4005, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4012, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (5030, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (5031, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (5032, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261196);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4003, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4005, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4012, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (5031, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (5034, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261180);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4003, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4005, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (5031, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261081);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5550, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5553, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5558, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5567, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5575, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4008, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261055);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4002, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4003, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4004, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (5031, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261143);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4016, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4019, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261197);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4014, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4025, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261146);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4016, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4019, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261124);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5555, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5557, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5559, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5560, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5562, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5569, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4005, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261179);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5553, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5577, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261072);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4016, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4019, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4025, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261168);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4014, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4016, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4029, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261075);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4015, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4025, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261159);

INSERT INTO hoeren (student, vorlesung)
VALUES (4006, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4013, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4017, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4020, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4021, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4022, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4023, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4025, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4043, 261057);

INSERT INTO hoeren (student, vorlesung)
VALUES (4711, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4712, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5551, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5552, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5555, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5557, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5559, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5561, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5562, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5563, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5564, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5566, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5570, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5571, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5572, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5573, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5574, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5576, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5578, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5579, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5580, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5581, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5582, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5583, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5584, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5585, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5586, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5587, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5588, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (5589, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4001, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4007, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4009, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4010, 261026);

INSERT INTO hoeren (student, vorlesung)
VALUES (4011, 261026);