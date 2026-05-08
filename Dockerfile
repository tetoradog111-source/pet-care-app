FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# Gemfileのコピーとインストール
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# プロジェクトファイルのコピー
COPY . /myapp