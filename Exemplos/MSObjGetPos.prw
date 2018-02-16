#include 'protheus.ch'
#include 'parmtype.ch'
#include "rwmake.ch"

#Define STR0069 "teste"
#Define STR0070 "teste"
#Define STR0076 "teste"
#Define STR0077 "teste"
#Define STR0078 "teste"
#Define STR0079 "teste"
#Define STR0081 "teste"
#Define STR0090 "teste"
#define DS_MODALFRAME 128

user function MSObjGetPos()
Local aSizeAut     := MsAdvSize(.T.,.F.,400) 
Local nOper := 1
Local cDir := 'c:/teste'
Local cVersao := 'versao_teste'
Local oChkSel := .F.
	aPosOri := {}
	aadd(aPosOri,{050,050,350,610})	//MSDialog
	aadd(aPosOri,{009,006,500,008})	//Say1
	aadd(aPosOri,{015,006,500,008})	//Say2
	aadd(aPosOri,{021,006,500,008})	//Say3
	aadd(aPosOri,{027,006,500,008})	//Checkbox
	aadd(aPosOri,{034,006})			//Listbox
	aadd(aPosOri,{014,140,040,040,040,270,110})//Campos Listbox
	
	aPosGet := MsObjGetPos(	aSizeAut[3]-aSizeAut[1]	, 305, aPosOri )
	
	DEFINE MSDIALOG oDlg TITLE IIf(nOper==1,STR0076,STR0077) From aSizeAut[7],aSizeAut[1] To aSizeAut[6],aSizeAut[5] PIXEL Style DS_MODALFRAME 
	
	DEFINE FONT oFont NAME "MS Sans Serif" SIZE 0, -9 BOLD
	
	@ aPosGet[2][1],aPosGet[2][2] SAY STR0078 SIZE aPosGet[2][3],aPosGet[2][4] OF oDlg PIXEL FONT oFont
	@ aPosGet[3][1],aPosGet[3][2] SAY STR0079+cDir SIZE aPosGet[3][3],aPosGet[3][4] OF oDlg PIXEL FONT oFont
	@ aPosGet[4][1],aPosGet[4][2] SAY STR0069 + cVersao + " / " + STR0090 + DTOC(STOD(STR(CFGX051_V(),8))) + ' ' +STR0070 + TCGetDB() SIZE aPosGet[4][3],aPosGet[4][4] OF oDlg PIXEL 
	
	@ aPosGet[5][1],aPosGet[5][2] CHECKBOX oChkSel PROMPT STR0081 SIZE aPosGet[5][3],aPosGet[5][4];
		OF oDlg PIXEL;
		ON CLICK (aEval(aSelProces, {|x| x[1] := oChkSel} ),;
		oProcess:Refresh())
	
	@ aPosGet[6][1],aPosGet[6][2] LISTBOX oProcess FIELDS HEADER " ", "Descrição do processo", "Código do processo", "Nome do pacote" FIELDSIZES aPosGet[7][1],aPosGet[7][2],aPosGet[7][3],aPosGet[7][4] SIZE aPosGet[7][6],aPosGet[7][7] PIXEL OF oDlg ;
	  ON DBLCLICK ( If( aSelProces[oProcess:nAt,1] == .T. , aSelProces[oProcess:nAt,1] := .F. , ;
	                    aSelProces[oProcess:nAt,1] := .T. ) , oProcess:Refresh() )
	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg, {||  oDlg:End()},{|| oDlg:End()}))
return