//Exemplo de tratamento de erro

User function TestError()
    // Salva bloco de c�digo do tratamento de erro
    Local oError := ErrorBlock({|e| MsgAlert("Mensagem de Erro: " +chr(10)+ e)})
  
    cExpr := "aaa"
 
    If !Empty(cExpr)
        Begin Sequence    // For�a erro, enviando caracter onde deveria ser num�rico
	        cNum := StrZero(cExpr,5)
	        MsgAlert( cNum )
	        Return .T.
        End Sequence
    EndIf
 
    ErrorBlock(oError)
Return .F.