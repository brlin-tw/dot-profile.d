HBASE_HOME=/usr/lib/hbase

if is_path_exist "${HBASE_HOME}"; then
	export HBASE_HOME
else
	unset HBASE_HOME
fi