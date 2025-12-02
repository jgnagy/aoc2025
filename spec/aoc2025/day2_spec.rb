# frozen_string_literal: true

require "spec_helper"

RSpec.describe Aoc2025::Day2 do
  subject(:solution) { described_class.new }

  describe "#part1" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part1(sample: true)).to eq(1_227_775_554)
      end
    end
  end

  describe "#part2" do
    context "with sample data" do
      it "returns the correct result" do
        expect(solution.part2(sample: true)).to eq(4_174_379_265)
      end
    end
  end
end
