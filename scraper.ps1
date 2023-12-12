$path = "C:\users\louis\desktop\test.txt"
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
    $test = $links[0]
    $link = Select-String -Path $path -Pattern $test
    if($link -ne $links[0]){
        Add-Content -Path $path -Value $test
    }
}

DB-Check
Randomise
