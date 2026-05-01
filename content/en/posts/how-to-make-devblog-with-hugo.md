+++
date = '2025-04-04T21:56:30+09:00'
draft = false
title = 'How to Make Devblog With Hugo'
+++

※ This page was translated from Korean to English using AI.

A summary of how I built this blog!

## ✅ Prerequisites
- GitHub account
- Hugo installed

## ✅ Step 1: Create a Repository on GitHub
- Name: `zomggang-devblog`
- Create as a Public repository


## ✅ Step 2: Install Hugo
Why Hugo? Hugo is a static site generator. When I first started as a developer, Jekyll seemed to be the standard, but lately Hugo seems more popular due to its speed and instant local preview on changes.

Jekyll (Ruby-based) vs Hugo (Go-based)
## 🔍 Hugo vs Jekyll Comparison

| Item | Jekyll | Hugo |
|------|--------|------|
| Language | Ruby-based | Go-based |
| Build speed | Slow (especially large projects) | Very fast ⚡ |
| Installation | Requires Ruby environment → a bit tricky on Windows | Simple install with Go included |
| Usability | Easy GitHub integration (official support) | GitHub supported, requires some config |
| Theme count | Many (some outdated) | Many, with modern trendy themes |
| Customization | Somewhat complex | Relatively easy |
| Documentation | Rich | Rich and up-to-date |

> 🎯 **Conclusion**:  
> Since I'm on Windows and wanted fast speed and easy setup, I chose **Hugo**.



#### Hugo install commands by environment
https://gohugo.io/installation/
Since I'm on Windows and had recently reformatted my machine (no npm or choco available), I used the built-in winget.
```powershell
winget install Hugo.Hugo.Extended
```

The common approach is via choco:
```bash
choco install hugo-extended
```
---

## ✅ Step 3: Create a New Hugo Site Locally

Being able to use ***git submodule*** was great!  
I tried following other blogs but couldn't get it working — the official docs made it straightforward.  
Official docs: https://gohugo.io/getting-started/quick-start/

In my case:

### First, create a site with the same name as your repository
```bash
hugo new site zomggang-devblog
```
### Choose a theme
https://themes.gohugo.io/
![poster](https://zomggang.github.io/zomggang-devblog/image/20250406/hugo_theme.png)

I originally wanted a different theme, but it was too heavy and kept failing to deploy, so I'd recommend starting with papermode (officially recommended) or a lighter theme.  
After some trial and error, re-terminal worked without issues!

[re-terminal theme link](https://themes.gohugo.io/themes/hugo-theme-re-terminal/#demo-and-some-blog-posts-about-re-terminal---httpsre-terminalnebrowsercom)

This theme requires at least Hugo **Extended** v0.128.x.

#### Install theme locally
```bash
git clone https://github.com/mirus-ua/hugo-theme-re-terminal.git themes/re-terminal
```

#### Install theme as a submodule
```bash
hugo new site {blogName}
cd {blogName}
git init
git submodule add -f https://github.com/mirus-ua/hugo-theme-re-terminal.git themes/re-terminal
echo "theme = 're-terminal'" >> hugo.toml
```

Clone didn't work properly for me, but the submodule approach did.  
Since the theme may be updated in the future, using a submodule is the better choice.

### Step 4: Check that the installed theme opens. How to run your site
```bash
hugo server
```


## ✅ Step 4: Create New Pages (content)
Let's create a new page.
```bash
hugo new content content/posts/my-first-post.md
```

This generates a markdown file like this:
```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++

```
Other examples show you can set values like `author`, but in this setup only properties defined in the
```path 
archetypes  
```

folder are available.  
I kept getting errors and eventually realized the theme I picked uses only the basics.

### Then run the dev server to build and preview:
```bash
hugo server --buildDrafts
hugo server -D
```

If the page looks good, it's time to deploy.

## ✅ Step 5: Deploy with Github Actions
Everything is in the official docs! https://gohugo.io/host-and-deploy/host-on-github-pages/

### Update GitHub settings
Go to Settings > Pages, then change Build and deployment Source to **GitHub Actions**.

![github action settings](https://zomggang.github.io/zomggang-devblog/image/20250406/github_action.png)


### Create a workflow yaml file
```bash
mkdir -p .github/workflows
touch .github/workflows/hugo.yaml
```
I'd recommend copy-pasting from the official docs, but here it is:

```config
# Sample workflow for building and deploying a Hugo site to GitHub Pages
name: Deploy Hugo site to Pages

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.145.0
      HUGO_ENVIRONMENT: production
      TZ: America/Los_Angeles
    steps:
      - name: Install Hugo CLI
        run: |
          wget -O ${{ runner.temp }}/hugo.deb https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb \
          && sudo dpkg -i ${{ runner.temp }}/hugo.deb
      - name: Install Dart Sass
        run: sudo snap install dart-sass
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0
      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5
      - name: Install Node.js dependencies
        run: "[[ -f package-lock.json || -f npm-shrinkwrap.json ]] && npm ci || true"
      - name: Cache Restore
        id: cache-restore
        uses: actions/cache/restore@v4
        with:
          path: |
            ${{ runner.temp }}/hugo_cache
          key: hugo-${{ github.run_id }}
          restore-keys:
            hugo-
      - name: Build with Hugo
        run: |
          hugo \
            --gc \
            --minify \
            --baseURL "${{ steps.pages.outputs.base_url }}/" \
            --cacheDir "${{ runner.temp }}/hugo_cache"
      - name: Cache Save
        id: cache-save
        uses: actions/cache/save@v4
        with:
          path: |
            ${{ runner.temp }}/hugo_cache
          key: ${{ steps.cache-restore.outputs.cache-primary-key }}
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

After creating this file, commit and push — it will be reflected in the GitHub repository and trigger the GitHub Actions workflow.

![github actions success](https://zomggang.github.io/zomggang-devblog/image/20250406/github_action_success.png)

I actually got 404 errors at first and had to update the baseURL.

Update `hugo.toml` like this and verify that the sitemap, index, etc. are pointing to the right root directory after building:

```bash
baseURL = 'https://zomggang.github.io/zomggang-devblog/'
```

Rebuild and deploy with this change, and GitHub Pages will work without issues. Done!

...
