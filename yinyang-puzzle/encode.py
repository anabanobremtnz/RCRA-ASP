#!/usr/bin/env python3
import sys
import os
import glob

"""
python3 encode.py dom02.txt dom02.lp
"""

def encode_file(infile, outfile):
    """
    Reads an ASCII domain file (e.g., dom02.txt) and writes an ASP file (e.g., dom02.lp)
    containing only facts and constants.
    
    The input file is assumed to be an n x n grid. Each line should have n characters:
      - '.' represents a cell with no fixed assignment (will be encoded as cell(X,Y).)
      - '0' represents a white fixed cell (encoded as fixed(X,Y,white).)
      - '1' represents a black fixed cell (encoded as fixed(X,Y,black).)
    
    Coordinates are 0-indexed, with X being the column and Y the row.
    """
    try:
        with open(infile, 'r') as fin:
            # Read non-empty lines (strip newline characters)
            lines = [line.rstrip('\n') for line in fin if line.rstrip('\n') != '']
    except Exception as e:
        print(f"Error reading file {infile}: {e}")
        return

    # Determine grid size from the number of lines.
    n = len(lines)
    if n == 0:
        print(f"Warning: File {infile} is empty.")
        return

    # Assume all lines are of equal length (grid is square)
    num_cols = len(lines[0])
    if num_cols != n:
        print(f"Warning: File {infile} is not square ({n} rows vs {num_cols} columns).")
    # We'll use n as the grid size (assuming an n x n puzzle)

    try:
        with open(outfile, 'w') as fout:
            # Write grid size fact
            fout.write(f"gridsize({n}).\n")
            # Process each cell
            for y, line in enumerate(lines):
                for x, char in enumerate(line):
                    if char == '.':
                        fout.write(f"cell({x},{y}).\n")
                    elif char == '0':
                        fout.write(f"fixed({x},{y},black).\n")
                    elif char == '1':
                        fout.write(f"fixed({x},{y},white).\n")
                    else:
                        print(f"Unexpected character '{char}' in file {infile} at position ({x},{y})")
    except Exception as e:
        print(f"Error writing to file {outfile}: {e}")

def main():
    args = sys.argv[1:]
    if len(args) == 2:
        # Single file mode: encode one input file to one output file.
        infile, outfile = args
        if not os.path.isfile(infile):
            print(f"Input file {infile} does not exist.")
            sys.exit(1)
        encode_file(infile, outfile)
    elif len(args) == 1:
        # Directory mode: process all files matching "dom*.txt" in the given directory.
        directory = args[0]
        if not os.path.isdir(directory):
            print(f"{directory} is not a directory.")
            sys.exit(1)
        pattern = os.path.join(directory, "dom*.txt")
        files = glob.glob(pattern)
        if not files:
            print(f"No files matching 'dom*.txt' found in directory {directory}.")
            sys.exit(1)
        for infile in files:
            base, _ = os.path.splitext(infile)
            outfile = base + ".lp"
            print(f"Encoding {infile} -> {outfile}")
            encode_file(infile, outfile)
    else:
        print("Usage:")
        print("  python3 encode.py <input_file> <output_file>")
        print("or")
        print("  python3 encode.py <directory>")
        sys.exit(1)

if __name__ == "__main__":
    main()
