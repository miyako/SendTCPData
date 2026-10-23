//%attributes = {}
#DECLARE($data : Collection; $kind : Text; $current : Integer; $total : Integer)->$blobPacket : Blob

var $packet : Object

$packet:=New object:C1471(\
"info"; New object:C1471("kind"; $kind; "current"; $current; "total"; $total); \
"data"; $data\
)

TEXT TO BLOB:C554(JSON Stringify:C1217($packet); $blobPacket)

