cls
#dot source the function
. .\Set-CellColor.ps1

#Some test data
$Data = @"
"Server","Path","CookedValue"
"dc","\\dc\\memory\available mbytes","1377"
"dc2","\\dc2\\memory\available mbytes","70"
"dc2","\\dc2\\processor(_total)\% processor time","0.00190904948765835"
"dc","\\dc\\processor(_total)\% processor time","0.000565369831695417"
"dc2","\\dc2\\system\processor queue length","0"
"dc2","\\dc2\\processor(_total)\% privileged time","0"
"dc2","\\dc2\\memory\pages/sec","0"
"dc","\\dc\\memory\pages/sec","0"
"dc","\\dc\\processor(_total)\% privileged time","0"
"dc","\\dc\\system\processor queue length","0"
"@

$Data = $Data | ConvertFrom-Csv
$Header = @"
<style>
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {border-width: 1px;padding: 3px;border-style: solid;border-color: black;background-color: #6495ED;}
TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
</style>
"@
$HTML = $Data | sort server | ConvertTo-html -head $header | Set-CellColor cookedvalue purple -Filter "cookedvalue -gt 90" -Row
#$HTML = $HTML | Set-CellColor Server green -Filter "server blah blah 'dc2'" 
$HTML = $HTML | Set-CellColor Path Yellow -Filter "Path -like ""*memory*"""
$HTML = $HTML | Set-CellColor cookedvalue green -Filter "cookedvalue -gt 90" -Row
$HTML | Out-File c:\Dropbox\Test\colortest.html
& c:\Dropbox\Test\colortest.html