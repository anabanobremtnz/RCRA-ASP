"""
AUTHORS: Samuel Otero Agraso (s.agraso) and Ana Bañobre Martinez (ana.banobre)

python3 encode.py domXX.txt domXX.lp
"""
import sys
import os
import glob

def encode_file(infile, outfile):
    try:
        with open(infile, 'r') as fin:
            # Read non-empty lines (strip newline characters)
            lines = [line.rstrip('\n') for line in fin if line.rstrip('\n') != '']
    except Exception as e:
        print(f"Error reading file {infile}: {e}")
        return

    n = len(lines)
    
    try:
        with open(outfile, 'w') as fout:
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
        infile, outfile = args
        if not os.path.isfile(infile):
            print(f"Input file {infile} does not exist.")
            sys.exit(1)
        encode_file(infile, outfile)
    elif len(args) == 1:
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
        print("python3 encode.py <directory>")
        sys.exit(1)

if __name__ == "__main__":
    main()
