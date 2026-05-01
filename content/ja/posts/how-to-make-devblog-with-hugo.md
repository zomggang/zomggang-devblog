+++
date = '2025-04-04T21:56:30+09:00'
draft = false
title = 'How to Make Devblog With Hugo'
+++

※ このページは韓国語からAIで日本語に翻訳されました。

今まで私が作ったブログのプロセスまとめ！

## ✅ 事前準備
- GitHubアカウント
- Hugoインストール

## ✅ ステップ1: GitHubでRepositoryを作成
- 名前: `zomggang-devblog`
- Public repositoryで作成


## ✅ ステップ2: Hugoをインストール
なぜHugoなのか？Hugoは静的ページを作るツールです。開発者として始めた頃はJekyllが主流だったようですが、最近はHugoの方が速い・ローカルで修正してすぐ反映される点から多く使われているようです。

Jekyll（Ruby言語ベース）とHugo（Go言語）
## 🔍 Hugo vs Jekyll 比較

| 項目 | Jekyll | Hugo |
|------|--------|------|
| 言語 | Ruby ベース | Go ベース |
| ビルド速度 | やや遅め（特に大規模プロジェクト） | 非常に高速 ⚡ |
| インストール難易度 | Ruby環境が必要 → Windowsでは少し面倒 | Goが組み込まれており、インストールが簡単 |
| 使いやすさ | GitHubとの連携が簡単（公式サポートあり） | GitHubも使用可能、設定が必要 |
| テーマ数 | 多い（古いものも含む） | 多く、モダンなテーマが豊富 |
| カスタマイズ性 | やや複雑 | 比較的簡単 |
| ドキュメントの充実度 | 充実している | 充実しており、最新情報も多い |

> 🎯 **結論**：  
> Windows環境で、高速なビルドと簡単なセットアップを求めていたため、**Hugo** を選択しました。



#### 環境別 Hugoインストールコマンド
https://gohugo.io/installation/
私はWindowsで、端末をフォーマットしたばかりでnpmもchocoも使えなかったため、標準のwingetを使ってインストールしました。
```powershell
winget install Hugo.Hugo.Extended
```

一般的にはchocoでのインストールが多いようです。
```bash
choco install hugo-extended
```
---

## ✅ ステップ3: ローカルで新しいHugoサイトを作成

***git submodule*** が使えるのはとても便利でした！  
他のブログを参考にしてみたのですが上手くいかず、公式ドキュメントに従ったら簡単にできました。  
公式ドキュメント: https://gohugo.io/getting-started/quick-start/

私の場合：

### まずRepositoryと同じ名前のサイトを作成
```bash
hugo new site zomggang-devblog
```

### テーマ選択
https://themes.gohugo.io/
![poster](https://zomggang.github.io/zomggang-devblog/image/20250406/hugo_theme.png)

元々使いたいテーマがあったのですが重すぎるのか、デプロイがどうしてもうまくいかず、  
公式推奨のpapermodeや軽めのテーマから試してみることをおすすめします。  
少し迷いましたが、re-terminalは問題なく反映されました！

[re-terminal theme link](https://themes.gohugo.io/themes/hugo-theme-re-terminal/#demo-and-some-blog-posts-about-re-terminal---httpsre-terminalnebrowsercom)

このテーマには少なくともHugo **Extended** v0.128.x が必要です。

#### テーマをローカルにインストール
```bash
git clone https://github.com/mirus-ua/hugo-theme-re-terminal.git themes/re-terminal
```

#### テーマをsubmoduleとしてインストール
```bash
hugo new site {blogName}
cd {blogName}
git init
git submodule add -f https://github.com/mirus-ua/hugo-theme-re-terminal.git themes/re-terminal
echo "theme = 're-terminal'" >> hugo.toml
```

git cloneとsubmoduleどちらでもインストールできますが、cloneでは上手くいかずsubmoduleで解決しました。  
今後バージョンが上がる可能性もあるので、submoduleを使う方がよいと思います。

### ステップ4: インストールしたテーマが開くか確認する。How to run your site
```bash
hugo server
```


## ✅ ステップ4: 新しいページ（content）を作成する
新しいページを作ってみましょう。
```bash
hugo new content content/posts/my-first-post.md
```

以下のようなmdファイルが生成されます。
```md
+++
title = 'My First Post'
date = 2024-01-14T07:07:07+01:00
draft = true
+++

```
他の例ではauthorなど様々な値を指定できますが、ここでは
```path
archetypes
```

フォルダ内に定義されたプロパティのみ使用できました。  
エラーが続いたので調べてみると、入れたテーマが最もシンプルなものだったようです。

### その後、開発サーバーでビルドしてサイトを確認する
```bash
hugo server --buildDrafts
hugo server -D
```

ページに問題がなければ、いよいよデプロイです。

## ✅ ステップ5: Github Actionsでデプロイする
すべては公式サイトで！ https://gohugo.io/host-and-deploy/host-on-github-pages/

### GitHubの設定を変更する
Settings > Pages の Build and deployment の  
Sourceを **GitHub Actions** に変更します。変更後は以下の画像のようになります。

![github action settings](https://zomggang.github.io/zomggang-devblog/image/20250406/github_action.png)


### yamlファイルでworkflowを作成する
```bash
mkdir -p .github/workflows
touch .github/workflows/hugo.yaml
```
公式サイトのソースをコピペすることをおすすめしますが、内容は以下の通りです。

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

このファイルを作成してcommitとpushをすると、GitHubリポジトリに反映されます。  
同時にGitHub ActionsでWorkflowが実行されます。

![github actionsで成功した場合](https://zomggang.github.io/zomggang-devblog/image/20250406/github_action_success.png)

最初は404エラーが出ていて、baseURLを変更する必要がありました。

hugo.tomlのbaseURLを以下のように変更し、ビルド後にsitemap・indexなどのルートディレクトリが正しく変更されているか確認します。

```bash
baseURL = 'https://zomggang.github.io/zomggang-devblog/'
```

この状態で再ビルドしてデプロイすれば、GitHub Pagesが問題なく公開されます！終わり

...
