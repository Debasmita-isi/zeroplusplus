import argparse
import datetime
import time

import minizinc
from drawdistinguisher import *

line_separator = "#" * 55


class ZCDistinguisher:
    def __init__(self, params) -> None:
        self.RD = params["RD"]
        #self.MD = params["MD"]
        self.block_size = params["block_size"]
        self.output_file_name = params["output_file_name"]
        self.cp_solver_name = params["cp_solver_name"]
        self.time_limit = params["time_limit"]
        #self.is_combined = params["is_combined"]
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
        #self.cp_instance["MD"] = self.MD
        #self.cp_instance["is_combined"] = self.is_combined
        self.cp_instance["block_size"] = self.block_size

        self.result = self.cp_instance.solve(timeout=time_limit, processes=self.number_of_threads)

        elapsed_time = time.time() - start_time
        # print time
        print("Elapsed time: {:0.02f} seconds".format(elapsed_time))

        if self.result.status == minizinc.Status.SATISFIED or self.result.status == minizinc.Status.OPTIMAL_SOLUTION or self.result.status == minizinc.Status.ALL_SOLUTIONS:
            attack_summary = self.print_attack_parameters()
            attack_summary += line_separator + "\n"
            print(attack_summary)
            draw = Draw(self, self.output_file_name, attack_summary)
            draw.generate_attack_shape()
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
        attack_summary += "RD = {}\n".format(self.RD)
        #attack_summary += "MD = {}\n".format(self.MD)
        attack_summary += "Solver = {}\n".format(self.cp_solver_name)
        attack_summary += "Time limit = {}\n".format(self.time_limit)
        #attack_summary += "Is combined = {}\n".format(self.is_combined)
        attack_summary += "Number of threads = {}\n".format(self.number_of_threads)
        attack_summary += "Status = {}\n".format(self.result.status)
        #attack_summary += "Objective = {}\n".format(self.result.objective)
        return attack_summary


def load_params(args):
    params = {
        "RD": 11,
        "output_file_name": "output.tex",
        "cp_solver_name": "cp-sat",
        "time_limit": -1,
        "block_size": 32,
        "number_of_threads": 8
    }
    if args.RD:
        params["RD"] = args.RD
    if args.output_file_name:
        params["output_file_name"] = args.output_file_name
    if args.cp_solver_name:
        params["cp_solver_name"] = args.cp_solver_name
    if args.time_limit:
        params["time_limit"] = args.time_limit
    if args.block_size:
        params["block_size"] = args.block_size
    if args.number_of_threads:
        params["number_of_threads"] = args.number_of_threads
    return params


def main():
    '''
    Parse the command line arguments
    '''
    parser = argparse.ArgumentParser(description="Zero-Correlation distinguisher for SIMECK.")
    parser.add_argument("-RD", type=int, default=11, help="The number of rounds")
    #parser.add_argument("-MD", type=int, default=7, help="The number of middle rounds")
    parser.add_argument("-output-file-name", type=str, default="output.tex", help="The name of the output file")
    # Fetch available solvers from MiniZinc
    available_solvers = [solver_name for solver_name in minizinc.default_driver.available_solvers().keys()]
    parser.add_argument("-cp-solver-name", default="cp-sat", type=str,
                        choices=available_solvers,
                        help="Choose a CP solver")    
    parser.add_argument("-time-limit", type=int, default=-1, help="The time limit in seconds")
    parser.add_argument("-block-size", type=int, default=32, help="The block size of SIMECK")
    # parser.add_argument("-is-combined", type=bool, default=False, help="The type of the model")
    parser.add_argument("-number-of-threads", type=int, default=8, help="The number of threads")

    args = parser.parse_args()
    params = load_params(args)

    zc_distinguisher = ZCDistinguisher(params)
    zc_distinguisher.search()


if __name__ == "__main__":
    main()
