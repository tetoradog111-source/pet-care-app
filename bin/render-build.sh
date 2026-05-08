#!/usr/bin/env bash
# エラーが起きたら即終了させる
set -o errexit

bundle install
yarn install
# プリコンパイル（CSSやJSを本番用にまとめる）
bundle exec rails assets:precompile
bundle exec rails assets:clean
# データベースのマイグレーション（テーブル作成）
bundle exec rails db:migrate