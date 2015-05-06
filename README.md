# mboxhtmltocsv
Export .csv from html in an mbox archive.

A little program I wrote to parse values from html in an mbox archive and export a .csv file with those values.

Uses mbox gem to parse mbox archive, oga gem to parse html, and xpath to specify the HTML nodes holding values to be exported.

I used this to parse email archives from Google's Takeout service.


