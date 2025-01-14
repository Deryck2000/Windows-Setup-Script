# �J���[�t����ASCII�A�[�g�ŃE�F���J�����b�Z�[�W��\��
Write-Host "  ____  _____ ____ ___  _ ____  _  __ ____  ____  ____  ____ " -ForegroundColor Green
Write-Host " /  _ \/  __//  __\\  \///   _\/ |/ //_   \/  _ \/  _ \/  _ \ " -ForegroundColor Green
Write-Host " | | \||  \  |  \/| \  / |  /  |   /  /   /| / \|| / \|| / \| " -ForegroundColor Green
Write-Host " | |_/||  /_ |    / / /  |  \_ |   \ /   /_| \_/|| \_/|| \_/| " -ForegroundColor Green
Write-Host " \____/\____\\_/\_\/_/   \____/\_|\_\\____/\____/\____/\____/ " -ForegroundColor Green

Write-Host "�f�f�I�`������PC�Z�b�g�A�b�v"
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

Write-Host "Chocolatey���g�p���ă\�t�g�E�F�A���C���X�g�[�����܂��B"
Start-Sleep -Seconds 1

# �C���X�g�[������\�t�g�E�F�A�̃��X�g
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

# �C���X�g�[���Ɏ��s�����\�t�g�E�F�A��ێ�����z��
$failedInstalls = @()

Write-Host "�C���X�g�[������\�t�g�E�F�A���X�g:" 
$softwareList | ForEach-Object { Write-Host $_ }
Start-Sleep -Seconds 1

Write-Host "�C���X�g�[�����J�n���܂��B"
Start-Sleep -Seconds 1

foreach ($software in $softwareList) {
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

# ���s�����\�t�g�E�F�A���o��
if ($failedInstalls.Count -gt 0) {
    Write-Host "�����̃\�t�g�E�F�A�̃C���X�g�[���Ɏ��s���܂���:" -ForegroundColor Red
    $failedInstalls | ForEach-Object { Write-Host $_ }
} else {
    Write-Host "���ׂẴ\�t�g�E�F�A�𐳏�ɃC���X�g�[�����܂����B" -ForegroundColor Green
}

pause