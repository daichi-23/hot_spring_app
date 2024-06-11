# Discover Hot Springs

[Heroku](https://dihotsprings-8487653a13cb.herokuapp.com/)でご確認いただけます。<br>
ヘッダーの"ゲストログイン"より、メールアドレスとパスワードを入力せずにログインできます。

## アプリについて
自分のおすすめの温泉情報を、位置情報付きで投稿し共有することができます。<br>
行きたい温泉を見つけたら、行きたい温泉リストに保存しておき見返すことができます。<br>
行ったことのある温泉を行った温泉リストに入れ、コレクションとして楽しむこともできます。

## 技術
* Ruby 3.0.4
* Ruby on Rails 6.1.3.2
* Rspec
* Google Maps API
* AWS S3

### ER図    

![image](https://github.com/daichi-23/hot_spring_app/blob/main/app/assets/images/readme/app-ER.png)

## 機能
* ユーザー登録、ログイン機能
* ゲストログイン機能
* ユーザー情報編集機能
* 温泉投稿機能
* 温泉情報編集機能
* 温泉検索機能
* 温泉一覧の人気順並べ替え機能
* 行きたい温泉保存機能（いいね）
* 行った温泉保存機能（コレクション）

**Topページ**
* Googleマップ上から投稿された温泉を探すことができます。
* マップの他に、投稿の新しい順や人気順、所在地・キーワード検索から温泉を探すこともできます。

![image](https://github.com/daichi-23/hot_spring_app/blob/main/app/assets/images/readme/app-top.png)

**温泉投稿**
* 温泉を位置情報付きで投稿できます。
* 所在地の検索後マップのピンを動かすことができるので、温泉の正確な位置情報を共有できます。

![app-new-gif](https://github.com/daichi-23/hot_spring_app/assets/150008295/208aa4ca-2f9a-4a95-9313-0706fa713985)

**温泉詳細画面**
* 温泉の詳細をマップとともに確認できます。
* 投稿者のアイコンと名前はプロフィール画面へのリンクになっています。

![image](https://github.com/daichi-23/hot_spring_app/blob/main/app/assets/images/readme/app-details.png)

**プロフィール画面**
* 各ユーザーのプロフィールと投稿した温泉を確認できます。
* ユーザーがいいねした投稿が行きたい温泉欄に表示されます。

![image](https://github.com/daichi-23/hot_spring_app/blob/main/app/assets/images/readme/app-profile.png)

**行った温泉**
ユーザーが行った温泉をマップとともに見ることができます。

![image](https://github.com/daichi-23/hot_spring_app/blob/main/app/assets/images/readme/app-collection.png)

## 開発の背景
温泉が好きで、旅行に行くときなどに目的地やルート沿い近くの温泉を探すことがよくあるのですが、<br>
・ 例えば「◯◯県 温泉」などで調べて出てきた温泉を地図で見てみると、実際にはかなり離れた場所であることもある<br>
・ より狭い地名で温泉を検索すればルートに近い温泉を見つけられるが、何度も検索を繰り返すのが面倒<br>
などといった理由から、ちょうどいい温泉を見つけるのが難しいなと感じることが多くありました。<br>
そこで、マップ上でどこに温泉があるのかを見ることができれば上記の問題が解決でき、より気軽に温泉を楽しめるのではないかと考えこちらのアプリを作成いたしました。
