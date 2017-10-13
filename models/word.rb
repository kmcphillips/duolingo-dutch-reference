# frozen_string_literal: true
class Word < Sequel::Model
  many_to_one :lesson
  one_to_many :definitions

  def definition_lines
    if definitions.any?
      definitions.map do |definition|
        definition.value.split("\n")
      end.flatten.compact
    else
      []
    end
  end
end
