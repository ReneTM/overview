

::fontTestString <- "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 _!#$%&'()*+,-./\\:;~<=>?[]{}|^@\""

::CharDigTable <-
{
	A =	"01111110,00000101,00000101,00000101,01111110", a = "00100000,01010100,01010100,01010100,01111000",
	B = "01111111,01000101,01000101,01000101,00111010", b = "01111111,01001000,01000100,01000100,00111000",
	C = "00111110,01000001,01000001,01000001,00100010", c = "00111000,01000100,01000100,01000100,00101000",
	D = "01111111,01000001,01000001,01000001,00111110", d = "00111000,01000100,01000100,01001000,01111111",
	E = "01111111,01000101,01000101,01000001,01000001", e = "00111000,01010100,01010100,01010100,01011000",
	F = "01111111,00000101,00000101,00000001,00000001", f = "00000100,01111110,00000101,00000101",
	G = "00111110,01000001,01000101,01000101,00111101", g = "10011000,10100100,10100100,10100100,01111100",
	H = "01111111,00000100,00000100,00000100,01111111", h = "01111111,00001000,00000100,00000100,01111000",
	I = "01000001,01111111,01000001", i = "01111101",	
	J = "00100000,01000000,01000000,01000000,00111111", j = "01100000,10000000,10000000,10000000,01111101",
	K = "01111111,00000100,00000100,00001010,01110001", k = "01111111,00010000,00101000,01000100",
	L = "01111111,01000000,01000000,01000000,01000000", l = "00111111,010000000",	
	M = "01111111,00000010,00000100,00000010,01111111", m = "01111100,00000100,00011000,00000100,01111000",
	N = "01111111,00000010,00000100,00001000,01111111", n = "01111100,00000100,00000100,00000100,01111000",
	O = "00111110,01000001,01000001,01000001,00111110", o = "00111000,01000100,01000100,01000100,00111000",
	P = "01111111,00000101,00000101,00000101,00000010", p = "11111100,00101000,00100100,00100100,00011000",
	Q = "00111110,01000001,01000001,00100001,01011110", q = "00011000,00100100,00100100,00101000,11111100",
	R = "01111111,00000101,00000101,00000101,01111010", r = "01111100,00001000,00000100,00000100,00001000",
	S = "00100010,01000101,01000101,01000101,00111001", s = "01001000,01010100,01010100,01010100,00100100",
	T = "00000001,00000001,01111111,00000001,00000001", t = "00000010,00111111,01000010",	
	U = "00111111,01000000,01000000,01000000,00111111", u = "00111100,01000000,01000000,01000000,01111100",
	V = "00001111,00110000,01000000,00110000,00001111", v = "00011100,00100000,01000000,00100000,00011100",
	W = "01111111,00100000,00010000,00100000,01111111", w = "00111100,01000000,01110000,01000000,01111100",
	X = "01110001,00001010,00000100,00001010,01110001", x = "01000100,00101000,00010000,00101000,01000100",
	Y = "00000001,00000010,01111100,00000010,00000001", y = "10011100,10100000,10100000,10100000,01111100",
	Z = "01100001,01010001,01001001,01000101,01000011", z = "01000100,01100100,01010100,01001100,01000100",
}

CharDigTable["0"] <- "00111110,01010001,01001001,01000101,00111110" 
CharDigTable["1"] <- "01000000,01000010,01111111,01000000,01000000"
CharDigTable["2"] <- "01100010,01010001,01001001,01001001,01000110"
CharDigTable["3"] <- "00100010,01000001,01001001,01001001,00110110"
CharDigTable["4"] <- "00011000,00010100,00010010,00010001,01111111"
CharDigTable["5"] <- "00100111,01000101,01000101,01000101,00111001"
CharDigTable["6"] <- "00111100,01001010,01001001,01001001,00110000"
CharDigTable["7"] <- "00000011,00000001,01110001,00001001,00000111"
CharDigTable["8"] <- "00110110,01001001,01001001,01001001,00110110"
CharDigTable["9"] <- "00000110,01001001,01001001,00101001,00011110"
CharDigTable[" "] <- "00000000,00000000,00000000"
CharDigTable["_"] <- "10000000,10000000,10000000,10000000,10000000"
CharDigTable["!"] <- "01011111"
CharDigTable["#"] <- "00010100,01111111,00010100,01111111,00010100"
CharDigTable["$"] <- "00100100,00101010,01101011,00101010,00010010"
CharDigTable["%"] <- "01000011,00110000,00001000,00000110,01100001"
CharDigTable["&"] <- "00110000,01001010,01011101,00110010,01001000"
CharDigTable["'"] <- "00000011"
CharDigTable["("] <- "00011100,00100010,01000001,01000001"
CharDigTable[")"] <- "01000001,01000001,00100010,00011100"
CharDigTable["*"] <- "00000101,00000010,00000010,00000101"
CharDigTable["+"] <- "00010000,00010000,01111100,00010000,00010000"
CharDigTable[","] <- "11100000"
CharDigTable["-"] <- "00010000,00010000,00010000,00010000,00010000"
CharDigTable["."] <- "01100000"
CharDigTable["/"] <- "01000000,00110000,00001000,00000110,00000001"
CharDigTable["\\"] <- "00000001,00000110,00001000,00110000,01000000"
CharDigTable[":"] <- "01100110"
CharDigTable[";"] <- "11100110"
CharDigTable["~"] <- "00000010,00000001,00000001,00000010,00000010,00000001"
CharDigTable["<"] <- "00001000,00010100,00100010,01000001"
CharDigTable["="] <- "00100100,00100100,00100100,00100100,00100100"
CharDigTable[">"] <- "01000001,00100010,00010100,00001000"
CharDigTable["?"] <- "00000010,00000001,01010001,00001001,00000110"
CharDigTable["["] <- "01111111,01000001,01000001"
CharDigTable["]"] <- "01000001,01000001,01111111"
CharDigTable["{"] <- "00001000,00110110,01000001,01000001"
CharDigTable["}"] <- "01000001,01000001,00110110,00001000"
CharDigTable["|"] <- "11111111"
CharDigTable["^"] <- "00000100,00000010,00000001,00000010,00000100"
CharDigTable["@"] <- "00111110,01000001,01011101,01011101,01010001,01011110"
CharDigTable["\""] <- "00000011,00000000,00000011"




//------- INITIAL STATES OF VALUES -------

::boxPos <- Vector(0,0,0)

::cubecolor <- Vector(25,35,44)

::debugBoxSize <- 1

::DebugBoxUp <- function(){
	boxPos += Vector(0, debugBoxSize * 2 ,0)
}

::DebugBoxDown <- function(){
	boxPos += Vector(0,-(debugBoxSize * 2) ,0)
}


::DebugBoxRight <- function(){
	boxPos += Vector(debugBoxSize * 2,0,0)
}

::DebugBoxLeft <- function(){
	boxPos += Vector(-(debugBoxSize * 2),0,0)
}



::DebugBoxNewChar <- function(){
	boxPos += Vector(0,-(debugBoxSize * 2) * 8,0)
}






::isASCI <- function(arr){
	local ASCIArray = [
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"0","1","2","3","4","5","6","7","8","9",
		"!","#","$","%","&","'","(",")","*","+",",","-",".","/",":",";","<","=",">","?","@",
		"\"","[","\\","]","^","_","{","|","}","~","DEL","SPACER"," "
	]

	foreach(val in arr){
		if (ASCIArray.find(val) == null){
			return false	
		}
	}
	return true
}




::WriteText <- function(pos, message){

	local lines = split(message, "\n")
	
	
	//--------------------------------------------
	
	local longestline = ""
	
	if(lines.len() > 0){
		for(local i = 0; i < lines.len(); i++){
			if(lines[i].len() > longestline.len()){
				longestline = lines[i]
			}
		}
	}
	
	ClientPrint(null, 5, "" + longestline)
	
	local width = 0
	foreach(str in longestline){
		width += (split(CharDigTable[str.tochar()], ",").len() * debugBoxSize)
	}
	
	//--------------------------------------------
	

	local letterHeight = ((debugBoxSize * 2) * 8)
	
	local doTransCubes = false

	local lineDistance = letterHeight * 2

	boxPos = pos
	//--------------------------------------------
	boxPos.x -= width
	boxPos.y += (lines.len()  * letterHeight) / 2
	//--------------------------------------------
	local startedAt = boxPos

	local textContainerArray = []

	for(local line = 0; line < lines.len(); line++){
		
		local chatString = lines[line]
		local chatStringlen = chatString.len()
		textContainerArray.clear()
	
		for(local i=0; i<chatStringlen; i++){
			
			if(chatString.slice(i, i + 1) == " "){
				
				textContainerArray.append("SPACER")
			
			}else{
				
				textContainerArray.append(chatString.slice(i, i + 1))
			
			}
		}
		
		if(isASCI(textContainerArray)){
			
			if(chatStringlen <= 96){
				
				for(local k = 0; k < chatStringlen; k++){
					
					local Letter = chatString.slice(k, k + 1)

					local LetterArray = split(CharDigTable[Letter.tostring()], ",")
					
					local LetterCollumns = LetterArray.len()
					
					for(local collumn= 0; collumn < LetterCollumns; collumn++){
						
						for (local cube=0; cube < 8; cube++){
							
							if(LetterArray[collumn].slice(cube, cube + 1) == "1"){
								// Colored Box
								DebugDrawBoxAngles(boxPos, Vector(debugBoxSize, debugBoxSize, debugBoxSize), Vector(-debugBoxSize, -debugBoxSize, -debugBoxSize), QAngle(0,0,0), cubecolor, 255, 9999.0)
								
								DebugBoxUp()
							}else{
								if(doTransCubes){
									// Black box (Zeros)
									DebugDrawBoxAngles(boxPos, Vector(debugBoxSize, debugBoxSize, debugBoxSize), Vector(-debugBoxSize, -debugBoxSize, -debugBoxSize), QAngle(0,0,0), Vector(0,0,0), 200, 9999.0)
								}
								DebugBoxUp()
							}
						} 
						DebugBoxRight()
						DebugBoxNewChar()
					
					}
					
					// White space
					for(local i=0; i<8; i++){
						if (doTransCubes){
							DebugDrawBoxAngles(boxPos, Vector(debugBoxSize, debugBoxSize, debugBoxSize), Vector(-debugBoxSize, -debugBoxSize, -debugBoxSize), QAngle(0,0,0), Vector(0,0,0), 200, 9999.0)
						}
						DebugBoxUp()
					}
					DebugBoxRight()
					DebugBoxNewChar()
				}
			}
			else{
				ClientPrint(null, 5, BLUE + "Character maximum is 96. We should not try to melt your pc.")
				SendToConsole("play ui/beep_error01.wav")
			}
		}else{
			ClientPrint(null, 5, BLUE + "Entered text contains forbidden characters")
			SendToConsole("play ui/beep_error01.wav")
		}	

		if(line > 0){
			lineDistance += ( letterHeight * 2 ) 
		}

		boxPos = Vector(startedAt.x, startedAt.y-lineDistance, startedAt.z)

	}
}

