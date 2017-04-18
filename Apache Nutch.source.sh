# 依照下列網頁說明設定 Nutch 跟 Solr 軟體的根目錄
# http://wiki.apache.org/nutch/NutchTutorial#A4._Setup_Solr_for_search
NUTCH_RUNTIME_HOME="$HOME/軟體/Apache Nutch"

if is_path_exist "${NUTCH_RUNTIME_HOME}" ; then
	export NUTCH_RUNTIME_HOME
	install_executable_search_path "${NUTCH_RUNTIME_HOME}"
else
	unset NUTCH_RUNTIME_HOME
fi
