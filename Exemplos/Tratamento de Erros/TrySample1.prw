User Function TrySample1()

//Salvando o bloco de erro do sistema e Atribuindo tratamento personalizado Local 
bError := ErrorBlock( { |oError| MyError( oError ) } )

BEGIN SEQUENCE

a := 0
a += 1
//a += 'a' //For�a o erro
 
 MsgInfo( " Caso der erro n�o devo apararecer, pois o erro est� acima de mim e o recover est� abaixo")
 
RECOVER
 //"Se ocorreu erro, ap�s o BREAK, venho para c�"
 MsgInfo( "Peguei o Desvio do BREAK" )
END SEQUENCE

MsgInfo( "Continuo ap�s o tratamento de erro" )

//Restaurando bloco de erro do sistema
ErrorBlock( bError )

Return( NIL )

Static Function MyError( oError )
MsgInfo( oError:Description , "Deu Erro" )
BREAK
Return( NIL )
