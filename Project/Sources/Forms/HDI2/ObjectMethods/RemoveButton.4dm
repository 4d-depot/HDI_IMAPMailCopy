If (Form:C1466.mails.length>0)
	var $status : Object
	var $ids : Collection
	
	If (Form:C1466.trace)
		TRACE:C157
	End if 
	
	// ids of the email to delete
	$ids:=Form:C1466.mails.extract("id")
	
	// set the \deleted flag for these messages. They will be deleted when the session will close
	$status:=Form:C1466.transporter.delete($ids)
	
	If ($status.success)
		// If the 4D version is 18r6 or above, replace the close and open session by Form.transporter.expunge( ) 
		// Close the session. It force the deletion of the emails
		Form:C1466.transporter:=Null:C1517
		// Open the session. 
		Form:C1466.transporter:=IMAP New transporter:C1723(Form:C1466.IMAP)
		//  download the email of the selected mailbox
		StartReceiving
	Else 
		ALERT:C41($status.statusText)
	End if 
	
End if 