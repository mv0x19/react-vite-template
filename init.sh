#!/bin/bash

# Set colours
MAGENTA='\033[0;35m'
NC='\033[0m'

# Remove the .git directory
echo -e "${MAGENTA}Removing the .git directory...${NC}"
rm -rf .git

# Delete the README.md file
echo -e "${MAGENTA}Deleting the README.md file...${NC}"
rm README.md

# Delete the init.sh script
echo -e "${MAGENTA}Deleting the init.sh script...${NC}"
rm init.sh

# Delete the react-vite-template.sh script
echo -e "${MAGENTA}Deleting the react-vite-template.sh script...${NC}"
rm react-vite-template.sh

# Check for updates
echo -e "${MAGENTA}Checking for updates...${NC}"
updates=$(npx npm-check-updates 2>&1)

# Check if updates are available
if echo "$updates" | grep -q "All dependencies match the latest package versions :)"
then
  # No updates available, skip prompt and display message
  echo "All dependencies match the latest package versions :)"

  # Set the updated variable to false since there are no updates available
  updated=false
else
  # Output message returned by npm-check-updates
  echo "$updates"

  # Prompt user to update
  read -p "Would you like to update the dependencies? (y/n) " answer
  case ${answer:0:1} in
    y|Y)
      # Update dependencies
      echo -e "${MAGENTA}Updating dependencies...${NC}"
      npx npm-check-updates -u

      # Install updated dependencies
      echo -e "${MAGENTA}Installing updated dependencies...${NC}"
      npm i

      # Set the updated variable to true as updated dependencies have been installed
      updated=true
      ;;
    *)
      # Set the updated variable to false as the user chose not to update the dependencies
      updated=false
      ;;
  esac
fi

# Install dependencies if not updated
if [ "$updated" = false ]
then
  # The user chose not to update the dependencies, so install the existing dependencies
  echo -e "${MAGENTA}Installing dependencies...${NC}"
  npm i
fi

# Initialize git repository
echo -e "${MAGENTA}Initializing git repository...${NC}"
git init

# Add files to the staging area
echo -e "${MAGENTA}Adding files to the staging area...${NC}"
git add .

# Commit the changes
echo -e "${MAGENTA}Committing the changes...${NC}"
git commit -m "init"

# Open the project directory in Visual Studio Code
echo -e "${MAGENTA}Opening the project directory in Visual Studio Code...${NC}"
code .