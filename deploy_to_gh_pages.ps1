# Requires PowerShell 7.3 or later.
param([switch]$UseVerifiedBuild)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true
$remote = 'https://github.com/AhmedAElghareeb/my_portfolio.git'
$credentials = 'credential.https://github.com.username=AhmedAElghareeb'
$savedIndex = $env:GIT_INDEX_FILE

Push-Location -LiteralPath $PSScriptRoot
try {
  if ((git remote get-url origin).Trim() -ne $remote) { throw 'Unexpected origin URL.' }
  if (@(git status --porcelain).Count) { throw 'Commit the source changes before publishing.' }
  git -c $credentials fetch --no-tags origin
  $source = (git rev-parse HEAD).Trim()
  if ($source -ne (git rev-parse origin/main).Trim()) { throw 'Publish the reviewed source on main before deploying it.' }
  $previous = (git rev-parse origin/gh-pages).Trim()

  if (!$UseVerifiedBuild) {
    flutter pub get
    flutter analyze
    flutter test
    flutter build web --release --base-href /my_portfolio/ --wasm --pwa-strategy=none
  }
  $release = (Resolve-Path -LiteralPath 'build/web').Path
  $gitDir = (git rev-parse --absolute-git-dir).Trim()
  $publish = @('assets', 'canvaskit', 'icons', 'favicon.ico', 'favicon.png', 'flutter.js', 'flutter_bootstrap.js', 'flutter_service_worker.js', 'index.html', 'main.dart.js', 'main.dart.mjs', 'main.dart.wasm', 'manifest.json', 'retire_flutter_service_worker.js', 'version.json')
  $allowedRoot = $publish + @('.nojekyll', '.last_build_id')
  $previousRoot = @(git ls-tree --name-only $previous)
  $releaseRoot = @(Get-ChildItem -LiteralPath $release -Force | Select-Object -ExpandProperty Name)
  if (@(($previousRoot + $releaseRoot) | Where-Object { $_ -notin $allowedRoot }).Count) { throw 'Unexpected files in build/web or gh-pages.' }
  if ((Get-Content -Raw -LiteralPath (Join-Path $release 'index.html')) -notmatch '<base href="/my_portfolio/">') { throw 'Wrong Pages base href.' }
  $files = @(Get-ChildItem -LiteralPath $release -File -Recurse -Force | Where-Object { $_.Name -ne '.last_build_id' })
  if (@($files | Where-Object { $_.Name -match '(?i)(\.pdf$|\.mp4$|\.zip$|\.pem$|\.key$|^\.git|^\.env|\.lock$)' }).Count) { throw 'Unexpected file type in the release.' }

  $temp = New-Item -ItemType Directory -Path (Join-Path $PSScriptRoot ('build/pages-' + [Guid]::NewGuid().ToString('N')))
  $env:GIT_INDEX_FILE = Join-Path $temp.FullName 'index'
  $markerFile = Join-Path $temp.FullName '.nojekyll'
  [IO.File]::WriteAllBytes($markerFile, [byte[]]@())
  $releaseGit = @("--git-dir=$gitDir", "--work-tree=$release")
  Push-Location -LiteralPath $release
  try {
    git @releaseGit read-tree --empty
    git -c core.autocrlf=false @releaseGit add --force -- @publish
    $marker = (git @releaseGit hash-object -w --no-filters -- $markerFile).Trim()
    git @releaseGit update-index --add --cacheinfo "100644,$marker,.nojekyll"
    if (@(git @releaseGit ls-files).Count -ne ($files.Count + 1)) { throw 'Unexpected staged release file count.' }
    foreach ($file in $files) {
      $relative = [IO.Path]::GetRelativePath($release, $file.FullName).Replace('\', '/')
      $raw = (git @releaseGit hash-object --no-filters -- $relative).Trim()
      $staged = (git @releaseGit rev-parse (':' + $relative)).Trim()
      if ($raw -ne $staged) { throw "Published bytes would differ for $relative." }
    }
    $tree = (git @releaseGit write-tree).Trim()
    $deployment = (git @releaseGit commit-tree $tree -p $previous -m 'Deploy Flutter portfolio to GitHub Pages' -m "Source: $source").Trim()
  } finally {
    Pop-Location
  }

  # A regular push rejects concurrent updates to the publishing branch.
  git -c $credentials push origin ($deployment + ':refs/heads/gh-pages')
  [pscustomobject]@{ Source = $source; Pages = $deployment; PreviousPages = $previous; Files = $files.Count + 1 }
} finally {
  $env:GIT_INDEX_FILE = $savedIndex
  Pop-Location
}
