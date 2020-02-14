#!/bin/bash

# Convert the mov to gif
ffmpeg -ss 00:00:00.000 -i yesbuddy.mov -pix_fmt rgb24 -r 10 -s 320x240 -t 00:00:10.000 output.gif

# Optimize the gif
convert -layers Optimize output.gif output_optimized.gif

# Divide among png
convert foo.gif -coalesce foo.png

# Display in LaTeX
#
# \documentclass{beamer}
# \usepackage{animate}

# \begin{document}

# \begin{center}
#   \animategraphics[autoplay,loop]{1}{animation}{}{}
# \end{center}

# \end{document}
