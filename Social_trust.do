

#R

setwd("/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85")

library(foreign)

base_1<-read.spss ("Enaho01B-2019-1.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_1, file="base1.dta")

base_2<-read.spss ("Enaho01B-2019-2.sav", use.value.labels=TRUE, to.data.frame=TRUE)
write.dta(base_2, file="base2.dta")

list.files()

*Stata

clear

use "/Users/luisvicentesotelofarfan/Google Drive/III.ComponenteProfesional/Repo/ENAHO/2019/687-Modulo85/base1.dta"


*Domine: Region


gen region="AMAZONAS" 				if UBIGEO>=1 & UBIGEO<=51

replace region="ANCASH" 			if UBIGEO>=52 & UBIGEO<=128

replace region="APURIMAC" 			if UBIGEO>=129 & UBIGEO<=187

replace region="AREQUIPA" 			if UBIGEO>=188 & UBIGEO<=252

replace region="AYACUCHO" 			if UBIGEO>=253 & UBIGEO<=325

replace region="CAJAMARCA" 			if UBIGEO>=326 & UBIGEO<=404

replace region="CALLAO" 			    if UBIGEO>=405 & UBIGEO<=411

replace region="CUSCO" 	    		if UBIGEO>=412 & UBIGEO<=487

replace region="HUANCAVELICA" 			if UBIGEO>=488 & UBIGEO<=552

replace region="HUANUCO" 			    if UBIGEO>=553 & UBIGEO<=617

replace region="ICA" 			    if UBIGEO>=618 & UBIGEO<=654

replace region="JUNIN" 	    if UBIGEO>=655 & UBIGEO<=728

replace region="LA LIBERTAD" 		if UBIGEO>=729 & UBIGEO<=789

replace region="LAMBAYEQUE" 			    if UBIGEO>=790 & UBIGEO<=825

replace region="LIMA" 			if UBIGEO>=826 & UBIGEO<=935

replace region="LORETO"      if UBIGEO>=934 & UBIGEO<=977

replace region="MADRE DE DIOS" 			if UBIGEO>=978 & UBIGEO<=988

replace region="MOQUEGUA" 			    if UBIGEO>=989 & UBIGEO<=1007

replace region="PASCO" 			    if UBIGEO>=1008 & UBIGEO<=1035

replace region="PIURA" 			    if UBIGEO>=1036 & UBIGEO<=1086

replace region="PUNO" 	    if UBIGEO>=1087 & UBIGEO<=1153

replace region="SAN MARTIN" 			    if UBIGEO>=1154 & UBIGEO<=1212

replace region="TACNA" 			if UBIGEO>=1213 & UBIGEO<=1232

replace region="TUMBES" 			if UBIGEO>=1233 & UBIGEO<=1245

replace region="UCAYALI" 			if UBIGEO>=1246 & UBIGEO<=1259




* Argument: Social Trust

foreach p in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 {

	gen d_`p' = (P1_`p'==3 | P1_`p'==4)
	
	replace d_`p' = .  if P1_`p'==5 
	
	replace d_`p' = .  if P1_`p'==. 
}

*Function: mean

collapse (mean) d_* [iw=FAMIEGOB07], by (region)

*Lables
rename d_01 JNE

rename d_02 ONPE

rename d_03 RENIEC

rename d_04 Prov

rename d_05 Dist

rename d_06 PNP

rename d_07 FFAA

rename d_08 Nac

rename d_09 PJ

rename d_10 MINEDU

rename d_11 Defens

rename d_12 Congreso

rename d_13 Partidos

rename d_14 Prensa_Escrita

rename d_15 Radio_Televisión

rename d_16 Iglesia_Católica

rename d_17 Procuradoría

rename d_18 Fiscalía

rename d_19 Contraloría

rename d_20 SUNAT

rename d_21 Comisión_Anticorrupción

*Graphs

global var JNE ONPE RENIEC Prov Dist PNP FFAA Nac PJ  MINEDU Defens  Congreso Partidos Prensa_Escrita Radio_Televisión Iglesia_Católica Procuradoría Fiscalía Contraloría SUNAT Comisión_Anticorrupción

foreach x of global var {
graph hbar `x', by(region)
}

graph hbar RENIEC Prov Dist Nac Defens Iglesia_Católica, by(region)





