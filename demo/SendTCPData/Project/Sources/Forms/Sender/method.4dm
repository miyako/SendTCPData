Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		Form:C1466.fileToSend:=New object:C1471(\
			"path"; ""; \
			"size"; 0; \
			"content"; ""\
			)
		
		Form:C1466.limit:=5
		Form:C1466.interval:=1*60  //5s
		
		Form:C1466.transferInformation:=New object:C1471(\
			"currentPacket"; 0; \
			"packetToTransfer"; 0; \
			"packetTransfered"; 0; \
			"transfer"; False:C215\
			)
		
	: (FORM Event:C1606.code=On Timer:K2:25)
		var $dataToSend : Collection:=[]
		var $packet : Blob
		
		Case of 
			: (Form:C1466.transferInformation.currentPacket=0)
				If (Form:C1466.receiver#Null:C1517)
					$packet:=packetToSend($dataToSend; "start"; Form:C1466.transferInformation.currentPacket; Form:C1466.transferInformation.packetToTransfer)
					Form:C1466.receiver.sendPacket($packet)
					
					Form:C1466.transferInformation.currentPacket:=1
					SET TIMER:C645(Form:C1466.interval)
				Else 
					ALERT:C41("please connect first")
					SET TIMER:C645(0)
				End if 
				
			: ((Form:C1466.transferInformation.currentPacket>0) && (Form:C1466.transferInformation.currentPacket<=Form:C1466.transferInformation.packetToTransfer))
				$dataToSend:=Form:C1466.data.slice((Form:C1466.transferInformation.currentPacket-1)*Form:C1466.limit; ((Form:C1466.transferInformation.currentPacket-1)*Form:C1466.limit)+Form:C1466.limit)
				
				$packet:=packetToSend($dataToSend; "inProgress"; Form:C1466.transferInformation.currentPacket; Form:C1466.transferInformation.packetToTransfer)
				Form:C1466.receiver.sendPacket($packet)
				
				Form:C1466.transferInformation.currentPacket:=Form:C1466.transferInformation.currentPacket+1
				SET TIMER:C645(Form:C1466.interval)
				
			: (Form:C1466.transferInformation.currentPacket>Form:C1466.transferInformation.packetToTransfer)
				$packet:=packetToSend($dataToSend; "end"; Form:C1466.transferInformation.currentPacket; Form:C1466.transferInformation.packetToTransfer)
				Form:C1466.receiver.sendPacket($packet)
				
				SET TIMER:C645(0)
				
			Else 
				SET TIMER:C645(0)
		End case 
End case 