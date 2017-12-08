User Function TrySample1()

//Salvando o bloco de erro do sistema e Atribuindo tratamento personalizado Local 
bError := ErrorBlock( { |oError| MyError( oError ) } )

BEGIN SEQUENCE

a := 0
a += 1
//a += 'a' //Força o erro
 
 MsgInfo( " Caso der erro não devo apararecer, pois o erro está acima de mim e o recover está abaixo")
 
RECOVER
 //"Se ocorreu erro, após o BREAK, venho para cá"
 MsgInfo( "Peguei o Desvio do BREAK" )
END SEQUENCE

MsgInfo( "Continuo após o tratamento de erro" )

//Restaurando bloco de erro do sistema
ErrorBlock( bError )

Return( NIL )

Static Function MyError( oError )
MsgInfo( oError:Description , "Deu Erro" )
BREAK
Return( NIL )
