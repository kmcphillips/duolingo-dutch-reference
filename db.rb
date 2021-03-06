# frozen_string_literal: true
module DB
  extend self

  FILENAME = "dutch.sqlite3"

  def connection
    @connection ||= Sequel.connect("sqlite://#{ FILENAME }")
  end

  def connect
    connection

    require_relative "models/lookup"
    require_relative "models/lesson"
    require_relative "models/word"
    require_relative "models/definition"

    connection
  end

  def reset
    @connection = nil

    FileUtils.rm(FILENAME)
    FileUtils.touch(FILENAME)

    migrate
    connect

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
      Integer :learned_count, default: 0
    end

    connection.create_table(:definitions) do
      primary_key :id
      foreign_key :word_id, :words
      String :value, text: true
      String :source
    end
  end
end
