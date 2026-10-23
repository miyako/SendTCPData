Case of 
	: (FORM Event:C1606.code=On Clicked:K2:4)
		Form:C1466.receiver:=cs:C1710.TCPConnection.new("localhost"; 19820)
		
		Form:C1466.receiver.connect()
End case 