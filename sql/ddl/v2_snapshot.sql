-- =============================================
-- ORCAZEN SNAPSHOT ENGINE V1
-- =============================================

CREATE TABLE account_snapshots(
snapshot_id UUID PRIMARY KEY,
account_id UUID NOT NULL,
snapshot_date DATE NOT NULL,
balance NUMERIC(14,2) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX ux_snapshot_account_date ON account_snapshots(account_id,snapshot_date);

-- =============================================
-- FUNÇÃO: GERAR SNAPSHOT
-- =============================================

CREATE OR REPLACE FUNCTION generate_account_snapshot(p_account_id UUID,p_date DATE)
RETURNS NUMERIC
AS $$
DECLARE v_balance NUMERIC(14,2);
BEGIN
SELECT COALESCE(SUM(amount),0)
INTO v_balance
FROM journal_lines jl
JOIN journal_entries je ON je.entry_id=jl.entry_id
WHERE jl.account_id=p_account_id
AND je.created_at<=p_date;
INSERT INTO account_snapshots(snapshot_id,account_id,snapshot_date,balance)
VALUES(gen_random_uuid(),p_account_id,p_date,v_balance)
ON CONFLICT(account_id,snapshot_date)
DO UPDATE SET balance=EXCLUDED.balance;
RETURN v_balance;
END;
$$ LANGUAGE plpgsql;

-- =============================================
-- FUNÇÃO: OBTER SALDO
-- =============================================

CREATE OR REPLACE FUNCTION get_account_balance(p_account_id UUID,p_date DATE)
RETURNS NUMERIC
AS $$
DECLARE v_balance NUMERIC(14,2);
BEGIN
SELECT balance INTO v_balance
FROM account_snapshots
WHERE account_id=p_account_id
AND snapshot_date=p_date;
IF v_balance IS NOT NULL THEN RETURN v_balance; END IF;
RETURN generate_account_snapshot(p_account_id,p_date);
END;
$$ LANGUAGE plpgsql;
