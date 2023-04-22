-- SQLite

CREATE TABLE favorite_words (
  word TEXT
);

CREATE TABLE audit (
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  changed_table TEXT,
  changed_rowid INTEGER,
  changed_column JSON TEXT
);

CREATE TRIGGER audit_favorite_words_insert
AFTER INSERT ON favorite_words
BEGIN
  INSERT INTO audit (changed_table, changed_rowid, changed_column)
  VALUES ('favorite_words', new.rowid, json_object('word', new.word));
END;

CREATE TRIGGER audit_favorite_words_update
AFTER UPDATE ON favorite_words
BEGIN
  INSERT INTO audit (changed_table, changed_rowid, changed_column)
  VALUES ('favorite_words', new.rowid, json_object('rowid', new.rowid, 'word', new.word));
END;

CREATE TRIGGER audit_favorite_words_delete
AFTER DELETE ON favorite_words
BEGIN
  INSERT INTO audit (changed_table, changed_rowid, changed_column)
  VALUES ('favorite_words', old.rowid, null);
END;
