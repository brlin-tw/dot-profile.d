# Use user local prefix as GOPATH prefix(for install Go packages)
export GOPATH="${HOME}/.local" 
export GOROOT="${HOME}/軟體/go1.10.2.linux-amd64"
install_executable_search_path "${GOROOT}/bin"
