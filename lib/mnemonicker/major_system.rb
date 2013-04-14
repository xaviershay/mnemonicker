module Mnemonicker
  class MajorSystem
    MAPPINGS = {
      'S' => 0,
      '0' => 1,
      'T' => 1,
      'D' => 1,
      'N' => 2,
      'M' => 3,
      'R' => 4,
      'L' => 5,
      'J' => 6,
      'K' => 7,
      'F' => 8,
      'V' => 8,
      'P' => 9,
      'B' => 9,
      'X' => 6,
      'A' => nil,
      'W' => nil,
      'H' => nil
    }

    def self.word_to_number(word)
      # Metaphone is insufficient since it has a maximum length of six, which
      # does not work for long words like "hindquarters" or "manufacturing".
      #
      # Best phonetic algorithm I have found though.
      metaphone = RubyFish::DoubleMetaphone.phonetic_code(word)[0]
      metaphone.gsub!(/KS$/, "")    # fox    => FKS  => F
      metaphone.gsub!(/RNK$/, "RK") # turing => TRNK => TRK
      n = ""
      metaphone.each_char do |c|
        if MAPPINGS.has_key?(c)
          n << MAPPINGS[c].to_s if MAPPINGS[c]
        else
          raise "No mapping for #{c}"
        end
      end
      n
    end
  end
end
