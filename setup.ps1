# �J���[�t����ASCII�A�[�g�ŃE�F���J�����b�Z�[�W��\��
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green
Write-Host "�f�f�I�`������PC�Z�b�g�A�b�v�ɂ悤�����I"
Write-Host "Version 1.0"
Start-Sleep -Seconds 1
Write-Host "�Ǘ��Ҍ����Ŏ��s����Ă��邩�`�F�b�N���܂�..."

# �Ǘ��Ҍ������`�F�b�N����֐�
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# �Ǘ��Ҍ����Ŏ��s����Ă��邩�ǂ������m�F
if (-not (Test-Admin)) {
    Write-Host "���̃X�N���v�g�͊Ǘ��Ҍ����Ŏ��s����K�v������܂��B" -ForegroundColor Red
    pause
    exit
}

Write-Host "�Ǘ��Ҍ����ŃX�N���v�g�����s����Ă��܂��B�Z�b�g�A�b�v�𑱍s���܂��B" -ForegroundColor Green

Start-Sleep -Seconds 1

# ���[�U�[�t�H���_�Ɉړ� 
Set-Location -Path $env:USERPROFILE

# ------------------------------------------------------------------------------
# ���W�X�g���ҏW
# ------------------------------------------------------------------------------
Write-Host "���W�X�g����ҏW���܂�..."

Start-Sleep -Seconds 1

# �G�N�X�v���[���Ŋg���q��\��
Write-Host "���W�X�g����ҏW:�G�N�X�v���[���Ŋg���q��\��..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0

# �G�N�X�v���[���ŉB���t�@�C����\��
Write-Host "���W�X�g����ҏW:�G�N�X�v���[���ŉB���t�@�C����\��..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1

# �G�N�X�v���[���ŃR���p�N�g�r���[���g�p����
Write-Host "���W�X�g����ҏW:�G�N�X�v���[���ŃR���p�N�g�r���[���g�p����..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'UseCompactMode' -Value 1

# Windows ���_�[�N���[�h�ɐݒ�
Write-Host "���W�X�g����ҏW:Windows ���_�[�N���[�h�ɐݒ�..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Value 0
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'SystemUsesLightTheme' -Value 0

# �N���b�v�{�[�h�����̗L����
Write-Host "���W�X�g����ҏW:�N���b�v�{�[�h�����̗L����..."
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Clipboard' -Name 'EnableClipboardHistory' -Value 1

# �}�E�X�̃v���p�e�B�́u�|�C���^�[�̐��x�����߂�v�𖳌���
Write-Host "���W�X�g����ҏW:�}�E�X�̃v���p�e�B�́u�|�C���^�[�̐��x�����߂�v�𖳌���..."
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Value 0
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Value 0
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Value 0

Write-Host "���W�X�g���̕ҏW���������܂����B"
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# DNS�ݒ�̕ύX
# ------------------------------------------------------------------------------

Write-Host "�p�u���b�NDNS��Google�̂��̂ɕύX���܂��B"
Start-Sleep -Seconds 1

$interfaceIndex = (Get-NetIPInterface -AddressFamily IPv4).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8

Write-Host "�p�u���b�NDNS��ύX���܂����B"
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# Chocolatey���C���X�g�[��
# ------------------------------------------------------------------------------
Write-Host "Chocolatey���C���X�g�[�����܂�..."
Start-Sleep -Seconds 1

# Chocolatey�̃C���X�g�[��
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Write-Host "Chocolatey���C���X�g�[�����܂����B"
Start-Sleep -Seconds 1

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

Write-Host "Chocolatey���C���X�g�[������Ă��邩�`�F�b�N���܂�..."

# Chocolatey ���C���X�g�[������Ă��邩���`�F�b�N����
function Test-Chocolatey {
    $chocoPath = (Get-Command choco -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (-not (Test-Chocolatey)) {
    Write-Host "Chocolatey���C���X�g�[������Ă��܂���B�Z�b�g�A�b�v���I�����܂��B" -ForegroundColor Red
    pause
    exit
}

Write-Host "Chocolatey�̓C���X�g�[������Ă��܂��B�Z�b�g�A�b�v�𑱍s���܂��B" -ForegroundColor Green
Start-Sleep -Seconds 1

Write-Host "Chocolatey���g�p���ăp�b�P�[�W���C���X�g�[�����܂��B"
Start-Sleep -Seconds 1

# �C���X�g�[������p�b�P�[�W�̃��X�g���t�@�C������ǂݍ���
$packageList = Get-Content -Path "./packages.txt"

# �C���X�g�[���Ɏ��s�����p�b�P�[�W��ێ�����z��
$failedInstalls = @()

Write-Host "�C���X�g�[������p�b�P�[�W���X�g:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host "�C���X�g�[�����J�n���܂��B"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software ���C���X�g�[�����܂�..."
    choco install $software -y
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software �̃C���X�g�[���Ɏ��s���܂����B" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
    } else {
        Write-Host "$software �𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
        Start-Sleep -Seconds 1
    }
}

Start-Sleep -Seconds 1

# ���s�����p�b�P�[�W���o��
if ($failedInstalls.Count -gt 0) {
    Write-Host "�����̃p�b�P�[�W�̃C���X�g�[���Ɏ��s���܂���:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "���ׂẴp�b�P�[�W�𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
}

pause