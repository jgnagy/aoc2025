# frozen_string_literal: true

module Aoc2025
  # Base class for all solutions to Advent of Code 2024 problems.
  class Solution
    DATA_DIR = File.expand_path("../../data", __dir__)

    private

    def load_input(part: 1, sample: false)
      dir_path = sample ? File.join(DATA_DIR, "samples") : DATA_DIR
      filename_base = self.class.name.split("::").last.downcase
      filenames = [
        File.join(dir_path, "#{filename_base}p#{part}.txt"),
        File.join(dir_path, "#{filename_base}.txt")
      ]
      filename = filenames.find { File.exist?(_1) }
      raise "Input file not found" unless filename

      @data = File.read(filename)
    end
  end
end
