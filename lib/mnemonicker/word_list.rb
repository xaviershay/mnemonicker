module Mnemonicker
  class WordList < Struct.new(:key)
    class ListNotFound < RuntimeError; end

    def fetch
      JSON.parse(File.read(cache_file))
    rescue
      raise ListNotFound
    end

    def update(&block)
      wordlist = {
        version:    1,
        fetched_at: Time.now.utc,
        'words' => {}
      }
      index = fetch_url('index.html')
      index.lines.each do |line|
        line = line.chomp
        words = fetch_url(line)
        words.lines.each do |word|
          word = word.chomp
          number = MajorSystem.word_to_number(word)
          wordlist['words'][number] ||= []
          wordlist['words'][number] << word
        end
        if block
          block.call(line, words.lines.count)
        end
      end

      FileUtils.mkdir_p(File.dirname(cache_file))
      File.open(cache_file, "w") {|f| f.write wordlist.to_json }
    end

    private

    def cache_file
      File.expand_path("~/.mnemonicker/#{key}.json")
    end

    def fetch_url(file)
      Net::HTTP.get('xaviershay.github.io', '/mnemonicker-wordlist/' + file)
    end
  end
end
