#!/bin/sh

my_path=../../bin

if [ "$1" = clean ]; then
    rm -f *.log *.dat target.txt
    exit
fi

echo "
import sys
sys.path.append('$my_path')
import gen_target
for n in xrange(4):
    gen_target.print_Reber_grammar(500, 100)
    print '\n'
" | python > target.txt

$my_path/rnn-learn -e 10000 -l 1000 -n 30 -t 10.0 -k 1 -a -x 0.001 -m 0.9 target.txt
$my_path/rnn-generate -n 2000 rnn.dat > orbit.log

