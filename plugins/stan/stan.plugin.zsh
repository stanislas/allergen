MYSERVER=paganini.ergon.ch
for c in tel show_login viaz_activity viaz_bill viaz_item_export viaz_show_bad zpz zaz asknis viaz
do
    CMD="alias $c=\"ssh -q -t $MYSERVER $c\""
    eval $CMD
done

function viaz_add {
	ssh -q -t paganini.ergon.ch viaz_add $1 $2 $3 $4 \'$5\'
}

function copy-and-tag-schema {
	ant -Dschema.tag=${1} copy-and-tag-schema; hg commit -A -m "copy-and-tag-schema ${1}"
}

function move-and-tag-migration {
	ant -Dfrom.version=${1} -Dto.version=${2} move-and-tag-migration; hg commit -A -m "move-and-tag-migration from ${1} to ${2}"
}

function archive-schema {
	ant -Dschema.tag=${1} archive-schema; hg commit -A -m "archive schema ${1}";
}

function archive-migration {
	ant -Dfrom.version=${1} -Dto.version=${2} archive-migration; hg commit -A -m "archive migration ${1} to ${2}";
}

function virgo-pid {
	ps -ef | grep virgo | grep -v grep | grep java | awk '{print $2}';
}

function viaz-start {
	/Users/nanchen/Library/soft/viaz-tomcat/bin/startup.sh
}

function viaz-stop {
	/Users/nanchen/Library/soft/viaz-tomcat/bin/shutdown.sh
}

function link-training-config {
	ln -s /home/nanchen/coop/repository/management/testing/server/ch.ergon.mws.test.training/src/test/resources/testdata/training-config/my-first-config .
}

function cp-jtt {
	\rm -fr /home/nanchen/soft/jtt
	cp -r /usr2/ergon/jtt/jtt/dist /home/nanchen/soft/jtt
}

function java7 {
	export JAVA_HOME=/usr/lib/jvm/java-1.7.0
	export PATH=$JAVA_HOME/bin:${PATH}
}

function va {
	viaz_activity $1 all
}

function vag {
	viaz_activity $1 all | grep -i $2
}

export JAVA_HOME=/usr/java/default

alias hg-pull-merge-push-pull='hg pull && hg merge && hg ci -m "merge" && hg push && hg pull -u'