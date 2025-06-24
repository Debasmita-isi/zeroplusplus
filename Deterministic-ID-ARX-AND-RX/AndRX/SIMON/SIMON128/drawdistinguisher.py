import textwrap


class Draw(object):
  def __init__(self, impossible_object, output_file_name="output.tex", attack_summary=""):
    self.result = impossible_object.result
    self.RD = impossible_object.RD
    self.block_size = impossible_object.block_size
    self.attack_summary = attack_summary
    self.output_file_name = output_file_name
    self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
    self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

  def draw_ed(self, r):
    """
    Paint ED
    """
    output = dict()

    output["rot8"] = ""
    output["rot1"] = ""
    output["rot2"] = ""
    output["left"] = ""
    output["right"] = ""
    output["key"] = ""
    output["xor"] = ""
    output["and"] = ""
    for i in range(self.block_size//2):
      output["left"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xul"][r][i]], i)
      output["right"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xur"][r][i]], i)
      output["rot8"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["yul"][r][i]], i)
      output["rot1"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["zul"][r][i]], i)
      output["rot2"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["wul"][r][i]], i)
      output["and"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["pul"][r][i]], i)
      output["xor"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["qul"][r][i]], i)

      output["left"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdl"][r][i]], i)
      output["right"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdr"][r][i]], i)
      output["rot8"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["ydr"][r][i]], i)
      output["rot1"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["zdr"][r][i]], i)
      output["rot2"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["wdr"][r][i]], i)
      output["and"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["pdr"][r][i]], i)
      output["xor"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["qdr"][r][i]], i)

    return output

  def draw_final_ed(self, r):
    """
    Paint the final ED
    """
    output = dict()

    output["left"] = ""
    output["right"] = ""

    for i in range(self.block_size//2):
      output["left"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xul"][r][i]], i)
      output["right"] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xur"][r][i]], i)

      output["left"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdl"][r][i]], i)
      output["right"] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdr"][r][i]], i)
    return output

  def generate_attack_shape(self):
    """
    Draw the figure of the Impossible distinguisher
    """
    contents = ""
    contents += textwrap.dedent(r"""
      \documentclass[varwidth=100cm]{standalone}
      \usepackage{tikz}
      \usepackage{simon}
      \begin{document}
      \begin{figure}
        \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
          \simoncompactfalse
          \SimonInit["""+str(self.block_size)+ """]""") + "\n"
    # draw ED
    for r in range(0, self.RD):
      state = self.draw_ed(r)
      contents += r"""
      \SimonRound{""" + str(r+1) + """}
      {""" + state["left"] + """}
      {""" + state["right"] + """}
      {""" + state["rot8"] + """}
      {""" + state["rot1"] + """}
      {""" + state["rot2"] + """}
      {}
      {""" + state["and"] + """}
      {""" + state["xor"] + "}""" + "\n"

    # draw final ED
    state = self.draw_final_ed(self.RD)
    contents += r"""
      \SimonFinal{""" + str(self.RD+1) + """}
      {""" + state["left"] + """}
      {""" + state["right"] + "}\n" + "\n"
    contents += "\n"
    contents += r"""  \end{tikzpicture}""" + "\n"
    contents += r"""\caption{""" + str(self.RD) + r" rounds of \SIMON[" + str(self.block_size) +"].}\n"
    contents += r"""\end{figure}""" + "\n"
    # contents += r"""\begin{comment}""" + "\n"
    # contents += self.attack_summary
    # contents += r"""\end{comment}""" + "\n"
    contents += r"""\end{document}"""
    with open(self.output_file_name, "w") as output_file:
      output_file.write(contents)
