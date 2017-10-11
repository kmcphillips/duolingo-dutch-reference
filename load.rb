# frozen_string_literal: true
require_relative "base"

puts "Connecting to DB"

DB.connect

puts "Resetting the DB"

DB.reset

puts "Loading source file"

data = JSON.parse(File.read("dutch.json"))

print "Processing lessons"

data.each do |lesson_name, values|
  Lesson.insert(name: lesson_name)

  lesson = Lesson.last

  values.each do |value|
    Word.insert(value: value)
    word = Word.last

    lesson.add_word(word)
  end

  print "."
end

puts ""
puts "Done"
