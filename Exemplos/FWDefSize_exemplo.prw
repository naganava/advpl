#include 'protheus.ch'
#include 'parmtype.ch'

user function FWDefSize_exemplo()

	oSize := FwDefSize():New(.T.)             
	oSize:AddObject( "CABECALHO",  100, 10, .T., .T. ) // Totalmente dimensionavel
	oSize:AddObject( "GETDADOS" ,  100, 85, .T., .T. ) // Totalmente dimensionavel 
	
	oSize:lProp 	:= .T. // Proporcional             
	oSize:aMargins 	:= { 3, 3, 3, 3 } // Espaco ao lado dos objetos 0, entre eles 3 
	
	oSize:Process() // Dispara os calculos 
	
	oDlg := MSDialog():New(oSize:aWindSize[1],oSize:aWindSize[2],oSize:aWindSize[3],oSize:aWindSize[4],"Teste de tela",,,,,CLR_BLACK,CLR_WHITE,,,.T.)
	
	oGrp1 := TGroup():New(	oSize:GetDimension("CABECALHO","LININI"),;
							oSize:GetDimension("CABECALHO","COLINI"),;
							oSize:GetDimension("CABECALHO","LINEND"),;
							oSize:GetDimension("CABECALHO","COLEND"),"Grupo 1",oDlg,,,.T.,)
	oGrp2 := TGroup():New(	oSize:GetDimension("GETDADOS","LININI"),;
							oSize:GetDimension("GETDADOS","COLINI"),;
							oSize:GetDimension("GETDADOS","LINEND"),;
							oSize:GetDimension("GETDADOS","COLEND"),"Grupo 2",oDlg,,,.T.,)
	oDlg:bInit := {||  EnchoiceBar(oDlg,{|| oDlg:End() },{|| oDlg:End() },,)}		
	
	oDlg:Activate()
return