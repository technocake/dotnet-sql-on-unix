FROM microsoft/mssql-server-linux:latest

# Optional: Copy the database files into the container
# COPY database.sql /

# Make sqlcmd available from the path
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> /etc/bash.bashrc


# Mind that there is no ENTRYPOINT in this Dockerfile, this makes docker reuse
# the one we inherit from the mssql base image.
