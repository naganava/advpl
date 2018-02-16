#include "Totvs.ch"

User Function tGetCss()
 Local cNome := Space(100) //Irei declarar uma vari�vel chamada cNome do tipo string para o meu campo nome
 Local cEstiloNom := "" //Irei declarer uma variavel chamada cEstiloNom do tipo string para inserir meu estilo
 
 //Irei criar uma janela
 DEFINE DIALOG oDlg TITLE "Usando estilos CSS no Protheus" FROM 180,180 TO 550,700 PIXEL
 
 /*Para funcionar, � preciso utilizar a classe QLineEdit ele ser� respons�vel para o correto desenvolvimento do estilo que ser� utilizado no meu objeto.
 Para quem j� conhece CSS, ver� que � exatamente o mesmo c�digo utilizado para uma p�gina web.
 A apresenta��o de imagens nos objetos criados podem ser resgatados de dentro do reposit�rio (RPO), exemplificando ficaria assim: (rpo:imagemqueexistenorepositorio.png)
 */
 
 cEstiloNom := "QLineEdit{ border: 1px solid gray;border-radius: 5px;background-color: #ffffff;selection-background-color: #ffffff;" 
 cEstiloNom += "background-image:url(rpo:responsa.png); "
 cEstiloNom += "background-repeat: no-repeat;"
 cEstiloNom += "background-attachment: fixed;"
 cEstiloNom += "padding-left:25px; "
 cEstiloNom += "}"
 
 /*Agora criamos o nosso objeto tGet normalmente*/
 oNome := TGet():New( 01,10,{|| cNome },oDlg,200,011,"",,0,,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F.,,"cNome",,,,,,,"Nome: ",1 )
 
 /*Neste momento, para definirmos o estilo, usaremos a propriedade SetCss, no qual informaremos a ela a variavel que cont�m o estilo que criamos anteriormente.*/
 oNome:SetCss(cEstiloNom)
 
 //Irei utilizar a classe QPushButton, ela � respons�vel em criar a formata��o do bot�o. 
    cEstilo1 := "QPushButton {"  
    //Usando a propriedade background-image, inserimos a imagem que ser� utilizada, a imagem pode ser pega pelo reposit�rio (RPO)
    cEstilo1 += " background-image: url(rpo:totvsprinter_spool.png);background-repeat: none; margin: 2px;" 
    cEstilo1 += " border-style: outset;"
    cEstilo1 += " border-width: 2px;"
    cEstilo1 += " border: 1px solid #C0C0C0;"
    cEstilo1 += " border-radius: 5px;"
    cEstilo1 += " border-color: #C0C0C0;"
    cEstilo1 += " font: bold 12px Arial;"
    cEstilo1 += " padding: 6px;"
    cEstilo1 += "}"
 
    //Na classe QPushButton:pressed , temos o efeito pressed, onde ao se pressionar o bot�o ele muda
    cEstilo1 += "QPushButton:pressed {"
    cEstilo1 += " background-color: #e6e6f9;"
    cEstilo1 += " border-style: inset;"
    cEstilo1 += "}"
 
    cEstilo2 := "QPushButton {background-image: url(rpo:totvsprinter_pdf.png);background-repeat: none; margin: 2px; "
    cEstilo2 += " border-style: outset;"
    cEstilo2 += " border-width: 2px;"
    cEstilo2 += " border: 1px solid #C0C0C0;"
    cEstilo2 += " border-radius: 0px;"
    cEstilo2 += " border-color: #C0C0C0;"
    cEstilo2 += " font: bold 12px Arial;"
    cEstilo2 += " padding: 6px;"
    cEstilo2 += "}"
    cEstilo2 += "QPushButton:pressed {"
    cEstilo2 += " background-color: #e6e6f9;"
    cEstilo2 += " border-style: inset;"
    cEstilo2 += "}"
 
    cEstilo3 := "QPushButton {background-image: url(rpo:totvsprinter_email.png);background-repeat: none; margin: 2px;}"
 
    //Cria-se os botoes normalmente, para mais detalhes das op��es do bot�o acesse o TDN (http://tdn.totvs.com/display/tec/TButton)
    //O espa�o entre a primeira aspa e o texto do bot�o, � necess�rio pois � neste espa�o que a imagem entra
    oBtnImprimir := TButton():New(50,010,"      Imprimir"	,oDlg,{|| Alert('Bot�o Imprimir com efeito') },50,20,,,.F.,.T.,.F.,,.F.,,,.F. )
    oBtnPDF   	 := TButton():New(50,070,"       Gerar PDF"	,oDlg,{|| Alert('Bot�o Gerar PDF com efeito') },60,20,,,.F.,.T.,.F.,,.F.,,,.F. )
    oBtnEmail    := TButton():New(50,140,"     Enviar E-mail" 	,oDlg,{|| Alert('Bot�o Enviar E-mail com efeito') },60,20,,,.F.,.T.,.F.,,.F.,,,.F. )
 
    /*Neste momento, para definirmos o estilo, usaremos a propriedade SetCss, no qual informaremos a ela a variavel que cont�m o estilo que criamos anteriormente.*/
    oBtnImprimir:SetCss(cEstilo1) 
    oBtnPDF:SetCss(cEstilo2) 
    oBtnEmail:SetCss(cEstilo3) 

 //Finalizamos a janela
 ACTIVATE DIALOG oDlg CENTERED

Return //Finalizamos o programa