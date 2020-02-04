FactoryBot.define do
# rspecのテスト時の自動入力
  factory :user do
    name                  {"abe"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
  end

end