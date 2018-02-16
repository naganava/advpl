#include 'protheus.ch'
#include 'parmtype.ch'

user function MSObjSize()
	//Primeiro pegamos o tamanho disponivel na tela com o comando MsAdvSize. 
	aSize := MsAdvSize(.T.) //lEnchoiceBar = Parametro logico, indica se a tela possui Enchoice Bar
	//Ele ira retornar uma array com os dados: 
	/*
	aSize = {	1=Linha inicial �rea trabalho,
				2=Coluna inicial �rea trabalho,
				3=Linha final �rea trabalho,
				4=Coluna final �rea trabalho,
				5=Coluna final dialog (janela),
				6=Linha final dialog (janela),
				7=Linha inicial dialog (janela) }*/
	
	//Agora montamos uma array com os elementos da tela:
	//Aonde devemos informar
	//AAdd( aObjects, { Tamanho X (horizontal) , Tamanho Y (vertical), Dimensiona X , Dimensiona Y, Retorna dimens�es X e Y ao inv�s de linha / coluna final } )
	aObjects := {}
	AAdd( aObjects, { 100 , 100, .T. , .T. , .F. } )
	AAdd( aObjects, { 100 , 100, .T. , .T. , .F. } )
	
	//Montamos a array com o valor da tela, aonde:
	//aInfo := { 1=Linha inicial, 2=Coluna Inicial, 3=Linha Final, 4=Coluna Final, Separa��o X, Separa��o Y, Separa��o X da borda (Opcional), Separa��o Y da borda (Opcional) }
	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 5 , 5 , 5 , 5 }
	
	//Passamos agora todas as informa��es para o calculo das dimen��es:
	//MsObjSize( aInfo, aObjects, Mantem Propor��o , Disposi��o Horizontal )
	aPosObj := MsObjSize( aInfo, aObjects, .T. , .F. )
	
	//Pronto ja temos uma array com todos os dados!!!
	
	//Exemplo do oDlg
	oDlg := MSDialog():New(aSize[7],aSize[1],aSize[6],aSize[5],"Teste de tela",,,,,CLR_BLACK,CLR_WHITE,,,.T.)
	
	oGrp1 := TGroup():New(aPosObj[1,1],aPosObj[1,2],aPosObj[1,3],aPosObj[1,4],"Grupo 1",oDlg,,,.T.,)
	oGrp2 := TGroup():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3],aPosObj[2,4],"Grupo 2",oDlg,,,.T.,)
	oDlg:bInit := {||  EnchoiceBar(oDlg,{|| oDlg:End() },{|| oDlg:End() },,)}		
	
	oDlg:Activate()
return