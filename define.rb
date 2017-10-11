# frozen_string_literal: true
require_relative "base"

puts "Connecting to DB"

DB.connect

puts "Adding definitions"

words = Word.where(definition: nil)

puts "Processing #{ words.count } words"

words.each do |word|
  definition = Definition.new(word.value)

  if definition.value
    word.definition = definition.value
    word.source = definition.source
    word.save
    print "."
  end
end
