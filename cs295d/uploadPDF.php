<?php

 $targetfolder = "pdfs/";
 $targetfolder = $targetfolder . basename( $_FILES['file']['name']);

 if (move_uploaded_file($_FILES['file']['tmp_name'], $targetfolder)) {
   echo "The file ". basename( $_FILES['file']['name']). " is uploaded";
 } else {
   echo "Problem uploading file";
 }

 function pdfEncrypt ($origFile, $password, $destFile){
    require_once('fdpi/FPDI_Protection.php');
    $pdf =& new FPDI_Protection();
    $pdf->FPDF('P', 'in');
    //Calculate the number of pages from the original document.
    $pagecount = $pdf->setSourceFile($origFile);
    //Copy all pages from the old unprotected pdf in the new one.
    for ($loop = 1; $loop <= $pagecount; $loop++) {
        $tplidx = $pdf->importPage($loop);
        $pdf->addPage();
        $pdf->useTemplate($tplidx);
    }

    //Protect the new pdf file, and allow no printing, copy, etc. and
    //leave only reading allowed.
    $pdf->SetProtection(array(), $password);
    $pdf->Output($destFile, 'F');
    return $destFile;
}

//Password for the PDF file (I suggest using the email adress of the purchaser).
$password = $_POST['username'] . $_POST['apptdate'] . $_POST['password'];
//Name of the original file (unprotected).
$origFile = basename( $_FILES['file']['name']);
//Name of the destination file (password protected and printing rights removed).
$destFile = basename( $_FILES['file']['name']);
//Encrypt the book and create the protected file.
pdfEncrypt($origFile, $password, $destFile );
 ?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Upload PDF</title>
</head>
<body>
<form action="uploadPDF.php" method="post" enctype="multipart/form-data">

<input type="file" name="file" size="50" />

<br />

<input type="submit" value="Upload" />

</form>
</body>
</html>
