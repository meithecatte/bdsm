# min-heap backed by bash's associative array
#
# indexing:
#   root is at 0
#   left child is at 2n+1
#   right child is at 2n+2
#   parent is at (n-1)/2

# pq_push queue_name key value - insert an element into the queue
#
# Where:
#   queue_name is the name of an associative array in your scope
#          key is an integer expression
#        value is a string
pq_push() {
    local -n _queue="$1"
    local -i _key="$2"
    local _value="$3"

    local _k=${#_queue[@]} _parent  

    # Invariant: we have a hole at $_k, which will get filled with $_key.
    # Logically, the hole already contains $_key, but we don't put it there
    # yet to avoid having to do swaps
    while (( _parent = (_k - 1) / 2, _k )) && (( _key < ${_queue[$_parent]%%:*} )); do
        _queue[$_k]="${_queue[$_parent]}" _k=$_parent
    done

    _queue[$_k]="$_key:$_value"
}

# pq_pop queue_name key value - remove the element with the smallest key
#
# Where:
#   queue_name is the name of an associative array in your scope
#          key is the name of the output variable that will contain the key
#        value is the name of the output variable that will contain the value
#
# Errors:
#   returns 1 if the queue is empty
pq_pop() {
    local -n _queue="$1" _key="$2" _value="$3"
    (( !${#_queue[@]} )) && return 1
    _key="${_queue[0]%%:*}"
    _value="${_queue[0]#*:}"

    local _last=$((${#_queue[@]} - 1)) _k=0 _left _right
    local _lastkey=${_queue[$_last]%%:*}

    # Invariant: we have a hole at $_k, which will get filled with $_last.
    # Logically, the hole already contains $_last, but we don't put it there
    # yet to avoid havving to do swaps
    #
    # while we have a smaller child...
    while (( _left = 2*_k+1, _right = 2*_k+2, _left < _last )) &&
        (( _lastkey > ${_queue[$_left]%%:*} )) ||
        (( _right < _last && _lastkey > ${_queue[$_right]%%:*}+0 ))
    do
        # if the right child exist and is smallest...
        if (( _right < _last )) &&
            (( ${_queue[$_right]%%:*} < ${_queue[$_left]%%:*} ))
        then
            _queue[$_k]="${_queue[$_right]}" _k=$_right
        else
            _queue[$_k]="${_queue[$_left]}" _k=$_left
        fi
    done

    _queue[$_k]="${_queue[$_last]}"
    unset _queue[$_last]
}
