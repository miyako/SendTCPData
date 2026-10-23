//%attributes = {}
#DECLARE($params : Object)

var $title : Text:="Sender"
var $window : Integer

If (Count parameters=0)
	
	// already open? bring it to the front instead of opening a duplicate
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	var $i : Integer
	For ($i; 1; Size of array($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$title)
			var $left; $top; $right; $bottom : Integer
			GET WINDOW RECT($left; $top; $right; $bottom; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($left; $top; $right; $bottom; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER:C1389(1; Current method name; {})
	
Else 
	
	SET MENU BAR(1)
	$window:=Open form window:C675("Sender"; Plain form window:K39:10; 200; 200; *)
	SET WINDOW TITLE($title; $window)
	DIALOG:C40("Sender"; $params; *)
	
End if 
