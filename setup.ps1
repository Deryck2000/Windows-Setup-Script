# カラー付きのASCIIアートでウェルカムメッセージを表示
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green
Write-Host "デデオチャンのPCセットアップにようこそ！"
Write-Host "Version 1.0"
Start-Sleep -Seconds 1
Write-Host "管理者権限で実行されているかチェックします..."

# 管理者権限をチェックする関数
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# 管理者権限で実行されているかどうかを確認
if (-not (Test-Admin)) {
    Write-Host "このスクリプトは管理者権限で実行する必要があります。" -ForegroundColor Red
    pause
    exit
}

Write-Host "管理者権限でスクリプトが実行されています。セットアップを続行します。" -ForegroundColor Green

Start-Sleep -Seconds 1

# ユーザーフォルダに移動 
Set-Location -Path $env:USERPROFILE

# ------------------------------------------------------------------------------
# レジストリ編集
# ------------------------------------------------------------------------------
Write-Host "レジストリを編集します..."

Start-Sleep -Seconds 1

# エクスプローラで拡張子を表示
Write-Host "レジストリを編集:エクスプローラで拡張子を表示..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0

# エクスプローラで隠しファイルを表示
Write-Host "レジストリを編集:エクスプローラで隠しファイルを表示..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1

# エクスプローラでコンパクトビューを使用する
Write-Host "レジストリを編集:エクスプローラでコンパクトビューを使用する..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'UseCompactMode' -Value 1

# Windows をダークモードに設定
Write-Host "レジストリを編集:Windows をダークモードに設定..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'SystemUsesLightTheme' -Value 0

# クリップボード履歴の有効化
Write-Host "レジストリを編集:クリップボード履歴の有効化..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Clipboard' -Name 'EnableClipboardHistory' -Value 1

# マウスのプロパティの「ポインターの精度を高める」を無効化
Write-Host "レジストリを編集:マウスのプロパティの「ポインターの精度を高める」を無効化..."
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value 0
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value 0
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value 0

Write-Host "レジストリの編集を完了しました。"
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# DNS設定の変更
# ------------------------------------------------------------------------------

Write-Host "パブリックDNSをGoogleのものに変更します。"
Start-Sleep -Seconds 1

$interfaceIndex = (Get-NetIPInterface -AddressFamily IPv4).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8

Write-Host "パブリックDNSを変更しました。"
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# Chocolateyをインストール
# ------------------------------------------------------------------------------
Write-Host "Chocolateyをインストールします..."
Start-Sleep -Seconds 1

# Chocolateyのインストール
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Chocolateyをインストールしました。"
Start-Sleep -Seconds 1

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Chocolateyがインストールされているかチェックします..."

# Chocolatey がインストールされているかをチェックする
function Test-Chocolatey {
    $chocoPath = (Get-Command choco -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (-not (Test-Chocolatey)) {
    Write-Host "Chocolateyがインストールされていません。セットアップを終了します。" -ForegroundColor Red
    pause
    exit
}

Write-Host "Chocolateyはインストールされています。セットアップを続行します。" -ForegroundColor Green
Start-Sleep -Seconds 1

Write-Host "Chocolateyを使用してパッケージをインストールします。"
Start-Sleep -Seconds 1

# インストールするパッケージのリストをファイルから読み込み
$packageList = Get-Content -Path "./packages.txt"

# インストールに失敗したパッケージを保持する配列
$failedInstalls = @()

Write-Host "インストールするパッケージリスト:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host "インストールを開始します。"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software をインストールします..."
    choco install $software -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software のインストールに失敗しました。" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
    } else {
        Write-Host "$software を正常にインストールしました。" -ForegroundColor Green
        Start-Sleep -Seconds 1
    }
}

Start-Sleep -Seconds 1

# 失敗したパッケージを出力
if ($failedInstalls.Count -gt 0) {
    Write-Host "これらのパッケージのインストールに失敗しました:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "すべてのパッケージを正常にインストールしました。" -ForegroundColor Green
}

pause