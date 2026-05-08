FROM ruby:3.2.2

# Node.jsとYarnをインストールするための設定
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# 必要なパッケージのインストール（nodejsとyarnを追加）
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    yarn

# 作業ディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# Gemfileのインストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Yarnのパッケージをインストール（これが必要！）
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock
RUN yarn install

# プロジェクトファイルのコピー
COPY . /myapp