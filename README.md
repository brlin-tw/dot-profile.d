# .profile.d

A decentralized user profile configuration management solution  
<https://github.com/brlin-tw/.profile.d>  
[![GitHub Actions workflow status badge](https://github.com/brlin-tw/.profile.d/actions/workflows/check-potential-problems.yml/badge.svg "GitHub Actions workflow status")](https://github.com/brlin-tw/.profile.d/actions/workflows/check-potential-problems.yml) [![pre-commit enabled badge](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white "This project uses pre-commit to check potential problems")](https://pre-commit.com/) [![REUSE Specification compliance badge](https://api.reuse.software/badge/github.com/brlin-tw/.profile.d "This project complies to the REUSE specification to decrease software licensing costs")](https://api.reuse.software/info/github.com/brlin-tw/.profile.d)

\[English\] \[[台灣中文](README.zh-TW.md)\]

The .profile file in the root of the user's home directory is a configuration file that will be loaded and executed once while the user is logging in on Unix-like OSes.  It is normally used to configure the user's environment variables(including the `PATH` environment variable which is used to search the executable file of the command).

This project provides a solution to host the user's script fragments that is originally placed into the ~/.profile file in order to minimize the pollution of the OS distribution-provided version and allows reusing of the configuration fragments.

You need to create the .profile.d directory in you home directory(if it didn't exist), then place your configuration fragments in the directory under the .sh.source filename extension.  The logic in the .profile file will automatically source and execute these files.

## Features

* Supplies utility functions to install specified directory into the command search PATHs.
* If the specified directory doesn't exist or the command search PATHs already contains that directory then it won't be added, avoid unnecessary time wasted by the additional search path.

## Setup

1. Download the release package from [the project's Releases page](https://github.com/brlin-tw/.profile.d/releases).
1. Extract the release package.
1. Launch a text terminal emulator application.
1. In the text terminal emulator application, change the working directory to the extracted release package directory by running the following command:

    ```bash
    cd /path/to/extracted/release/package/dir
    ```

1. Run the installation program by running the following command:

    ```bash
    ./install.sh
    ```

    You need to logout and re-login your user session to make the configuration change in effect.

## Remark

The .profile file is a generic shell script, you should use [the POSIX.1-2008 specification-compliant shell script syntax](http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html) to write the configuration scriptlets instead of specific shell script syntaxes like Bash.

## Licensing

Unless otherwise noted(individual file's header/[REUSE DEP5](.reuse/dep5)), this product is licensed under [version 3 of The GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.html.en), or any of its recent versions you would prefer.

This work complies to [the REUSE Specification](https://reuse.software/spec/), refer the [REUSE - Make licensing easy for everyone](https://reuse.software/) website for info regarding the licensing of this product.
