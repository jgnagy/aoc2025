# frozen_string_literal: true

module Aoc2025
  # Solution for day 1.
  class Day1 < Solution
    def part1(sample: false)
      load_input(sample:)

      @starting_position = 50

      @moves = parse_data_for_part1
      @current_position = @starting_position
      @zero_count = 0

      @moves.each do |direction, distance|
        new_position = rotate_lock(@current_position, direction, distance)
        @zero_count += (new_position.zero? ? 1 : 0)
        @current_position = new_position
      end

      @zero_count
    end

    def part2(sample: false)
      load_input(part: 2, sample:)

      @starting_position = 50

      @moves = parse_data_for_part1
      @current_position = @starting_position
      @zero_count = 0

      @moves.each do |direction, distance|
        new_position, zeros_passed = rotate_lock_counting_zeros(@current_position, direction, distance)
        @zero_count += zeros_passed
        @current_position = new_position
      end

      @zero_count
    end

    private

    def parse_data_for_part1
      @data
        .split("\n")
        .map { [_1.chars.first, _1.chars[1..].join.to_i] }
    end

    # Rotate the lock according to the moves
    # L means rotate left (counter-clockwise)
    # R means rotate right (clockwise)
    def rotate_lock(current_position, direction, distance)
      if direction == "L"
        (current_position - distance) % 100
      else
        (current_position + distance) % 100
      end
    end

    # Rotate the lock according to the moves, counting each time we pass or land on 0
    # L means rotate left (counter-clockwise)
    # R means rotate right (clockwise)
    def rotate_lock_counting_zeros(current_position, direction, distance)
      zero_count = if current_position.zero?
                     distance / 100
                   elsif direction == "L"
                     # Need current_position steps to reach 0, then count additional laps
                     distance >= current_position ? 1 + ((distance - current_position) / 100) : 0
                   else
                     # Need (100 - current_position) steps to reach 0, then count additional laps
                     distance_to_zero = 100 - current_position
                     distance >= distance_to_zero ? 1 + ((distance - distance_to_zero) / 100) : 0
                   end

      [rotate_lock(current_position, direction, distance), zero_count]
    end
  end
end
