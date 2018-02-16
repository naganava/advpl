#Include 'Topconn.ch'

User Function baixa_inox()
Local ExpA1 := {}
Local ExpN2 := 3
Local cTPMovimento 	:= "504"
Local nQtd 	   		:= 10
Local nQtd2 		:= 10
Local cProd	   		:= ""
Local cUnidade  	:= ""
Local cUn2		    := ""
Local cArmazem     	:= ""
Local dEmissao     	:= ""
Local cLoteCtl		:= ""
Local n := 0

PRIVATE lMsErroAuto := .F.          
	
	cQuery := "select B8_PRODUTO, B8_SALDO, B8_SALDO2, B8_LOTECTL "
	cQuery += "from sb8010 SB8 inner join sb1010 on b8_produto = b1_cod and b1_desc like '%INOX%RETALHO%' "
	cQuery += "WHERE B8_SALDO <> 0 AND SB8.D_E_L_E_T_ = ' ' and b8_data < '20180126'"
	cQuery := ChangeQuery(cQuery)
	TCQUERY cQuery NEW ALIAS 'TMP'
	DbSelectArea('TMP')
	DbGoTop()

	While !eof()
		lMsErroAuto := .F.
		cProd := TMP->B8_PRODUTO
		nQtd := TMP->B8_SALDO
		cLoteCTL := TMP->B8_lotectl
		nQtd2 := TMP->B8_SALDO2
		dbSelectArea("SB1")
		dbSetOrder(1)
		dbSeek(xFilial("SB1")+cProd)
		cProd := B1_COD
		cUnidade := Posicione("SB1",1,xFilial("SB1")+cProd,"B1_UM")
		cUn2	 := Posicione("SB1",1,xFilial("SB1")+cProd,"B1_SEGUM")
		cArmazem := Posicione("SB1",1,xFilial("SB1")+cProd,"B1_LOCPAD")
		dEmissao := dDataBase
		
	
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//| Teste de Inclusao                                            |
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸   
		Begin Transaction   	
			ExpA1 := {} 		
			aadd(ExpA1,{"D3_TM",cTPMovimento,NIL})	
			aadd(ExpA1,{"D3_COD",cProd,NIL})	
			aadd(ExpA1,{"D3_UM",cUnidade,NIL})	
			aadd(ExpA1,{"D3_SEGUM",cUn2,NIL})			
			aadd(ExpA1,{"D3_LOCAL",'04',NIL})	
			aadd(ExpA1,{"D3_QUANT",nQtd,NIL})	
			aadd(ExpA1,{"D3_QTSEGUM",nQtd2,NIL})	
			aadd(ExpA1,{"D3_EMISSAO",dEmissao,NIL})
			aadd(ExpA1,{"D3_LOTECTL",cLotectl,NIL})
			aadd(ExpA1,{"D3_EMISSAO",dEmissao,NIL})
			aadd(EXpA1,{"D3_UCODPRO",'AUTO_C',NIL})		        
			
			MSExecAuto({|x,y| mata240(x,y)},ExpA1,ExpN2)		
			
			If lMsErroAuto		
				mostraerro()
			EndIf		         
		End Transaction
		n += 1
		TMP->(DbSkip())
	enddo
	alert('Finalizado')
Return Nil