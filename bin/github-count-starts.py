#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
first version:
https://github.com/guofei9987/github_star_counter/blob/master/github_counter.py
"""

__author__ = "guofei9987"

import sys, json
import http.client

github_id = "laixintao"
conn = http.client.HTTPSConnection("api.github.com")
headers = {"User-Agent": "Mozilla/5.0 (platform; rv:geckoversion) Gecko/geckotrail Firefox/firefoxversion"}


url = "https://api.github.com"
repo_list = []
page = 1
while True:
    print("request page = {}...".format(page))
    conn.request("GET", f"/users/{github_id}/repos?page={page}", headers=headers)
    response = conn.getresponse()

    resp_body = response.read().decode('utf-8')
    if response.status != 200:
        print("HTTP Reponse code = {}".format(response.status))
        print(resp_body)
        sys.exit(1)

    repo_array = json.loads(resp_body)
    if len(repo_array) == 0:
        break

    for repo in repo_array:
        if not repo["fork"]:
            repo_list.append(
                [repo["name"], repo["stargazers_count"], repo["forks_count"]]
            )
    page += 1

# sort by number of stars
repo_list = sorted(repo_list, key=lambda x: x[1], reverse=True)

print("=" * 55)
print("\n".join(["{: <50}★{: <5}\tfork {} ".format(*repo) for repo in repo_list]))
print("=" * 55)
print(
    "{: <30}★{: <10}\tfork {} ".format(
        "total", sum([i[1] for i in repo_list]), sum([i[2] for i in repo_list])
    )
)
