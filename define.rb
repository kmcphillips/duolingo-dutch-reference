# frozen_string_literal: true
require_relative "base"

puts "Connecting to database"

DB.connect

puts "Adding definitions"

words = Word.all.to_a.select{ |w| w.definitions.blank? }

bar = TTY::ProgressBar.new("Adding definitions [:bar] :current/:total", total: words.count)

words.each do |word|
  lookup = Lookup.new(word.value)

  # if lookup.value
  #   word.definition = lookup.value
  #   word.source = lookup.source
  #   word.save
  # end

  bar.advance(1)
end
