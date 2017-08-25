#!/usr/bin/env python

import sys

def main():
    if not sys.argv[1]:
        print("Ussage: formdata typeId=2&test=string")
    form_source = sys.argv[1]
    pairs = form_source.split('&')
    output_template = "[\n{}\n]"
    fields = []
    for pair in pairs:
        key, value = pair.split('=')
        fields.append("    ('{}', '{}'),".format(key, value))
    print output_template.format('\n'.join(fields))


if __name__ == '__main__':
    main()
