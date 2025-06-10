import numpy as np
from draw1 import *
from argparse import ArgumentParser

def read_from_file(filename):
    attributes = {}

    with open(filename, 'r') as file:
        content = file.read()
    lines = content.split('\n')
    # Remove lines starting with %%
    filtered_lines = [line for line in lines if not line.startswith('%%')]
    content = '\n'.join(filtered_lines)

    attribute_blocks = content.split(';')

    for block in attribute_blocks:
        if block.startswith('%%'):
            continue
        if '=' in block:
            parts = block.strip().split('=')
            attr_name = parts[0].strip()

            # Extract values and indices
            if '[' in parts[1] and ']' in parts[1]:
                data_part = parts[1].split('[')[1].split(']')[0].strip()
                lines = data_part.split('\n')

                # Extract index and values for each line
                matrix_data = []
                for line in lines[1:]:
                    line_parts = line.split(':')
                    if len(line_parts) >= 2:
                        index = line_parts[0].strip()
                        values = [int(val.strip().replace('|', '')) for val in line_parts[1].split(',')]
                        matrix_data.append(values)

                attributes[attr_name] = np.array(matrix_data)

    return attributes

class Drawer:
    def __init__(self, attributes, params):
        self.result = attributes
        self.RB = params["RB"]
        self.RD = params["RD"]
        self.MD = params["MD"]
        self.RF = params["RF"]
        self.RT = self.RB + self.RD + self.RF
        self.block_size = params["block_size"]
        self.output_file_name = params["output_file_name"]

def parse_dzn_file(filename, output_file_name):
    data = {}

    with open(filename, 'r') as file:
        lines = file.readlines()

    for line in lines:
        if '=' in line:
            key, value = line.strip().split('=')
            data[key.strip()] = int(value.strip().rstrip(';'))

    data["output_file_name"] = output_file_name
    return data

def parse_command_line():
    """
    Parse command line arguments
    """
    parser = ArgumentParser(description='Draw the attack')
    parser.add_argument('filename', default="input.txt", help='The file containing the input data')
    parser.add_argument('-RB', default=4, type=int, help='The number of rounds for EB')
    parser.add_argument('-RD', default=12, type=int, help='The number of rounds for ED')
    parser.add_argument('-MD', default=5, type=int, help='The number of rounds for ED')
    parser.add_argument('-RF', default=4, type=int, help='The number of rounds for EF')
    parser.add_argument('-bs', default=48, type=int, help='The block size')
    parser.add_argument('-o', default="output.tex", type=str, help='The output file')
    parser.add_argument('-dzn', default=None, type=str, help='The .dzn file containing parameters')
    args = parser.parse_args()
    if args.dzn:
        params = parse_dzn_file(args.dzn, args.o)
    else:
        params =  {
            "RB": args.RB,
            "RD": args.RD,
            "MD": args.MD,
            "RF": args.RF,
            "block_size": args.bs,
            "output_file_name": args.o
        }
    return args, params





if __name__ == '__main__':

    args, params = parse_command_line()
    attributes = read_from_file(args.filename)
    drawer = Drawer(attributes, params)
    draw = Draw(drawer)
    # draw.generate_attack_shape()
    draw.generate_attack_shape_2files()
    print("Attack shape generated successfully")
