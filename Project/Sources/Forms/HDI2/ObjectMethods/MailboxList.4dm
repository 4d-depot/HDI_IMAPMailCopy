Case of 
	: (FORM Event:C1606.code=On Selection Change:K2:29)
		
		StartReceiving
		
	: (FORM Event:C1606.code=On Drop:K2:12)
		If (Form:C1466.trace)
			TRACE:C157
		End if 
		If (Form:C1466.mails.length>0)
			var $destinationMailbox; $status : Object
			var $ids : Collection
			
			// search the box information of the destination box
			$destinationMailbox:=FindDestinationMailBox
			
			// ids of the email to copy
			$ids:=Form:C1466.mails.extract("id")
			
			If ($destinationMailbox#Null:C1517)
				If (Form:C1466.copy)
					// copy emails from selected mailbox to destination mailbox
					$status:=Form:C1466.transporter.copy($ids; $destinationMailbox.name)
				Else 
					// move emails from selected mailbox to destination mailbox
					$status:=Form:C1466.transporter.move($ids; $destinationMailbox.name)
					//  update the email of the selected mailbox
					StartReceiving
				End if 
				
				If (Not:C34($status.success))
					ALERT:C41($status.statusText)
				End if 
				
			End if 
		End if 
End case 