#!/usr/bin/env python3
"""
Convert markdown to HTML using Jekyll-style front matter and layout
Special handling for preformatted worksheets
"""

import re
import os
import sys

def read_layout(layout_name):
    """Read the layout template"""
    layout_paths = [
        f"_layouts/{layout_name}.html",
        f"../_layouts/{layout_name}.html"
    ]
    for layout_path in layout_paths:
        if os.path.exists(layout_path):
            with open(layout_path, 'r') as f:
                return f.read()
    return None

def parse_front_matter(content):
    """Parse Jekyll front matter"""
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            front_matter = parts[1].strip()
            body = parts[2].strip()
            
            # Parse key-value pairs
            metadata = {}
            for line in front_matter.split('\n'):
                if ':' in line:
                    key, value = line.split(':', 1)
                    metadata[key.strip()] = value.strip().strip('"').strip("'")
            
            return metadata, body
    return {}, content

def markdown_to_html(content):
    """Convert markdown to HTML with fenced code blocks"""
    # Escape HTML entities
    content = content.replace('&', '&amp;')
    content = content.replace('<', '&lt;')
    content = content.replace('>', '&gt;')

    # Split into fenced code blocks and normal text
    parts = re.split(r'(?:^|\n)```([^\n]*)\n([\s\S]*?)\n```', content)

    html_parts = []
    i = 0
    while i < len(parts):
        if i + 2 < len(parts):
            normal = parts[i]
            if normal:
                html_parts.append(
                    '<pre style="white-space: pre-wrap; word-wrap: break-word; margin: 0; font-family: monospace;">'
                    + normal +
                    '</pre>'
                )
            lang = parts[i + 1].strip()
            code = parts[i + 2]
            class_attr = f' class="language-{lang}"' if lang else ''
            html_parts.append(f'<pre><code{class_attr}>{code}</code></pre>')
            i += 3
        else:
            normal = parts[i]
            if normal:
                html_parts.append(
                    '<pre style="white-space: pre-wrap; word-wrap: break-word; margin: 0; font-family: monospace;">'
                    + normal +
                    '</pre>'
                )
            i += 1

    return '\n'.join(html_parts)

def process_file(md_file):
    """Process a markdown file"""
    with open(md_file, 'r') as f:
        content = f.read()
    
    metadata, body = parse_front_matter(content)
    
    if 'layout' not in metadata:
        print(f"No layout specified for {md_file}")
        return
    
    layout = read_layout(metadata['layout'])
    if not layout:
        print(f"Layout not found: {metadata['layout']}")
        return
    
    # Convert markdown body
    html_body = markdown_to_html(body)
    
    # Apply layout
    html = layout.replace('{{ content }}', html_body)
    html = html.replace('{{ page.title }}', metadata.get('title', 'Untitled'))
    
    # Output filename
    html_file = md_file.replace('.md', '.html')
    
    with open(html_file, 'w') as f:
        f.write(html)
    
    print(f"Converted: {md_file} -> {html_file}")

if __name__ == '__main__':
    if len(sys.argv) > 1:
        for md_file in sys.argv[1:]:
            if os.path.exists(md_file):
                process_file(md_file)
            else:
                print(f"File not found: {md_file}")
    else:
        # Process all markdown files in current directory
        for md_file in os.listdir('.'):
            if md_file.endswith('.md'):
                process_file(md_file)
