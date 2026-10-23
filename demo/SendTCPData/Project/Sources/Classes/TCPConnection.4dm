property connection : 4D:C1709.TCPConnection
property url : Text
property port : Integer

Class constructor($url : Text; $port : Integer)
	This:C1470.connection:=Null:C1517
	This:C1470.url:=$url
	This:C1470.port:=$port
	
	
	// Connect to one of the servers launched inside workers
Function connect()
	This:C1470.connection:=4D:C1709.TCPConnection.new(This:C1470.url; This:C1470.port; This:C1470)
	
	
	// Disconnect from the server
Function disconnect()
	This:C1470.connection.shutdown()
	This:C1470.connection:=Null:C1517
	
Function sendPacket($blob : Blob)
	This:C1470.connection.send($blob)
	
	
	// Send data to the server
Function getInfo()
	var $blob : Blob
	
	TEXT TO BLOB:C554("Information"; $blob)
	This:C1470.connection.send($blob)
	
	
	// Callback called when the connection is successfully established
Function onConnection($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	ALERT:C41("Connection established")
	
	
	// Callback called when the connection is properly closed
Function onShutdown($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	ALERT:C41("Connection closed")
	
	
	// Callback called when receiving data from the server
Function onData($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	ALERT:C41(BLOB to text:C555($event.data; UTF8 text without length:K22:17))
	
	
	
	// Callback called when the connection is closed unexpectedly
Function onError($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	ALERT:C41("Connection error")
	
	
	// Callback called after onShutdown/onError just before the TCPConnection object is released
Function onTerminate($connection : 4D:C1709.TCPConnection; $event : 4D:C1709.TCPEvent)
	ALERT:C41("Connection terminated")