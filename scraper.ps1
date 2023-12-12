$url = Invoke-WebRequest 'https://www.brentozar.com/archive/category/development/t-sql/'
$res = $url.ParsedHtml.getElementsByTagName('div') |Where-Object { $_.className -eq 'w-grid-list' }
$links = $res | ForEach-Object { $_.getElementsByTagName('a') }
$links.href -replace '#comments', '' -replace 'https://www.brentozar.com/archive/author/brento/', '' -replace 'https://www.brentozar.com/archive/category/videos/', '' -replace 'https://www.brentozar.com/archive/category/development/t-sql/', '' | Select-Object -Unique
