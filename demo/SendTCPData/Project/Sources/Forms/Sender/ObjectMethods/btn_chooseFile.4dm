Case of 
	: (FORM Event:C1606.code=On Clicked:K2:4)
		var $doc : Text:=Select document:C905(Folder(fk resources folder).platformPath; ".txt"; Localized string("Sender_ChooseFilePrompt"); Allow alias files:K24:10)
		
		If (ok=1)
			var $file : 4D:C1709.File:=File:C1566(Document; fk platform path:K87:2)
			
			Form:C1466.fileToSend:=New object:C1471(\
				"path"; $file.platformPath; \
				"size"; $file.size; \
				"content"; $file.getText(); \
				"blobContent"; $file.getContent()\
				)
			
			If (Is Windows:C1573)
				Form:C1466.data:=Split string:C1554($file.getText(); Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))
			Else 
				Form:C1466.data:=Split string:C1554($file.getText(); Char:C90(Line feed:K15:40))
			End if 
			
		End if 
End case 