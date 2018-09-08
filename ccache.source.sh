# https://source.android.com/source/initializing.html

if command -v ccache >/dev/null 2>/dev/null; then
	USE_CCACHE=1
	CC='ccache gcc'
	CXX='ccache g++'

	export \
		USE_CCACHE \
		CC \
		CXX
fi
