#!/usr/bin/env sh

set -e

# Helper function to print colored status
print_step() {
  echo "\033[1;34m🔄 $1...\033[0m"
}

print_success() {
  echo "\033[1;32m✅ $1\033[0m"
}

print_error() {
  echo "\033[1;31m❌ $1\033[0m"
}


# Load environment variables from .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  print_success ".env loaded"
else
  print_error ".env file not found!"
  exit 1
fi

# Ensure required env vars are set
if [ -z "$GITHUB_USER" ] || [ -z "$REPO_NAME" ] || [ -z "$PROJECT_NAME" ]; then
  print_error "GITHUB_USER, REPO_NAME, PROJECT_NAME must be defined in the .env file"
  exit 1
fi

# # Extract Angular project name from angular.json
# PROJECT_NAME=$(node -p "require('./angular.json').defaultProject")

# Remove previous dist/ folder
print_step "Removing previous dist/ folder if it exists"
rm -rf dist
print_success "Old dist/ folder removed"

# Build the Angular project with base-href for GitHub Pages
print_step "Building Angular project with base-href"
# ng build --base-href "https://${GITHUB_USER}.github.io/${REPO_NAME}/"
ng build $PROJECT_NAME --base-href "/${REPO_NAME}/" --deploy-url "/${REPO_NAME}/"
print_success "Build complete"


# Navigate to the output directory
print_step "Navigating to dist/$PROJECT_NAME/browser"
# cd dist/${PROJECT_NAME}
cd dist/${PROJECT_NAME}/browser

# Deploy to GitHub Pages
print_step "Initializing Git repository and committing changes"
git init > /dev/null
git checkout -b main
git add -A
git commit -m 'deploy' > /dev/null
print_success "Git commit done"

print_step "Pushing to GitHub gh-pages branch"
# git push -f git@github.com:${GITHUB_USER}/${REPO_NAME}.git main:gh-pages
git push -f https://github.com/${GITHUB_USER}/${REPO_NAME}.git main:gh-pages
print_success "Deployment complete!"