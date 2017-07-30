# frozen_string_literal: true
class Lesson < Sequel::Model
  one_to_many :words
end
