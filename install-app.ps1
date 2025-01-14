# カラー付きのASCIIアートでウェルカムメッセージを表示
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green

Write-Host "デデオチャンのPCセットアップ"
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

Write-Host "Chocolateyを使用してソフトウェアをインストールします。"
Start-Sleep -Seconds 1

# インストールするソフトウェアのリスト
$softwareList = @(
    "git.install",
    "pwsh",
    "powertoys",
    "tabby",
    "path-copy-copy",
    "flow-launcher",
    "sublimetext4",
    "eartrumpet",
    "opera-gx",
    "discord.install",
    "steam"
)

# インストールに失敗したソフトウェアを保持する配列
$failedInstalls = @()

Write-Host "インストールするソフトウェアリスト:" 
$softwareList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host "インストールを開始します。"
Start-Sleep -Seconds 1

foreach ($software in $softwareList) {
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

# 失敗したソフトウェアを出力
if ($failedInstalls.Count -gt 0) {
    Write-Host "これらのソフトウェアのインストールに失敗しました:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "すべてのソフトウェアを正常にインストールしました。" -ForegroundColor Green
}

pause