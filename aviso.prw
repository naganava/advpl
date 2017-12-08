#include "protheus.ch"

User Function teste_aviso()
Local cArq := "TESTE.TXT"
Local cTit:= "Atencao!"
Local aOp 	:= {}
Local cMsg 	:= ""
Local nOp
While .T.	
	If !File(cArq)	    
		aOp:= {"Sim","Nao","Cancela"}	    
		cMsg:= "O arquivo "+cArq+" n�o foi encontrado!�	    
		cMsg:= cMsg + " Tenta novamente?"	    
		nOp:= Aviso(cTit,cMsg,aOp)                   	    
		If nOp == 1 // Sim               	    	
			ApMsgAlert("Usu�rio tentando novamente")		    
			Loop	    
		ElseIf nOp == 3 // Cancela	    	
			ApMsgAlert("Usu�rio cancelou opera��o")	    	    	
			Return	    
		Else // Nao ou ESC                   	    	
			ApMsgAlert("Usu�rio n�o tentou novamente")	    	    	
			Exit	 	
		Endif	 
	Endif
End
	Return