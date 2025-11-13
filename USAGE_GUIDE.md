# Zettelkasten Math Journal - Usage Guide

## Project Structure

```
zettelkasten-math-journal/
├── client/                    # Your React application
│   ├── public/assets/        # Images (logo, favicon, backgrounds)
│   ├── src/
│   │   ├── components/       # UI components (Sidebar, NoteDisplay, GraphView)
│   │   ├── data/            # ⭐ YOUR NOTES ARE HERE!
│   │   │   └── sampleNotes.js   # Edit this file to add/modify notes
│   │   ├── App.jsx          # Main app component
│   │   └── index.css        # All styling
│   ├── package.json         # Frontend dependencies
│   └── vite.config.js       # Build configuration
├── attached_assets/          # User-uploaded files
├── replit.md                # Project documentation & memory
└── USAGE_GUIDE.md           # This file
```

## Overview

Your portfolio has been transformed into a **Zettelkasten-Dataxis hybrid website** for journaling your self-study progress in mathematics. This system combines the networked note-taking approach of Zettelkasten with mathematical content rendered beautifully with MathJax.

## What You Have

### Features

1. **Zettelkasten Structure**: Notes are interconnected with bidirectional links, allowing you to build a network of mathematical knowledge
2. **PreTeXt-Style Math Rendering**: Mathematical notation using LaTeX syntax, rendered beautifully with MathJax
3. **Interactive Graphs**: Data visualizations using Chart.js for mathematical concepts
4. **BibTeX Citations**: Academic citation management with expandable BibTeX entries
5. **Aesthetic Academic Design**: Clean, readable layout optimized for mathematical content

### Sample Prototype Notes

The application includes 4 prototype notes with:
- **AI warning labels** (as requested - these are clearly marked as placeholder content)
- **Lorem ipsum text** (placeholder text for you to replace)
- **Mathematical formulas** in LaTeX format
- **Interactive graphs** demonstrating different visualization types
- **BibTeX citations** with proper academic formatting

## How to Use

### Viewing Notes

1. The **sidebar** on the left shows all your notes in Zettelkasten format
2. Click any note to view its full content
3. Each note displays:
   - Unique ID (timestamp-based)
   - Tags for categorization
   - Abstract
   - Mathematical content
   - Interactive visualizations (where applicable)
   - Links to related notes
   - Academic references with BibTeX

### Creating Your Own Notes

To replace the sample content with your own mathematical notes:

1. **Edit the data file**: `client/src/data/sampleNotes.js`
2. Follow this structure for each note:

```javascript
{
  id: '202511100005',  // Use timestamp format: YYYYMMDDHHmmss
  title: 'Your Note Title',
  tags: ['category1', 'category2'],
  linkedNotes: ['202511100001', '202511100002'],  // IDs of related notes
  content: {
    abstract: 'Brief summary of the mathematical concept',
    sections: [
      {
        title: 'Section Title',
        text: 'Your explanation here',
        math: `LaTeX math notation here, for example:
               \\int_a^b f(x) \\, dx = F(b) - F(a)`
      }
    ]
  },
  citations: ['citation_key'],
  hasGraph: true,  // Set to true if you want a visualization
  graphType: 'function',  // Options: 'function', 'metric', 'sequence'
  aiWarning: false  // Set to false for your real content
}
```

### Writing Mathematical Notation

Use standard LaTeX syntax in the `math` field:

**Inline Math**: `$x^2 + y^2 = z^2$`

**Display Math**: 
```latex
\\text{The Pythagorean theorem states:}
a^2 + b^2 = c^2
```

**Aligned Equations**:
```latex
\\begin{aligned}
f(x) &= x^2 + 3x + 2 \\\\
     &= (x+1)(x+2)
\\end{aligned}
```

### Adding Citations

1. Add your BibTeX entry to the `bibliography` object in `client/src/data/sampleNotes.js`
2. Reference it in your note's `citations` array
3. The formatted citation and BibTeX code will display automatically

Example:
```javascript
bibliography: {
  'your_ref_2024': {
    type: 'book',
    author: 'Author Name',
    title: 'Book Title',
    year: '2024',
    publisher: 'Publisher Name',
    bibtex: `@book{your_ref_2024,
  author = {Author Name},
  title = {Book Title},
  year = {2024},
  publisher = {Publisher Name}
}`
  }
}
```

### Customizing Graphs

Three graph types are available in `client/src/components/GraphDisplay.jsx`:

1. **function**: Line graph (e.g., for plotting f(x) = sin(x))
2. **metric**: Scatter plot (e.g., for points in metric spaces)
3. **sequence**: Line graph with discrete points (e.g., for sequences)

You can customize these or add new graph types by editing `GraphDisplay.jsx`.

## File Structure

```
client/
├── src/
│   ├── components/
│   │   ├── Sidebar.jsx          # Navigation sidebar
│   │   ├── NoteDisplay.jsx      # Main note viewer
│   │   └── GraphDisplay.jsx     # Graph visualizations
│   ├── data/
│   │   └── sampleNotes.js       # Your notes and citations
│   ├── App.jsx                   # Main application
│   └── index.css                 # Styling
├── index.html                    # MathJax configuration
└── package.json                  # Dependencies
```

## Styling & Customization

- **Colors**: Edit CSS variables in `client/src/index.css` (lines 5-22)
- **Fonts**: Currently using:
  - Aclonica for headings
  - Merriweather for body text
  - Fira Code for code/IDs
  - Times New Roman for math
- **Background**: Change the background image by replacing the file reference in `client/src/index.css`

## PreTeXt Integration Notes

While this system uses PreTeXt *principles* (semantic mathematical content, LaTeX notation), it doesn't use PreTeXt XML directly. Instead, it uses:

1. **MathJax** for rendering LaTeX mathematics
2. **Structured JSON** for organizing content semantically
3. **React components** for displaying the structured content

This approach gives you the benefits of PreTeXt (semantic markup, beautiful math rendering) while maintaining flexibility and ease of editing.

## Tips for Building Your Math Journal

1. **Start Small**: Begin with one topic area and build connections as you learn
2. **Link Often**: The power of Zettelkasten comes from connections between ideas
3. **Use Tags Wisely**: Create a consistent tagging system for easy navigation
4. **Be Atomic**: Each note should contain one main concept
5. **Write in Your Own Words**: This aids understanding and retention
6. **Add Visualizations**: Graphs make abstract concepts concrete
7. **Cite Your Sources**: Build good academic habits early

## Development

- **Run Dev Server**: The Vite dev server runs automatically on port 5000
- **Hot Reload**: Changes to files are reflected immediately
- **Build**: Run `npm run build` in the client directory for production

## Removing Sample Content

When you're ready to add your real notes:

1. Edit `client/src/data/sampleNotes.js`
2. Replace the sample notes array with your own notes
3. Update or remove the sample bibliography entries
4. The AI warnings will disappear when you set `aiWarning: false`

---

**Happy studying!** Build your mathematical knowledge network one note at a time.
