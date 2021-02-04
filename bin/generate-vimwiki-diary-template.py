#!/usr/bin/python
# Found on https://frostyx.cz/posts/vimwiki-diary-template

import sys
import datetime

template = """# Daglog {date}

## Todo

## Notes"""

date = (datetime.date.today() if len(sys.argv) < 2
        # Expecting filename in YYYY-MM-DD.foo format
        else sys.argv[1].rsplit(".", 1)[0])
print(template.format(date=date))
