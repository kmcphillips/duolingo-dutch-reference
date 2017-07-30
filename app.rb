# frozen_string_literal: true

require "sinatra"
require "erb"

require_relative "base"

DB.connection

require_relative "word"
require_relative "lesson"

get "/" do
  @lessons = Lesson.all
  erb :index
end
