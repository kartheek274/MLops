FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install build tools (optional but helpful for some packages). Remove cached lists to keep image small.
RUN apt-get update \
	&& apt-get install -y --no-install-recommends build-essential \
	&& rm -rf /var/lib/apt/lists/*

# Copy only requirements first so Docker can cache dependency installation when sources change
COPY requirements.txt ./

# Upgrade pip and install python dependencies
RUN python -m pip install --upgrade pip setuptools wheel \
	&& pip install --no-cache-dir -r requirements.txt

# Now copy application source
COPY . /app

# Default command
CMD ["python", "app.py"]
