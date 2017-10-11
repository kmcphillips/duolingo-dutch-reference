# frozen_string_literal: true
class Definition
  attr_reader :word

  def initialize(word)
    @word = word
  end

  delegate :value, :source, to: :factory, allow_nil: true

  def factory
    return @factory if defined? @factory

    SOURCES.each do |klass|
      source = klass.new(@word)

      if source.value
        @factory = source
        return @factory
      end
    end

    @factory = nil
  end

  class Dict
    def initialize(word)
      @word = word
    end

    def value
      return @value if defined? @value
      if raw = shell_to_dict
        @value = raw.lines.drop(2).map do |l|
          l.starts_with?("dict.org") ? "" : l
        end.join
      else
        @value = nil
      end

      @value
    end

    def source
      "dict fd-nld-eng"
    end

    private

    def shell_to_dict
      `dict --formatted --nocorrect --database fd-nld-eng "#{ @word }"`.presence
    end
  end

  SOURCES = [
    Dict
  ].freeze
end
