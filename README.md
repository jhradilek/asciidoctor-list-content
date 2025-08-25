# list-content

`list-content` is a simple script that parses an AsciiDoc file and prints all files included in it to standard output.

## Installation

Install the `asciidoctor-list-content` Ruby gem:

```console
gem install asciidoctor-list-content
```

## Usage

*   List all AsciiDoc files included in the specified file:

    ```console
    list-content main.adoc
    ```

    By default, the files are listed with the path relative to the current working directory. To make the paths relative to a different directory, specify the `--relative-to` or `-r` command-line option:

    ```console
    list-content --relative-to ../../../ main.adoc
    ```
*   Include the name of the specified file on each output line:

    ```console
    list-content --with-filename main.adoc
    ```

    This is especially useful if you are running the script of multiple files at the same time:

    ```console
    list-content --with-filename */main.adoc
    ```

    By default, the script uses a colon followed by a single space as the separator. If you plan to save the output as a CSV file, specify the `--delimiter` or `-d` command-line option:

    ```console
    list-content --with-filename --delimiter ',' */main.adoc
    ```
*   For a complete list of available options, run the script with the `--help` or `-h` command-line option:

    ```console
    list-content --help
    ```

## Copyright

Copyright © 2022, 2025 Jaromir Hradilek

This program is free software, released under the terms of the MIT license. It is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
