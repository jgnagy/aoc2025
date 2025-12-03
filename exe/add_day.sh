#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 DAY_NUMBER"
  exit 1
fi

DAY_NUMBER=$1

add_spec_file() {
  local day_number=$1
  local spec_file="spec/aoc2025/day${day_number}_spec.rb"
  cat <<EOL > "$spec_file"
# frozen_string_literal: true

require "spec_helper"

RSpec.describe Aoc2025::Day${day_number} do
  subject(:solution) { described_class.new }

  describe "#part1" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part1(sample: true)).to eq(1) # update expected value
      end
    end
  end

  describe "#part2" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part2(sample: true)).to eq(1) # update expected value
      end
    end
  end
end
EOL
}

add_solution_file() {
  local day_number=$1
  local solution_file="lib/aoc2025/day${day_number}.rb"
  cat <<EOL > "$solution_file"
# frozen_string_literal: true

module Aoc2025
  # Solution for day 3.
  class Day${day_number} < Solution
  end
end
EOL
}

add_data_files() {
  local day_number=$1
  local sample_file="data/samples/day${day_number}.txt"
  local input_file="data/day${day_number}.txt"
  touch "$sample_file"
  touch "$input_file"
}

add_ruby_include() {
  local day_number=$1
  local include_file="lib/aoc2025.rb"
  if ! grep -q "require \"aoc2025/day${day_number}\"" "$include_file"; then
    echo "require \"aoc2025/day${day_number}\"" >> "$include_file"
  fi
}

add_spec_file "$DAY_NUMBER"
add_solution_file "$DAY_NUMBER"
add_data_files "$DAY_NUMBER"
add_ruby_include "$DAY_NUMBER"
