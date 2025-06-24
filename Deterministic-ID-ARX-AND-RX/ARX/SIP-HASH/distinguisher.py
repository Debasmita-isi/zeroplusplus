import argparse
import datetime
import time

import minizinc
#from sympy.physics.vector.printing import params

#from draw import *
from print import save_solution_to_file


line_separator = "#" * 55


class ImpossibleARXDistinguisher:
    def __init__(self, params) -> None:
        self.RD = params["RD"]
        self.block_size = params["block_size"]
        self.output_file_name = params["output_file_name"]
        self.cp_solver_name = params["cp_solver_name"]
        self.time_limit = params["time_limit"]
        self.number_of_threads = params["number_of_threads"]
        self.supported_cp_solvers = [solver_name for solver_name in minizinc.default_driver.available_solvers().keys()]
        self.cp_solver = minizinc.Solver.lookup(self.cp_solver_name)
        self.mzn_file_name = "distinguisher.mzn"

    def search(self):
        if self.time_limit != -1:
            time_limit = datetime.timedelta(seconds=self.time_limit)
        else:
            time_limit = None

        start_time = time.time()

        self.cp_model = minizinc.Model()
        self.cp_model.add_file(self.mzn_file_name)
        self.cp_instance = minizinc.Instance(solver=self.cp_solver, model=self.cp_model)
        self.cp_instance["RD"] = self.RD
        self.cp_instance["block_size"] = self.block_size

        self.result = self.cp_instance.solve(timeout=time_limit, processes=self.number_of_threads)

        elapsed_time = time.time() - start_time
        # print time
        print("Elapsed time: {:0.02f} seconds".format(elapsed_time))

        if self.result.status == minizinc.Status.SATISFIED or self.result.status == minizinc.Status.OPTIMAL_SOLUTION or self.result.status == minizinc.Status.ALL_SOLUTIONS:
            attack_summary = self.print_attack_parameters()
            attack_summary += line_separator + "\n"
            print(attack_summary)
            save_solution_to_file(self.result.solution, self.output_file_name)
        elif self.result.status == minizinc.Status.UNSATISFIABLE:
            print("Model is unsatisfiable")
        else:
            print("No solution found")

    def print_attack_parameters(self):
        """
        Print the attack parameters
        :return:
        """
        attack_summary = "Attack parameters:\n"
        attack_summary += "Block size = {}\n".format(self.block_size)
        attack_summary += "RD = {}\n".format(self.RD)
        attack_summary += "Solver = {}\n".format(self.cp_solver_name)
        attack_summary += "Time limit = {}\n".format(self.time_limit)
        attack_summary += "Number of threads = {}\n".format(self.number_of_threads)
        attack_summary += "Status = {}\n".format(self.result.status)
        return attack_summary

    

	

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
    '''
        Parse the command line arguments
        '''
    parser = argparse.ArgumentParser(description="Impossible distinguisher for Sip-Hash.")
    parser.add_argument('-RD', default=4, type=int, help='The number of rounds for ED')
    parser.add_argument('-bs', default=256, type=int, help='The block size')
    parser.add_argument('-o', default="output.txt", type=str, help='The output file')
    # Fetch available solvers from MiniZinc
    available_solvers = [solver_name for solver_name in minizinc.default_driver.available_solvers().keys()]
    parser.add_argument("-sl", "--solver", default="cp-sat", type=str,
                        choices=available_solvers,
                        help="Choose a CP solver")
    parser.add_argument("-tl", type=int, default=-1, help="The time limit in seconds")
    parser.add_argument("-p", type=int, default=8, help="The number of threads")
    parser.add_argument('-dzn', default=None, type=str, help='The .dzn file containing parameters')
    # Parse command line arguments and construct parameter list
    args = parser.parse_args()
    params = {
        "RD": args.RD,
        "block_size": args.bs,
        "output_file_name": args.o,
        "cp_solver_name": args.solver,
        "time_limit": args.tl,
        "number_of_threads": args.p
    }
    if args.dzn:
        params.update(parse_dzn_file(args.dzn, args.o))

    return args, params


        	

def main():
    args, params = parse_command_line()
    id_distinguisher = ImpossibleARXDistinguisher(params)
    id_distinguisher.search()


if __name__ == "__main__":
    main()
