<?php
include "top.php";
?>
<?php
//Creates the variables for each of the counters
$whereCount = 0;
$conditionscount = 0;
$quotescount = 0;
$symbolcount = 0;
$whereClause = "";
$data = "";
//########################################################
//	This	page	lists	the	records	based	on	the	query	given
//########################################################

//Creates the query in order to find the sum of total studenss taught by each of the CS teachers and sorts them by this valve
$query = 'SELECT fldUsername, fldEmail,fldPassword 
FROM tblUsers';

$records = $thisDatabaseReader->select($query, "",$whereCount , $conditionscount, $quotescount, $symbolcount, false, false);
//Creates a debug statement
if (DEBUG) {
    print "<p>Contents	of	the	array<pre>";
    print_r($records);
    print "</pre></p>";
}
print '<h2	class="alternateRows">Meet	the	Jetsons!</h2>';
if (is_array($records)) {
    foreach ($records as $record) {
        print "<p>" . $record['fldUsername'] . "	" . $record['fldEmail'] . "	" . $record['fldPassword'] . "</p>";
    }
}
?>