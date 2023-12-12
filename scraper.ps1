$url = Invoke-WebRequest 'https://www.brentozar.com/archive/category/development/t-sql/'
$res = $url.ParsedHtml.getElementsByTagName('div') |
  Where-Object { $_.className -eq 'w-grid-list' }
$links = $res | ForEach-Object { $_.getElementsByTagName('a') }
$parse = $links.href