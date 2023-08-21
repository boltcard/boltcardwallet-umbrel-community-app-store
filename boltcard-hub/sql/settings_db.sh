#!/bin/bash

echo "** Creating settings table"

decrypt_key=$(hexdump -vn16 -e'4/4 "%08x" 1 "\n"' /dev/random)
echo $decrypt_key

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	\c card_db;

	DELETE FROM settings;

	-- an explanation for each of the bolt card server settings can be found here
	-- https://github.com/boltcard/boltcard/blob/main/docs/SETTINGS.md

	INSERT INTO settings (name, value) VALUES ('LOG_LEVEL', '$LOG_LEVEL');
	INSERT INTO settings (name, value) VALUES ('AES_DECRYPT_KEY', '$decrypt_key');
	INSERT INTO settings (name, value) VALUES ('HOST_DOMAIN', '$HOST_DOMAIN');
	INSERT INTO settings (name, value) VALUES ('MIN_WITHDRAW_SATS', '$MIN_WITHDRAW_SATS');
	INSERT INTO settings (name, value) VALUES ('MAX_WITHDRAW_SATS', '$MAX_WITHDRAW_SATS');
	INSERT INTO settings (name, value) VALUES ('LN_HOST', '$LN_HOST');
	INSERT INTO settings (name, value) VALUES ('LN_PORT', '$LN_PORT');
	INSERT INTO settings (name, value) VALUES ('LN_TLS_FILE', '$LN_TLS_FILE');
	INSERT INTO settings (name, value) VALUES ('LN_MACAROON_FILE', '$LN_MACAROON_FILE');
	INSERT INTO settings (name, value) VALUES ('FEE_LIMIT_SAT', '$FEE_LIMIT_SAT');
	INSERT INTO settings (name, value) VALUES ('FEE_LIMIT_PERCENT', '$FEE_LIMIT_PERCENT');
	INSERT INTO settings (name, value) VALUES ('LN_TESTNODE', '$LN_TESTNODE');
	INSERT INTO settings (name, value) VALUES ('FUNCTION_LNURLW', '$FUNCTION_LNURLW');
	INSERT INTO settings (name, value) VALUES ('FUNCTION_LNURLP', '$FUNCTION_LNURLP');
	INSERT INTO settings (name, value) VALUES ('FUNCTION_EMAIL', '$FUNCTION_EMAIL');
	INSERT INTO settings (name, value) VALUES ('DEFAULT_DESCRIPTION', '$DEFAULT_DESCRIPTION');
	INSERT INTO settings (name, value) VALUES ('AWS_SES_ID', '$AWS_SES_ID');
	INSERT INTO settings (name, value) VALUES ('AWS_SES_SECRET', '$AWS_SES_SECRET');
	INSERT INTO settings (name, value) VALUES ('AWS_SES_EMAIL_FROM', '$AWS_SES_EMAIL_FROM');
	INSERT INTO settings (name, value) VALUES ('AWS_REGION', '$AWS_REGION');
	INSERT INTO settings (name, value) VALUES ('EMAIL_MAX_TXS', '$EMAIL_MAX_TXS');
	INSERT INTO settings (name, value) VALUES ('FUNCTION_LNDHUB', '$FUNCTION_LNDHUB');
	INSERT INTO settings (name, value) VALUES ('LNDHUB_URL', '$LNDHUB_URL');
	INSERT INTO settings (name, value) VALUES ('FUNCTION_INTERNAL_API', '$FUNCTION_INTERNAL_API');
	INSERT INTO settings (name, value) VALUES ('SENDGRID_API_KEY', '$SENDGRID_API_KEY');
	INSERT INTO settings (name, value) VALUES ('SENDGRID_EMAIL_SENDER', '$SENDGRID_EMAIL_SENDER');


EOSQL

echo "** Finished creating settings table"