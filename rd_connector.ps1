# remoteapp_logon_connector ver. 1.0 by I.Pielczyk 2024 AD

[cmdletbinding()]
param(
  [Parameter(Mandatory=$true, HelpMessage="URL of the RDS web feed")]
  [string] $URL
)

try {
  # Check if web feed already exists
  if (-not (Check-RDSWebFeed -URL $URL)) {
    Write-Output "Information: Web feed doesn't exist. Adding..."

    # Create temporary WCX file in user's temp directory
    $wcxPath = Create-WCXFile -URL $URL -TempPath ($env:TEMP + "\RDWebFeed")

    # Add the web feed
    Start-Process -FilePath rundll32.exe -ArgumentList 'tsworkspace,WorkspaceSilentSetup', $wcxPath -Wait -NoNewWindow

    Write-Output "Web feed added successfully."
  } else {
    Write-Output "Information: Web feed already exists."
  }
} catch {
  Write-Error $_.Exception
  throw
}

function Check-RDSWebFeed {
  param(
    [Parameter(Mandatory=$true)]
    [string] $URL
  )

  # Get all feeds for the current user
  $feeds = Get-Item 'HKCU:\Software\Microsoft\Workspaces\Feeds\*’

  $inUse = $false
  foreach ($feed in $feeds) {
    if ($feed.GetValue("URL") -eq $URL) {
      $inUse = $true
      break
    }
  }
  return $inUse
}

function Create-WCXFile {
  param(
    [Parameter(Mandatory=$true)]
    [string] $URL,
    [Parameter(Mandatory=$false)]
    [string] $TempPath = "$env:TEMP"
  )

  $xml = @"
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<workspace name="Company Remote Access" xmlns="http://schemas.microsoft.com/ts/2008/09/tswcx" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <defaultFeed url="$URL" />
</workspace>
"@

  # Create temporary directory (if TempPath not provided)
  if (-not (Test-Path $TempPath)) {
    New-Item -Path $TempPath -ItemType Directory -Force | Out-Null
  }

  $wcxFile = "webfeed.wcx"
  $fullPath = Join-Path $TempPath $wcxFile

  # Export the WCX file
  $xml | Out-File -FilePath $fullPath -Encoding utf8 -Force | Out-Null

  return $fullPath
}
