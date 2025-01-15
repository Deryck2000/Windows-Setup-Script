# Windows-Setup-Script

自分用にwindowsをセットアップするPowershellスクリプト、使用は自己責任！！おれ用！！！

## 使い方
1. 	`Start.bat`をダブルクリックで起動
3. 	自力でインストールする：
 - CubeICE 
 - Bitwarden

## setup.ps1
流れ
1. Windowsを使いやすくするためのレジストリ編集
1. ipv4パブリックDNSをGoogleのものに設定
1. Chocolateyのインストール
1. Chocolateyでパッケージをインストールする
#### レジストリ編集部分
- エクスプローラで拡張子を表示
- エクスプローラで隠しファイルを表示
- エクスプローラでコンパクトビューを使用する
- Windows をダークモードに設定
- クリップボード履歴の有効化
- マウス プロパティの「ポインターの精度を高める」を無効化
#### パッケージのインストール
Chocolateyでパッケージをインストールする。
`sources\packages.txt`でインストールするパッケージを設定している
