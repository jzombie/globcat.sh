# Use an official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    bash \
    coreutils \
    findutils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /usr/src/app

# Copy the globcat.sh script into the container
COPY globcat.sh .

# Copy the scenario_1 test directories and files into the container
COPY test/scenario_1/test1 /usr/src/app/test/test1
COPY test/scenario_1/test2 /usr/src/app/test/test2

# Copy the scenario_2 test directories and files into the container
COPY test/scenario_2/test3 /usr/src/app/test/test3
COPY test/scenario_2/test4 /usr/src/app/test/test4

# Make the globcat.sh script executable
RUN chmod +x globcat.sh

# Copy the expected output files into the container
COPY test/scenario_1/expected_output.txt /usr/src/app/expected_output_scenario_1.txt
COPY test/scenario_2/expected_output.txt /usr/src/app/expected_output_scenario_2.txt

# Create a test script
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Running Scenario 1 Test..."\n\
./globcat.sh -e "*.md,*.txt" -d "./test/test1,./test/test2" > actual_output_scenario_1.txt\n\
diff -u expected_output_scenario_1.txt actual_output_scenario_1.txt\n\
if [ $? -eq 0 ]; then\n\
  echo "Scenario 1 Test passed: Output matches expected result."\n\
else\n\
  echo "Scenario 1 Test failed: Output does not match expected result."\n\
  exit 1\n\
fi\n\
echo "Running Scenario 2 Test..."\n\
./globcat.sh -e "*.md" -d "./test/test3,./test/test4" > actual_output_scenario_2.txt\n\
diff -u expected_output_scenario_2.txt actual_output_scenario_2.txt\n\
if [ $? -eq 0 ]; then\n\
  echo "Scenario 2 Test passed: Output matches expected result."\n\
else\n\
  echo "Scenario 2 Test failed: Output does not match expected result."\n\
  exit 1\n\
fi' > test.sh && \
    chmod +x test.sh

# Run the test script
CMD ["./test.sh"]
