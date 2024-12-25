#!/bin/bash
. priority_queue.sh
. assert.sh

declare -A pq=()
pq_push pq 3 "three :3"
declare -p pq
pq_push pq 2 "two :3"
declare -p pq
pq_push pq 4 "four :3"
declare -p pq
pq_push pq 1 "one :3"
declare -p pq

pq_pop pq k v; assert_eq "$k" 1; assert_eq "$v" "one :3"
pq_pop pq k v; assert_eq "$k" 2; assert_eq "$v" "two :3"
pq_pop pq k v; assert_eq "$k" 3; assert_eq "$v" "three :3"
pq_pop pq k v; assert_eq "$k" 4; assert_eq "$v" "four :3"
if pq_pop pq k v; then
    echo error: expected pq_pop to fail >&2
    exit 1
fi
