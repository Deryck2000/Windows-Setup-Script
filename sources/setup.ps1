# �J���[�t����ASCII�A�[�g�ŃE�F���J�����b�Z�[�W��\��
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green
Write-Host "�f�f�I�`������PC�Z�b�g�A�b�v�ɂ悤�����I"
Write-Host "Version 3"
Start-Sleep -Seconds 1
Write-Host " "
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
Write-Host " "
Start-Sleep -Seconds 1

# ���[�U�[�t�H���_�Ɉړ� 
Set-Location -Path $env:USERPROFILE

function SelectJob {
    while ($true) {
        $input = Read-Host "�Z�b�g�A�b�v��I�����Ă�������"
        
        if ($input -eq "1" -or $input -eq "2" -or $input -eq "3") {
            return $input
        } else {
            Write-Host "�����ȓ��͂ł��B������x��蒼���Ă��������B" -ForegroundColor Red
        }
    }
}







# ------------------------------------------------------------------------------
# ���W�X�g���ҏW
# ------------------------------------------------------------------------------

function Job1 {
Write-Host "���W�X�g����ҏW���܂�..."

Start-Sleep -Seconds 1
Write-Host " "

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

Write-Host " "
Write-Host "���W�X�g���̕ҏW���������܂����B" -ForegroundColor Green
Start-Sleep -Seconds 1

# ------------------------------------------------------------------------------
# DNS�ݒ�̕ύX
# ------------------------------------------------------------------------------

Write-Host " "
Write-Host "�p�u���b�NDNS��Google�̂��̂ɕύX���܂��B"
Start-Sleep -Seconds 1

$interfaceIndex = (Get-NetIPInterface -AddressFamily IPv4).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses 8.8.8.8

Write-Host "�p�u���b�NDNS��ύX���܂����B" -ForegroundColor Green
Start-Sleep -Seconds 1

Selecter


}
# ------------------------------------------------------------------------------
# �p�b�P�[�W�̃C���X�g�[��
# ------------------------------------------------------------------------------

function Job2 {
Write-Host " "
Write-Host "WinGet���C���X�g�[������Ă��邩�`�F�b�N���܂�..."

# WinGet ���C���X�g�[������Ă��邩���`�F�b�N����
function Test-WinGet {
    $chocoPath = (Get-Command winget -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (Test-WinGet) {

    Write-Host "WinGet�̓C���X�g�[������Ă��܂��B" -ForegroundColor Green

}else{

    Write-Host "WinGet���C���X�g�[�����܂��B"
    Start-Sleep -Seconds 1
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "WinGet���C���X�g�[�����܂����B"  -ForegroundColor Green
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "���ϐ����ēǂݍ��݂��܂����B"  -ForegroundColor Green
}

Start-Sleep -Seconds 1
Write-Host " "

Write-Host "WinGet���g�p���ăp�b�P�[�W���C���X�g�[�����܂��B"
Start-Sleep -Seconds 1

# ���s�������ʂ̃X�N���v�g�̃p�X��ݒ肷��
$packageTxt = Join-Path -Path $PSScriptRoot -ChildPath "packages.txt"

# �C���X�g�[������p�b�P�[�W�̃��X�g���t�@�C������ǂݍ���
$packageList = Get-Content -Path $packageTxt

# �C���X�g�[���Ɏ��s�����p�b�P�[�W��ێ�����z��
$failedInstalls = @()

Write-Host " "
Write-Host "�C���X�g�[������p�b�P�[�W���X�g:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host " "
Write-Host "�C���X�g�[�����J�n���܂��B"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software ���C���X�g�[�����܂�..."
    winget install -e --id $software
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software �̃C���X�g�[���Ɏ��s���܂����B" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
        Write-Host " "
    } else {
        Write-Host "$software �𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
        Start-Sleep -Seconds 1
        Write-Host " "
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


Start-Sleep -Seconds 1
Selecter

}


function Job3 {

Write-Host " "
Write-Host "WinGet���C���X�g�[������Ă��邩�`�F�b�N���܂�..."

# WinGet ���C���X�g�[������Ă��邩���`�F�b�N����
function Test-WinGet {
    $chocoPath = (Get-Command winget -ErrorAction SilentlyContinue).Path
    return -not [string]::IsNullOrEmpty($chocoPath)
}

if (Test-WinGet) {

    Write-Host "WinGet�̓C���X�g�[������Ă��܂��B" -ForegroundColor Green

}else{

    Write-Host "WinGet���C���X�g�[�����܂��B"
    Start-Sleep -Seconds 1
    $progressPreference = 'silentlyContinue'
    Write-Host "Installing WinGet PowerShell module from PSGallery..."
    Install-PackageProvider -Name NuGet -Force | Out-Null
    Install-Module -Name Microsoft.WinGet.Client -Force -Repository PSGallery | Out-Null
    Write-Host "Using Repair-WinGetPackageManager cmdlet to bootstrap WinGet..."
    Repair-WinGetPackageManager
    Write-Host "WinGet���C���X�g�[�����܂����B"  -ForegroundColor Green
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    Write-Host "���ϐ����ēǂݍ��݂��܂����B"  -ForegroundColor Green
}

Start-Sleep -Seconds 1
Write-Host " "

Write-Host "WinGet���g�p���ăp�b�P�[�W���C���X�g�[�����܂��B"
Start-Sleep -Seconds 1

# ���s�������ʂ̃X�N���v�g�̃p�X��ݒ肷��
$packageTxt = Join-Path -Path $PSScriptRoot -ChildPath "packages-ex.txt"

# �C���X�g�[������p�b�P�[�W�̃��X�g���t�@�C������ǂݍ���
$packageList = Get-Content -Path $packageTxt

# �C���X�g�[���Ɏ��s�����p�b�P�[�W��ێ�����z��
$failedInstalls = @()

Write-Host " "
Write-Host "�C���X�g�[������p�b�P�[�W���X�g:" 
$packageList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host " "
Write-Host "�C���X�g�[�����J�n���܂��B"
Start-Sleep -Seconds 1

foreach ($software in $packageList) {
    Write-Host "$software ���C���X�g�[�����܂�..."
    winget install -e --id $software
    if ($LASTEXITCODE -ne 0) {
        Write-Host "$software �̃C���X�g�[���Ɏ��s���܂����B" -ForegroundColor Red
        $failedInstalls += $software
        Start-Sleep -Seconds 1
        Write-Host " "
    } else {
        Write-Host "$software �𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
        Start-Sleep -Seconds 1
        Write-Host " "
    }
}

Start-Sleep -Seconds 1

# ���s�����p�b�P�[�W���o��
if ($failedInstalls.Count -gt 0) {
    Write-Host "�����̃p�b�P�[�W�̃C���X�g�[���Ɏ��s���܂���:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "���ׂẴG�N�X�g���E�p�b�P�[�W�𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
}


Start-Sleep -Seconds 1
Selecter

}


# ------------------------------------------------------------------------------
# �I��
# ------------------------------------------------------------------------------

function Selecter{

Write-Host " "
Write-Host "------------------------------"
Write-Host " "
Write-Host "���s������̂�I�����Ă��������B"
Write-Host " "
Write-Host "1 : ���W�X�g���ҏW�E�p�u���b�NDNS�̕ύX"
Write-Host "2 : �p�b�P�[�W�̃C���X�g�[��"
Write-Host "3 : �G�N�X�g���E�p�b�P�[�W�̃C���X�g�[��"
Write-Host " "
$userInput = SelectJob

if ($userInput -eq "1") {
    Write-Host "���W�X�g���ҏW�E�p�u���b�NDNS�̕ύX �����s���܂��B"
    Job1    
} elseif ($userInput -eq "2") {
    Write-Host "�p�b�P�[�W�̃C���X�g�[�� �����s���܂��B"
    Job2
} elseif ($userInput -eq "3") {
    Write-Host "3 : �G�N�X�g���E�p�b�P�[�W�̃C���X�g�[�� �����s���܂��B"
    Job3
}
}

Selecter