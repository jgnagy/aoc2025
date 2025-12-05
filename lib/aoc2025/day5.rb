# frozen_string_literal: true

module Aoc2025
  # Solution for day 5.
  class Day5 < Solution
    def part1(sample: false)
      load_input(sample:)

      ranges_data, available_ids_data = parse_data_for_part1

      ranges = parse_ranges(ranges_data)

      available_ids = available_ids_data.map(&:to_i)

      available_ids.select { |id| ranges.any? { |range| range.include?(id) } }.size
    end

    def part2(sample: false)
      load_input(sample:)

      ranges_data, _ids = parse_data_for_part1

      # Establish ranges
      ranges = parse_ranges(ranges_data)

      # Sort ranges by their starting point to facilitate merging
      sorted_ranges = ranges.sort_by(&:begin)
      merged_ranges = []

      # Merge overlapping ranges
      sorted_ranges.each do |current_range|
        if merged_ranges.empty? || merged_ranges.last.end < current_range.begin - 1
          merged_ranges << current_range
        else
          last_range = merged_ranges.pop
          merged_ranges << (last_range.begin..[last_range.end, current_range.end].max)
        end
      end

      # Calculate total unique IDs covered by merged ranges
      merged_ranges.sum(&:size)
    end

    private

    def parse_data_for_part1
      @data
        .split("\n\n")
        .map { _1.split("\n") }
    end

    def parse_ranges(data)
      data.map do |line|
        start_id, end_id = line.split("-").map(&:to_i)
        (start_id..end_id)
      end
    end
  end
end
