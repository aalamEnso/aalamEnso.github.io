# Windows (PowerShell) version of new-post.sh
# Usage:  powershell -ExecutionPolicy Bypass -File .\new-post.ps1 "Title of the piece"
# Creates _posts\YYYY-MM-DD-title-of-the-piece.md ready to fill in.
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Title
)

$ErrorActionPreference = "Stop"

$slug = ($Title.ToLower() -replace '[^a-z0-9]+', '-').Trim('-')
if ([string]::IsNullOrEmpty($slug)) {
    Write-Host "Please use a title with at least one letter or number."
    exit 1
}

$date = Get-Date -Format "yyyy-MM-dd"
$relative = "_posts/$date-$slug.md"
$full = Join-Path (Get-Location).Path $relative

if (Test-Path $full) {
    Write-Host "$relative already exists"
    exit 1
}

# Escape double quotes so the title stays valid inside the front matter
$safeTitle = $Title.Replace('"', '\"')

$content = @"
---
title: "$safeTitle"
date: $date
tags: [sketch]
excerpt: "One line shown under the picture on the home page."
header:
  teaser: /assets/images/$slug.jpg
---

![Describe the picture for people who cannot see it](/assets/images/$slug.jpg)

Write a few words about the piece here.
"@

# Write as UTF-8 without a byte-order mark (a BOM breaks Jekyll front matter)
[System.IO.File]::WriteAllText($full, $content, (New-Object System.Text.UTF8Encoding($false)))

Write-Host "Created $relative"
Write-Host "Now save your image as assets\images\$slug.jpg (about 1600 px on the long side)."
