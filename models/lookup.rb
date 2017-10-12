# frozen_string_literal: true
class Lookup
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def all
    return @all if defined? @all

    @all = SOURCES.map do |klass|
      result = klass.new(@word)

      if result.value
        result
      else
        nil
      end
    end.compact

    @all
  end

  class Glosbe
    def initialize(word)
      @word = word
    end

    def value
      return @value if defined? @value

      response = ::Glosbe::Language.new(from: :nl, to: :en).lookup(@word)

      unless response.success?
        raise "Response not successful with messages: #{response.messages}"
      end

      return unless response.found?

      pieces = [ response.translation ]
      pieces = pieces + response.translated_define.uniq.first(5)
      pieces = pieces.reject(&:blank?)

      @value = pieces.join("\n").presence
    end

    def source
      "Glosbe"
    end
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
      `dict --formatted --nocorrect --database fd-nld-eng "#{ @word }" 2> /dev/null`.presence
    end
  end

  SOURCES = [
    Glosbe,
    Dict,
  ].freeze
end
