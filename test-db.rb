#! /usr/local/bin/ruby
# $Id$

# Berkeley DB ���ɤ߹��ߥƥ���

require 'bdb'

db = BDB::Hash.open("edr_words.db")
db.each_key do |k|
     puts "#{k}\t#{db[k]}"
end
