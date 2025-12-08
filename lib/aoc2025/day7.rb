# frozen_string_literal: true

module Aoc2025
  # Solution for day 7.
  class Day7 < Solution
    def part1(sample: false)
      load_input(sample:)

      track_beam_splits(parse_data_for_part1).size
    end

    def part2(sample: false)
      load_input(sample:)

      track_beam_quantum_outcomes(parse_data_for_part1)
    end

    private

    def parse_data_for_part1
      @data
        .split("\n")
        .map(&:chars)
    end

    def track_beam_splits(data)
      splits = []
      beam_source = [data.shift.index("S"), 0]
      reachable_positions = Set[beam_source]

      data.each_with_index do |line, y|
        line.each_with_index do |char, x|
          next unless reachable_positions.include?([x, y])

          if char == "^"
            splits << [x, y]
            reachable_positions << [x - 1, y + 1]
            reachable_positions << [x + 1, y + 1]
          else
            reachable_positions << [x, y + 1]
          end
        end
      end

      splits
    end

    def track_beam_quantum_outcomes(data)
      beam_source_x = data.shift.index("S")
      timeline_counts = Hash.new(0)
      timeline_counts[beam_source_x] = 1

      data.each do |row|
        next_counts = Hash.new(0)

        timeline_counts.each do |x_pos, count|
          if row[x_pos] == "^"
            next_counts[x_pos - 1] += count
            next_counts[x_pos + 1] += count
          else
            next_counts[x_pos] += count
          end
        end

        timeline_counts = next_counts
      end

      timeline_counts.values.sum
    end
  end
end
