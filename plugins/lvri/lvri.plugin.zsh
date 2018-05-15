# LVRI
export LVRI=/Users/stan/work/lvri/lvri

function lvri-db-reset {
	pushd $LVRI/tools/migration
	{
		psql -U postgres -d postgres -h localhost -p 5444 -f drop_db.sql
		psql -U postgres -d postgres -h localhost -p 5444 -f setup_db.sql
		export GPG_TTY=$(tty)
		aws --profile deepimpact-skuld s3 cp s3://lvri/dumps/lvri_test_20180420.dump.pgp - | \
  			gpg --decrypt | \
  			psql -U lvri_usr -d lvri -h localhost -p 5444 
		cd $LVRI/
		lein run -m tools.db/baseline-migrate # or just baseline to test migrations
	}
	popd
}