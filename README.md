# Duolingo Dutch-English

This project exported all the words from Duolingo's Dutch-English lessons, and shows them with definitions for further studying.

## Files

* `dutch.json` : Source data file of lesson names and words.
* `dutch.sqlite3` : DB with words and lessons and as many definitions as possible added.

## Usage

* `load.rb` : Parse and load the JSON file into the DB.
* `define.rb` : Take any words without definitions in the DB and add them from sources.
* `app.rb` : Run the Sinatra app on http://localhost:4567/

Currently the only source is the `dict fd-nld-eng` package. But it's proving to only be around 70% hit rate.
