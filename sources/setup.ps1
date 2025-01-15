# カラー付きのASCIIアートでウェルカムメッセージを表示
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green
Write-Host "デデオチャンのPCセットアップにようこそ！"
Write-Host "Version 3"
Start-Sleep -Seconds 1
Write-Host " "
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
Write-Host " "
Start-Sleep -Seconds 1

# ユーザーフォルダに移動 
Set-Location -Path $env:USERPROFILE

function SelectJob {
    while ($true) {
        $input = Read-Host "セットアップを選択してください"
        
        if ($input -eq "1" -or $input -eq "2" -or $input -eq "3") {
            return $input
        } else {
            Write-Host "無効な入力です。もう一度やり直してください。" -ForegroundColor Red
        }
    }
}







# ------------------------------------------------------------------------------
# レジストリ編集
# ------------------------------------------------------------------------------

function Job1 {
Write-Host "レジストリを編集します..."

Start-Sleep -Seconds 1
Write-Host " "

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

Write-Host " "
Write-Host "レジストリの編集を完了しました。" -ForegroundColor Green
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# DNS設定の変更
# ------------------------------------------------------------------------------

Write-Host " "
Write-Host "パブリックDNSをGoogleのものに変更します。"
Start-Sleep -Seconds 1

$interfaceIndex = (Get-NetIPInterface -AddressFamily IPv4).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8

Write-Host "パブリックDNSを変更しました。" -ForegroundColor Green
Start-Sleep -Seconds 1

Selecter


}
# ------------------------------------------------------------------------------
# パッケージのインストール
# ------------------------------------------------------------------------------

function Job2 {
Write-Host " "
Write-Host "WinGetがインストールされているかチェックします..."

# WinGet がインストールされているかをチェックする
function Test-WinGet {
    $chocoPath = (Get-Command winget -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (Test-WinGet) {

    Write-Host "WinGetはインストールされています。" -ForegroundColor Green

}else{

    Write-Host "WinGetをインストールします。"
    Start-Sleep -Seconds 1
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "WinGetをインストールしました。"  -ForegroundColor Green
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "環境変数を再読み込みしました。"  -ForegroundColor Green
}

Start-Sleep -Seconds 1
Write-Host " "

Write-Host "WinGetを使用してパッケージをインストールします。"
Start-Sleep -Seconds 1

# 実行したい別のスクリプトのパスを設定する
$packageTxt = Join-Path -Path $PSScriptRoot -ChildPath "packages.txt"

# インストールするパッケージのリストをファイルから読み込み
$packageList = Get-Content -Path $packageTxt

# インストールに失敗したパッケージを保持する配列
$failedInstalls = @()

Write-Host " "
Write-Host "インストールするパッケージリスト:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host " "
Write-Host "インストールを開始します。"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software をインストールします..."
    winget install -e --id $software
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software のインストールに失敗しました。" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
        Write-Host " "
    } else {
        Write-Host "$software を正常にインストールしました。" -ForegroundColor Green
        Start-Sleep -Seconds 1
        Write-Host " "
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


Start-Sleep -Seconds 1
Selecter

}


function Job3 {

Write-Host " "
Write-Host "WinGetがインストールされているかチェックします..."

# WinGet がインストールされているかをチェックする
function Test-WinGet {
    $chocoPath = (Get-Command winget -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (Test-WinGet) {

    Write-Host "WinGetはインストールされています。" -ForegroundColor Green

}else{

    Write-Host "WinGetをインストールします。"
    Start-Sleep -Seconds 1
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "WinGetをインストールしました。"  -ForegroundColor Green
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "環境変数を再読み込みしました。"  -ForegroundColor Green
}

Start-Sleep -Seconds 1
Write-Host " "

Write-Host "WinGetを使用してパッケージをインストールします。"
Start-Sleep -Seconds 1

# 実行したい別のスクリプトのパスを設定する
$packageTxt = Join-Path -Path $PSScriptRoot -ChildPath "packages-ex.txt"

# インストールするパッケージのリストをファイルから読み込み
$packageList = Get-Content -Path $packageTxt

# インストールに失敗したパッケージを保持する配列
$failedInstalls = @()

Write-Host " "
Write-Host "インストールするパッケージリスト:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host " "
Write-Host "インストールを開始します。"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software をインストールします..."
    winget install -e --id $software
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software のインストールに失敗しました。" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
        Write-Host " "
    } else {
        Write-Host "$software を正常にインストールしました。" -ForegroundColor Green
        Start-Sleep -Seconds 1
        Write-Host " "
    }
}

Start-Sleep -Seconds 1

# 失敗したパッケージを出力
if ($failedInstalls.Count -gt 0) {
    Write-Host "これらのパッケージのインストールに失敗しました:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "すべてのエクストラ・パッケージを正常にインストールしました。" -ForegroundColor Green
}


Start-Sleep -Seconds 1
Selecter

}


# ------------------------------------------------------------------------------
# 選択
# ------------------------------------------------------------------------------

function Selecter{

Write-Host " "
Write-Host "------------------------------"
Write-Host " "
Write-Host "実行するものを選択してください。"
Write-Host " "
Write-Host "1 : レジストリ編集・パブリックDNSの変更"
Write-Host "2 : パッケージのインストール"
Write-Host "3 : エクストラ・パッケージのインストール"
Write-Host " "
$userInput = SelectJob

if ($userInput -eq "1") {
    Write-Host "レジストリ編集・パブリックDNSの変更 を実行します。"
    Job1    
} elseif ($userInput -eq "2") {
    Write-Host "パッケージのインストール を実行します。"
    Job2
} elseif ($userInput -eq "3") {
    Write-Host "3 : エクストラ・パッケージのインストール を実行します。"
    Job3
}
}

Selecter