Mnemonicker
===========

An encoder and decoder for the [mnemonic major system][major-system] for
remembering numbers.

[major-system]: https://en.wikipedia.org/wiki/Mnemonic_major_system

Usage
-----

```
> gem install mnemonicker
> mnemonicker

Commands

   encode [number] - Suggest words that can represent the number
   decode [*words] - Convert words to numbers
   update          - Download latest wordlist
   help            - This output

System

   Each number maps to a group of similar sounds, which you can then make
   a sentence out of that is easier to remember than the numbers themself.

   # | Sound     | Way to remember
   --+-----------+---------------------------
   0 | s, z      | z is the first letter of zero
   1 | t, th, t  | t & d have one downstroke
   2 | n         | n has two downstrokes
   3 | m         | m has three downstrokes
   4 | r         | r is the last character of four
   5 | l         | L is the roman numeral for 50
   6 | sh, ch, j | I just remember this one
   7 | k         | K contains two sevens back to back
   8 | f, v      | Script f looks like an 8
   9 | p, b      | p and b both very similar shape to 9

   Any sounds not in this list (vowels, "w", "h", "x") are "free" and do not
   represent anything.

> mnemonicker encode 314
emitter
matter
meter
mother
motor
> mnemonicker decode mother
314
> mnemonicker decode a man a plan a canal panama
32952725923
```

Known Issues
------------

Mnemonicker uses the [Double Metaphone][double-metaphone] phonetic encoding algorithm, which causes some limitations:

* Does not decode long words correctly. For instance, "hindquarters" and
  "manufacturing" are both a number of digits short.
* Certain words with odd pronunciation (such as "enough") are incorrectly
  decoded.

Additionally, the current word list is somewhat anemic.

That said, the goal of this project is to spark your imagination. Only you can
combine words in a way that is memorable to you!

[double-metaphone]: https://en.wikipedia.org/wiki/Metaphone
