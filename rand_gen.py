#!/usr/bin/python

import random
import sys

max_int = 2**31
max_64 = 2**63
max_128 = 2**127
for i in range(0, 10):
    print random.randrange(0, max_int)
for i in range(0, 10):
    print random.randrange(0, max_64)
for i in range(0, 10):
    print random.randrange(0, max_128)

