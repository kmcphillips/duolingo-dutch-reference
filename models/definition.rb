# frozen_string_literal: true
class Definition < Sequel::Model
  many_to_one :word
end
