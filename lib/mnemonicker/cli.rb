require 'json'
require 'fileutils'
require 'net/http'

require 'rubyfish'

require 'mnemonicker/major_system'
require 'mnemonicker/word_list'

module Mnemonicker
  class CLI
    def self.run(*args)
      cmd = args.shift
      cmd ||= 'help'
      cmd = cmd[0].upcase + cmd[1..-1]
      handler = Commands.const_get(cmd)
      handler.new.process(*args)
    rescue NameError
      Commands::Help.new.process
    end
  end

  module Commands
    class Update
      def process
        Mnemonicker::WordList.new('cli').update do |file, count|
          puts "%s...%i words" % [file, count]
        end
      end
    end

    class Encode
      def process(number)
        tried = false
        list = WordList.new('cli')
        wordlist = begin
          list.fetch
        rescue WordList::ListNotFound
          if tried
            raise
          else
            tried = true
            $stderr.puts "No word list found, downloading..."
            list.update
            retry
          end
        end

        candidates = wordlist['words'][number]

        puts candidates.sort if candidates
        true
      end
    end

    class Decode
      def process(*words)
        words.each do |word|
          puts MajorSystem.word_to_number(word)
        end
      end
    end

    class Help
      def process
$stderr.puts <<-EOS

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

 EOS
      end
    end
  end
end
