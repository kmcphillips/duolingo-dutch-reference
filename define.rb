# frozen_string_literal: true
require_relative "base"

puts "Connecting to DB"

DB.connection

require_relative "word"
require_relative "lesson"

puts "Adding definitions"

words = Word.where(definition: nil)

puts "Processing #{ words.count } words"

words.each do |word|
  definition = Definition.new(word.value)

  if definition.value
    word.definition = definition.value
    word.save
    print "."
  end
end