# Delete blank lines
/^\s*\r*$/d

# Strip carriage returns from windows/dos files
s/\r$//

# Convert standard keys
s/^Title:/name:/
s/^Description:/description:/
s/^Yield:/servings:/
s/^Original URL:/source_url:/
s/^Source:/source:/
s/^Active:/prep_time:/
s/^Total:/cook_time:/
s/^Categories\: ([a-zA-Z \.\,\-]*)/categories: [\1]/

# Convert image key, download image from URL found, format it, and insert it inline
/^Image:/ {
  h
  s/.*/photo: |/p
  x
  s/^Image: *(.*)$/wget -qO- \1 | uuencode -m test | sed -re '1,1 d' -e '\/===\/,\/===\/ d' -e 's\/^\/  \/'/e
}

# Convert key, strip leading spaces and asterisks, 
# convert ingredients with '[]' to : to properly display as a section in paprika
/^Ingredients/,/^Instructions/ {
  s/^Ingredients:/ingredients: |/
  /^ingredients|Instructions/ !{
    s/^[ \t\*]*/  /
    s/\[(.*)\]/\1:/
  }
}

# convert instructions with '[]' to : to properly display as a section in paprika
# Add a line after each instruction so paprika lets to select the instruction whilecooking
/^Instructions/,/^Notes/ {
  s/^Instructions:\s*(.*)$/directions: |/
  /^directions|Notes/ !{
    s/\s*/  /
    s/\[(.*)\]/\1:/
    a
  }
}

# convert the key
# convert notes with '[]' to : to properly display as a section in paprika
# add a line after each note so paprika recognizes that they are not the same paragraph
/^Notes/, $ {
  s/^Notes:\s*(.*)/notes: |\n  \1/
  /^notes/ !{
    s/\s*/  /
    s/\[(.*)\]/\1:/
    a
  }
}
