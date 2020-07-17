

*R

/*setwd("/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85")

library(foreign)

base_1<-read.spss ("Enaho01B-2019-1.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_1, file="base1.dta")

base_2<-read.spss ("Enaho01B-2019-2.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_2, file="base2.dta")

list.files()
*/

*Stata

clear

use "/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85/base1.dta"


*Domine: Region

gen region=1				if UBIGEO>=1 & UBIGEO<=51

replace region=2			if UBIGEO>=52 & UBIGEO<=128

replace region=3			if UBIGEO>=129 & UBIGEO<=187

replace region=4			if UBIGEO>=188 & UBIGEO<=252

replace region=5			if UBIGEO>=253 & UBIGEO<=325

replace region=6			if UBIGEO>=326 & UBIGEO<=404

replace region=7			if UBIGEO>=405 & UBIGEO<=411

replace region=8	        if UBIGEO>=412 & UBIGEO<=487

replace region=9			if UBIGEO>=488 & UBIGEO<=552

replace region=10			if UBIGEO>=553 & UBIGEO<=617

replace region=11 			if UBIGEO>=618 & UBIGEO<=654

replace region=12 	        if UBIGEO>=655 & UBIGEO<=728

replace region=13 		    if UBIGEO>=729 & UBIGEO<=789

replace region=14			if UBIGEO>=790 & UBIGEO<=825

replace region=15		    if UBIGEO>=826 & UBIGEO<=935

replace region=16           if UBIGEO>=934 & UBIGEO<=977

replace region=17			if UBIGEO>=978 & UBIGEO<=988

replace region=18		    if UBIGEO>=989 & UBIGEO<=1007

replace region=19			if UBIGEO>=1008 & UBIGEO<=1035

replace region=20 			if UBIGEO>=1036 & UBIGEO<=1086

replace region=21 	        if UBIGEO>=1087 & UBIGEO<=1153

replace region= 22 			if UBIGEO>=1154 & UBIGEO<=1212

replace region=23 			if UBIGEO>=1213 & UBIGEO<=1232

replace region=24 			if UBIGEO>=1233 & UBIGEO<=1245

replace region=25			if UBIGEO>=1246 & UBIGEO<=1259


label variable region "regiones" /*seting nd execution labes variable*/


*#delimit ;						/*seting label values*/

label define regiones ///
///
1 "AMAZONAS" 	2 "ÁNCASH"  ///
3 "APURÍMAC" 	4 "AREQUIPA" ///
5 "AYACUCHO" 	6 "CAJAMARCA" ///
7 "CALLAO" ///
8 "CUSCO" 	    9 "HUANCAVELICA" ///
10 "HUÁNUCO" 	11 "ICA" ///
12 "JUNÍN"   	13 "LA LIBERTAD" ///
14 "LAMBAYEQUE" 15 "LIMA" ///
16 "LORETO"  	17 "MADRE DE DIOS" ///
18 "MOQUEGUA"   19 "PASCO" ///
20 "PIURA"   	21 "PUNO" ///
22 "SAN MARTIN"  23 "TACNA" ///
24 "TUMBES"  	25 "UCAYALI"
*;

label values region regiones   /*execution label values*/


* Argument: Social Trust

global num 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21

foreach i of global num {

	gen d_`i' 			= (P1_`i'==3 | P1_`i'==4)
	
	replace d_`i' 		= .  if P1_`i'==5 
	
	replace d_`i' 		= .  if P1_`i'==. 
}


*Function: mean

collapse (mean) d_* [iw=FAMIEGOB07], by (region)

*Labels
rename d_01 JNE

rename d_02 ONPE

rename d_03 RENIEC

rename d_04 Municipio_Provincial

rename d_05 Municipio_Distrital

rename d_06 PNP

rename d_07 FFAA

rename d_08 Gobierno_Nacional

rename d_09 Poder_Judicial

rename d_10 MINEDU_centros_educativos

rename d_11 Defensoría_Pueblo

rename d_12 Congreso

rename d_13 Partidos_Políticos

rename d_14 Prensa_Escrita

rename d_15 Radio_Televisión

rename d_16 Iglesia_Católica

rename d_17 Procuradoría_Anticorrupción

rename d_18 Fiscalía

rename d_19 Contraloría

rename d_20 SUNAT

rename d_21 Comisión_Anticorrupción

*Graphs:

global var1 RENIEC Iglesia_Católica  MINEDU_centros_educativos FFAA Radio_Televisión JNE Poder_Judicial Gobierno_Nacional Congreso Partidos_Políticos


*Graph 1

#delimit ;

graph hbar $var1 

if region>=1 & region<=12, by(region, note("Fuente: Módulo 5-ENAHO 2019 (repuesta múltiple).") caption (Repositorio:https://github.com/VicenteSotelo/Social_trust, size(*0.75) ) title("Índice de confianza en las organizaciones") )

legend( label (1 "RENIEC") label (2 "Iglesia_Católica") label(3 "MINEDU (centros_educativos)")  label(4 "FFAA") label (5 "Radio_Televisión") label(6 "JNE") 

			label( 7 "Poder_Judicial") label(8 "Gobierno_Nacional") label (9 "Congreso") label (10 "Partidos_Políticos") 

	size(vsmall) cols(7) rowgap(0.5) colgap(0.5) symysize(2) symxsize(2) )
;


*Graph 2

#delimit ;

graph hbar $var1 

if region>=13 & region<=25, by(region, note("Fuente: Módulo 5-ENAHO 2019 (repuesta múltiple).") caption (Repositorio:https://github.com/VicenteSotelo/Social_trust, size(*0.75) ) title("Índice de confianza en las organizaciones") )

legend( label (1 "RENIEC") label (2 "Iglesia_Católica") label(3 "MINEDU (centros_educativos)")  label(4 "FFAA") label (5 "Radio_Televisión") label(6 "JNE") 

			label( 7 "Poder_Judicial") label(8 "Gobierno_Nacional") label (9 "Congreso") label (10 "Partidos_Políticos") 

	size(vsmall) cols(7) rowgap(0.5) colgap(0.5) symysize(2) symxsize(2) )
;
















