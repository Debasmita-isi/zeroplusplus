
#print.py

def save_solution_to_file(solution, filename="output.txt"):
    def format_element(x):
        if isinstance(x, list):
            return "[" + ", ".join(str(i) for i in x) + "]"
        else:
            return str(x)

    with open(filename, "w") as f:
        for var_name in dir(solution):
            if var_name.startswith("_"):
                continue
            value = getattr(solution, var_name)
            if isinstance(value, list) and all(isinstance(row, list) for row in value):
                f.write(f"{var_name} =\n")
                for row in value:
                    f.write("  " + " ".join(format_element(x) for x in row) + "\n")
                f.write("\n")
