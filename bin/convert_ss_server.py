#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys
import json


def convert_ss_to_clash_config(filename):
    config = json.load(open(filename))
    for ss in config["configs"]:
        print(
            f"- {{ name: \"{ss['remarks']}\", type: trojan, server: {ss['server']}, port: {ss['server_port']}, password: {ss['password']} }}"
        )

    for ss in config["configs"]:
        print(f"- \"{ss['remarks']}\"")


if __name__ == "__main__":
    convert_ss_to_clash_config(sys.argv[1])
