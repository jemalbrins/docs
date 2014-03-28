#!/bin/bash

make html
s3cmd sync --acl-public _build/html/ s3://docs.tribapps.com
