# frozen_string_literal: true

require "sinatra"
require "erb"

require_relative "base"

DB.connection

get "/" do
  @lessons = Lesson.all
  erb :index
end
