import textwrap


class Draw(object):
    def __init__(self, impossible_object, output_file_name, attack_summary=""):
        self.result = impossible_object.result
        self.RD = impossible_object.RD
        self.block_size = impossible_object.block_size
        self.attack_summary = attack_summary
        self.output_file_name = output_file_name
        self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
        self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

    def draw_ed(self, r):
        """
        Draw ED
        """
        keys_values = {
            "left": ("xul", "xdl"),
            "right": ("xur", "xdr"),
            "rot8": ("yul", "ydr"),
            "rot3": ("wul", "wdr")

        }

        output = {key: "" for key in keys_values.keys()}
        for i in range(self.block_size // 2):
            for key, (val_up, val_lo) in keys_values.items():
                output[key] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result[val_up][r][i]], i) if self.result[val_up][r][i] != 0 else ""
                output[key] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result[val_lo][r][i]], i) if self.result[val_lo][r][i] != 0 else ""
        return output

    def draw_final_ed(self, r):

        """
        Paint the final ED
        """
        output = {
            "left": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xul"][r][i]], i) +
                            r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdl"][r][i]], i)
                            for i in range(self.block_size // 2)),
            "right": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xur"][r][i]], i) +
                             r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdr"][r][i]], i)
                             for i in range(self.block_size // 2))
        }
        return output


    def draw_shape(self):
        contents = textwrap.dedent(r"""
        \documentclass[varwidth=100cm]{standalone}
        \usepackage{tikz}
        \usepackage{simon}
        \begin{document}
        \begin{figure}
            \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50},rot/.append style={specklabelstyle}]
                \SpeckInit[""" + str(self.block_size) + """]""")
        #draw ED
        for r in range(0, self.RD):
            state = self.draw_ed(r)
            contents += r"""
                    \SpeckRound{""" + str(r + 1) + """}
                        {""" + state["left"] + """} % left
                        {""" + state["right"] + """} % right
                        {""" + state["rot8"] + """} % rot8
                        {""" + state["rot3"] + """} % rot3""" + "\n"
        state = self.draw_final_ed(self.RD)
        contents += r"""
                    \SpeckFinal{""" + str(self.RD + 1) + """}
                        {""" + state["left"] + """}
                        {""" + state["right"] + "}\n" + "\n"
        contents += r"""   \end{tikzpicture}""" + "\n"
        contents += r"""\caption{""" + str(self.RD) + r" rounds of \SPECK[" + str(self.block_size) + "].}\n"
        contents += r"""\end{figure}""" + "\n"
        contents += r"""\end{document}"""
        return contents

    def generate_attack_shape(self):
        """
        Draw the figure of the Impossible distinguisher
        """

        contents = self.draw_shape()
        with open(self.output_file_name, "w") as output_file:
            output_file.write(contents)

