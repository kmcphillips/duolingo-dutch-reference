# frozen_string_literal: true
require_relative "base"

puts "Connecting to DB"

DB.connect

puts "Adding definitions"

words = Word.where(definition: nil)

puts "Processing #{ words.count } words"

words.each do |word|
  lookup = Lookup.new(word.value)

  if lookup.value
    word.definition = lookup.value
    word.source = lookup.source
    word.save
    print "."
  end
end
