+++
date = '2025-04-04T21:56:30+09:00'
draft = false
title = 'How to Make Devblog With Hugo'

+++

今まで私が作ったブログのプロセスまとめ！

## ✅ 事前準備
- GitHubアカウント
- Hugoインストール

## ✅ 1段階: GitHubでRepository生成
- 名前： `zomggang-devblog`.
- Public repositoryで作成


## ✅ 2段階: Hugoインストール
なぜhugoなのか？ まず、Hugoは静的ページを作るツールです。開発者に挑戦した時はjekyllが主流だったようですが、最近はHugoがもっと速いとか、localで修正してすぐ反映される点で、Hugoをよく使ってるようです。

Jekyll(Ruby言語ベース)とHugo(Go言語)

| 項目 | Jekyll | Hugo |
|------|--------|------|
| 言語 | Ruby 基盤 | Go 基盤 |
| 項目         | Jekyll                                         | Hugo                                       |
|--------------|------------------------------------------------|--------------------------------------------|
| ビルド速度    | やや遅め（特に大規模プロジェクトの場合）        | 非常に高速 ⚡                                |
| インストールの難易度 | Ruby環境が必要 → Windowsでは少し面倒       | Goが組み込まれており、インストールが簡単     |
| 使いやすさ    | GitHubとの連携が簡単（公式サポートあり）         | GitHubも使用可能だが、設定が必要            |
| テーマの数    | 多い（古いものも含まれる）                       | 多く、モダンでトレンド感のあるテーマが豊富  |
| カスタマイズ性| やや複雑                                        | 比較的簡単                                   |
| ドキュメントの充実度 | 充実している                             | 充実しており、最新の情報も多い              |

> 🎯 **結論**：  
> 自分は **Windows環境** で開発しており、**高速なビルド** と **簡単なセットアップ** を重視しているため、**Hugo** を選択しました。



#### Hugo의 환경별 install 커맨드
https://gohugo.io/installation/
일단 저는 Windows로 나는 최근의 단말을 포맷해서 Package Manager 의 npm조차 없어서 choco는 사용하지 못했고 기본 winget을 이용해 설치 했다.
```powershell
winget install Hugo.Hugo.Extended
```

보통은 choco로 설치하는 듯하다.
```bash
choco install hugo-extended
```
---

## ✅ 3단계: 로컬에서 새 hugo사이트 생성 

***git submodule***을 사용할 수 있다는 건 정말 좋았다!  
다른 블로그들을 참고해서 설치해봤지만,, 잘 안 됐는데 공식문서를 따라하니 쉽게 됐다   
공식 문서 : https://gohugo.io/getting-started/quick-start/

나의 경우 

### 일단 repository명과 같은 사이트를 만들고
```bash
hugo new site zomggang-devblog
```

### 테마선택
https://themes.gohugo.io/
![poster](https://jo-gangeun.github.io/zomggang-devblog/image/20250406/hugo_theme.png)

원래는 하고 싶었던 게 있었는데 무거워서 그런가,,, 도통 deploy가 안되길래 추천은
공식이 추천하는 papermode나 좀 가벼워보이는 테마부터 넣어보는 것을 추천한다. 
조금 헤맸지만 일단 re-terminal은 문제없이 반영이 됐다!

[re-terminal theme link](https://themes.gohugo.io/themes/hugo-theme-re-terminal/#demo-and-some-blog-posts-about-re-terminal---httpsre-terminalnebrowsercom)

이 테마는 적어도 Hugo **Extended** v0.128.x.가 필요하다. 

#### install theme locally
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

git clone이나 서브모듈을 사용해서 설치하면 되는데 어째 clone으로는 제대로 되지 않아서 submodule로 하니까 됐다.   
앞으로 버전이 오를 수도 있으니 서브모듈을 쓰는 것이 좋은듯.

### 4단계 : 일단 설치한 테마가 열리는지 확인해본다. How to run your site
```bash
hugo server
```


## ✅ 4단계: 새로운 페이지(content) 만들기
새로운 페이지를 만들어보자
```bash
hugo new content content/posts/my-first-post.md
```

그러면 아래와 같은 md파일이 만들어진다. 
```md

+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++

```
다른 예제들을 보면 author라던가 여러 value를 지정할 수 있는데 여기는
```bash
 archetypes  
 ```

폴더 안에 정의가 되어 있는 속성들만 현재 사용할 수 있었다.  
자꾸 에러가 나서 보니 내가 받은 테마가 가장 기본적인 것 같다.

### 이후에 개발 서버를 통해 빌드 후 사이트를 확인한다. 
```
hugo server --buildDrafts
hugo server -D
```

페이지가 문제가 없다면 이제 배포다

## ✅ 5단계: Github Actions로 배포하기
모든 건 공홈에서 !! https://gohugo.io/host-and-deploy/host-on-github-pages/

### Github에서의 설정을 수정한다. 
Settings > Pages의 Build and deployment와 
Source를 Github Actions로 수정하면 된다. 수정 후 아래의 이미지와 같다.

![github action settings](https://jo-gangeun.github.io/zomggang-devblog/image/20250406/github_action.png)


### yaml파일로 workflow만들기
```bash
mkdir -p .github/workflows
touch .github/workflows/hugo.yaml
```
왠만해서는 공홈의 소스를 복붙하는 것을 추천하지만 일단 아래와 같다

```config
# Sample workflow for building and deploying a Hugo site to GitHub Pages
name: Deploy Hugo site to Pages

on:
  # Runs on pushes targeting the default branch
  push:
    branches:
      - main

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

# Allow only one concurrent deployment, skipping runs queued between the run in-progress and latest queued.
# However, do NOT cancel in-progress runs as we want to allow these production deployments to complete.
concurrency:
  group: "pages"
  cancel-in-progress: false

# Default to bash
defaults:
  run:
    shell: bash

jobs:
  # Build job
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

  # Deployment job
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

이 파일을 만든 후 commit 과 push를 하면 github repository에 반영이 된다. 
그럼과 동시에 Githubs Action에서 workflow가 실행이되는데

![github actions에서 성공한 경우](https://jo-gangeun.github.io/zomggang-devblog/image/20250406/github_action_success.png)

사실 이러면 404에러가 나오고 그랬는데 baseUrl을 바꿀 필요가 있었다. 

hugo.toml의 BaseUrl을 아래와 같이 바꾸고, 빌드하면서 sitemap,index등이 루트 디렉토리가 잘 변경되었는지 확인해본다

```bash
baseURL = 'https://jo-gangeun.github.io/zomggang-devblog/'
```

이대로 다시 빌드해서 배포하면 문제없이 github pages가 배포된다! 끝

...
