#!/bin/bash
rm -rf ~/.my-project-deploy-dir
mkdir -p ~/.my-project-deploy-dir

# Variables
version=$(node -p "require('./package.json').version")
timestamp=$(date)

# Flags (production|staging)
while [ ! $# -eq 0 ]
do
	case "$1" in
		production)
			target="production"
			;;
	esac
	shift
done

# Defining Target repository
if [ "$target" == "production" ]; then
    apiRepository="my-project-heroku-project-name"
else
    exit;
fi

echo "Deploying SpeakEasy API to $target";

PROJECT_DIR=$(pwd)

echo "Deploying API..."

echo "Deploying from $PROJECT_DIR";

# Back-end
cp -r $PROJECT_DIR/* ~/.my-project-deploy-dir/
cp $PROJECT_DIR/.gitignore ~/.my-project-deploy-dir/
cp $PROJECT_DIR/key.json ~/.my-project-deploy-dir/agent-key.json
cp $PROJECT_DIR/Procfile ~/.my-project-deploy-dir/

echo "API ready for deploy."

cd ~/.my-project-deploy-dir

git init
heroku git:remote -a "$apiRepository"

git add .
git commit -m "Auto-Deploy version: $version" -m "Deployed at $timestamp"

echo "Deploying API..."
git push -f heroku master
echo "API deployed."

echo "Removing temporary data..."
rm -rf ~/.my-project-deploy-dir
echo "Temporary data removed...All done."
