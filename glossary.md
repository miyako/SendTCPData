# 用語集 / Glossary

Keep terminology consistent across `src/<target>.md` and `figures/*.<target>.txt`.
Change an entry here first, then search and replace in both places.

Style (ja): です・ます調. Half-width alphanumerics, no space between Japanese and Latin text (e.g. `4D.Vector型`).
Full-width `（）` and `：` in prose. First occurrence of a technical term: 日本語（English）.

## 4D terms (from the official 4D Japanese documentation)

| English | 日本語 | Notes |
|---|---|---|
| entity / entity selection | エンティティ / エンティティセレクション | |
| datastore | データストア | |
| dataclass | データクラス | |
| attribute | 属性 | |
| computed attribute | 計算属性 | |
| collection | コレクション | |
| object | オブジェクト | |
| method | メソッド | |
| project method | プロジェクトメソッド | |
| function | 関数 | |
| class | クラス | |
| parameter | 引数 | |
| form | フォーム | |
| form object | フォームオブジェクト | |
| list box | リストボックス | |
| web area | Webエリア | |
| 4D Web Server | 4D Webサーバー | |
| worker | ワーカー | |
| process | プロセス | |
| query | クエリ | |
| formula | フォーミュラ | |
| component | コンポーネント | |
| property | プロパティ | |
| class constructor | クラスコンストラクター | |
| BLOB / Blob | BLOB | Type name in code stays `Blob` |
| callback | コールバック | First use: コールバック（callback） |
| event handler | イベントハンドラー | |
| folder | フォルダー | |
| server | サーバー | |

## Document-specific terms

| English | 日本語 | Notes |
|---|---|---|
| TCP data acquisition | TCPによるデータ取得 | Title |
| event logging | イベントログ | |
| connection (TCP) | 接続 / TCP接続 | |
| connection lifecycle | 接続のライフサイクル | |
| asynchronous / synchronous | 非同期 / 同期 | First use: 非同期（asynchronous） |
| non-blocking | ブロッキングしない | First use with（non-blocking） |
| event-driven | イベント駆動型 | |
| packet | パケット | |
| fragmented data | 断片化されたデータ | |
| Methods: (class section heading) | 関数： | They are class functions |
| sender / receiver window | 「送信側」/「受信側」ウィンドウ | Window titles of the demo (XLIFF `Sender_WindowTitle`, `Receiver_WindowTitle`) |
| Run Demo (menu item) | デモを実行 | In the File menu (ファイル) |
| connect / choose file / send buttons | 「接続」「ファイルを選択」「送信」 | Demo button labels (`demo/*/Resources/ja.lproj/SenderJA.xlf`) |
| End Receiving | 受信が完了しました | Progress title (`messagesJA.xlf`) |
| progress bar | プログレスバー | |
| Technical Services Engineer | テクニカルサービスエンジニア | |
| Technical Note | テクニカルノート | No space before the number |
| class / method names, TCPConnection alert strings | Kept in English | `TCPConnection`, `onData`, "Connection established" (they match the printed code). Other demo UI labels are localised: quote the Japanese label in 「」, matching the XLIFF |

## Proper nouns in examples

| English | 日本語 | Notes |
|---|---|---|
