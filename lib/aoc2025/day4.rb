# frozen_string_literal: true

module Aoc2025
  # Solution for day 4.
  class Day4 < Solution
    def part1(sample: false)
      load_input(sample: sample)

      @grid = parse_data_for_part1

      max_y = @grid.size - 1
      max_x = @grid[0].size - 1

      find_accessible_paper(@grid, max_x, max_y)
    end

    def part2(sample: false)
      load_input(sample: sample)

      @grid = parse_data_for_part1

      max_y = @grid.size - 1
      max_x = @grid[0].size - 1

      total_accessible = 0

      loop do
        accessible_count = find_accessible_paper(@grid, max_x, max_y)
        break if accessible_count.zero?

        total_accessible += accessible_count
        @grid = find_and_remove_accessible_paper(@grid, max_x, max_y)
      end

      total_accessible
    end

    private

    def parse_data_for_part1
      @data
        .split("\n")
        .map(&:chars)
    end

    def find_accessible_paper(grid, max_x, max_y)
      grid.each_with_index.sum do |row, y|
        row.each_with_index.count do |cell, x|
          next false unless cell == "@"

          adjacent_rolls = []
          (-1..1).each do |neighbor_y|
            (-1..1).each do |neighbor_x|
              next if neighbor_x.zero? && neighbor_y.zero?

              new_x = x + neighbor_x
              new_y = y + neighbor_y

              adjacent_rolls << grid[new_y][new_x] if new_y.between?(0, max_y) && new_x.between?(0, max_x)
            end
          end

          adjacent_rolls.count { _1 == "@" } < 4
        end
      end
    end

    def find_and_remove_accessible_paper(grid, max_x, max_y)
      removed_rolls = []
      grid.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          next unless cell == "@"

          adjacent_rolls = []
          (-1..1).each do |neighbor_y|
            (-1..1).each do |neighbor_x|
              next if neighbor_x.zero? && neighbor_y.zero?

              new_x = x + neighbor_x
              new_y = y + neighbor_y

              adjacent_rolls << grid[new_y][new_x] if new_y.between?(0, max_y) && new_x.between?(0, max_x)
            end
          end

          next unless adjacent_rolls.count { _1 == "@" } < 4

          removed_rolls << [x, y]
        end
      end

      removed_rolls.each do |x, y|
        grid[y][x] = "." # remove roll
      end

      grid
    end
  end
end
