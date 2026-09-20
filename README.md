# aalam's blog

A Jekyll site for GitHub Pages, using the Minimal Mistakes theme. It shows each sketch or piece of art as its own post, laid out as a responsive grid on the home page.

Live address (after setup): https://aalamenso.github.io

These instructions cover both **Windows** and **Mac**. Where they differ, each has its own section. Commands for Windows are typed into **PowerShell** (search for "PowerShell" in the Start menu).

## What is in this folder

| Path | What it does |
| --- | --- |
| `_config.yml` | Site title, description, theme, skin and settings. Restart the preview after editing. |
| `_posts/` | One file per piece. File names look like `2026-09-20-title.md`. |
| `assets/images/` | The images used by your posts. |
| `index.html` | The home page (a grid of your latest pieces). |
| `about.md` | The About page. Edit the text. |
| `tags.md` | The "browse by tag" page. Leave as is. |
| `_data/navigation.yml` | Links in the top bar. |
| `new-post.ps1` | Windows helper that creates a blank post for you. |
| `new-post.sh` | Mac helper that does the same. |
| `Gemfile`, `.ruby-version`, `.gitattributes`, `.gitignore` | Setup files. You should not need to change these. |

## One-time setup

### Windows

1. **Install Git for Windows.** Download it from https://git-scm.com/download/win and accept the default options. (Or, in PowerShell: `winget install Git.Git`.)
2. **Install Ruby.** Go to https://rubyinstaller.org/downloads/ and download the recommended **Ruby+Devkit 3.3.x (x64)** installer. Run it with the default options. At the end, leave "Run 'ridk install'" ticked. A black window then appears and asks which components to install. Press **Enter** to accept the default and wait until it finishes.
3. **Close PowerShell and open a new one**, so that it can find Ruby. Check it works:

   ```
   ruby -v
   ```

   It should print a version starting with `ruby 3.3`.
4. **Install Bundler**, then this site's packages. Go to the site folder first (change the path to wherever the folder is on your computer):

   ```
   gem install bundler
   cd C:\Users\YourName\AalamWebsite
   bundle install
   ```

Optional but pleasant: install Visual Studio Code (https://code.visualstudio.com) for editing posts, and GitHub Desktop (https://desktop.github.com) if you would rather click than type Git commands.

### Mac

1. Install Apple's command line tools: `xcode-select --install`
2. Install Homebrew from https://brew.sh (copy the one line from that page, and run the two "Next steps" lines it prints at the end).
3. Install the tools:

   ```
   brew install git rbenv ruby-build
   echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
   source ~/.zshrc
   rbenv install 3.3.6
   gem install bundler
   ```

4. In the site folder, install the site's packages: `bundle install`

## Preview on your computer

This is the same on Windows and Mac. From the site folder:

```
bundle exec jekyll serve
```

Open http://localhost:4000 in your browser. Edits to posts and pages appear when you refresh. Stop the preview with Ctrl+C. To check the phone layout, narrow the browser window or use your browser's device toolbar (F12, then the phone icon).

Windows notes:

- The first time, Windows Defender Firewall may ask about Ruby. Choose "Private networks" and Allow.
- If edits do not show up after a refresh, stop the preview and start it again with `bundle exec jekyll serve --force_polling`.
- If you see a warning about `_config.yml` changes, that is normal. Restart the preview after editing that file.

## Publish on GitHub Pages (first time)

1. Sign in to GitHub as `aalamEnso` and create a new **public** repository named exactly `aalamEnso.github.io`. Leave "Add a README" unticked.
2. In the site folder (PowerShell on Windows, Terminal on Mac):

   ```
   git init -b main
   git add .
   git commit -m "First version of aalam's blog"
   git remote add origin https://github.com/aalamEnso/aalamEnso.github.io.git
   git push -u origin main
   ```

   On Windows, a browser window opens the first time you push so that you can sign in to GitHub. On Mac, the easiest ways are GitHub Desktop, or `brew install gh` followed by `gh auth login`.

   If Git says it does not know who you are, run these two commands once (with your own name and email) and then repeat the commit:

   ```
   git config --global user.name "Your Name"
   git config --global user.email "you@example.com"
   ```
3. On GitHub, open the repository, then Settings, then Pages. Under "Build and deployment", choose **Deploy from a branch**, branch `main`, folder `/ (root)`, and Save.
4. Wait a minute or two, then visit https://aalamenso.github.io.

## Adding a new piece

1. Prepare the image: about 1600 px on the long side, saved as JPG (or PNG for flat colour work), ideally under 500 KB.
2. Create the post file. On **Windows**:

   ```
   powershell -ExecutionPolicy Bypass -File .\new-post.ps1 "Title of the piece"
   ```

   On **Mac**:

   ```
   ./new-post.sh "Title of the piece"
   ```

   Either one creates a file in `_posts/` and tells you what to name the image.
3. Save the image in `assets/images/` with that name.
4. Open the new post file and fill in the tags, the one-line excerpt, the image description (alt text) and your few words about the piece.
5. Preview it, then publish:

   ```
   git add .
   git commit -m "Add: title of the piece"
   git push
   ```

Notes:

- The `teaser` image in the post's header is the thumbnail shown in the home page grid. Using the same image is fine.
- A post dated in the future stays hidden until that date.
- Keep original high-resolution files elsewhere. GitHub warns at 50 MB per file and rejects 100 MB, and the site loads faster with web-sized images.
- If you create posts by hand in Notepad, save as UTF-8 and make sure the file name really ends in `.md` (Windows may hide extensions and produce `title.md.txt`).

## Using more than one computer

The GitHub repository is the master copy. If you start on one computer and move to another:

- On the new computer, get the site with `git clone https://github.com/aalamEnso/aalamEnso.github.io.git`, then run `bundle install` inside it.
- Before you start working, run `git pull` to fetch the latest changes. After you finish, run `git add .`, `git commit -m "..."` and `git push`.
- If the site folder currently exists only on a Mac and has not been pushed yet, you can copy the whole folder to the Windows computer (a zip file or a USB stick is fine) and do the "Publish on GitHub Pages (first time)" steps from Windows. Skip the `.jekyll-cache`, `_site` and `vendor` folders if they exist.

## Removing the sample posts

Delete the three `sample-sketch-*.md` files in `_posts/` and the three `sample-*.svg` files in `assets/images/`.

## Changing the look

In `_config.yml`, change `minimal_mistakes_skin`. Light options: `default`, `air`, `dirt`, `mint`, `sunrise`. Dark options: `dark`, `contrast`, `neon`, `plum`, `aqua`. Theme documentation: https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/

## Troubleshooting

- **`bundle install` fails while building a package on Windows:** the Ruby development tools did not install. Run `ridk install` in PowerShell, press Enter to accept the defaults, then try `bundle install` again.
- **`bundle` or `ruby` is not recognised:** close PowerShell and open a new window. If it still fails, reinstall Ruby and tick the option to add Ruby to PATH.
- **The site builds locally but looks unstyled on GitHub:** check that the repository is public and named exactly `aalamEnso.github.io`, and look at the Actions tab on GitHub for the build error.
- **A post does not appear:** check that its date is not in the future, that the file name starts with `YYYY-MM-DD-`, and that the file starts with a line containing only `---`.
