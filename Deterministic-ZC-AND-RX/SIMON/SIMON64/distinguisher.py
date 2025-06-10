from argparse import ArgumentParser

import minizinc
import datetime
import time
from drawdistinguisher import Draw
line_separator = "#" * 55

class ZC:
    DL_counter = 0

    def __init__(self, params) -> None:
        ZC.DL_counter += 1
        self.id = ZC.DL_counter
        self.RD = params["RD"]
        self.name = "ZC" + str(self.id)
        self.type = "ZC"
        self.cp_solver_name = params["cp_solver_name"]
        self.time_limit = params["time_limit"]
        self.block_size = params["block_size"]
        self.number_of_threads = params["number_of_threads"]
        self.output_file_name = params["output_file_name"]
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
        """
        attack_summary = ""
        attack_summary += "Attack Parameters\n"
        attack_summary += "-----------------\n"
        attack_summary += "RD = {}\n".format(self.RD)
        attack_summary += "Solver = {}\n".format(self.cp_solver_name)
        attack_summary += "Time limit = {}\n".format(self.time_limit)
        attack_summary += "Number of threads = {}\n".format(self.number_of_threads)
        attack_summary += "Status = {}\n".format(self.result.status)
        return attack_summary

def load_params(args):
    params = {
        "RD": args.RD,
        "block_size": args.block_size,
        "cp_solver_name": args.cp_solver_name,
        "time_limit": args.time_limit,
        "number_of_threads": args.number_of_threads,
        "output_file_name": args.output_file_name,
    }
    return params

def main():
    '''
    Parse the command line arguments and start the search
    '''
    parser = ArgumentParser(description="ZC distinguisher")
    parser.add_argument("-RD", type=int, default=13, help="The number of rounds")
    parser.add_argument("-output-file-name", type=str, default="output.tex", help="The name of the output file")
    # Fetch available solvers from MiniZinc
    available_solvers = [solver_name for solver_name in minizinc.default_driver.available_solvers().keys()]
    parser.add_argument("-cp-solver-name", default="cp-sat", type=str,
                        choices=available_solvers,
                        help="Choose a CP solver")  
    parser.add_argument("-time-limit", type=int, default=-1, help="The time limit in seconds")
    parser.add_argument("-variant", type=int, default=64, help="The variant of SIMON")
    parser.add_argument("-block-size", type=int, default=64, help="The block size of SIMON")
    parser.add_argument("-number-of-threads", type=int, default=8, help="The number of threads")
    args = parser.parse_args()
    params = load_params(args)
    zc = ZC(params)
    zc.search()

if __name__ == "__main__":
    main()
