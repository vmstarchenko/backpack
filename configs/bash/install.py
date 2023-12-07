#!/usr/bin/env python3

import os
import re
import sys


def main():
    copy = '--copy' in sys.argv
    root = os.path.dirname(os.path.abspath(os.path.expanduser(__file__)))
    bashrc_custom = os.path.expanduser('~/.bashrc_custom')
    os.chdir(os.path.dirname(__file__))

    print('Install bash configs')

    # patch bashrc
    regex = r'# LOCALS HERE(.|\n)*# LOCALS END'
    bashrc_section = '# LOCALS HERE\n[[ -f "$HOME/.bashrc_custom" ]] && . ~/.bashrc_custom\n# LOCALS END'

    with open(os.path.expanduser('~/.bashrc')) as inp:
        value = inp.read()

    if re.search(regex, value):
        value = re.sub(regex, bashrc_section, value)
    else:
        value = f'{value}\n\n{bashrc_section}'

    with open(os.path.expanduser('~/.bashrc'), 'w') as out:
        out.write(value)

    # update bashrc_custom
    if copy:

        with open(os.path.expanduser('.bashrc')) as inp:
            local_section = inp.read().strip('\n')

        os.unlink(bashrc_custom)
        with open(bashrc_custom, 'w') as out:
            out.write(local_section)
    else:
        os.unlink(bashrc_custom)
        os.symlink(
            os.path.join(root, '.bashrc'),
            bashrc_custom)



if __name__ == '__main__':
    main()
