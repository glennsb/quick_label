# Quick Label

This is a quick sinatra app for lab members to quickly print labels.
It basically gives a text form to wrap lp printing of a small syntax
for making barcode labels to the lab's [DataRay](http://www.datarayusa.com)
print server attached to the Zebra label printer

# Requirements

 * Some ancient version of sinatra
 * Some manner of unix for lp
 * The print server setup correctly to the lp system
 * The actual print server

# Printer Notes
 * at 20pt can do 8 lines of 20 characters with 1 leading space
 * at 18pt can do 9 lines of 23 characters with 1 leading space

# License

BSD 3 clause, see LICENSE.txt
