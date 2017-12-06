#include "rwmake.ch"
#include "tbiconn.ch"

//Exemplo tratamento de erro em rotinas automaticas
User Function GravaErro()

Local nX     := 0
Local nCount := 0   
Local aLog 	 := {}
Local aVetor := {}


PRIVATE lMsErroAuto := .F.// vari�vel que define que o help deve ser gravado no arquivo de log e que as informa��es est�o vindo � partir da rotina autom�tica.
Private lMsHelpAuto	:= .T.    // for�a a grava��o das informa��es de erro em array para manipula��o da grava��o ao inv�s de gravar direto no arquivo tempor�rio 
Private lAutoErrNoFile := .T. 
//+-------------------+
//| Teste de Inclusao |
//+-------------------+
	For nCount := 1 To 1
		alert(cValtochar(nCount))
		aVetor:= {{"B1_COD"     ,"99"+Alltrim(Str(nCount)),Nil},; 			 
		{"B1_DESC"    ,"Teste"        ,Nil},;			 
		{"B1_UM"      ,"UN"           ,Nil},; 			 
		{"B1_LOCPAD"  ,"01"           ,Nil}}   	
		lMsErroAuto := .F.    	
		MSExecAuto( {|x,y| MATA010(x, y) }, aVetor, 3 )	
		If lMsErroAuto		
			aLog := GetAutoGRLog()	                                 				                                                                  						
			For nX := 1 To Len(aLog)
				if 'HELP: OBRIGAT' $ UPPER(aLog[nX])
					alert('sou um erro de campo obrigatorio. trate-me')
				else
					alert(aLog[nX])
				endif		
			Next nX					
		EndIf
	Next
	

Return