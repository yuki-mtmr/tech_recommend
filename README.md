<img src="https://cdn-images-1.medium.com/max/959/1*Qc0XxYm-qAZL-7tjjlNfrg.png" width="100"><img src="http://i2.wp.com/samancha.com/wp-content/uploads/2017/12/rails.png?fit=600%2C600" width="100"><img src="https://upload.wikimedia.org/wikipedia/commons/b/b2/Bootstrap_logo.svg" width="100"><img src="https://www.mysql.com/common/logos/logo-mysql-170x115.png" width="140"><img src="https://a0.awsstatic.com/libra-css/images/logos/aws_logo_smile_1200x630.png" width="100">

# 製作経緯
『必要な情報を共有して開発効率をあげる』
スクールで学習する中で、仲の良い生徒間で参考になったサイトを個人的に共有していました。そこで参考になったサイトを誰でも共有できるプラットフォームがあると便利だと考え本サイトを作成することにしました。
## 詳細
テックエキスパートのカリキュラムを学習する上で受講生がそれぞれ調べた技術的な内容を共有しあうことで、学習効率を上げるスクール受講生を対象にしたチートシートとなるサイトです。参考になったサイトのURLをフォームに入力する事で、サイトのmeta情報からサムネ、記事タイトル、記事詳細をスクレイピングによって簡易的に参照することができます。

# 使用方法
1.サイトURLにアクセスし、ユーザー登録をします。(ユーザー以外は記事を参照することが出来ません)</br>
2.ログインしたらサイト上部ナビゲーションバーにある「投稿する」のリンクから投稿ページに移ります</br>
3.参考になった記事のURLをフォームに入力し、当てはまるカテゴリーがある場合はチェックボックスにチェックを入れ、「投稿する」ボタンを押します。

# 工夫した箇所
## 処理速度の改善
開発当初はデータベースにURLのみを保存し、表示される度にスクレイピング処理を行なっていたので記事数が増えると表示までにかなり時間がかかってしまっていました。そこで、postモデルにスクレイピングの処理を書き、before saveメソッドを使って必要なデータを一括で保存することで表示速度の問題を改善しました。

## UI,UXを意識したデザイン
無駄な配色や項目を省き、見やすいシンプルなデザインを心がけました。サムネの色が映えるように他はほぼモノトーンの配色になっています。要素の配置はBootstrapのグリッドシステムを採用しており、画面サイズに合わせた配置になるようになっています。

### URL
http://3.114.118.86/

### sample_login_account
- mail: sample@sample
- pass: 1234567890

# Environment
- Ruby 2.5.1
- Rails 5.2.3
- Bootstrap
- SCSS
- JavaScript
- MySQL
- jQuery
- AWS EC2, S3
- capistrano (Automatic deployment)

# Function
- Log_in
- Log_out
- Sign_up
- New post
- Destory post
- profile
- Edit profile
- Likes
- Scraping
- Category
- Automatic deployment(capistrano)
- Search
- SNS authentication

## gem
- gem 'haml-rails'
- gem 'pry-rails'
- gem 'carrierwave'
- gem 'devise'
- gem 'bootstrap', ~> 4.3.1'
- gem 'omniauth'
- gem 'nokogiri'
- gem 'font-awesome-sassc'
- gem 'jquery-rails'
- gem 'pry-rails'
- gem 'capistrano'
- gem 'capistrano-rbenv'
- gem 'capistrano-bundler'
- gem 'capistrano-rails'
- gem 'capistrano3-unicorn'
- gem 'devise'
- gem 'carrierwave'
- gem 'fog-aws'
- gem 'unicorn', '5.4.1'

# tech_recommend DB設計
## users テーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, index|
|email|string||null: false|
|password|string|null: false|
|image|string|
|uid|string|
|provider|string|
### Asociation
- has_many :posts, dependent: :destroy
- has_one :profiles, dependent: :destroy
- has_many :likes, dependent: :destroy
- has_many :liked_posts, through: :likes, source: :post

## posts テーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|img|string|
|title|string|
|description|string|
|user_id|refrences|null: false, foregin_key :true|
|created_at|date|
### Asociation
- belongs_to: user
- has_many: post_categories
- has_many :categories, through: :post_categories
- has_many: likes, dependent: :destroy
- has_many: has_many :liked_users, through: :likes, source: :user

## category テーブル
|Column|Type|Options|
|------|----|-------|
|name|string||null: false|
### Asociation
- has_many: diary_categories
- has_many :posts, through: :post_categories

## post_categries テーブル
|Column|Type|Options|
|------|----|-------|
|post_id|refrences|null: false, foregin_key :true|
|categry_id|refrences|null: false, foregin_key :true|
### Asociation
- belong_to :post
- belong_to :category

## profile テーブル
|Column|Type|Options|
|------|----|-------|
|content|string|null: false|
|region|string|null: false|
|website|string|null: false|
|user_id|refrences|null: false, foregin_key :true|
### Asociation
- belongs_to :user

## likes テーブル
|Column|Type|Options|
|------|----|-------|
|user_id|refrences|null: false, foregin_key :true|
|post_id|refrences|null: false, foregin_key :true|
|created_at|date|
### Asociation
- belongs_to :user
- belong_to :post
- validates_uniqueness_of :post_id, scope: :user_id
