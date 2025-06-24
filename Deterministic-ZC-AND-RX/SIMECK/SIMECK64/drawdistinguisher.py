import textwrap


class Draw(object):
    def __init__(self, zc_object, output_file_name="output.tex", attack_summary=""):
        self.result = zc_object.result
        self.MD = zc_object.MD
        self.RD = zc_object.RD
        self.block_size = zc_object.block_size
        self.attack_summary = attack_summary
        self.output_file_name = output_file_name
        self.fillcolor_up = {0: "zero", 1: "upperone", -1: "upperunknown"}
        self.fillcolor_lo = {0: "zero", 1: "lowerone", -1: "lowerunknown"}

    def draw_upperX(self, r):
        """
        Paint the upper part of the ED
        """

        output = {
            "left": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xul"][r][i]], i) for i in
                            range(self.block_size // 2) if self.result["xul"][r][i] != 0),
            "right": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["xur"][r][i]], i) for i in
                             range(self.block_size // 2) if self.result["xur"][r][i] != 0),
        }
        return output

    def draw_upperM(self, r):
        output = {
            "left": "".join(r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["mxl1"][r][i]], i) for i in
                            range(self.block_size // 2) if self.result["mxl1"][r][i] != 0),
            "right": "".join(r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["mxr1"][r][i]], i) for i in
                             range(self.block_size // 2) if self.result["mxr1"][r][i] != 0)
        }
        return output

    def draw_lowerX(self, r):
        """
        Paint the lower part of the ED
        """
        output = {
            "left": "".join(r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdl"][r][i]], i) for i in
                            range(self.block_size // 2) if self.result["xdl"][r][i] != 0),
            "right": "".join(r"\BFill[{0}]{{s{1}}}".format(self.fillcolor_lo[self.result["xdr"][r][i]], i) for i in
                             range(self.block_size // 2) if self.result["xdr"][r][i] != 0),
        }
        return output

    def draw_lowerM(self, r):
        output = {
            "left": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["mxl1"][r][i]], i) for i in
                            range(self.block_size // 2) if self.result["mxl1"][r][i] != 0),
            "right": "".join(r"\TFill[{0}]{{s{1}}}".format(self.fillcolor_up[self.result["mxr1"][r][i]], i) for i in
                             range(self.block_size // 2) if self.result["mxr1"][r][i] != 0)
        }
        return output

    def draw_ed(self, r):
        """
        Draw ED
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

    def draw_combined_shape(self):
        contents = textwrap.dedent(r"""
                    \documentclass[varwidth=100cm]{standalone}
                    \usepackage{tikz}
                    \usepackage{simeck}
                    \begin{document}
                    \begin{figure}
                        \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
                            \simeckcompactfalse
                            \begin{scope}[local bounding box=SimeckInit]
                                \SimeckInit[""" + str(self.block_size) + """]""")
        # draw upper ED
        for r in range(0, self.MD):
            state = self.draw_upperX(r)
            contents += r"""
                        \SimeckRoundShort{""" + str(r + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        # draw last round of upper ED
        state = self.draw_upperX(self.MD)
        contents += r"""
                        \SimeckFinal{""" + str(self.MD + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}""" + "\n"
        contents += r"""
                        \SimeckGap"""
        # draw lower ED
        for r in range(self.MD, self.RD):
            state = self.draw_lowerX(r)
            contents += r"""
                        \SimeckRoundShort{""" + str(r + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        # draw last round of lower ED
        state = self.draw_lowerX(self.RD)
        contents += r"""
                        \SimeckFinal{""" + str(self.RD + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}""" + "\n"
        contents += r"""
                            \end{scope}
                            \newlength{\mydimen}
                            \pgfextractx{\mydimen}{\pgfpointanchor{current bounding box}{east}}
                            \begin{scope}[xshift=\mydimen*1.2,local bounding box=SimeckInit2]
                                \SimeckInit[""" + str(self.block_size) + """]""" + "\n"
        # draw upper MD
        for r in range(0, self.MD):
            state = self.draw_upperM(r)
            contents += r"""
                        \SimeckRoundShort{""" + str(r + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        state = self.draw_upperM(self.MD)
        contents += r"""
                        \SimeckFinal{""" + str(self.MD + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        contents += r"""
                        \SimeckGap"""
        # draw lower MD
        for r in range(self.MD, self.RD):
            state = self.draw_lowerM(r)
            contents += r"""
                        \SimeckRoundShort{""" + str(r + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        state = self.draw_lowerM(self.RD)
        contents += r"""
                        \SimeckFinal{""" + str(self.RD + 1) + """}
                            {""" + state["left"] + """}
                            {""" + state["right"] + """}"""
        contents += r"""
                        \end{scope}""" + "\n"

        contents += r"""    \end{tikzpicture}""" + "\n"
        contents += r"""\caption{""" + str(self.RD) + r" rounds of \SIMECK[" + str(self.block_size) + "].}\n"
        contents += r"""\end{figure}""" + "\n"
        contents += r"""\end{document}"""
        return contents

    def draw_direct_shape(self):
        contents = textwrap.dedent(r"""
        \documentclass[varwidth=100cm]{standalone}
        \usepackage{tikz}
        \usepackage{simeck}
        \begin{document}
        \begin{figure}
            \begin{tikzpicture}[>=latex,fillopts/.style={black},raster/.style={gray!50}]
                \simeckcompactfalse
                \SimeckInit[""" + str(self.block_size) + """]""")
        # draw ED
        for r in range(0, self.RD):
            state = self.draw_ed(r)
            contents += r"""
                    \SimeckRoundShort{""" + str(r + 1) + """}
                        {""" + state["left"] + """} % left
                        {""" + state["right"] + """} % right""" + "\n"
        state = self.draw_ed(self.RD)
        contents += r"""
                    \SimeckFinal{""" + str(self.RD + 1) + """}
                        {""" + state["left"] + """}
                        {""" + state["right"] + "}\n" + "\n"
        contents += r"""   \end{tikzpicture}""" + "\n"
        contents += r"""\caption{""" + str(self.RD) + r" rounds of \SIMECK[" + str(self.block_size) + "].}\n"
        contents += r"""\end{figure}""" + "\n"
        contents += r"""\end{document}"""
        return contents

    def generate_attack_shape(self):
        """
        Generate the attack shape
        """
        
        contents = self.draw_combined_shape()
        with open(self.output_file_name, "w") as f:
            f.write(contents)
