#!/bin/bash

# Define the project directory
project_dir="my_project"

# Create the project structure
mkdir -p "${project_dir}"/app/{api,models,services,utils,templates,static}
mkdir -p "${project_dir}"/tests
mkdir -p "${project_dir}"/migrations/versions
mkdir -p "${project_dir}"/scripts
mkdir -p "${project_dir}"/docs

cd "${project_dir}"

# Create Python package initializations
touch app/__init__.py
touch app/api/__init__.py
touch app/models/__init__.py
touch app/services/__init__.py
touch app/utils/__init__.py
touch tests/__init__.py

# Create specific Python files with provided content
# Flask app initialization
cat << EOF > app/__init__.py
from flask import Flask
from config import Config
from app.models.models import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    from app.api import bp as api_bp
    app.register_blueprint(api_bp, url_prefix='/api')

    return app
EOF

# API Blueprint initialization
echo "from flask import Blueprint

bp = Blueprint('api', __name__)

from app.api import routes, errors" > app/api/__init__.py

# API routes and errors with simple test endpoint and error handlers
cat << EOF > app/api/routes.py
from flask import jsonify
from app.api import bp

@bp.route('/test', methods=['GET'])
def test():
    return jsonify({'message': 'API is working!'})
EOF

echo "from flask import jsonify
from app.api import bp

@bp.errorhandler(404)
def not_found_error(error):
    return jsonify({'error': 'Resource not found'}), 404

@bp.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500" > app/api/errors.py

# Models with SQLAlchemy
echo "from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()" > app/models/__init__.py

echo "from app.models import db

class ExampleModel(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True, nullable=False)" > app/models/models.py

# Placeholder service and utility functions
echo "# Placeholder for business logic to process text
def process_text(text):
    # Imagine processing text here
    return text.upper()" > app/services/text_service.py

echo "import openai

def generate_text(prompt):
    openai.api_key = 'your-api-key-here'
    response = openai.Completion.create(engine='text-davinci-003', prompt=prompt, max_tokens=50)
    return response.choices[0].text.strip()" > app/utils/openai_utils.py

# Configuration, environment variables, and gitignore
echo "import os

class Config(object):
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'you-will-never-guess'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or 'sqlite:///app.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False" > config.py

echo "SECRET_KEY=your_secret_key_here" > .env

echo "venv/
*.pyc
__pycache__/
.env" > .gitignore

# Documentation, README, and requirements.txt
cat << EOF > README.md
# My Project

This project integrates Flask for backend services, including API management, data modeling, and utility functions. It's structured for easy development and deployment.

## Setup

First, install dependencies:

\`\`\`
pip install -r requirements.txt
\`\`\`

Then, start the Flask application:

\`\`\`
flask run
\`\`\`
EOF

cat << EOF > requirements.txt
Flask==2.0.1
Flask-SQLAlchemy==2.5.1
openai==0.10.2
python-dotenv==0.19.0
EOF

# Additional placeholders and configs
touch tests/conftest.py
touch tests/test_models.py
touch tests/test_api.py
touch tests/test_services.py
touch scripts/start_server.sh
echo "# Placeholder for database migration scripts" > migrations/README.md
echo "# Project Documentation

Detail your API endpoints, usage examples, and configuration here." > docs/api_docs.md
echo "# Configuration settings" > config.py

echo "Project structure created successfully."
