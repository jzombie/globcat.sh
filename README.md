# globcat.sh

<img src="assets/globcat.webp" alt="Glob Cat" width="400"/>

`globcat.sh` is a tiny little script that concatenates multiple files together, as specified by a glob pattern, and outputs them to standard output.

I personally use it to send the source code of multiple files to ChatGPT (and I even used it to help write the tests for this project).

## Usage

```bash
./globcat.sh [-e globs] [-d directories]
```

## Example Output

```
File: /path/to/docs/example.md
-------------------------------------
# Example Markdown

This is a sample markdown file.

=====================================

File: /path/to/src/example.txt
-------------------------------------
This is a sample text file.

=====================================
```

### Options

- `-e globs`:
  - A comma-separated list of file patterns (globs) to search for.
  - Example: `*.md,*.txt`

- `-d directories`:
  - A comma-separated list of directories to search within.
  - Directories can be absolute paths or relative to the current directory.
  - If no directories are specified, the current directory is used by default.

### Example

```bash
./globcat.sh -e '*.md,*.txt' -d './docs,./src'
```

This command will search for files with extensions `.md` and `.txt` within the `docs` and `src` directories and display their contents.

## How It Works

1. **Parsing Options**: The script parses the provided globs and directories.
2. **Default Directory**: If no directories are provided, it defaults to the current directory.
3. **Absolute Paths**: Converts relative directory paths to absolute paths.
4. **File Search and Display**: Recursively searches for files matching the specified globs in each directory, sorts the results, and displays their contents.

## Requirements

- Bash (version 4.0 or later)
- Unix-like operating system (Linux, macOS, etc.)

## Installation

1. Download `globcat.sh`.
2. Make the script executable:

```bash
chmod +x globcat.sh
```

3. Run the script using the usage instructions above.

## Testing with Docker

### Why Use Docker for Testing?

Using Docker for testing ensures that the absolute file paths are handled consistently across different environments. This approach is particularly useful to ensure that the script behaves as expected when dealing with absolute paths.

#### Docker Test Instructions

1. Build the Docker Image

Navigate to the root directory of your project (where `globcat.sh` is located) and build the Docker image using the following command:

```bash
$ docker build -t globcat-test -f test.docker/Dockerfile .
```

2. Run the Docker Container

Run the Docker container to execute the tests:

```bash
$ docker run --rm globcat-test
```

## Run directly from GitHub

Change the parameters as needed.

Running scripts directly from GitHub is generally not an advisable thing to do, by the way, but here are the instructions on how to do it anyway.

```bash
curl -sL https://raw.githubusercontent.com/jzombie/globcat.sh/main/globcat.sh | bash -s -- -e '*.md,*.txt' -d '.'
```

## Contributing

If you have suggestions for improvements or find any issues, please feel free to submit a pull request or open an issue on the GitHub repository.

## License

[MIT License](LICENSE). Copyright (c) Jeremy Harris.
