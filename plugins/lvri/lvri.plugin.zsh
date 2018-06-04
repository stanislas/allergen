# LVRI
export LVRI=/Users/stan/work/lvri/lvri

function lvri-db-reset-baseline {
	pushd $LVRI/tools/migration
	{
		psql -U postgres -d postgres -h localhost -p 5444 -f drop_db.sql
		psql -U postgres -d postgres -h localhost -p 5444 -f setup_db.sql
		export GPG_TTY=$(tty)
		aws --profile deepimpact-skuld s3 cp s3://lvri/dumps/lvri_test_20180420.dump.pgp - | \
  			gpg --decrypt | \
  			psql -U lvri_usr -d lvri -h localhost -p 5444 
		pushd $LVRI/
		lein run -m tools.db/baseline # or just baseline to test migrations
		popd
	}
	popd || echo 'popd'
}

function lvri-db-reset {
	pushd $LVRI/tools/migration
	{
		psql -U postgres -d postgres -h localhost -p 5444 -f drop_db.sql
		psql -U postgres -d postgres -h localhost -p 5444 -f setup_db.sql
		export GPG_TTY=$(tty)
		aws --profile deepimpact-skuld s3 cp s3://lvri/dumps/lvri_test_20180420.dump.pgp - | \
  			gpg --decrypt | \
  			psql -U lvri_usr -d lvri -h localhost -p 5444 
		pushd $LVRI/
		lein run -m tools.db/baseline-migrate dev # or just baseline to test migrations
		popd
	}
	popd || echo 'popd'
}

function lvri-aws-test-db-reset {
	pushd $LVRI/tools/migration
	{
		psql -U postgres -d postgres -h localhost -p 5445 -f drop_db.sql
		psql -U postgres -d postgres -h localhost -p 5445 -f setup_db.sql
		export GPG_TTY=$(tty)
		aws --profile deepimpact-skuld s3 cp s3://lvri/dumps/lvri_test_20180420.dump.pgp - | \
  			gpg --decrypt | \
  			psql -U lvri_usr -d lvri -h localhost -p 5445 
		pushd $LVRI/
		lein run -m tools.db/baseline-migrate aws-test-db # or just baseline to test migrations
    popd	
  }
	popd || echo 'popd'
}

function lvri-pw-reset {
	pushd $LVRI
	{
		lein run -m tools.db/reset-passwords $1
	}
	popd || echo 'popd'
}