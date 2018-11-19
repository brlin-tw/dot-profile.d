# Use user local prefix as GOPATH prefix(for install Go packages)
GOPATH="${HOME}/.local"
export GOPATH

your_go_installation="${HOME}/軟體/go1.10.2.linux-amd64"

if test -d "${your_go_installation}"; then
    GOROOT="${your_go_installation}"
    export GOROOT
    install_executable_search_path "${GOROOT}/bin"
fi
