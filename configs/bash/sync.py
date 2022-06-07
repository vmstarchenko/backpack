#!/usr/bin/env python3

import re
import os


def main():
    print('Sync bash configs')

    os.chdir(os.path.dirname(__file__))

    with open(os.path.expanduser('~/.bashrc')) as inp:
        value = re.search(r'# LOCALS HERE(.|\n)*# LOCALS END', inp.read())

    if not value:
        print('  WARNING: Bash local section not found, skip')
    else:
        with open('.bashrc', 'w') as out:
            out.write(value.group().strip('\n'))
            out.write('\n')

        print('Bash configs synced')

if __name__ == '__main__':
    main()
