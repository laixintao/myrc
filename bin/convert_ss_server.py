#!/usr/local/var/pyenv/shims/python3
# -*- coding: utf-8 -*-

import json

config = json.load(open("gui-config.json"))
for ss in config["configs"]:
    print(
        f"- {{ name: \"{ss['remarks']}\", type: ss, server: {ss['server']}, port: {ss['server_port']}, cipher: {ss['method']}, password: {ss['password']} }}"
    )

for ss in config["configs"]:
    print(f"- \"{ss['remarks']}\"")
