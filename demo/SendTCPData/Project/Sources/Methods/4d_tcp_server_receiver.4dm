//%attributes = {}
var $status : Integer
var $tcpID : Integer
var $data : Blob
var $blob : Blob
var $close : Boolean:=False:C215
var $activated : Boolean:=False:C215
var $receivedPackets : Collection
var $err : Integer
var $p : Integer:=Progress New
var $packet_js : Object
Repeat 
	Progress SET TITLE($p; Localized string("Progress_WaitingForConnection"); -1)
	
	$err:=TCP_Listen("localhost"; 0; 19820; 0; $tcpID)
	
	$err:=TCP_State($tcpID; $status)
	
	Progress SET TITLE($p; Localized string("Progress_WaitingForPackets"); -1)
	
	If ($status=8)
		DELAY PROCESS:C323(Current process:C322(); 2)
		
		Repeat 
			$err:=TCP_ReceiveBLOB($tcpID; $data)
			$err:=TCP_State($tcpID; $status)
			
			If (BLOB size:C605($data)#0)
				$packet_js:=JSON Parse:C1218(BLOB to text:C555($data; 0))
				
				Case of 
					: ($packet_js.info.kind="start")
						Progress SET TITLE($p; Localized string("Progress_StartReceiving"); -1)
						$receivedPackets:=New collection:C1472()
						
						
					: ($packet_js.info.kind="inProgress")
						$receivedPackets.combine($packet_js.data)
						
						Progress SET TITLE($p; Localized string("Progress_ReceivingPackets"); -1)
						Progress SET PROGRESS($p; $packet_js.info.current/$packet_js.info.total; String:C10($packet_js.info.current)+" /"+String:C10($packet_js.info.total))
						
					: ($packet_js.info.kind="end")
						Progress SET PROGRESS($p; -1)
						Progress SET TITLE($p; Localized string("Progress_EndReceiving"); -1)
						
						var $form : Object:=New object:C1471()
						
						If (Is Windows:C1573)
							$form.packetReceived:=$receivedPackets.join(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40))
						Else 
							$form.packetReceived:=$receivedPackets.join(Char:C90(Line feed:K15:40))
							
							
						End if 
						
						var $winRef : Integer
						$winRef:=Open form window:C675("Receiver"; Plain form window:K39:10; 1600; 200; *)
						DIALOG:C40("Receiver"; $form)
						CLOSE WINDOW:C154($winRef)
						TCP_Close($tcpID)
				End case 
				
			End if 
			
		Until (($status=0) | ($err#0))
		
		
	End if 
	TCP_Close($tcpID)
	Progress QUIT($p)
	HIDE PROCESS:C324(Current process:C322)
Until (False:C215)

