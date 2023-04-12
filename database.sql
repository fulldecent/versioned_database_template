-- SQLite

CREATE TABLE favorite_words (
  id INTEGER PRIMARY KEY,
  word TEXT
);

CREATE TABLE audit (
  id INTEGER PRIMARY KEY,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name TEXT,
  changed_columns TEXT
);

CREATE TRIGGER favorite_words_audit_trigger_insert
AFTER INSERT ON favorite_words
BEGIN
  INSERT INTO audit (table_name, changed_columns)
  VALUES ('favorite_words', json_object('new', new.word));
END;

CREATE TRIGGER favorite_words_audit_trigger_modify
AFTER UPDATE ON favorite_words
BEGIN
  INSERT INTO audit (table_name, changed_columns)
  VALUES ('favorite_words', json_object('new', new.word));
END;

CREATE TRIGGER favorite_words_audit_trigger_delete
AFTER DELETE ON favorite_words
BEGIN
  INSERT INTO audit (table_name, changed_columns)
  VALUES ('favorite_words', json_object('old', old.word));
END;
