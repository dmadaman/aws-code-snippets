Some calculated fields that I found useful for splitting URIs into substrings:
```
firstSlash = locate({cs-uri-stem},'/', 8)

secondSlash = locate({cs-uri-stem},'/', {firstSlash} + 1)

thirdSlash = locate({cs-uri-stem},'/', {secondSlash} + 1)

fourthSlash = locate({cs-uri-stem},'/', {thirdSlash} + 1)

CNAME = substring({cs-uri-stem},8,{firstSlash} - 8)

CNAME+firstDir = substring({cs-uri-stem},8,{secondSlash}-7)

CNAME+secondDir = substring({cs-uri-stem},8,{thirdSlash}-7)

```