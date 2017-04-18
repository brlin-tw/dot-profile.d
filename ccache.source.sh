# https://source.android.com/source/initializing.html
export USE_CCACHE=1

CCACHE_DIR="/mnt/Data/林博仁的檔案/CCache"

if is_path_exist "${CCACHE_DIR}"; then
	export CCACHE_DIR
else
	unset CCACHE_DIR
fi
