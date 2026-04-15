-- =============================================
-- ORCAZEN CORE 1.0
-- LEDGER BASE
-- =============================================

CREATE TABLE accounts(
account_id UUID PRIMARY KEY,
user_id UUID NOT NULL,
name VARCHAR(100) NOT NULL,
type VARCHAR(50) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories(
category_id UUID PRIMARY KEY,
name VARCHAR(100) NOT NULL,
type VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE journal_entries(
entry_id UUID PRIMARY KEY,
user_id UUID NOT NULL,
description VARCHAR(255),
reference_id UUID,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE journal_lines(
line_id UUID PRIMARY KEY,
entry_id UUID NOT NULL REFERENCES journal_entries(entry_id),
account_id UUID NOT NULL REFERENCES accounts(account_id),
category_id UUID,
amount NUMERIC(14,2) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transfers(
transfer_id UUID PRIMARY KEY,
from_account_id UUID NOT NULL,
to_account_id UUID NOT NULL,
entry_id UUID NOT NULL REFERENCES journal_entries(entry_id),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_journal_lines_entry ON journal_lines(entry_id);
CREATE INDEX idx_journal_lines_account ON journal_lines(account_id);
CREATE INDEX idx_journal_entries_user ON journal_entries(user_id);
