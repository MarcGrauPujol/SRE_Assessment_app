# Use an official Python runtime as a base image
FROM python:3.12-slim

# Declare environment variable
ARG FLASK_ENV=production
ENV FLASK_APP=hello
ENV FLASK_ENV=${FLASK_ENV}

# Set the working directory in the container
WORKDIR /app

# Copy only setup first to take advantage of Docker layer caching
COPY setup.py .

# Install dependencies
RUN pip install --upgrade pip &&\
    pip install .

# Copy the rest of the application code to the container
COPY . .

# Create a non-root user, give ownership of the app directory,and switch to that user
RUN useradd --create-home myuser && \
    chown -R myuser:myuser /app
USER myuser

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Run the application
CMD ["flask", "run", "--host=0.0.0.0"]
