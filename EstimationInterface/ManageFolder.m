function ManageFolder(foldername,DataArea)
try 
    rmdir([DataArea '\' foldername ],'s') 
catch
end
mkdir([DataArea '\' foldername ])
mkdir([DataArea '\' foldername '\ExcelFileRev'])
mkdir([DataArea '\' foldername '\ExcelFileVintages'])
mkdir([DataArea '\' foldername '\RealTimePlusRev'])
end