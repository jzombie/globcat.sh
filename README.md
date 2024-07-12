# globcat.sh

`globcat.sh` is a bash script that searches for files matching specified patterns (globs) within given directories and displays their contents. It's a useful 
utility for quickly finding and reviewing files in a structured manner.

## Usage

```bash
./globcat.sh [-e globs] [-d directories]
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

## Contributing

If you have suggestions for improvements or find any issues, please feel free to submit a pull request or open an issue on the GitHub repository.
