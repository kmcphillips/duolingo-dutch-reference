# frozen_string_literal: true
require_relative "base"

puts "Connecting to database"

DB.connect

puts "Adding definitions"

words = Word.all.to_a.select{ |w| w.definitions.blank? }

bar = TTY::ProgressBar.new("Adding definitions [:bar] :current/:total", total: words.count)

words.each do |word|
  Lookup.new(word.value).all.each do |result|
    Definition.insert(value: result.value, source: result.source, word_id: word.id)
  end

  bar.advance(1)
end
