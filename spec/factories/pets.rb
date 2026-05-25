FactoryBot.define do
  factory :pet do
    name { 'ポチ' }
    species { '犬' }
    age { 3 }
    gender { :male } # enumの設定に合わせて変更（元のコードの ja.yml より）
    association :group # ペット作成時に自動でグループも作成して紐づける設定
  end
end