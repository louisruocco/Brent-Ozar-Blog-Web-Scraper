$path = "<insert link here>"
Function DB-Check {
    if(!(test-path $path)){
        New-Item $path
    }
}

$url = Invoke-WebRequest 'https://www.brentozar.com/archive/category/development/t-sql/'
$res = $url.ParsedHtml.getElementsByTagName('div') |Where-Object { $_.className -eq 'w-grid-list' }
$links = $res | ForEach-Object { $_.getElementsByTagName('a') }
$random = $links.href -replace '#comments', '' -replace 'https://www.brentozar.com/archive/author/brento/', '' -replace 'https://www.brentozar.com/archive/category/videos/', '' -replace 'https://www.brentozar.com/archive/category/development/t-sql/', '' | Select-Object -Unique

function Randomise {
    $links = $random | Sort-Object {Get-Random}
    $link = $links[0]
    $check = Select-String -Path $path -Pattern $link
    if($check -ne $links[0]){
        Add-Content -Path $path -Value $link
    }
}

DB-Check
Randomise
