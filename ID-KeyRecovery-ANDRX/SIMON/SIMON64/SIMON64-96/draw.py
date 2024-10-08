import textwrap


class Draw:
    def __init__(self, integral_object, output_file_name="output.tex", attack_summary=""):
        self.result = integral_object.result
        self.RD = integral_object.RD
        self.RB = integral_object.RB
        self.RF = integral_object.RF
        self.RT = integral_object.RT
        self.output_file_name = output_file_name
        self.attack_summary = attack_summary
        self.block_size = integral_object.block_size
        self.fillcolor = {0: "zero", 1: "one", -1: "unknown"}
        self.keyfillcolor = {0: "zero", 1: "active"}
        self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
        self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

    def draw_ed(self, r):
        """
        Paint ED
        """
        keys_values = {
            "rot8": ("yul", "ydr"),
            "rot1": ("zul", "zdr"),
            "rot2": ("wul", "wdr"),
            "left": ("xul", "xdl"),
            "right": ("xur", "xdr"),
            "and": ("pul", "pdr"),
            "xor": ("qul", "qdr")
        }

        output = {key: "" for key in keys_values.keys()}

        for i in range(self.block_size // 2):
            for key, (val_up, val_lo) in keys_values.items():
                output[key] += "\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result[val_up][r][i]], i) if \
                self.result[val_up][r][i] != 0 else ""
                output[key] += "\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result[val_lo][r][i]], i) if \
                self.result[val_lo][r][i] != 0 else ""
            if r == 0 and self.result["fin2"][self.RB - 1][i] == 1:
                output["left"] += "\FrameCell[yellow]{{s{0}}}".format(i)
        return output
    def draw_final_ed(self, r):
        """
        Paint the final ED
        """
        keys_values = {
            "left": "dxfl",
            "right": "dxfr"
        }

        output = {key: "" for key in keys_values.keys()}

        for i in range(self.block_size // 2):
            for key, val in keys_values.items():
                output[key] += "\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result[val][r][i]], i) if self.result[val][r][i] != 0 else ""
                if self.result["k" + val][r][i] == 1:
                    output[key] += "\PattCell[black]{{s{0}}}".format(i)
                if self.result["kx" + val[-2:]][r][i] == 1:
                    output[key] += "\MarkCell[red]{{s{0}}}".format(i)
        return output

    def draw_eb(self, r):
        """
        Draw tge shape for EB
        """
        keys_values = {
            "left": ("dxbl", "kdxbl", "kxbl"),
            "right": ("dxbr", "kdxbr", "kxbr"),
            "rot8": ("dybr", "kdybr", "kybr"),
            "rot1": ("dzbr", "kdzbr", "kzbr"),
            "rot2": ("dwbr", "kdwbr", "kwbr"),
            "key": ("IK", None, None),
            "and": ("dpbr", "kdpbr", "kpbr"),
            "xor": ("dqbr", "kdqbr", "kqbr")
        }
        output = {key: "" for key in keys_values.keys()}
        for i in range(self.block_size // 2):
            if self.result["fin1"][r][i] == 1:
                output["xor"] += "\FrameCell[yellow]{{s{0}}}".format(i)
            if (r > 0 and self.result["fin2"][r - 1][i] == 1):
                output["left"] += "\FrameCell[yellow]{{s{0}}}".format(i)
            for key, (val_fill, val_patt, val_mark) in keys_values.items():
                fillcolor = self.keyfillcolor if key == "key" else self.fillcolor
                output[key] += "\Fill[{0}]{{s{1}}}".format(fillcolor[self.result[val_fill][r][i]], i) if self.result[val_fill][r][i] != 0 else ""
                if val_patt and self.result[val_patt][r][i] == 1:
                    output[key] += "\PattCell[black]{{s{0}}}".format(i)
                if val_mark and self.result[val_mark][r][i] == 1:
                    output[key] += "\MarkCell[red]{{s{0}}}".format(i)

        return output

    def draw_ef(self, r):
        """
        Draw the shape for EF
        """
        keys_values = {
            "left": ("dxfl", "kdxfl", "kxfl"),
            "right": ("dxfr", "kdxfr", "kxfr"),
            "rot8": ("dyfl", "kdyfl", "kyfl"),
            "rot1": ("dzfl", "kdzfl", "kzfl"),
            "rot2": ("dwfl", "kdwfl", "kwfl"),
            "key": ("IK", None, None),
            "and": ("dpfl", "kdpfl", "kpfl"),
            "xor": ("dqfl", "kdqfl", "kqfl")
        }
        output = {key: "" for key in keys_values.keys()}
        for i in range(self.block_size // 2):
            if self.result["fout1"][r][i] == 1:
                output["xor"] += "\FrameCell[yellow]{{s{0}}}".format(i)
            if self.result["fout2"][r][i] == 1:
                output["right"] += "\FrameCell[yellow]{{s{0}}}".format(i)
            for key, (val_fill, val_patt, val_mark) in keys_values.items():
                if key == "key":
                    output["key"] += "\Fill[{0}]{{s{1}}}".format(
                        self.keyfillcolor[self.result["IK"][self.RD + self.RB + r][i]], i) if \
                        self.result["IK"][self.RD + self.RB + r][i] != 0 else ""
                else:
                    output[key] += "\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result[val_fill][r][i]], i) if \
                        self.result[val_fill][r][i] != 0 else ""

                if val_patt and self.result[val_patt][r][i] == 1:
                    output[key] += "\PattCell[black]{{s{0}}}".format(i)
                if val_mark and self.result[val_mark][r][i] == 1:
                    output[key] += "\MarkCell[red]{{s{0}}}".format(i)


        return output

    def generate_attack_shape(self):
        """
        Generate the attack shape
        """
        contents = ""
        contents += textwrap.dedent(r"""
        \documentclass[varwidth=100cm]{standalone}
        \usepackage{tikz}
        \usepackage{simon}
        \begin{document}
        \begin{figure}
            \centering
            \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
                \simoncompactfalse % vertically less compact layout
                \SimonInit["""+str(self.block_size)+"""]""") + "\n"

        for r in range(0, self.RB):
            state = self.draw_eb(r)
            contents += r"""
            \SimonRound{""" + str(r + 1) + """}
                {""" + state["left"] + r"""} % left
                {""" + state["right"] + r"""} % right
                {""" + state["rot8"] + r"""} % rot8
                {""" + state["rot1"] + r"""} % rot1
                {""" + state["rot2"] + r"""} % rot2
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + r"""} % and
                {""" + state["xor"] + r"""} % xor""" + "\n"

        for r in range(0, self.RD):
            state = self.draw_ed(r)
            contents += r"""
            \SimonRound{""" + str(self.RB + r + 1) + """}
                {""" + state["left"] + r"""} % left
                {""" + state["right"] + r"""} % right
                {""" + state["rot8"] + r"""} % rot8
                {""" + state["rot1"] + r"""} % rot1
                {""" + state["rot2"] + r"""} % rot2
                {} % key
                {""" + state["and"] + r"""} % and
                {""" + state["xor"] + r"""} % xor""" + "\n"

        for r in range(0, self.RF):
            state = self.draw_ef(r)
            contents += r"""
            \SimonRound{""" + str(self.RB + self.RD + r + 1) + """}
                {""" + state["left"] + r"""} % left
                {""" + state["right"] + r"""} % right
                {""" + state["rot8"] + r"""} % rot8
                {""" + state["rot1"] + r"""} % rot1
                {""" + state["rot2"] + r"""} % rot2
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + r"""} % and
                {""" + state["xor"] + r"""} % xor""" + "\n"

        state = self.draw_final_ed(self.RF)
        contents += r"""
            \SimonFinal{""" + str(self.RD + self.RB + self.RF + 1) + """}
                {""" + state["left"] + r"""} % left
                {""" + state["right"] + r"""} % right""" + "\n"

        contents += r"""    \end{tikzpicture}""" + "\n"
        contents += r"""\caption{""" + str(self.RT) + " rounds of \SIMON["+str(self.block_size)+"].}\n"
        contents += r"""\end{figure}""" + "\n"
        contents += r"""\end{document}""" + "\n"
        with open(self.output_file_name, "w") as f:
            f.write(contents)