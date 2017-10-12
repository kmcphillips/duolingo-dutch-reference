# frozen_string_literal: true
require_relative "base"
require "tty-progressbar"

puts "Creating database"

DB.reset

puts "Loading source file"

data = JSON.parse(File.read("dutch.json"))

bar = TTY::ProgressBar.new("Creating lessons and words [:bar] :current/:total", total: data.length)

data.each do |lesson_name, values|
  Lesson.insert(name: lesson_name)

  lesson = Lesson.last

  values.each do |value|
    Word.insert(value: value, lesson_id: lesson.id)
  end

  bar.advance(1)
end

puts "Done"
