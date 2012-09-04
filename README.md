# Description [![Build Status](https://secure.travis-ci.org/martinos/rubyc.png?branch=master)](http://travis-ci.org/martinos/rubyc)
Adds Ruby's power to the command line.
Supports many enumerator methods applied to STDIN. The current line is represented by the "line" variable name or it's shorter alias 'l'.

To get help:
  rubyc help

## Examples
``` bash
$ ls | rubyc map 'line.upcase'
GEMFILE
RAILS_VERSION
README.RDOC
RAKEFILE
ACTIONMAILER
ACTIONPACK
...
```
Here are the currently supported methods:
  compact      # Remove empty lines
  count_by     # Count the number of lines that have the same property. The property is defined by the return value of the given the block.
  grep         # Enumerable#grep the first argument is the pattern matcher and the second is the block executed on each line.
  map          # Apply Enumerable#map on each line and outputs the results of the block by calling to_s on the returned object.
  merge        # Merge consecutive lines
  scan         # String#scan
  select       # Enumerable#select
  sort_by      # Emumerable#sort_by
  sum          # Rails Enumerable#sum
  uniq         # uniq
  
