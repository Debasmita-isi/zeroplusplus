import textwrap


class Draw:
    def __init__(self, object, attack_summary=""):
        self.result = object.result
        self.RD = object.RD
        self.RB = object.RB
        self.RF = object.RF
        self.RT = object.RT
        self.block_size = object.block_size
        self.output_file_name = object.output_file_name
        self.attack_summary = attack_summary
        self.fillcolor = {0: "zero", 1: "one", -1: "unknown"}
        self.keyfillcolor = {0: "zero", 1: "active"}
        self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
        self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

    def draw_ed(self, r):
        """
        Draw ED
        """
        keys_values = {
            "left": ("xul", "xdl"),
            "right": ("xur", "xdr"),
            "rot0": ("yul", "ydr"),
            "rot5": ("zul", "zdr"),
            "rot1": ("wul", "wdr"),
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

    def draw_final_eb(self, r):
        output = {
            "left": "".join("\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result["xul"][r][i]], i) for i in
                            range(self.block_size // 2) if self.result["xul"][r][i] != 0),
            "right": "".join("\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result["xur"][r][i]], i) for i in
                             range(self.block_size // 2) if self.result["xur"][r][i] != 0),
        }
        for i in range(self.block_size // 2):
            if (self.result["fin2"][self.RB - 1][i] == 1):
                output["left"] += "\FrameCell[yellow]{{s{0}}}".format(i)
        return output
    def draw_final_ed(self, r):
        """
        Draw the final ED
        """
        keys_values = {
            "left": ("dxfl", "kdxfl", "kxfl"),
            "right": ("dxfr", "kdxfr", "kxfr")
        }

        output = {key: "" for key in keys_values.keys()}

        for i in range(self.block_size // 2):
            for key, (val_fill, val_patt, val_mark) in keys_values.items():
                output[key] += "\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result[val_fill][r][i]], i) if \
                    self.result[val_fill][r][i] != 0 else ""
                if self.result[val_patt][r][i] == 1:
                    output[key] += "\PattCell[black]{{s{0}}}".format(i)
                if self.result[val_mark][r][i] == 1:
                    output[key] += "\MarkCell[red]{{s{0}}}".format(i)

        return output

    def draw_eb(self, r):
        """
        Draw the shape for EB
        """
        keys_values = {
            "left": ("dxbl", "kdxbl", "kxbl"),
            "right": ("dxbr", "kdxbr", "kxbr"),
            "rot0": ("dybr", "kdybr", "kybr"),
            "rot5": ("dzbr", "kdzbr", "kzbr"),
            "rot1": ("dwbr", "kdwbr", "kwbr"),
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
                if key == "key":
                    output["key"] += "\Fill[{0}]{{s{1}}}".format(
                        self.keyfillcolor[self.result["IK"][r-1][i]], i) if self.result["IK"][r-1][i] != 0 else ""
                else:
                    output[key] += "\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result[val_fill][r][i]], i) if \
                        self.result[val_fill][r][i] != 0 else ""
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
            "rot0": ("dyfl", "kdyfl", "kyfl"),
            "rot5": ("dzfl", "kdzfl", "kzfl"),
            "rot1": ("dwfl", "kdwfl", "kwfl"),
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
                if (key == "key") and (r < self.RF - 1):
                    output["key"] += "\Fill[{0}]{{s{1}}}".format(
                        self.keyfillcolor[self.result["IK"][self.RD + self.RB + r+1 ][i]], i) if \
                        self.result["IK"][self.RD + self.RB + r +1][i] != 0 else ""
                else:
                    output[key] += "\Fill[{0}]{{s{1}}}".format(self.fillcolor[self.result[val_fill][r][i]], i) if \
                        self.result[val_fill][r][i] != 0 else ""

                if val_patt and self.result[val_patt][r][i] == 1:
                    output[key] += "\PattCell[black]{{s{0}}}".format(i)
                if val_mark and self.result[val_mark][r][i] == 1:
                    output[key] += "\MarkCell[red]{{s{0}}}".format(i)

        return output
    def draw_edf(self, r):
        """
        Paint ED
        """
        keys_values = {
            "left": ("xul", "xdl"),
            "right": ("xur", "xdr"),
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
    def find_contradiction(self):
        """
        Find the contradiction, search on result["contradiction"][i][j] =1 then this is a contradiction then return the location i,j
        """
        for i in range(self.RT):
            for j in range(self.block_size // 2):
                if self.result["contradict"][i][j] == 1:
                    return i, j
        return None
    def generate_attack_shape(self):
        """
        Generate the attack shape
        """
        content = ""
        contents = ""
        contents += textwrap.dedent(r"""
        \documentclass[varwidth=100cm]{standalone}
        \usepackage{tikz}
        \usepackage{simeck}
        \begin{document}
        \begin{figure}
            \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
            \simeckcompactfalse
            \SimeckInit[""" + str(self.block_size) + """]""")
        # draw the first round without the key
        state = self.draw_eb(0)
        contents += r"""
            \SimeckNoKey{1}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        # draw the rest of the rounds
        for r in range(1, self.RB):
            state = self.draw_eb(r)
            contents += r"""
            \SimeckRoundEQ{""" + str(r + 1) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot0"] + """} % rot0
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        # Draw the final EB
        state = self.draw_final_eb(0)
        contents += r"""
            \SimeckFinal{""" + str(self.RB + 1) + """}
                {""" + state["left"] + """}
                {""" + state["right"] + "}\n"
        contents += r"""
            \SimeckGaps{""" + str(self.RD)+ "}\n"
        for r in range(0, self.RF-1):
            state = self.draw_ef(r)
            contents += r"""
            \SimeckRoundEQ{""" + str(r + 1 + self.RB + self.RD) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot0"] + """} % rot0
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        state = self.draw_ef(self.RF-1)
        contents += r"""
            \SimeckNoKey{""" + str(self.RB + self.RD + self.RF) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        # draw final ED
        state = self.draw_final_ed(self.RF)
        contents += r"""
              \SimeckFinal{""" + str(self.RD + self.RB + self.RF + 1) + """}
              {""" + state["left"] + """}
              {""" + state["right"] + "}\n"
        contents += r"""  \end{tikzpicture}""" + "\n"
        # contents += r"""\caption{""" + str(self.RT) + " rounds of \SIMECK[" + str(self.block_size) + "].}\n"
        contents += r"""\end{figure}""" + "\n"
        # contents += r"""\begin{comment}""" + "\n"
        # contents += self.attack_summary
        # contents += r"""\end{comment}""" + "\n"
        contents += r"""\end{document}"""
        with open(self.output_file_name, "w") as output_file:
            output_file.write(contents)
    def generate_attack_shape_2files(self):
        """
        Generate the attack shape into Distinguisher file and Key Recovery file for Simeck
        """

        contentsDist = ""
        contentsKR = ""
        openfile = textwrap.dedent(r"""
        \documentclass[varwidth=100cm]{standalone}
        \usepackage{tikz}
        \usepackage{simeck}
        \usetikzlibrary {decorations.fractals,spy}
        \begin{document}
        \begin{figure}
            \centering
            \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}, spy using outlines={circle, magnification=3.5, size=1.2cm, connect spies}]
                \simeckcompactfalse
                \SimeckInit[""" + str(self.block_size) + """]""") + "\n"
        # find postion of contradiction
        contradiction = self.find_contradiction()
        if contradiction:
            print("Contradiction found at round {0} and position {1}".format(contradiction[0], contradiction[1]))
            # contentsDist += r"""

            posJ = contradiction[0] * -2.4
            posI = contradiction[1] * 0.05
            posG = posJ * 0.9
            contentsDist += r"""
                    \spy [red] on (""" + str(posI) + """, """ + str(posJ) + """) in node [left] at (-0.4, """ + str(posG) + """);""" + "\n"

        # draw the first round without the key
        state = self.draw_eb(0)
        contentsKR += r"""
            \SimeckNoKey{1}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor" + "\n"
        # draw the rest of the rounds
        for r in range(1, self.RB):
            state = self.draw_eb(r)
            contentsKR += r"""
            \SimeckRoundEQ{""" + str(r + 1) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot0"] + """} % rot0
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor" + "\n"
        # Draw the final EB
        state = self.draw_final_eb(0)
        contentsKR += r"""
            \SimeckFinal{""" + str(self.RB + 1) + """}
                {""" + state["left"] + """}
                {""" + state["right"] + "}\n"
        contentsKR += r"""
            \SimeckGaps{""" + str(self.RD)+ "}\n"
        # Draw the distinguisher
        for r in range(0, self.RD):
            state = self.draw_ed(r)
            contentsDist += r"""
            \SimeckNoKey{""" + str(self.RB + r + 1) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor" + "\n"
        state = self.draw_edf(self.RD)
        contentsDist += r"""
            \SimeckFinal{""" + str(self.RB + self.RD + 1) + """}
                {""" + state["left"] + """}
                {""" + state["right"] + "}\n" + "\n"
        for r in range(0, self.RF - 1):
            state = self.draw_ef(r)
            contentsKR += r"""
            \SimeckRoundEQ{""" + str(r + 1 + self.RB + self.RD) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot0"] + """} % rot0
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["key"] + r"""} % key
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        state = self.draw_ef(self.RF - 1)
        contentsKR += r"""
            \SimeckNoKey{""" + str(self.RB + self.RD + self.RF) + """}
                {""" + state["left"] + """} % left
                {""" + state["right"] + """} % right
                {""" + state["rot5"] + """} % rot5
                {""" + state["rot1"] + """} % rot1
                {""" + state["and"] + """} % and
                {""" + state["xor"] + "} % xor"""
        # draw final ED
        state = self.draw_final_ed(self.RF)
        contentsKR += r"""
              \SimeckFinal{""" + str(self.RD + self.RB + self.RF + 1) + """}
              {""" + state["left"] + """}
              {""" + state["right"] + "}\n"
        closefile = r"""    \end{tikzpicture}""" + "\n"
        closefile += r"""\end{figure}""" + "\n"
        closefile += r"""\end{document}""" + "\n"

        # Draw 2 files
        with open(self.output_file_name.split(".")[0] + "_dist.tex", "w") as f:
            f.write(openfile + contentsDist + closefile)
        with open(self.output_file_name.split(".")[0] + "_kr.tex", "w") as f:
            f.write(openfile + contentsKR + closefile)
