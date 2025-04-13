#!/usr/bin/env bash
# Cognitive Ecosystem - Initialization Script
# Creates the essential structure for your knowledge system

# Configuration
CURRENT_DIR=$(pwd)
TEMPLATES_PATH="$CURRENT_DIR/.templates"
CURRENT_DATE=$(date +%Y-%m-%d)
DEFAULT_EDITOR="nvim" # Change to your preferred editor

# Colors for prettier output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function log_step() {
    echo -e "${BLUE}→ $1${NC}"
}

function log_done() {
    echo -e "${GREEN}✓ $1${NC}"
}

function log_warn() {
    echo -e "${YELLOW}! $1${NC}"
}

function log_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Prompt for username
log_step "Please enter your username for the seed file:"
read USERNAME
if [ -z "$USERNAME" ]; then
    USERNAME="user"
    log_warn "No username provided, using 'user' as default"
else
    log_done "Using username: $USERNAME"
fi

# Safety check - confirm if critical directories already exist
if [ -d "$CURRENT_DIR/journal" ] || [ -d "$CURRENT_DIR/.templates" ]; then
    log_warn "Some system directories already exist in: $CURRENT_DIR"
    read -p "Continue and potentially overwrite existing files? (y/N) " confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        log_error "Initialization aborted by user"
        exit 1
    fi
fi

# Create basic README
log_step "Creating README.md..."
echo "# Cognitive Ecosystem" > "$CURRENT_DIR/README.md"
echo "" >> "$CURRENT_DIR/README.md"
echo "A personal knowledge management system designed for deep integration of ideas, code, and resources." >> "$CURRENT_DIR/README.md"
log_done "README created"

# Create all necessary directories
log_step "Creating directory structure..."
# Main directories
mkdir -p "$CURRENT_DIR/journal/daily"
mkdir -p "$CURRENT_DIR/journal/weekly"
mkdir -p "$CURRENT_DIR/journal/monthly"
mkdir -p "$CURRENT_DIR/journal/quarterly"
mkdir -p "$CURRENT_DIR/journal/yearly"
mkdir -p "$CURRENT_DIR/projects"
mkdir -p "$CURRENT_DIR/people"
mkdir -p "$CURRENT_DIR/knowledge"
mkdir -p "$CURRENT_DIR/notebooks"
mkdir -p "$CURRENT_DIR/code"
mkdir -p "$CURRENT_DIR/resources"
mkdir -p "$TEMPLATES_PATH"
log_done "Directory structure created"

# Create seed node template
log_step "Creating seed node template..."
SEED_TEMPLATE="$TEMPLATES_PATH/01-seed-node.md"
echo "---" > "$SEED_TEMPLATE"
echo "aliases: [\"Home\", \"Hub\", \"Seed\"]" >> "$SEED_TEMPLATE"
echo "tags: [system/core]" >> "$SEED_TEMPLATE"
echo "created: $CURRENT_DATE" >> "$SEED_TEMPLATE"
echo "---" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
echo "# Personal Seed Node" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
echo "## Input Stream" >> "$SEED_TEMPLATE"
echo "<!-- Capture your thoughts here without worrying about organization -->" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
echo "## Navigation" >> "$SEED_TEMPLATE"
echo "<!-- Core links to primary areas -->" >> "$SEED_TEMPLATE"
echo "- [[journal/00-index|Journal]]" >> "$SEED_TEMPLATE"
echo "- [[projects/00-index|Projects]]" >> "$SEED_TEMPLATE"
echo "- [[people/00-index|People]]" >> "$SEED_TEMPLATE"
echo "- [[knowledge/00-index|Knowledge]]" >> "$SEED_TEMPLATE"
echo "- [[notebooks/00-index|Notebooks]]" >> "$SEED_TEMPLATE"
echo "- [[code/00-index|Code]]" >> "$SEED_TEMPLATE"
echo "- [[resources/00-index|Resources]]" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
echo "## Current Focus" >> "$SEED_TEMPLATE"
echo "<!-- What needs your attention right now -->" >> "$SEED_TEMPLATE"
echo "" >> "$SEED_TEMPLATE"
log_done "Seed node template created"

# Create daily note template
log_step "Creating daily note template..."
DAILY_TEMPLATE="$TEMPLATES_PATH/10-daily-note.md"
echo "---" > "$DAILY_TEMPLATE"
echo "tags: [journal/daily]" >> "$DAILY_TEMPLATE"
echo "date: {{date}}" >> "$DAILY_TEMPLATE"
echo "---" >> "$DAILY_TEMPLATE"
echo "# {{date_pretty}}" >> "$DAILY_TEMPLATE"
echo "" >> "$DAILY_TEMPLATE"
echo "## Morning Thoughts" >> "$DAILY_TEMPLATE"
echo "" >> "$DAILY_TEMPLATE"
echo "## Ideas & Notes" >> "$DAILY_TEMPLATE"
echo "" >> "$DAILY_TEMPLATE"
echo "## Evening Reflection" >> "$DAILY_TEMPLATE"
echo "" >> "$DAILY_TEMPLATE"
log_done "Daily note template created"

# Create project note template
log_step "Creating project note template..."
PROJECT_TEMPLATE="$TEMPLATES_PATH/20-project-note.md"
echo "---" > "$PROJECT_TEMPLATE"
echo "tags: [project]" >> "$PROJECT_TEMPLATE"
echo "status: idea" >> "$PROJECT_TEMPLATE"
echo "started: {{date}}" >> "$PROJECT_TEMPLATE"
echo "---" >> "$PROJECT_TEMPLATE"
echo "# {{title}}" >> "$PROJECT_TEMPLATE"
echo "" >> "$PROJECT_TEMPLATE"
echo "## Purpose" >> "$PROJECT_TEMPLATE"
echo "" >> "$PROJECT_TEMPLATE"
echo "## Current Status" >> "$PROJECT_TEMPLATE"
echo "" >> "$PROJECT_TEMPLATE"
echo "## Next Steps" >> "$PROJECT_TEMPLATE"
echo "" >> "$PROJECT_TEMPLATE"
log_done "Project template created"

# Create knowledge note template
log_step "Creating knowledge note template..."
KNOWLEDGE_TEMPLATE="$TEMPLATES_PATH/30-knowledge-note.md"
echo "---" > "$KNOWLEDGE_TEMPLATE"
echo "tags: [knowledge]" >> "$KNOWLEDGE_TEMPLATE"
echo "created: {{date}}" >> "$KNOWLEDGE_TEMPLATE"
echo "---" >> "$KNOWLEDGE_TEMPLATE"
echo "# {{title}}" >> "$KNOWLEDGE_TEMPLATE"
echo "" >> "$KNOWLEDGE_TEMPLATE"
echo "## Overview" >> "$KNOWLEDGE_TEMPLATE"
echo "" >> "$KNOWLEDGE_TEMPLATE"
echo "## Key Concepts" >> "$KNOWLEDGE_TEMPLATE"
echo "" >> "$KNOWLEDGE_TEMPLATE"
echo "## Connections" >> "$KNOWLEDGE_TEMPLATE"
echo "" >> "$KNOWLEDGE_TEMPLATE"
log_done "Knowledge template created"

# Create .env file template
log_step "Creating .env file template..."
ENV_TEMPLATE="$TEMPLATES_PATH/50-env.template"
echo "# Cognitive Ecosystem Configuration" > "$ENV_TEMPLATE"
echo "" >> "$ENV_TEMPLATE"
echo "# API Keys" >> "$ENV_TEMPLATE"
echo "OPENAI_API_KEY=" >> "$ENV_TEMPLATE"
echo "ANTHROPIC_API_KEY=" >> "$ENV_TEMPLATE"
echo "" >> "$ENV_TEMPLATE"
echo "# Model Configuration" >> "$ENV_TEMPLATE"
echo "DEFAULT_LLM_PROVIDER=anthropic" >> "$ENV_TEMPLATE"
echo "DEFAULT_LLM_MODEL=claude-3-7-sonnet-20250219" >> "$ENV_TEMPLATE"
echo "DEFAULT_EMBEDDING_MODEL=text-embedding-3-large" >> "$ENV_TEMPLATE"
echo "" >> "$ENV_TEMPLATE"
echo "# System Settings" >> "$ENV_TEMPLATE"
echo "LOG_LEVEL=info" >> "$ENV_TEMPLATE"
echo "ENABLE_AUTONOMOUS_AGENTS=false" >> "$ENV_TEMPLATE"
log_done ".env template created"

# Create basic .gitignore
log_step "Creating .gitignore..."
echo ".env" > "$CURRENT_DIR/.gitignore"
echo ".DS_Store" >> "$CURRENT_DIR/.gitignore"
echo "__pycache__/" >> "$CURRENT_DIR/.gitignore"
echo "*.pyc" >> "$CURRENT_DIR/.gitignore"
log_done ".gitignore created"

# Create initial seed node
log_step "Creating seed node..."
SEED_NODE="$CURRENT_DIR/people/01-seed-$USERNAME.md"
cat "$TEMPLATES_PATH/01-seed-node.md" > "$SEED_NODE"
log_done "Seed node created at $SEED_NODE"

# Create today's daily note
log_step "Creating today's daily note..."
TODAY_NOTE="$CURRENT_DIR/journal/daily/$CURRENT_DATE.md"
DATE_PRETTY=$(date '+%A, %B %-d, %Y')
sed "s/{{date}}/$CURRENT_DATE/g" "$TEMPLATES_PATH/10-daily-note.md" | sed "s/{{date_pretty}}/$DATE_PRETTY/g" > "$TODAY_NOTE"
log_done "Today's note created at $TODAY_NOTE"

# Create index files
log_step "Creating index files..."
# Journal index
JOURNAL_INDEX="$CURRENT_DIR/journal/00-index.md"
echo "# Journal" > "$JOURNAL_INDEX"
echo "" >> "$JOURNAL_INDEX"
echo "## Daily Entries" >> "$JOURNAL_INDEX"
echo "- [[$CURRENT_DATE]] (Today)" >> "$JOURNAL_INDEX"
echo "" >> "$JOURNAL_INDEX"
echo "## Time Periods" >> "$JOURNAL_INDEX"
echo "- [[weekly/00-index|Weekly Reviews]]" >> "$JOURNAL_INDEX"
echo "- [[monthly/00-index|Monthly Reviews]]" >> "$JOURNAL_INDEX"
echo "- [[quarterly/00-index|Quarterly Reviews]]" >> "$JOURNAL_INDEX"
echo "- [[yearly/00-index|Yearly Reviews]]" >> "$JOURNAL_INDEX"
echo "" >> "$JOURNAL_INDEX"

# Journal sub-indexes
echo "# Weekly Reviews" > "$CURRENT_DIR/journal/weekly/00-index.md"
echo "" >> "$CURRENT_DIR/journal/weekly/00-index.md"
echo "# Monthly Reviews" > "$CURRENT_DIR/journal/monthly/00-index.md"
echo "" >> "$CURRENT_DIR/journal/monthly/00-index.md"
echo "# Quarterly Reviews" > "$CURRENT_DIR/journal/quarterly/00-index.md"
echo "" >> "$CURRENT_DIR/journal/quarterly/00-index.md"
echo "# Yearly Reviews" > "$CURRENT_DIR/journal/yearly/00-index.md"
echo "" >> "$CURRENT_DIR/journal/yearly/00-index.md"

# Projects index
echo "# Projects" > "$CURRENT_DIR/projects/00-index.md"
echo "" >> "$CURRENT_DIR/projects/00-index.md"
echo "## Active Projects" >> "$CURRENT_DIR/projects/00-index.md"
echo "" >> "$CURRENT_DIR/projects/00-index.md"

# People index
echo "# People" > "$CURRENT_DIR/people/00-index.md"
echo "" >> "$CURRENT_DIR/people/00-index.md"
echo "## Connections" >> "$CURRENT_DIR/people/00-index.md"
echo "- [[01-seed-$USERNAME|$USERNAME (Me)]]" >> "$CURRENT_DIR/people/00-index.md"
echo "" >> "$CURRENT_DIR/people/00-index.md"

# Knowledge index
echo "# Knowledge" > "$CURRENT_DIR/knowledge/00-index.md"
echo "" >> "$CURRENT_DIR/knowledge/00-index.md"
echo "## Domains" >> "$CURRENT_DIR/knowledge/00-index.md"
echo "" >> "$CURRENT_DIR/knowledge/00-index.md"

# Notebooks index
echo "# Notebooks" > "$CURRENT_DIR/notebooks/00-index.md"
echo "" >> "$CURRENT_DIR/notebooks/00-index.md"
echo "## Experiments" >> "$CURRENT_DIR/notebooks/00-index.md"
echo "" >> "$CURRENT_DIR/notebooks/00-index.md"

# Code index
echo "# Code" > "$CURRENT_DIR/code/00-index.md"
echo "" >> "$CURRENT_DIR/code/00-index.md"
echo "## Components" >> "$CURRENT_DIR/code/00-index.md"
echo "" >> "$CURRENT_DIR/code/00-index.md"

# Resources index
echo "# Resources" > "$CURRENT_DIR/resources/00-index.md"
echo "" >> "$CURRENT_DIR/resources/00-index.md"
echo "## Papers" >> "$CURRENT_DIR/resources/00-index.md"
echo "" >> "$CURRENT_DIR/resources/00-index.md"
log_done "Index files created"

# Create .env file from template
log_step "Creating .env file..."
ENV_FILE="$CURRENT_DIR/.env"
cp "$TEMPLATES_PATH/50-env.template" "$ENV_FILE"
log_done ".env file created"

# Set up bash alias directly in current shell and in config
log_step "Setting up bash alias..."
REPO_PATH=$(realpath "$CURRENT_DIR")

# Create the alias in the current shell
alias s="cd \"$REPO_PATH\" && $DEFAULT_EDITOR \"people/01-seed-$USERNAME.md\""

# Also add it to the config file if not already there
BASH_RC="$HOME/.bashrc"
if [ -f "$HOME/.bash_profile" ]; then
    BASH_RC="$HOME/.bash_profile"
fi

if ! grep -q "alias s='cd \"$REPO_PATH\"" "$BASH_RC"; then
    echo "" >> "$BASH_RC"
    echo "# Cognitive Ecosystem - quick access to seed node" >> "$BASH_RC"
    echo "alias s='cd \"$REPO_PATH\" && $DEFAULT_EDITOR \"people/01-seed-$USERNAME.md\"'" >> "$BASH_RC"
    log_done "Added alias 's' to bash config and current shell"
else
    log_warn "Alias 's' already exists in bash config"
    log_done "Added alias 's' to current shell only"
fi

# Create next steps document
log_step "Creating next steps document..."
NEXT_STEPS="$CURRENT_DIR/00-NEXT-STEPS.md"
echo "# Next Steps for Your Cognitive Ecosystem" > "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "Now that you have your basic structure in place, here are some suggested next steps:" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "## Immediate Actions" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "1. **Initialize Git Repository**" >> "$NEXT_STEPS"
echo "   \`\`\`bash" >> "$NEXT_STEPS"
echo "   git init" >> "$NEXT_STEPS"
echo "   git add ." >> "$NEXT_STEPS"
echo "   git commit -m \"Initial commit: Cognitive Ecosystem seed\"" >> "$NEXT_STEPS"
echo "   \`\`\`" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "2. **Set Up Obsidian**" >> "$NEXT_STEPS"
echo "   - Open this folder in Obsidian" >> "$NEXT_STEPS"
echo "   - Configure graph view for better visualization" >> "$NEXT_STEPS"
echo "   - Consider useful plugins like Dataview or Calendar" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "3. **Begin Journal Practice**" >> "$NEXT_STEPS"
echo "   - Start using the daily journal for note-taking" >> "$NEXT_STEPS"
echo "   - Use the seed node as your dashboard" >> "$NEXT_STEPS"
echo "   - Begin organizing knowledge as it emerges" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "## Development Paths" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "1. **Basic CLI Tool**" >> "$NEXT_STEPS"
echo "   - Create a simple Python CLI in the code directory" >> "$NEXT_STEPS"
echo "   - Implement commands for common operations" >> "$NEXT_STEPS"
echo "   - Add FZF integration for navigation" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "2. **Resource Processing**" >> "$NEXT_STEPS"
echo "   - Set up a pipeline for processing PDFs" >> "$NEXT_STEPS"
echo "   - Implement YouTube transcript extraction" >> "$NEXT_STEPS"
echo "   - Create a system for code documentation" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "3. **Agent Framework**" >> "$NEXT_STEPS"
echo "   - Implement a basic receptionist agent" >> "$NEXT_STEPS"
echo "   - Set up vector storage for embeddings" >> "$NEXT_STEPS"
echo "   - Create a simple chat interface" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "## File Numbering Convention" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "The system uses a numerical prefix convention for organizing files:" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "- **00-**: Index files that provide an overview of a directory" >> "$NEXT_STEPS"
echo "- **01-09**: Primary/core files (e.g., seed node)" >> "$NEXT_STEPS"
echo "- **10-49**: Standard content files" >> "$NEXT_STEPS"
echo "- **50-99**: Configuration and system files" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "The only files without numerical prefixes are journal entries, which use date-based naming." >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "## System Evolution" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "As your system grows, consider:" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "- **Git Hooks** for automation" >> "$NEXT_STEPS"
echo "- **Dashboard Development** for system visibility" >> "$NEXT_STEPS"
echo "- **Integration with External Tools** like tmux and neovim" >> "$NEXT_STEPS"
echo "- **Autonomous Processing** for knowledge metabolism" >> "$NEXT_STEPS"
echo "" >> "$NEXT_STEPS"
echo "Remember that the system should grow organically based on your actual usage patterns." >> "$NEXT_STEPS"
echo "Focus on establishing consistent practices before implementing complex automations." >> "$NEXT_STEPS"
log_done "Next steps document created"

echo ""
log_done "Initialization complete! Your cognitive ecosystem is ready."
echo ""
echo -e "${GREEN}To access your seed node, type 's' (works in current shell)${NC}"
echo -e "${BLUE}Or navigate to: $SEED_NODE${NC}"
echo ""
echo -e "${YELLOW}See 00-NEXT-STEPS.md for suggested actions to continue development${NC}"
echo ""
