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

# ------------------------------------------------------------------------------
# PowerShell���ċN��
# ------------------------------------------------------------------------------

Write-Host "Chocolatey���g�p���ăp�b�P�[�W���C���X�g�[�����邽�߁APowerShell���ċN�����܂��B"
Start-Sleep -Seconds 1

# ���ݎ��s���Ă���.ps1�t�@�C���̃f�B���N�g�����擾����
$currentScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# ���s�������ʂ̃X�N���v�g�̃p�X��ݒ肷��
$otherScriptPath = Join-Path -Path $currentScriptDirectory -ChildPath "install-app.ps1"

# Windows Terminal�ŐV�����^�u���J���ăX�N���v�g���Ď��s����֐�
function Restart-PowerShell {

    # Windows Terminal���J���A�V�����^�u�ŕʂ̃X�N���v�g�����s
    Start-Process -FilePath "wt.exe" -ArgumentList "powershell.exe -NoExit -File `"$otherScriptPath`"" -Verb RunAs
    
    # ���݂̃X�N���v�g���I��
    exit
}

# PowerShell���ċN��
Restart-PowerShell

