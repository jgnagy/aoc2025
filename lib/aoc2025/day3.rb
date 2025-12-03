# frozen_string_literal: true

module Aoc2025
  # Solution for day 3.
  class Day3 < Solution
    def part1(sample: false)
      load_input(sample:)

      @batteries = parse_data_for_part1

      @batteries.map do |battery_row|
        first_num, remaining_batteries = highest_number_with_batteries_to_right(battery_row)
        (first_num.to_s + remaining_batteries.max.to_s).to_i
      end.sum
    end

    def part2(sample: false)
      load_input(sample:)

      @batteries = parse_data_for_part1

      @batteries.map do |battery_row|
        batteries_to_use = []
        11.downto(0) do |min_to_right|
          num, remaining_batteries = highest_number_with_batteries_to_right(battery_row, min_to_right:)
          batteries_to_use << num
          battery_row = remaining_batteries
        end

        batteries_to_use.map(&:to_s).join.to_i
      end.sum
    end

    private

    def parse_data_for_part1
      @data
        .split("\n")
        .map { _1.chars.map(&:to_i) }
    end

    def highest_number_with_batteries_to_right(batteries, min_to_right: 1)
      total_batteries = batteries.size
      9.downto(1).find do |num|
        num_position = batteries.index(num)
        next false if num_position.nil? # number not found
        next if num_position >= total_batteries - min_to_right # number is too close to end

        return [num, batteries[(num_position + 1)..]]
      end
    end
  end
end
