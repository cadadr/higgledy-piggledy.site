#!/bin/sh
# transform.sh --- markdown -> html

# Copyright (C) 2022 İ. Göktuğ Kayaalp <self at gkayaalp dot com> This
# file is part of “The Higgledy-Piggledy Website”.
#
# “The Higgledy-Piggledy Website” is non-violent software: you can use,
# redistribute, and/or modify it under the terms of the CNPLv6+ as found
# in the LICENCE_CNPLv6.txt file in the source code root directory or at
# <https://git.pixie.town/thufie/CNPL>.
#
# “The Higgledy-Piggledy Website” comes with ABSOLUTELY NO WARRANTY, to
# the extent permitted by applicable law.  See the CNPL for details.


# POSIX strict-ish mode, beware eager pipelines!
set -eu

infil=$1

eval "$(sed -e 's/\$/\\$/g' -e '//,$d' $infil)"

sed -e '1,//d' -e '$s/$/\n\n/' $infil  \
    | cat - partials/_links.markdown     \
    | pandoc -f markdown -t html         \
    | ( echo "<!-- $infil --- [page content] -->"; cat - ) \
    | sed 's/^/    /'                    \
    | cat partials/_head.html - partials/_foot.html \
    | sed -e "s/@@LANG@@/$language/g"    \
          -e "s/@@TITLE@@/$title/g"

