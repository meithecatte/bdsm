assert_eq() {
    if [ "$1" != "$2" ]; then
        echo "assertion error:" >&2
        echo " left: $1" >&2
        echo "right: $2" >&2
        exit 1
    fi
}
