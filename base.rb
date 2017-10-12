# frozen_string_literal: true
require "pry"
require "active_support/all"
require "json"
require "sqlite3"
require "sequel"
require "glosbe/translate"
require "tty-progressbar"

require_relative "db"
