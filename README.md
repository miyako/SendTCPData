# TCPによるデータ取得とイベントログ

TCP Data Acquisition and Event Logging (4D Technical Note 25-05): Japanese edition.

4D v20 R8で導入されたTCPConnectionクラスとTCPEventクラスを使用して、TCPクライアント接続を非同期で管理し、接続・データ受信・エラーなどのイベントを処理する方法を解説したテクニカルノートの日本語版です。接続のライフサイクルを扱うクラスの例と、断片化されたデータの扱い方を紹介しています。付属のデモでは、送信側ウィンドウからファイルをパケットに分けてTCPで送信し、受信側ウィンドウで受け取る様子を確認できます。

This is the Japanese edition of a technical note on asynchronous TCP client connections with the TCPConnection and TCPEvent classes in 4D v20 R8, with a companion demo that sends a file as TCP packets from a sender window to a receiver window.

## Download

| | |
|---|---|
| PDF (Japanese) | [25-05_SendTCPData_ja.pdf](https://github.com/miyako/SendTCPData/releases/latest/download/25-05_SendTCPData_ja.pdf) |
| 4D demo | [SendTCPData.zip](https://github.com/miyako/SendTCPData/releases/latest/download/SendTCPData.zip) |
| Original (English) | `document/25-05_SendTCPData.pdf` |

## Demo

- 4D version: 20 R8 (build 100353) or later, as stated in the note.
- Open `demo/SendTCPData/Project/SendTCPData.4DProject`.
- Languages: English only. The demo UI is not localised.
- On startup the receiver (a TCP server using 4D Internet Commands) starts in a worker and the Sender window opens. The menu item **File > Run Demo** opens it again.

## Differences from the original

- The cover shows the title and author only. The original's "Technical Note 25-05" line is omitted.
- The table of contents is regenerated with the page numbers of the Japanese edition.
- The method list screenshot (figure 1) is reused unchanged: it shows only method names.
- Code, alert strings and demo UI labels are kept in English, as in the demo.

## Editing and rebuilding

The PDF is generated from plain-text sources. Edit them and run `make`.

| File | What |
|---|---|
| `src/ja.md` | Translated body text. **Don't touch code blocks** (`make check` verifies them). |
| `figures/fig-NN.ja.txt` | Text drawn in figure NN. Line N corresponds to line N of `fig-NN.en.txt`: an identical line keeps the original, an empty line erases it. |
| `figures/layout/fig-NN.json` | Per-label overrides for size, weight, alignment and position; `"replace"` uses a ready-made image |
| `glossary.md` | Terminology |

```sh
make            # check → figures → build/25-05_SendTCPData_ja.pdf
make check      # code blocks unchanged, figure references complete
make review     # contact sheets of the figures (build/contact-N.png)
make release-assets
```

Requirements: Python 3, Google Chrome, CJK fonts, and Tesseract (only needed for re-extraction).
See the [localisation template](https://github.com/miyako/4d-technote-localisation-template) for the full workflow.

## Credits

- Original: Anouar Moustarih, Technical Services Engineer, 4D Morocco (4D Technical Note 25-05)
- Produced with [4d-technote-localisation-template](https://github.com/miyako/4d-technote-localisation-template) and GitHub Copilot.
