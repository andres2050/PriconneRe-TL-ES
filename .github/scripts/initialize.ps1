function New-ReleaseTag {
    $Date = Get-Date -Format 'yyyyMMdd'
    $charNumber = 64
    do {
        $char = [char]$charNumber
        if ($charNumber -eq 64) {
            $ReleaseTag = "ES-$Date"
        }
        else {
            $ReleaseTag = "ES-$Date" + $char.ToString().ToLower()
        }
        $charNumber++
    }
    while (git tag -l $ReleaseTag)

    return $ReleaseTag
}

$ReleaseTag = New-ReleaseTag
$ReleaseTitle = "Pricone UI ES DMM v$ReleaseTag"
# Buscar el tag ES anterior (excluye los tags del proyecto original sin prefijo)
$PreviousTag = git tag -l "ES-*" --sort=-v:refname | Select-Object -First 1
if (-not $PreviousTag) {
    $PreviousTag = git describe --tags --abbrev=0
}
"RELEASE_TAG=$ReleaseTag" >> $Env:GITHUB_ENV
"RELEASE_TITLE=$ReleaseTitle" >> $Env:GITHUB_ENV
"PREVIOUS_TAG=$PreviousTag" >> $Env:GITHUB_ENV

Write-Output @"
::group::Logs
Tag: $ReleaseTag
Title: $ReleaseTitle
Previous: $PreviousTag
::endgroup::
"@