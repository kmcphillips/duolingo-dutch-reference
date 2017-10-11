# frozen_string_literal: true
module DB
  extend self

  FILENAME = "dutch.sqlite3"

  def connection
    @connection ||= Sequel.connect("sqlite://#{ FILENAME }")
  end

  def connect
    connection

    require_relative "models/definition"
    require_relative "models/word"
    require_relative "models/lesson"

    connection
  end

  def reset
    FileUtils.rm(FILENAME)
    FileUtils.touch(FILENAME)
    @connection = nil
    migrate

    nil
  end

  def migrate
    connection.create_table(:lessons) do
      primary_key :id
      String :name
    end

    connection.create_table(:words) do
      primary_key :id
      foreign_key :lesson_id, :lessons
      String :value
      String :definition, text: true
      String :source
    end
  end
end
