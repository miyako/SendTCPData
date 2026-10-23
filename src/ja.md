# TCPによるデータ取得とイベントログ

Anouar Moustarih（テクニカルサービスエンジニア、4D Morocco）

## 概要

本テクニカルノートでは、4Dで新たに導入されたTCPConnectionクラスとTCPEventクラスを使用して、TCPによるデータ取得とイベントログを実装する方法を解説します。TCPConnectionクラスは、TCPクライアント接続を管理するための最新の非同期（asynchronous）アプローチを提供し、外部のサーバーやデバイスとのスムーズなデータ交換を可能にします。TCPEventクラスはこれを補完するもので、接続の確立、データの受信、エラーといった接続のライフサイクルイベントを扱い、堅牢なイベント駆動型プログラミングを実現します。本ノートでは、実践的な例と詳しい説明を通じて、これらのクラスを活用してTCP/IPネットワーク経由でデータを取得し、監視やデバッグのために重要なイベントを記録する方法を紹介します。これらの機能を組み込むことで、開発者は4Dアプリケーションの接続性と機能性を高め、リアルタイムのデータ取得と包括的なイベントログを実現できます。

## はじめに

ネットワークアプリケーションの分野において、TCP/IP（Transmission Control Protocol/Internet Protocol）は、インターネットやプライベートネットワーク上で信頼性の高いデータ通信を行うための基盤です。TCP/IPはデータが正確かつ順序どおりに送信されることを保証するため、一貫性がありエラーのないデータ交換を必要とするアプリケーションには欠かせません。データをどのようにパケット化し、アドレスを付与し、送信、ルーティング、受信するかを定めているのがTCP/IPであるため、ネットワークシステムに携わる開発者にとってTCP/IPの理解は不可欠です。

4Dはバージョン20 R8で、TCPConnectionクラスとTCPEventクラスを導入し、ネットワーク機能を強化しました。これらのクラスを使用すると、開発者は4Dアプリケーション内でTCP接続を直接確立・管理でき、TCP/IPで通信する外部のシステム、サービス、デバイスと簡単に連携できます。

TCPConnectionクラスを使用すると、指定したサーバーへのTCPクライアント接続を作成でき、同期モードと非同期モードの両方のデータ交換がサポートされます。また、接続の確立、データの受信、エラーの発生といった重要な接続イベントをアプリケーションに通知するさまざまなコールバック（callback）が用意されており、イベント駆動型のネットワーク通信を実現できます。

これを補完するのがTCPEventクラスで、各接続イベントの詳細な情報をカプセル化します。イベントの種類（例："connection"、"data"、"error"）、リモートシステムのIPアドレスとポート、受信したデータなどの情報が含まれます。これらの情報を利用することで、アプリケーションはさまざまなネットワークの状況に的確に対応でき、多様な外部データソースと連携する場合でも、堅牢で信頼性の高いTCP接続の管理が可能になります。

## 必要条件

4Dの新しいクラスであるTCPConnectionとTCPEventを使用したTCPによるデータ取得とイベントログについて、本テクニカルノートで紹介する概念を十分に理解し実装するには、次の前提条件を満たしている必要があります。

1. 本ノートは4Dバージョン20 R8以降を対象としています。TCPConnectionクラスとTCPEventクラスはこのリリースで導入されました。これらの機能を利用するため、4D環境を最新の状態にしてください。
2. TCP/IP（Transmission Control Protocol/Internet Protocol）の基本的な理解が必要です。IPアドレス、ポート、クライアント・サーバーモデルなどの概念は、TCP接続の確立と管理の基礎となるため、これらに精通している必要があります。
3. インターネット接続が必要です。

## 非同期の接続ライフサイクルとイベント処理のためのクラス

### 非同期の例

次の例では4Dのクラスを定義し、localhostで動作するサーバーへのTCP接続を管理して、コマンドの送信、データの受信、接続イベントの処理を非同期で行う方法を示します。

![](fig-01)

```4d
property connection : 4D.TCPConnection
property url : Text
property port : Integer

Class constructor($url : Text; $port : Integer)
    This.connection:=Null
    This.url:=$url
    This.port:=$port

Function connect()
    This.connection:=4D.TCPConnection.new(This.url; This.port; This)

Function disconnect ()
    This.connection.shutdown()
    This.connection:=Null

Function sendPacket($blob : Blob)
    This.connection.send($blob)

Function getInfo()
    var $blob : Blob

    TEXT TO BLOB("Information"; $blob)
    This.connection.send($blob)


Function onConnection($connection : 4D.TCPConnection; $event : 4D.TCPEvent)
    ALERT ("Connection established")


Function onShutdown($connection : 4D.TCPConnection; $event : 4D.TCPEvent)
    ALERT ("Connection closed")


Function onData($connection : 4D.TCPConnection; $event : 4D.TCPEvent)
    ALERT (BLOB to text($event.data; UTF8 text without length))


Function onError($connection : 4D.TCPConnection; $event : 4D.TCPEvent)
    ALERT ("Connection error")

Function onTerminate($connection : 4D.TCPConnection; $event : 4D.TCPEvent)
```

### 解説

この4Dクラスは、非同期のTCP接続を的確に処理します。概要は次のとおりです。

#### プロパティ：

- connection：TCP接続オブジェクトを保持します（初期値はNull）。
- url：サーバーのアドレス（例："127.0.0.1"）。
- port：サーバーのポート。

#### 関数：

- Constructor ($url, $port)：urlとportを設定し、connectionをNullで初期化します。
- connect ()：urlとportに対してTCP接続を開きます。
- disconnect ()：接続を閉じ、connectionをクリアします。
- sendPacket($blob)：バイナリデータのBLOBを接続経由で送信します。
- getInfo()："Information"というテキストを格納したBLOBを送信します。

#### イベントハンドラー（非同期）：

- **onConnection**：接続されると"Connection established"を表示します。
- **onShutdown**：切断されると"Connection closed"を表示します。
- **onData**：受信したデータをテキストとして表示します。
- **onError**：問題が発生すると"Connection error"を表示します。
- **onTerminate**：接続が完全に閉じられると"Connection terminated"を表示します。

#### 非同期の性質：

4D. TCPConnectionを使用して、ブロッキングしない（non-blocking）処理を行います。イベントハンドラーは、アプリケーションを停止させることなく、ネットワークイベント（接続、データ、エラー）に応答します。

### 断片化されたデータの処理

TCPではデータが複数のイベントに分割される場合があるため、onDataコールバックでは断片化されたデータを考慮してください。低レベルのTCP/IP接続を扱う場合、すべてのデータが1つのパケットで届く保証はないことに注意が必要です。データは順序どおりに届きますが、複数のパケットに断片化されることがあります。

## デモアプリケーション

本テクニカルノートに付属のデモアプリケーションでは、TCP接続を管理するクラスとパケット送信の機能を紹介します。前述の非同期の例をもとに、TCP接続の確立、構造化されたデータの送信、4D環境での非同期イベントの管理を実際に示します。

アプリケーションを実行するには、インターネットに接続した状態で、20R8のビルド100353以降を使用してください。このアプリケーションは、TCP_Listenなどの4D Internet Commandsを使用して、接続のための通信「ソケット」を作成します。

バージョン20 R9では、TCPListenerクラスを使用して4DでTCPサーバーを作成・設定できます。TCPListenerクラスをインスタンス化すると、クライアントからのTCP接続を受け付け、TCP互換のプロトコルで通信できるようになります。

アプリケーションを実行するには、次の手順を順番に行います。

- 前提条件がすべて満たされていることを確認し、アプリケーションメニューからRun Application > Runを選択します。
- 送信側（Sender）のウィンドウが表示されたら、「connect」ボタンをクリックしてTCPサーバーとの接続を確立します。
- 接続が確立されたら、「choose file」ボタンを使用して、プロジェクトのResourcesフォルダーからサンプルファイルを選択します。
- ファイルが正常に読み込まれたら、「send」ボタンをクリックしてパケットを送信します。
- パケットが正常に受信されると、プログレスバーに"End Receiving, ready for next packets..."と表示され、受信側（Receiver）のウィンドウに送信されたすべてのパケットが表示されます。
- パケットをすべて受信したら、プロジェクトのResourcesフォルダーから別のサンプルファイルを読み込んで、新しいパケットの送信を開始できます。

## まとめ

4D v20 R8のTCPConnectionクラスとTCPEventクラスは、TCPによるデータ取得とイベントログに革新をもたらし、開発者が堅牢でリアルタイムなネットワークアプリケーションを簡単に構築できるようにしました。非同期の設計と4Dのログ機能とのスムーズな統合により、比類のない効率と信頼性を実現します。4Dは進化を続けており、今後のリリースで予定されている新しいTCPクラスにより、さらに大きな可能性が広がり、接続された世界で4Dアプリケーションが実現できることの幅が一層広がるでしょう。今後の進化にご期待ください。
