# frozen_string_literal: true

module Aoc2025
  # Solution for day 2.
  class Day2 < Solution
    def part1(sample: false)
      load_input(sample:)

      ranges = parse_data_for_part1

      invalid_ids = []

      ranges.each do |range_start, range_end|
        invalid_ids += (range_start.to_i..range_end.to_i).reject do |num|
          check_id_validity(num.to_s)
        end
      end

      invalid_ids.sum
    end

    def part2(sample: false)
      load_input(sample:)

      ranges = parse_data_for_part1

      invalid_ids = []

      ranges.each do |range_start, range_end|
        invalid_ids += (range_start.to_i..range_end.to_i).reject do |num|
          check_id_extended_validity(num.to_s)
        end
      end

      invalid_ids.sum
    end

    private

    def parse_data_for_part1
      @data
        .split(",")
        .map { [_1.split("-").first, _1.split("-").last] }
    end

    def check_id_validity(id)
      return true if id.length.odd?

      half_length = id.length / 2
      first_half, second_half = id.partition(/.{#{half_length}}/)[1, 2]
      first_half != second_half
    end

    # an ID is invalid if it is made only of some sequence of digits repeated at least twice.
    # So, 12341234 (1234 two times), 123123123 (123 three times),
    # 1212121212 (12 five times), and 1111111 (1 seven times) are all invalid IDs.
    def check_id_extended_validity(id)
      (1..(id.length / 2)).each do |seq_length|
        next unless (id.length % seq_length).zero?

        sequence = id[0, seq_length]
        repetitions = id.length / seq_length
        return false if sequence * repetitions == id
      end

      true
    end
  end
end
