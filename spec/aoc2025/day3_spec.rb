# frozen_string_literal: true

require "spec_helper"

RSpec.describe Aoc2025::Day3 do
  subject(:solution) { described_class.new }

  describe "#part1" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part1(sample: true)).to eq(357) # update expected value
      end
    end
  end

  describe "#part2" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part2(sample: true)).to eq(3_121_910_778_619) # update expected value
      end
    end
  end
end
