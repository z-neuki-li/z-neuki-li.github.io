#!/bin/bash
# Local compile LaTeX CV script
# Usage: ./compile_cv.sh

cd "$(dirname "$0")/assets/cv"

# Check if there is a .tex file; if not, if there is pdf file, then use it; if not still, error out
if [ ! -f "CV_Zihan_Li_blog.tex" ] || [ ! -s "CV_Zihan_Li_blog.tex" ]; then
    # .tex file doesn't exist or is empty
    if [ ! -f "CV_Zihan_Li_blog.pdf" ]; then
        echo "Error: Neither CV_Zihan_Li_blog.tex nor CV_Zihan_Li_blog.pdf file found"
        exit 1
    fi
    # Clean up temporary files (if any)
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
    echo "No .tex file found. Using existing PDF file."
    echo "PDF file: assets/cv/CV_Zihan_Li_blog.pdf"
else
    # .tex file exists and is not empty, compile it
    echo "Compiling LaTeX CV..."
    pdflatex -interaction=nonstopmode -halt-on-error CV_Zihan_Li_blog.tex
    
    # Run pdflatex again to resolve all references (usually 2 passes are enough for CV)
    pdflatex -interaction=nonstopmode -halt-on-error CV_Zihan_Li_blog.tex
    
    # Clean up temporary files
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz
    
    echo "Compiled LaTeX CV successfully!"
    echo "PDF file: assets/cv/CV_Zihan_Li_blog.pdf"
fi

