Case of 
	: (FORM Event:C1606.code=On Clicked:K2:4)
		Form:C1466.transferInformation.transfer:=True:C214
		
		Form:C1466.transferInformation.packetToTransfer:=Form:C1466.data.length\Form:C1466.limit
		
		If (Form:C1466.data.length%Form:C1466.limit>0)
			Form:C1466.transferInformation.packetToTransfer:=Form:C1466.transferInformation.packetToTransfer+1
		End if 
		
		SET TIMER:C645(-1)
End case 