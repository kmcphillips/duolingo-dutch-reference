# frozen_string_literal: true
class Word < Sequel::Model
  many_to_one :lesson
end