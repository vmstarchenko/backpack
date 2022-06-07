#!/usr/bin/env python3

import os
import re


def main():
    print('Install bash configs')

    regex = r'# LOCALS HERE(.|\n)*# LOCALS END'

    os.chdir(os.path.dirname(__file__))

    with open(os.path.expanduser('~/.bashrc')) as inp:
        value = inp.read()

    with open(os.path.expanduser('.bashrc')) as inp:
        local_section = inp.read().strip('\n')

    if re.search(regex, value):
        value = re.sub(regex, local_section.replace('\\', '\\\\'), value)
    else:
        value = f'{value}\n\n{local_section}'

    with open(os.path.expanduser('~/.bashrc'), 'w') as out:
        out.write(value)


if __name__ == '__main__':
    main()
