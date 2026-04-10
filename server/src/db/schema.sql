PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS sources (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  access_type TEXT NOT NULL,
  platform TEXT,
  region TEXT,
  language TEXT,
  priority TEXT NOT NULL DEFAULT 'p2',
  status TEXT NOT NULL DEFAULT 'active',
  credibility TEXT,
  update_frequency TEXT,
  automation_feasibility TEXT,
  url TEXT,
  rss TEXT,
  notes TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_sources_category ON sources(category);
CREATE INDEX IF NOT EXISTS idx_sources_access_type ON sources(access_type);
CREATE INDEX IF NOT EXISTS idx_sources_platform ON sources(platform);
CREATE INDEX IF NOT EXISTS idx_sources_priority ON sources(priority);
CREATE INDEX IF NOT EXISTS idx_sources_status ON sources(status);
CREATE INDEX IF NOT EXISTS idx_sources_updated_at ON sources(updated_at);

CREATE TABLE IF NOT EXISTS watchlists (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  platform TEXT NOT NULL,
  account_type TEXT NOT NULL,
  region TEXT,
  language TEXT,
  priority TEXT NOT NULL DEFAULT 'p2',
  tracking_mode TEXT NOT NULL DEFAULT 'manual',
  profile_url TEXT,
  notes TEXT,
  last_checked_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_watchlists_platform ON watchlists(platform);
CREATE INDEX IF NOT EXISTS idx_watchlists_account_type ON watchlists(account_type);
CREATE INDEX IF NOT EXISTS idx_watchlists_priority ON watchlists(priority);
CREATE INDEX IF NOT EXISTS idx_watchlists_updated_at ON watchlists(updated_at);

CREATE TABLE IF NOT EXISTS watchlist_reasons (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  watchlist_id INTEGER NOT NULL,
  reason TEXT NOT NULL,
  FOREIGN KEY (watchlist_id) REFERENCES watchlists(id) ON DELETE CASCADE,
  UNIQUE (watchlist_id, reason)
);

CREATE INDEX IF NOT EXISTS idx_watchlist_reasons_watchlist_id ON watchlist_reasons(watchlist_id);

CREATE TABLE IF NOT EXISTS documents (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  summary TEXT,
  document_type TEXT NOT NULL,
  language TEXT,
  publisher TEXT,
  author TEXT,
  source_id INTEGER,
  source_url TEXT,
  original_file TEXT,
  file_path TEXT,
  processing_status TEXT NOT NULL DEFAULT 'pending',
  processing_mode TEXT,
  last_processed_at TEXT,
  priority TEXT NOT NULL DEFAULT 'p2',
  notes TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_documents_document_type ON documents(document_type);
CREATE INDEX IF NOT EXISTS idx_documents_source_id ON documents(source_id);
CREATE INDEX IF NOT EXISTS idx_documents_processing_status ON documents(processing_status);
CREATE INDEX IF NOT EXISTS idx_documents_priority ON documents(priority);
CREATE INDEX IF NOT EXISTS idx_documents_updated_at ON documents(updated_at);

CREATE TABLE IF NOT EXISTS digests (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  digest_type TEXT NOT NULL,
  summary TEXT,
  markdown_content TEXT NOT NULL,
  document_id INTEGER,
  source_id INTEGER,
  page_refs TEXT,
  chapter_refs TEXT,
  processing_notes TEXT,
  status TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE SET NULL,
  FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_digests_digest_type ON digests(digest_type);
CREATE INDEX IF NOT EXISTS idx_digests_document_id ON digests(document_id);
CREATE INDEX IF NOT EXISTS idx_digests_source_id ON digests(source_id);
CREATE INDEX IF NOT EXISTS idx_digests_status ON digests(status);
CREATE INDEX IF NOT EXISTS idx_digests_updated_at ON digests(updated_at);

CREATE TABLE IF NOT EXISTS entries (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  entry_type TEXT NOT NULL,
  summary TEXT,
  content TEXT,
  source_id INTEGER,
  watchlist_id INTEGER,
  platform TEXT,
  source_url TEXT,
  author_or_account TEXT,
  priority TEXT NOT NULL DEFAULT 'p2',
  published_at TEXT,
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE SET NULL,
  FOREIGN KEY (watchlist_id) REFERENCES watchlists(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_entries_entry_type ON entries(entry_type);
CREATE INDEX IF NOT EXISTS idx_entries_source_id ON entries(source_id);
CREATE INDEX IF NOT EXISTS idx_entries_watchlist_id ON entries(watchlist_id);
CREATE INDEX IF NOT EXISTS idx_entries_platform ON entries(platform);
CREATE INDEX IF NOT EXISTS idx_entries_priority ON entries(priority);
CREATE INDEX IF NOT EXISTS idx_entries_published_at ON entries(published_at);
CREATE INDEX IF NOT EXISTS idx_entries_updated_at ON entries(updated_at);

CREATE TABLE IF NOT EXISTS tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  tag_group TEXT NOT NULL,
  description TEXT,
  status TEXT NOT NULL DEFAULT 'active',
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_tags_tag_group ON tags(tag_group);
CREATE INDEX IF NOT EXISTS idx_tags_status ON tags(status);

CREATE TABLE IF NOT EXISTS source_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (source_id) REFERENCES sources(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  UNIQUE (source_id, tag_id)
);

CREATE INDEX IF NOT EXISTS idx_source_tags_source_id ON source_tags(source_id);
CREATE INDEX IF NOT EXISTS idx_source_tags_tag_id ON source_tags(tag_id);

CREATE TABLE IF NOT EXISTS watchlist_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  watchlist_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (watchlist_id) REFERENCES watchlists(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  UNIQUE (watchlist_id, tag_id)
);

CREATE INDEX IF NOT EXISTS idx_watchlist_tags_watchlist_id ON watchlist_tags(watchlist_id);
CREATE INDEX IF NOT EXISTS idx_watchlist_tags_tag_id ON watchlist_tags(tag_id);

CREATE TABLE IF NOT EXISTS document_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  document_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  UNIQUE (document_id, tag_id)
);

CREATE INDEX IF NOT EXISTS idx_document_tags_document_id ON document_tags(document_id);
CREATE INDEX IF NOT EXISTS idx_document_tags_tag_id ON document_tags(tag_id);

CREATE TABLE IF NOT EXISTS digest_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  digest_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (digest_id) REFERENCES digests(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  UNIQUE (digest_id, tag_id)
);

CREATE INDEX IF NOT EXISTS idx_digest_tags_digest_id ON digest_tags(digest_id);
CREATE INDEX IF NOT EXISTS idx_digest_tags_tag_id ON digest_tags(tag_id);

CREATE TABLE IF NOT EXISTS entry_tags (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  entry_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY (entry_id) REFERENCES entries(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE,
  UNIQUE (entry_id, tag_id)
);

CREATE INDEX IF NOT EXISTS idx_entry_tags_entry_id ON entry_tags(entry_id);
CREATE INDEX IF NOT EXISTS idx_entry_tags_tag_id ON entry_tags(tag_id);
