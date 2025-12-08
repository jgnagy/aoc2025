# frozen_string_literal: true

module Aoc2025
  # Solution for day 8.
  class Day8 < Solution
    def part1(sample: false)
      load_input(sample:)

      circuits(parse_data_for_part1, sample ? 10 : 1000)
        .sort_by(&:size)
        .last(3)
        .map(&:size)
        .reduce(:*)
    end

    def part2(sample: false)
      load_input(sample:)

      as_single_circuit(parse_data_for_part1)[:last_connection]
        .map { _1[0] } # take only the x coordinates of the last pair
        .reduce(:*)
    end

    private

    # Parse input data into list of circuits, each represented
    # as an array x, y, and z coordinates
    def parse_data_for_part1
      @data
        .split("\n")
        .map { _1.split(",").map(&:to_i) }
    end

    # Calculate the distance between two circuits
    def circuit_distance(circuit1, circuit2)
      Math.sqrt(
        ((circuit1[0] - circuit2[0])**2) +
        ((circuit1[1] - circuit2[1])**2) +
        ((circuit1[2] - circuit2[2])**2)
      )
    end

    # Find all possible connections and their distances
    def all_connections_with_distances(coordinates)
      connections = []

      coordinates.each_with_index do |circuit, index|
        coordinates.each_with_index do |other_circuit, other_index|
          next if index >= other_index

          distance = circuit_distance(circuit, other_circuit)
          connections << [[index, other_index], distance]
        end
      end

      connections
    end

    # Get the N shortest connections
    def shortest_connections(coordinates, count = nil)
      connections_with_distances = all_connections_with_distances(coordinates)
                                   .sort_by { |_, distance| distance }

      limited_connections = count ? connections_with_distances.first(count) : connections_with_distances

      limited_connections.map { |connection, _| connection }
    end

    def circuits(coordinates, connection_count)
      visited = Set.new
      circuits = []

      connections_list = shortest_connections(coordinates, connection_count)

      # Build adjacency list for fast discovery of connected coordinates
      adjacency = Hash.new { |h, k| h[k] = [] }
      connections_list.each do |(from_idx, to_idx)|
        adjacency[from_idx] << to_idx
        adjacency[to_idx] << from_idx
      end

      # Find all connected coordinates to build circuits
      coordinates.each_with_index do |_, index|
        next if visited.include?(index)

        circuit = []
        stack = [index]

        while stack.any?
          current_index = stack.pop
          next if visited.include?(current_index) # already part of a circuit

          visited.add(current_index)
          circuit << coordinates[current_index]

          adjacency[current_index].each do |neighbor_idx|
            stack << neighbor_idx unless visited.include?(neighbor_idx)
          end
        end

        circuits << circuit
      end

      circuits
    end

    def as_single_circuit(coordinates)
      visited = Set.new
      circuit = []
      last_connection = nil

      connections_list = shortest_connections(coordinates)

      connections_list.each do |(from_idx, to_idx)|
        unless visited.include?(from_idx) && visited.include?(to_idx)
          visited.add(from_idx)
          visited.add(to_idx)
          circuit << [coordinates[from_idx], coordinates[to_idx]]
          last_connection = [coordinates[from_idx], coordinates[to_idx]]
        end

        break if visited.size == coordinates.size
      end

      { circuit:, last_connection: }
    end
  end
end
