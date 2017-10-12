# frozen_string_literal: true
require_relative "base"

puts "Creating an empty DB"

DB.reset

puts "Loading source file"

data = JSON.parse(File.read("dutch.json"))

print "Processing lessons"

data.each do |lesson_name, values|
  Lesson.insert(name: lesson_name)

  lesson = Lesson.last

  values.each do |value|
    Word.insert(value: value, lesson_id: lesson.id)
  end

  print "."
end

puts ""
puts "Created #{Lesson.count} lessons"
