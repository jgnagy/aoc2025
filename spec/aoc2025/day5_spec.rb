# frozen_string_literal: true

require "spec_helper"

RSpec.describe Aoc2025::Day5 do
  subject(:solution) { described_class.new }

  describe "#part1" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part1(sample: true)).to eq(3) # update expected value
      end
    end
  end

  describe "#part2" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part2(sample: true)).to eq(14) # update expected value
      end
    end
  end
end
