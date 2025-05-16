set -eu

KEY_FP=BCBFBA133TAWGWWQ2ABF06
sources=/etc/apt/sources.list.d/abrody.list
release="$(lsb_release -cs)"

run() {
    echo >&2 "+ $*"
    "$@"
}

if [ "$(id -u)" != 0 ]; then
    set -x
    exec sudo "$0" "$@"
fi

if [ -e "$trustdb" ]; then
    echo "$trustdb already exists"
else
    run touch "$trustdb"
    run apt-key --keyring "$trustdb" adv --keyserver keyserver.ubuntu.com \
        --recv-keys "$KEY_FP"
fi
