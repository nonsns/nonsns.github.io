for k in  IP-ID WemMOS  ledbat+bittorrent ledbat+aqm bufferbloat classification;
do
echo "
---
layout: default
title: $k
permalink: "/dataset/$k"
---

## $k

{% warn $k work in progress %}

" > $k.md
done

