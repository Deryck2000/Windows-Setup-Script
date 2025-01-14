# Windows-Setup-Script

自分用にwindowsをセットアップするPowershellスクリプト、使用は自己責任！！おれ用！！！

## 使い方
1. 	管理者権限のPowershellで`Set-ExecutionPolicy RemoteSigned`を実行
3.	管理者権限のPowershellで`setup.ps1`を実行
3. 	自力でインストールする：
 - CubeICE 
 - Bitwarden

## setup.ps1
流れ
1. Windowsを使いやすくするためのレジストリ編集
1. ipv4パブリックDNSをGoogleのものに設定
1. Chocolateyのインストール
1. ChocolateyでパッケージをインストールするためにPowerShellを再起動し、`install-app.ps1`を実行する
#### レジストリ編集部分
- エクスプローラで拡張子を表示
- エクスプローラで隠しファイルを表示
- エクスプローラでコンパクトビューを使用する
- Windows をダークモードに設定
- クリップボード履歴の有効化
- マウス プロパティの「ポインターの精度を高める」を無効化

## install-app.ps1
Chocolateyでパッケージをインストールする。
`$packageList`でインストールするパッケージを設定している
