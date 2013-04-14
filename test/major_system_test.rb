require 'minitest/autorun'

require 'mnemonicker/cli'

class MajorSystemTest < MiniTest::Unit::TestCase
  {
    wikipedia: { # From https://en.wikipedia.org/wiki/Mnemonic_major_system
      "action"  => '762',
      "ghost"   => '701',
      'missile' => '305',
      'mossy'   => '30',
      'sail'    => '05',
    },
    exceptions: {
      "fox"    => '8',
      "turing" => '147',
    },
    known_bugs: {
      "enough"       => '27', # Should be 28
      'hindquarters' => '217' # Should be 2174140
    }
  }.each do |label, examples|
    examples.each do |word, number|
      define_method("test_#{label}_#{word}") do
        assert_equal number, Mnemonicker::MajorSystem.word_to_number(word)
      end
    end
  end
end
