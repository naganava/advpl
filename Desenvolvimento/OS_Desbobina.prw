#include 'protheus.ch'
#include 'parmtype.ch'
#include 'topconn.ch'


//--------------------------------------------------------------
/*/{Protheus.doc} TPCP003
@Description Tela para gerar ordem de servi�o de desbobinamento

@author  Felipe Naganava
@since 11/04/2018
/*/
//--------------------------------------------------------------
user function TPCP003()
Local aVar := {'3030 New','3020', '3030', 'Puncionadeira','Estoque'}
Private n := 1
Private nPosLotCTL := 12

Private oGetDados
Private aCols	:= {}
Private aHeader
Private oDlg

Private cOP		:= Space(6)	
Private cProd	:= Space(15)
Private cBobina	:= Space(15)
Private cDesc	:= Space(150)
Private cLote	:= Space(30)
Private cAgrup  := Space(9)
Private nQtde1  := 0
Private cUn1    := Space(2)
Private nQtde2  := 0
Private cUn2	:= Space(2)
Private dDtIni	:= cTod('')
Private dDtFim	:= cTod('')
Private cMaq	:= Space(13)
Private cLoc	:= Space(2)
Private cOper 	:= Space(10)


	cQuery := "select max(c2_num) as op from sc2010 where c2_num like 'B%' and d_e_l_e_t_ = ' ' and length(trim(c2_num)) = 6"
	cQuery := ChangeQuery(cQuery)
	TCQUERY cQuery NEW ALIAS 'OP'
	cOP := Soma1(OP->OP)
	DbCloseArea('OP')
	
	aSize 	:= MsAdvSize(.F.) //Pega o tamanho da tela
	oFont 	:= TFont():New('Courier new',,-26,.T.)

	aHeader := {}
    aAlter  := {'LARG','COMP','PESO','QUANT'}
	//Monta o cabe�alho da msNewGetDados
	aAdd(aHeader,{'Quant.'	,'QUANT'	,PesqPict("SH6","H6_QTDPRO2")	,004 ,0 ,,,'N',,})
	aAdd(aHeader,{'Larg.'	,'LARG' 	,PesqPict("SH6","H6_ULARG")		,004 ,2 ,,,'C',,})
	aAdd(aHeader,{'Comp.'	,'COMP'	 	,PesqPict("SH6","H6_UCOMP")		,004 ,2 ,,,'C',,})
	aAdd(aHeader,{'Peso'	,'PESO'	 	,PesqPict("SH6","H6_QTDPROD")	,004 ,0 ,,,'N',,})
	
	
	oDlg := MSDialog():New(0,0,440,426,"O.S. Desbobinar",,,,,CLR_BLACK,CLR_WHITE,,,.T.)
	
	oTGet01 := TGet():New( 001,005,{||cOP}	,oDlg,050,009,"@!",{||},0,,,,,.T.,,,{|| .F.} ,,,,.F.,,,"cOP",,,,,,,'N�mero OP',1 )

   
	oTGet02 := TGet():New( 021,005,{|u| if(PCount()>0,cProd:=u,cProd)},oDlg,050,009,PesqPict("SB1","B1_COD"),;
	{|| valida_produto()},;
	0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,"SB1","cProd",,,,,,,'Produto',1 )
	
	oTGet03 := TGet():New( 021,060,{|u| if(PCount()>0,cDesc:=u,cDesc)},oDlg,150,009,"@!",{||},0,,,,,.T.,,,{|| .F.} ,,,,.F.,,,"cDesc",,,,,,,'Desc. Prod',1 )
	
	oTGet12 := TGet():New( 041,005,{|u| if(PCount()>0,cBobina:=u,cBobina)},oDlg,050,009,PesqPict("SB1","B1_COD"),{|| },;
	0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,"SB1","cBobina",,,,,,,'Bobina',1 )
	
	oTGet04 := TGet():New( 041,060,{|u| if(PCount()>0,cLote:=u,cLote)}	,oDlg,90,009,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,"cLote",,,,,,,'Lote',1 )
	oTGet05 := TGet():New( 041,165,{|u| if(PCount()>0,cAgrup:=u,cAgrup)},oDlg,040,009,"@!",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,"cAgrup",,,,,,,'Agrupamento',1 )
	oTGet06 := TGet():New( 061,005,{|u|if(PCount()>0,nQtde1:=u,nQtde1)},oDlg,050,009,PesqPict("SC2","C2_QUANT"),{||},0,,,,,.T.,,,{|| .T.} ,,,,.F.,,,"nQtde1",,,,,,,'Peso',1,,,,.T. )
	oTGet07 := TGet():New( 061,060,{||cUn1}	,oDlg,025,009,"@!",{||},0,,,,,.T.,,,{|| .F.} ,,,,.F.,,,"cUn1",,,,,,,'Un',1 )
	oTGet08 := TGet():New( 061,090,{|u|if(PCount()>0,nQtde2:=u,nQtde2)},oDlg,050,009,PesqPict("SC2","C2_QTSEGUM"),{||},0,,,,,.T.,,,{|| .T.} ,,,,.F.,,,"nQtde2",,,,,,,'Qtde',1,,,,.T. )
	oTGet09 := TGet():New( 061,145,{||cUn2}	,oDlg,025,009,"@!",{||},0,,,,,.T.,,,{|| .F.} ,,,,.F.,,,"cUn2",,,,,,,'Un',1 )
	oTGet10 := TGet():New( 081,005,{|u|if(PCount()>0,dDtIni:=u,dDtIni)},oDlg,050,009,PesqPict("SC2","C2_DATPRI"),{||},0,,,,,.T.,,,{|| .T.} ,,,,.F.,,,"dDtIni",,,,,,,'Dt. Inicio',1,,,,.T. )
	oTGet11 := TGet():New( 081,060,{|u|if(PCount()>0,dDtFim:=u,dDtFim)},oDlg,050,009,PesqPict("SC2","C2_DATPRF"),{||},0,,,,,.T.,,,{|| .T.} ,,,,.F.,,,"dDtFim",,,,,,,'Dt. Fim',1,,,,.T. )
	oTGet13 := TGet():New( 101,005,{|u|if(PCount()>0,cOper:=u,cOper)},oDlg,105,009,,{||},0,,,,,.T.,,,{|| .T.} ,,,,.F.,,,"cOper",,,,,,,'Operador',1,,,,.T. )
	oCbx1	:= TComboBox():New(101,115,bSetGet(cMaq),aVar,072,010, oDlg,,,,,,.T.,,,,,,,,,,'M�quina',1)
	
	oGetDados	:=	MsNewGetDados():New(121,005,200,210,;
					GD_INSERT + GD_UPDATE + GD_DELETE,,,,aAlter,0,,,,{|| },oDlg,;
					aHeader,aCols,,,)
	
	oTButton1 := TButton():New(048,150, "?" ,oDlg,{|| lote()} , 7,11,,,.F.,.T.,.F.,,.F.,,,.F. )
    oTButton2 := TButton():New(205,190, "Salvar" ,oDlg,{|| salva()} , 20,14,,,.F.,.T.,.F.,,.F.,,,.F. )
    
    
	ACTIVATE MSDIALOG oDlg CENTERED
	
return

Static Function lote()
Local oError := ErrorBlock({|e| })

	Begin Sequence 
		F4Lote(,,,"MATA465",cBobina,'06',,,1) //Abre a tela de pesquisa de lote
	End Sequence
	ErrorBlock(oError)
Return

Static Function valida_produto()
Local lRet := .T.
	if !Empty(cDesc:=Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC"))
		cUn1:=Posicione("SB1",1,xFilial("SB1")+cProd,"B1_UM")
		cUn2:=Posicione("SB1",1,xFilial("SB1")+cProd,"B1_SEGUM")
		cLoc:=Posicione("SB1",1,xFilial("SB1")+cProd,"B1_LOCPAD")
	endif
Return lret

Static Function salva()
	if valida_chapas()
		gera_op()//gera op
		gera_empenho()//gera empenho
		aponta_op()//aponta op
		oDlg:end()
	endif
Return

Static Function valida_chapas()
Local lRet := .T.
	//valida se o peso e a quantidade de chapas bate com o peso total e a quantidade total.
	
	pesoTot := 0
	qtdTot	:= 0
	for i := 1 to len(oGetDados:aCols)
		pesoTot += oGetDados:aCols[i,1] * oGetDados:aCols[i,4] 
		qtdTot += oGetDados:aCols[i,1]
	Next i
	
	if pesoTot <> nQtde1 .or. qtdTot <> nQtde2
		alert('A quantidade/peso total n�o bate com as chapas')
		lRet := .F.
	endif
Return lRet


Static Function gera_op()
Local lMsErroAuto := .F.
Local lMsHelpAuto 	:= .F.
Local aMata650 := {}
Local lREt := .T.

	aAdd(aMata650, {"C2_FILIAL" , xFilial("SC2") 	,Nil})
	aAdd(aMata650, {"C2_ITEM" 	, "01"   			,Nil})
	aAdd(aMata650, {"C2_NUM" 	, cOp    			,Nil})
	aAdd(aMata650, {"C2_SEQUEN" , "001" 			,Nil})
	aAdd(aMata650, {"C2_PRODUTO", cProd 			,NIL})
	aAdd(aMata650, {"C2_LOCAL" 	, cLoc 				,Nil})
	aAdd(aMata650, {"C2_QUANT" 	, nQtde1			,NIL})
	aAdd(aMata650, {"C2_UM" 	, cUn1 				,Nil})
	aAdd(aMata650, {"C2_QTSEGUM", nQtde2			,Nil})
	aAdd(aMata650, {"C2_SEGUM"	, cUn2				,Nil})
	aAdd(aMata650, {"C2_DATPRI" , dDtIni	 		,NIL})
	aAdd(aMata650, {"C2_DATPRF" , dDtFim	 		,NIL})
	aAdd(aMata650, {"C2_OBS" 	, cAgrup			,Nil})
	aAdd(aMata650, {"C2_EMISSAO", dDataBase		 	,Nil})
	aAdd(aMata650, {"C2_STATUS" , "N" 				,Nil})
	aAdd(aMata650, {"AUTEXPLODE", "S" 				,NIL}) // definir se as OP's intermedi�rias e as solicita��es de compras que ainda n�o foram geradas devem ser geradas automaticamente ou n�o.

					
	msExecAuto({|x,Y| Mata650(x,Y)},aMata650,3)		
	
	IF lMsErroAuto
		Alert("Erro ao gerar op")
		MostraErro()
	Endif	
return lRet

//Gerar empenho com mata380
Static Function gera_empenho()
Local lMsErroAuto 	:= .F.
Local lMsHelpAuto 	:= .F.
Local aMata380 		:= {}
Local aEmpen		:= {}
Local dtvalid := Posicione('SB8',7,xFilial('SB8')+PadR(cProd,15,' ')+cLote,'B8_DTVALID')
Local lRet := .T.
	
	aMata380:={   	{"D4_COD"     ,PadR(cProd,15,' ')	,Nil},; //COM O TAMANHO EXATO DO CAMPO
		            {"D4_LOCAL"   ,cLoc				    ,Nil},;
		            {"D4_OP"      ,cOp+'01001'  		,Nil},;
		            {"D4_QTDEORI" ,nQtde1				,Nil},;
		            {"D4_QUANT"   ,nQtde1				,Nil},;
		            {"D4_TRT"     ,"001"            	,Nil},;
		            {"D4_LOTECTL" ,PadR(cLote,30,' ')	,Nil},;
		            {"D4_QTSEGUM" ,0					,Nil}}
		            
	AADD(aEmpen,{	nQtde1	,;	// SD4->D4_QUANT
					""		,;	// DC_LOCALIZ
					""		,;	// DC_NUMSERI
					nQtde2	,;	// D4_QTSEGUM
					.F.		})
	            
	MSExecAuto({|x,y,z| mata380(x,y,z)},aMata380,3,aEmpen) 
	 
	If lMsErroAuto
	    Alert("Erro ao empenhar")
	    MostraErro()
	EndIf
return

//Apontar com mata681
Static Function aponta_op()
Local lMsErroAuto 	:= .F.
Local lMsHelpAuto 	:= .F.
	
	if len(oGetDados:aCols) = 1
		TP := 'T'
	else
		TP := 'P'
	endif

	If cMaq = '3030 New'
		maquina := '1'
	elseif cMaq = '3020'
		maquina := '2'
	elseif cMaq = '3030'
		maquina := '3'
	elseif cMaq = 'Puncionadeira'
		maquina := '5'
	elseif cMaq = 'Estoque'
		maquina := '4'
	endif
	for i := 1 to len(oGetDados:aCols)
		cLarg := oGetDados:acols[i,2]
		cComp := oGetDados:acols[i,3]
		aVetor := { {"H6_OP"		,cOp+'01001'								,NIL},;
					{"H6_PRODUTO"	,cProd										,NIL},;
					{"H6_OPERAC" 	,'01' 										,NIL},;
					{"H6_RECURSO"	,'D1008'		    						,NIL},;
					{"H6_DTAPONT"	,dDataBase     								,NIL},;
					{"H6_DATAINI"	,dDtIni										,NIL},;
					{"H6_DATAFIN"	,dDtFim										,NIL},;
					{"H6_PT"     	,TP 										,NIL},;
					{"H6_LOCAL"  	,cLoc		 								,NIL},;
					{"H6_QTDPROD"	,oGetDados[i,1] * oGetDados[i,4]			,NIL},; 
					{"H6_QTDPROD2"	,oGetDados[i,1]								,NIL},; 
					{"H6_ULARG"		,cLarg										,NIL},; 
					{"H6_UCOMP"		,cComp										,NIL},;
					{"H6_LOTECTL"	,'L'+cLarg+' C'+cComp+'OP'+substr(cOP,1,6)	,NIL},; 
					{"H6_OBSERVA"	,cAgrup										,NIL},; 
					{"H6_UMAQUI"	,maquina									,NIL},; 
					{"H6_OPERADO"	,cOper										,NIL},; 
					{"H6_QTDPERD"	,0  										,NIL}}
	
		MSExecAuto({|x| mata681(x)},aVetor)			
		
		If lMsErroAuto
			ALERT ('Apontamento n�o processado.')
			Mostraerro()
		endif
	next i
return



