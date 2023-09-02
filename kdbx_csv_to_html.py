from collections import defaultdict
import csv
import datetime
import html
import os
import argparse
from typing import NamedTuple


class Item(NamedTuple):
    title: str
    username: str
    password: str
    notes: str


# When the index.html has been saved one can use
# "npx http-server ." to start a server
parser = argparse.ArgumentParser()
parser.add_argument("csv")
args = parser.parse_args()

with open(args.csv, encoding="utf-8") as f:
    reader = csv.DictReader(f)
    groups = defaultdict(list[Item])
    for row in reader:
        groups[row["Group"]].append(
            Item(
                title=row["Title"],
                username=row["Username"],
                password=row["Password"],
                notes=row["Notes"],
            )
        )

print("<html>")
print("<head>")
print("<style>")
print("body {font-family: monospace;}")
print("th {text-align: left;}")
print("tr {font-size: 12px;}")
print("</style>")
print("</head>")
print("<body>")

print("<table>")
first = True
for key, group in groups.items():
    if not first:
        print("  <tr><th>&nbsp;</th></tr>")

    if first:
        now = datetime.datetime.now().strftime("%Y-%m-%d")
        file = os.path.basename(__file__)
        print(
            f"  <tr><th colspan='2'>{html.escape(key)}</th><th colspan='2'>{file} {now}</th></tr>"
        )
    else:
        print(f"  <tr><th colspan='4'>{html.escape(key)}</th></tr>")

    print("  <tr>")
    print("    <th>Title</th>")
    print("    <th>Username</th>")
    print("    <th>Password</th>")
    print("    <th>Notes</th>")
    print("  </tr>")
    for item in group:
        print("  <tr>")
        print(f"    <td>{html.escape(item.title)}</td>")
        print(f"    <td>{html.escape(item.username)}</td>")
        print(f"    <td>{html.escape(item.password)}</td>")
        notes = item.notes.replace("\n", " ")
        print(f"    <td>{html.escape(notes)}</td>")
        print("  </tr>")

    first = False

print("</table>")

print("</body>")
print("</html>")
