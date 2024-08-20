# PowerShell

# both_repo means repo_origin_ubuntu.git
Set-Location C:\pyDjangoDEV\proj_mdm_timer

# 원격 리포지토리 정보 갱신
Write-Host "Fetching latest changes from the both_repo..."
git fetch both_repo

# 원격에서 삭제된 파일 목록 생성
Write-Host "Identifying files deleted in both_repo/main..."
$deleted_files = git diff --name-only --diff-filter=D both_repo/main

# 원격에서 삭제된 파일만 로컬에서 삭제
if (-not [string]::IsNullOrWhiteSpace($deleted_files)) {
    foreach ($file in $deleted_files -split "`n") {
        if (Test-Path $file) {
            Write-Host "Removing $file as it's deleted in both_repo/main"
            Remove-Item $file
            git rm --cached $file  # Git 인덱스에서 제거
        }
    }
} else {
    Write-Host "No files to delete."
}

# 원격과 로컬의 차이를 비교하여 변경된 파일 목록 생성
Write-Host "Identifying updated files..."
$updated_files = git diff --name-only both_repo/main

# 원격에 추가된 파일 목록 생성
Write-Host "Identifying added files..."
$added_files = git diff --name-only --diff-filter=A both_repo/main

# 변경된 파일을 로컬에 반영
if (-not [string]::IsNullOrWhiteSpace($updated_files)) {
    foreach ($file in $updated_files -split "`n") {
        Write-Host "Updating $file"
        git checkout both_repo/main -- $file
    }
} else {
    Write-Host "No updated files."
}

# 추가된 파일을 로컬에 반영
if (-not [string]::IsNullOrWhiteSpace($added_files)) {
    foreach ($file in $added_files -split "`n") {
        Write-Host "Adding $file"
        git checkout both_repo/main -- $file
    }
} else {
    Write-Host "No new files added."
}

# 원격에 있지만 로컬에 없는 파일 목록 생성 (missing files 처리)
Write-Host "Identifying missing files..."
$missing_files = git ls-tree -r both_repo/main --name-only | ForEach-Object {
    if (-not (Test-Path $_)) {
        $_
    }
}

# 원격에 있지만 로컬에 없는 파일을 로컬에 추가
if (-not [string]::IsNullOrWhiteSpace($missing_files)) {
    foreach ($file in $missing_files -split "`n") {
        Write-Host "Adding missing file $file"
        git checkout both_repo/main -- $file
    }
} else {
    Write-Host "No missing files."
}

# 변경된 모든 파일(추가, 삭제, 수정 포함)을 스테이징
Write-Host "Staging all changes..."
git add -A

# 스테이징된 변경사항 커밋
git commit -m "Synced local repository with both_repo/main, reflecting updates, deletions, and additions"

Write-Host "Updates applied successfully."
