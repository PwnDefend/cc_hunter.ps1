$path = 'data.txt'


$contents = Get-Content $path

$RegexPattern1 = "^(?:4[0-9]{12}(?:[0-9]{3})?|(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$"
$RegexPattern2 = "^\s*(?:(\d{4}-){3}\d{4}|(\d{4} ){3}\d{4}|\d{16})\s*$"
$RegexPattern3 = "\b(?:\d[ -]*?){13,16}\b"
$RegexPattern4 = "^\s*(?:(\d{4} ){3}\d{4}|(\d{4} ){3}\d{4}|\d{16})\s*$"

$cards = $contents | Select-String -Pattern $RegexPattern1 #16 chars joined up

$cards = $cards + $contents | Select-String -Pattern $RegexPattern2 #16 chars with spaces or -

$cards = $cards + $contents | Select-String -Pattern $RegexPattern3 #hungry strings length 13 or 16

$cards = $cards + $contents | Select-String -Pattern $RegexPattern4 #16 quad numbers blocks with spaces

$unqiues = $cards | sort-object | Get-Unique -asstring
$unqiues

$unqiues | Export-Csv -Path "credit_card_search_output.csv"

$unqiues.Count
