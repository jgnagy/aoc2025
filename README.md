# Advent of Code 2025

My personal solutions to [Advent of Code 2025](https://adventofcode.com/) written in Ruby.

## Adding a New Solution/Day

```bash
./exe/add_day.sh X
```

Where `X` is the day number (1-12). This will create the necessary files and boilerplate code for the new day's solution.

## Running Tests

```bash
bundle exec rake
```

## Running Solutions

1. Copy your input data into `data/dayX.txt` (where `X` is the day number)
2. Run the solution:

```bash
bundle exec exe/aoc2025 X Y
```

Where:
- `X` is the day number (1-12)
- `Y` is the part (1 or 2)

For example, to run Day 1, Part 1:

```bash
bundle exec exe/aoc2025 1 1
```
