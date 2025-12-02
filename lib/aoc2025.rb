# frozen_string_literal: true

# This is the main module for the Advent of Code 2024 project.
module Aoc2025
  class << self
    def run(day, part, sample: false)
      solution = Object.const_get("Aoc2025::Day#{day}").new
      solution.send("part#{part}", sample: sample)
    end
  end
end

require "aoc2025/version"
require "aoc2025/solution"
require "aoc2025/day1"
require "aoc2025/day2"
