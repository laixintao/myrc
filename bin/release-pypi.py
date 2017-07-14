#!/usr/bin/python

"""
release new verson for pypi
"""

import os
import commands
import re


def add_one(matched):
    old_version = matched.group(0)
    _version = str(int(matched.group('version')) + 1)
    matches = re.match(r'(\d+\.\d+\.)(\d+)', old_version)
    new_version = matches.group(1) + _version
    print new_version
    return new_version


def write_new_version():
    with open('setup.py', 'r+') as setuppy:
        content = setuppy.read()
        content_new = re.sub("\d+\.\d+\.(?P<version>\d+)", add_one, content)
        setuppy.seek(0)
        setuppy.write(content_new)
        setuppy.close()


if __name__ == '__main__':
    write_new_version()
