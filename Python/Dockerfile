# This is the base image from which we are building our application.
FROM python:alpine3.10

# Working Directiory where the commands needs to be executed.
WORKDIR /app

# Copy the files in the current Directory to the mentioned folder.
COPY . /app

# Runs the commands.
RUN pip install -r requirements.txt

# Expose the container externally so that we can view the applications.
EXPOSE 5001

# Command to run when the container starts up
CMD python ./launch.py