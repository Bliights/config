# Personal Development Configuration

This repository contains my personal development setup, with a strong focus on **Python**, which is my main programming language.

⚠️ **Disclaimer**: This setup is tailored for **Windows + Git Bash + VS Code**.


## Installation Guide
### 1. MSYS2
***
MSYS2 is used to bring Unix tools and a Unix-like environment to Windows. While it also provides compilers for C and C++, the main purpose here is to access Unix commands directly from Git Bash or any terminal. You can install MSYS2 using the official installer available [here](https://www.msys2.org/). After the installation, you need to add the following directory to your **PATH** so that the tools are accessible globally:
```text
C:\msys64\ucrt64\bin
```

It is important to note that this setup uses the UCRT64 environment, which is more modern and generally more reliable than the older mingw64 environment.

### 2. Unix Commands
***
Once MSYS2 is installed, you can install the Unix tools required for this setup. Open the UCRT64 terminal, then run the following commands to install:

- make 
    ```bash
    $ pacman -S mingw-w64-ucrt-x86_64-make
    # Creates a symbolic link so we can use make instead of mingw32-make
    $ ln -s /ucrt64/bin/mingw32-make.exe /ucrt64/bin/make.exe 
    ```

- tree
    ```bash
    $ pacman -S tree
    # This ensures the command is accessible correctly due to path differences in the installation
    $ ln -s /usr/bin/tree.exe /ucrt64/bin/tree.exe 
    ```

### 3. UV
***
To manage Python environments and dependencies efficiently, this setup uses [uv](https://docs.astral.sh/uv/), a fast and modern alternative to traditional tools like pip and venv. You can install it using the following command:
```bash
$ powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

### 4. SSH & GPG Configuration
***
To enhance security and enable features like signing commits and cloning Git repositories, you can set up SSH keys and GPG keys. First of all you will need to [generate an SSH key pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux) if you don't have one already:
```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"
```
You can then add the public key to your Git hosting service to enable SSH authentication.

For GPG, you will need to install [GPG for windows](https://www.gnupg.org/download/) and [generate a GPG key pair](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key) (It is recommended to use a strong passphrase to protect your GPG key): 
```bash
$ gpg --full-generate-key
```
After generating the key, you can list your keys and get the key ID (value following the protocol for example ed25519/Your_KeyID) using the following command:
```bash
$ gpg --list-secret-keys --keyid-format=long
```
Then you need to export the GPG key id in ASCII format with :
```bash
$ gpg --armor --export Your_KeyID
```
Finally copy your GPG key (with -----BEGIN PGP PUBLIC KEY BLOCK----- and -----END PGP PUBLIC KEY BLOCK-----) and add it to your Git hosting service to enable commit signing.


### 5. Terminal Enhancements
***
To improve the terminal experience, several tools are installed. First, [starship](https://starship.rs/guide/) is used to provide a fast and customizable prompt that adapts to the current project and environment:
```bash
$ winget install -e --id Starship.Starship
```

Next, [fzf](https://github.com/junegunn/fzf) is installed to enable fast fuzzy searching, especially useful for navigating command history and files (**ctrl-r** for search history, **ctrl-t** to search file and **alt-c** to go in a folder):
```bash
$ winget install -e --id junegunn.fzf
```

Then to enhance command-line capabilities, [jq](https://winstall.app/apps/jqlang.jq) is installed for JSON manipulation:
```bash
$ winget install -e --id jqlang.jq
```

Finally, [carapace](https://carapace-sh.github.io/carapace-bin/carapace-bin.html) is installed to provide intelligent command completion and descriptions (**double tab** to get the suggestions):
```bash
$ winget install -e --id rsteube.Carapace
```
Next, you need to place the terminal configuration files in the correct locations to ensure everything works properly. The following files should be placed in your user root directory (C:\Users\Your_User): 
- [.gitconfig](./configs/git/.gitconfig) (where you must set your key ID and name)
- [.bashrc](./configs/bash/.bashrc)
- [.bash_profile](./configs/bash/.bash_profile). 

Additionally, the [starship.toml](./configs/starship/starship.toml) file should be placed in the **.config** directory located in your user root.

### 6. Font Installation
***
To ensure proper rendering of icons and symbols in the terminal (especially with Starship), a Nerd Font is required. You can download fonts [here](https://www.nerdfonts.com/font-downloads) but the recommended font for this setup is:
```text
CaskaydiaMono Nerd Font Mono
```

### 7. VS Code Configuration
***
Now to complete the setup, you need to configure VS Code with the appropriate extensions and settings. First, you will need to install all required extensions using the [extensions.txt](./configs/vscode/extensions.txt) file using:
```bash
$ grep -v '^#' ./configs/vscode/extensions.txt | xargs -L 1 code --install-extension
```

Next, you need to update your Visual Studio Code settings. To do this, open the settings JSON file by pressing Ctrl + Shift + P and selecting "Preferences: Open Settings (JSON)", then add the contents of the [settings.json](./configs/vscode/settings.json) file to your VS Code configuration. Additionally, make sure to update the asset paths with the real absolute paths so that everything works correctly. Finally, for reference, here are the original sources of the background images used in my configuration:

- [mountain](https://fr.freepik.com/images-ia-gratuites/magnifique-paysage-montagneux_133374408.htm#fromView=keyword&page=4&position=33&uuid=fec8b9d8-c64c-4808-82e8-42d1d17a3ac9&query=Montagne+magique)
- [japan_festival](https://wallpapercave.com/w/wp13017680)
- [space](https://www.wallpaperflare.com/universe-space-art-sky-outer-space-galaxy-planet-wallpaper-tycvb/download/720x1280)

### 8. Claude code + Ollama
***
This setup is really interesting because it lets you use Claude Code with local Ollama models, without using any Anthropic credits. To do this, you first need to install [Ollama](https://ollama.com/download/windows). I recommend using the desktop version, so the Ollama server can run automatically in the background and you do not need to launch it manually every time.

Now you need to install Claude Code. For this, I will use `winget` again:
```bash
$ winget install Anthropic.ClaudeCode
```

Then, add the [settings.json](./configs/claude/settings.json) file to the **.claude** directory located in your user root. Now you only need to download a model, for example [`ornith:9b`](https://ollama.com/library/ornith) and to make Claude Code detect it more easily, we will create an alias with a name starting with `claude-`:
```bash
$ ollama pull ornith:9b
$ ollama cp ornith:9b claude-ornith:9b
```
The `ollama cp` command does not download the model again. It only creates another local name for the same model. Finally, you need to add the new model name to the `availableModels` section in your Claude Code settings to add it to the model list.