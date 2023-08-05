# 愛媛県情報サイト・ぐるぐるマップ愛媛　概要
ポートフォリオ用に作成した、県外の人向けのわかりやすい愛媛県観光情報サイトです。<br>
ジャンルごとの観光地を一目でわかるようにした地図で、行きたいところがすぐ見つかるように工夫しています。<br>
トップページ、スポット一覧、イベントリスト、おすすめルートなどの機能機加えて、<br>
フッター部分にてサイトマップ、お問い合わせ、ヘルプページなどを設けています。<br>

こちらのページから確認することができます。

# デザイン・レイアウト
* トップページ
<img width="1412" alt="名称未設定" src="https://github.com/kurota-wow/map_site/assets/77315612/0a9d2f9f-1351-48a5-b144-0b81a3c39f74">
* スポット一覧
<img width="1387" alt="名称未設定２" src="https://github.com/kurota-wow/map_site/assets/77315612/65eef154-ce2f-4a78-911c-d2ca2efc0582">
* イベントリスト
<img width="1351" alt="名称未設定3" src="https://github.com/kurota-wow/map_site/assets/77315612/21b9fa75-6110-4a30-89ac-b9f6802c77fd">
* おすすめルート
<img width="1377" alt="名称未設定4" src="https://github.com/kurota-wow/map_site/assets/77315612/be9c19ee-e03b-4e7f-9991-687199fca748">

# 使用した言語・フレームワーク
- Ruby
- Ruby on rails
- javascript
- jquery
- scss
- html

# 細かい特徴・機能
## トップページ<br>
- svgファイルを用いて地図のイメージマップを作成しリンクを配置、ボタンで切り替え可能に。<br>
- observer機能を用いて、スクロールすると要素が表示される<br>
- ピックアップとして、カルーセルを配置<br>
## スポット一覧<br>
- スポット一覧を画像として配置（S３から取得）<br>
- 条件によって検索できるよう、上部に検索機能<br>
- 詳細ページにGoogleMapAPIを用いて、地図を描画<br>
## イベントリスト<br>
- 季節によって表示を切り替え<br>
## おすすめルート<br>
- ボタンをクリックするとページ内リンクによって、そのルートの表示場所に移動<br>
- 縦に長いページには、上に戻るボタンを右下に配置<br>
## フッター<br>
- どんな内容があるかわかりやすくする為と、SEO対策にサイトマップ<br>
- サイトにお問い合わせするための、お問い合わせページ（自分のgmailに届くように設定）<br>
- 疑問点を解決するための、Q&Aを設けたヘルプページ<br>
