#!/bin/bash

setup() {
    printer "🔨 Setting up the repo"
    git submodule update --init --recursive
    handler
}

notes() {
    printer "📚 Generating documentation"
    mkdir -p ./dist
    pandoc ./docs/articles/md/*.md \
        -o ./dist/content_notes.pdf \
        --from=markdown \
        --template=./pandoc-latex-template/template-multi-file/eisvogel.latex \
        --pdf-engine=xelatex \
        --filter=pandoc-latex-environment \
        --listings
    pdfunite \
        ./dist/front_notes.pdf \
        ./dist/content_notes.pdf \
        ./dist/Notes.pdf
    handler
}

printer() {
    echo ""
    echo $1
    echo ""
}

handler() {
    if [ $? -eq 0 ]; then
        printer "✅ Process completed successfully"
    else
        printer "❌ An error occurred during the process"
        exit 1
    fi
}

case $1 in
    setup)
        setup
        ;;
    notes)
        notes
        ;;
    *)
        echo "Usage: $0 {setup|notes}"
        ;;
esac
