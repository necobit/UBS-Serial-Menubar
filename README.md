# USB-Serial Menubar

MacのメニューバーにUSB-Serialアダプターのシリアルポートを表示するmacOSアプリ

## 機能

- メニューバーにケーブルアイコンを表示
- 接続されているUSB-Serialポートを一覧表示
- ポート名をクリックするとパス（例: `/dev/cu.usbserial-1420`）をクリップボードにコピー
- 5秒間隔で自動的にポートを検出
- Dockアイコン非表示（メニューバーのみで動作）

## 対応ポート

以下のパターンのシリアルポートを検出します：

- `cu.usbserial-*` (FTDI、CH340など)
- `cu.usbmodem-*` (Arduino、STM32など)
- `cu.wchusbserial-*` (WCH CH340/CH341)

## 動作環境

- macOS 13.0 (Ventura) 以降

## ダウンロード

[Releases](https://github.com/necobit/UBS-Serial-Menubar/releases)からzipファイルをダウンロードできます。

### 署名なしアプリの起動方法

このアプリはApple Developer署名がないため、初回起動時に警告が表示されます。

1. zipを解凍して `USB-Serial-Menubar.app` を `/Applications` フォルダに移動
2. **右クリック** → **「開く」** を選択
3. 「開発元が未確認」の警告が表示されたら **「開く」** をクリック

または、ターミナルで以下を実行：
```bash
xattr -cr /Applications/USB-Serial-Menubar.app
open /Applications/USB-Serial-Menubar.app
```

## ビルド方法

### Xcodeでビルド

1. `USB-Serial-Menubar.xcodeproj` をXcodeで開く
2. `Cmd + R` でビルド・実行

### コマンドラインでビルド

```bash
xcodebuild -project USB-Serial-Menubar.xcodeproj -scheme USB-Serial-Menubar -configuration Release build
```

ビルドされたアプリは以下に出力されます：
```
~/Library/Developer/Xcode/DerivedData/USB-Serial-Menubar-*/Build/Products/Release/USB-Serial-Menubar.app
```

## インストール

1. ビルドしたアプリを `/Applications` フォルダにコピー
2. アプリを起動

### ログイン時に自動起動

1. システム設定 → 一般 → ログイン項目
2. 「+」ボタンをクリック
3. `USB-Serial-Menubar.app` を選択

## 使い方

1. アプリを起動するとメニューバーにケーブルアイコンが表示されます
2. アイコンをクリックするとメニューが開きます
3. 接続されているUSB-Serialポートが一覧表示されます
4. ポート名をクリックするとパスがクリップボードにコピーされます
5. ターミナルで `Cmd + V` でペーストして使用できます

### キーボードショートカット

| ショートカット | 動作 |
|--------------|------|
| `Cmd + R` | ポートリストを更新 |
| `Cmd + Q` | アプリを終了 |

## 使用例

```bash
# コピーしたポートでscreen接続
screen /dev/cu.usbserial-1420 115200

# コピーしたポートでminicom接続
minicom -D /dev/cu.usbserial-1420 -b 115200

# Arduino CLIでアップロード
arduino-cli upload -p /dev/cu.usbmodem2101 -b arduino:avr:uno sketch
```

## ライセンス

MIT License
