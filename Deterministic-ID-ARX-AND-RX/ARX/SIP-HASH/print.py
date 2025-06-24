

# print.py

def save_solution_to_file(solution, filename="output.txt"):
    """
    Writes all 2D arrays in the solution object to a file, with proper formatting.
    """
    with open(filename, "w") as f:
        for var_name in dir(solution):
            # Skip internal attributes and non-arrays
            if var_name.startswith("_"):
                continue

            value = getattr(solution, var_name)

            # Print only if it's a 2D list (list of lists)
            if isinstance(value, list) and all(isinstance(row, list) for row in value):
                f.write(f"{var_name} =\n")
                for row in value:
                    f.write("  " + " ".join(f"{x:>2}" for x in row) + "\n")
                f.write("\n")
