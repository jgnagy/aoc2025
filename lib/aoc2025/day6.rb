# frozen_string_literal: true

module Aoc2025
  # Solution for day 6.
  class Day6 < Solution
    def part1(sample: false)
      load_input(sample:)

      operations_per_line = parse_data_for_part1

      columns = []

      operations_per_line.each do |operations|
        operations.each_with_index do |value, index|
          columns[index] ||= []
          columns[index] << value.strip
        end
      end

      # grab the last element of each column to determine the operation
      column_operations = columns.map(&:pop)

      results = []
      columns.each_with_index do |col, index|
        results << col.map(&:to_i).reduce(&column_operations[index].to_sym)
      end

      results.sum
    end

    def part2(sample: false)
      load_input(sample:)

      operations = @data.split("\n").last.split(/\s+/).map(&:strip)

      original_numbers_per_line = parse_data_for_part2

      columns = []

      original_numbers_per_line.each do |numbers|
        numbers.each_with_index do |values, index|
          columns[index] ||= []
          columns[index] << values
        end
      end

      results = []

      columns.each_with_index do |col, index|
        results << col
                   .map(&:chars)
                   .transpose
                   .map { _1.join.strip.to_i }
                   .reduce(&operations[index].to_sym)
      end

      results.sum
    end

    private

    # Rows of numbers, ending with the operation to perform
    def parse_data_for_part1
      @data
        .split("\n")
        .map { _1.strip.split(/\s+/) }
    end

    def parse_data_for_part2
      rows = @data.split("\n")
      column_sizes = rows.last.strip.split(/[*+]/).map { _1.chars.size }[1..]
      rows.pop # remove the operations row
      rows.map do |row|
        row_segments = []

        column_sizes.each do |size|
          segment = row[0..(size - 1)]
          row_segments << segment
          row = row[(size + 1)..]
        end

        row_segments << row if row && !row.empty? # last segment

        row_segments
      end
    end
  end
end
