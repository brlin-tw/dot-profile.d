# Shortcut to Hadoop directory
HADOOP_HOME=/usr/lib/hadoop

if is_path_exist "${HADOOP_HOME}"; then
	export HADOOP_HOME
else
	unset HADOOP_HOME
fi
