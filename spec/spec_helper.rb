# Make sure specs run with the definitions from test.rb
ENV['ROBOT_ENVIRONMENT'] = 'development'

require 'coveralls'
Coveralls.wear!

bootfile = File.expand_path(File.dirname(__FILE__) + '/../config/boot')
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require bootfile

require 'pry'
require 'rspec'
require 'awesome_print'
require 'nokogiri'
require 'equivalent-xml'
require 'equivalent-xml/rspec_matchers'
