import textwrap


class Draw(object):
    def __init__(self, object, output_file_name="output.tex", attack_summary=""):
        self.result = object.result
        self.RD = object.RD
        self.block_size = object.block_size
        self.attack_summary = attack_summary
        self.output_file_name = output_file_name
        self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
        self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

    def draw_ed(self, r):
        """
        Paint ED
        """
        keys_values = {
            "left": ("xul", "xdl"),
            "right": ("xur", "xdr")
        }

        output = {key: "" for key in keys_values.keys()}

        for i in range(self.block_size // 2):
            for key, (val_up, val_lo) in keys_values.items():
                output[key] += r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result[val_up][r][i]], i) if \
                    self.result[val_up][r][i] != 0 else ""
                output[key] += r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result[val_lo][r][i]], i) if \
                    self.result[val_lo][r][i] != 0 else ""
        return output


    def generate_attack_shape(self):
        """
        Generate the attack shape
        """
        contents = textwrap.dedent(r"""
            \documentclass[varwidth=100cm]{standalone}
            \usepackage{tikz}
            \usepackage{simon}
            \begin{document}
            \begin{figure}
                \centering
                \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
                    \simoncompactfalse % vertically less compact layout
                    \SimonInit[""" + str(self.block_size) + """]""")
        # draw ED
        for r in range(0, self.RD):
            state = self.draw_ed(r)
            contents += r"""
            \SimonRoundShort{""" + str(r + 1) + """}
                {""" + state["left"] + """}
                {""" + state["right"] + "}"
        # draw final round
        state = self.draw_ed(self.RD)
        contents += (r"""
            \SimonFinal{""" + str(self.RD + 1) + """}
                {""" + state["left"] + """} 
                {""" + state["right"] + "}" + "\n")
        contents += r"""    \end{tikzpicture}""" + "\n"
        contents += r"""\caption{""" + str(self.RD) + r" rounds of \SIMON[" + str(self.block_size) +"].}\n"
        contents += r"""\end{figure}""" + "\n"
        contents += r"""\end{document}""" + "\n"
        with open(self.output_file_name, "w") as file:
            file.write(contents)