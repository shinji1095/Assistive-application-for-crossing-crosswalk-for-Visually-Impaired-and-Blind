# Assistive-application-for-crossing-crosswalk-for-Visually-Impaired-and-Blind
これは視覚障がい者（Visually Impaired and Blind:VIB）を対象とした横断歩道の横断支援デモアプリケーションです。検出対象は以下の3つです。
1. 歩行者用信号の色：Pedestrian Signal Color(PSC)
2. 横断歩道への接近具合：Proximity to Crosswalk(PTC)
3. 白線の傾き：Inclination of White Line(IWL)

PTCによって横断歩道への近さを確認し、近ければPSCによって歩行者用信号の色を確認します。歩行者用信号の色が赤→緑に変化するとIWLを用いてVIBの進行方向角度を推定します。これにより横断歩道をまっすぐ横断する補助を行います。

# Requirements
-   flutter_riverpod: ^1.0.3
-   freezed_annotation: ^2.2.0

# How to
pass

# Commit Message
- fix：バグ修正
- add：新規（ファイル）機能追加
- update：機能修正（バグではない）
- remove：削除（ファイル）

# Directory Configuration
| フォルダ名 | 内容 |
| ---------- | ----------- |
| model | データ型の格納 |
| parts | 繰り返し使ったり分担して開発を進めるために分割したコンポーネントを格納 |
| pages | 表示される画面の原型（ページ）を格納 |
| view | 実際に表示される画面を格納 |
| view_model | ビジネスロジックを格納 |
