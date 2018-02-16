//Exemplo de tratamento de erro

User function TestError()
    // Salva bloco de código do tratamento de erro
    Local oError := ErrorBlock({|e| MsgAlert("Mensagem de Erro: " +chr(10)+ e)})
  
    cExpr := "aaa"
 
    If !Empty(cExpr)
        Begin Sequence    // Força erro, enviando caracter onde deveria ser numérico
	        cNum := StrZero(cExpr,5)
	        MsgAlert( cNum )
	        Return .T.
        End Sequence
    EndIf
 
    ErrorBlock(oError)
Return .F.