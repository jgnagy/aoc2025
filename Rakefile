# frozen_string_literal: true

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")

require "rspec/core/rake_task"
require "aoc2025"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]
