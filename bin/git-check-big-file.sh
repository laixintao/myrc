#! /bin/sh
# shell from: https://stackoverflow.com/a/51315927/6931919
# pre-commit hook: check for large files
TMP=$(mktemp)
trap "rm -f $TMP" 0 1 2 3 15
MAX_FILE_SIZE=1048576 # 1 MB
status=0
git ls-files --stage > $TMP
while read mode hash stage path; do
    objsize=$(git cat-file -s $hash)
    if [ $objsize -gt $MAX_FILE_SIZE ]; then
        echo "file too big: '$path' as staged exceeds $MAX_FILE_SIZE bytes" 1>&2
        status=1
    fi
done < $TMP
exit $status
