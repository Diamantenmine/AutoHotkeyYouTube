;Controll YouTube and YouTube Music like a boss
;Author: Luca (Diamantenmine)

;Play,pause 1
;Volumen+ 6
;Volumen- 4
;Skip x
;Go back -
;+10S 2
;-10S 3
;like +
;dislike /

#SingleInstance, Force
#NoEnv
SetTitleMatchMode, 2
SendMode Input
youTubeTabSelect := 0
lastTabName := ""
lastTabNumber := ""
return

;--------Keybindings--------;
;Without ctrl
Numpad7::
NumpadHome::
youTubeTabSelect := 0
return
Numpad8::
NumpadUp::
youTubeTabSelect := 1
return
Numpad9::
NumpadPgUp::
youTubeTabSelect := 2
return

;Pause, play
Numpad1::
NumpadEnd::
sendKey("k", "{Space}")
return

;Volumen+
Numpad4::
NumpadLeft::
sendKey("{Up}", "+0")
return

;Volumen-
Numpad6::
NumpadRight::
sendKey("{Down}", "-")
return

;skip
NumpadMult::
sendKey("+n", "+n")
return

;go back
NumpadSub::
sendKey("+p", "+p")
return

;+10s
Numpad2::
NumpadDown::
sendKey("l", "l")
return

;-10s
Numpad3::
NumpadPgDn::
sendKey("j", "h")
return


;With ctrl
^Numpad1::
^NumpadEnd::
youTubeTabSelect := 0
return
^Numpad2::
^NumpadDown::
youTubeTabSelect := 1
return
^Numpad3::
^NumpadPgDn::
youTubeTabSelect := 2
return
^Numpad4::
^NumpadLeft::
youTubeTabSelect := 3
return
^Numpad5::
^NumpadClear::
youTubeTabSelect := 4
^Numpad6::
^NumpadRight::
youTubeTabSelect := 5
return
^Numpad7::
^NumpadHome::
youTubeTabSelect := 6
return
^Numpad8::
^NumpadUp::
youTubeTabSelect := 7
return
^Numpad9::
^NumpadPgUp::
youTubeTabSelect := 8
return

;--------Functions--------;
sendKey(keyYT,keyYTMusic)
{
	if findYouTubeTab() {
		IfWinExist, YouTube Music
		{
			sendKeyYouTube(keyYTMusic)
		} else {
			sendKeyYouTube(keyYT)	
		}
	}
}

sendKeyYouTube(key){
	ControlSend, Chrome_RenderWidgetHostHWND1, %key%, Google Chrome
}

findYouTubeTab()
{
	i := 0
	id := 0
	youTubeTabCounter := 0
	global youTubeTabSelect
	global lastTabName
	global lastTabNumber

	ControlGet, id, Hwnd,,Chrome_RenderWidgetHostHWND1, Google Chrome
	ControlFocus,,ahk_id %id%

	WinGetTitle, tmpTabName, Google Chrome
	if (youTubeTabSelect == lastTabNumber and tmpTabName == lastTabName) {
		return true
	}


	ControlSend,, ^1, Google Chrome
	
	Sleep, 100
	
	Loop
	{
		IfWinExist, YouTube
		{	
			if (youTubeTabCounter == youTubeTabSelect) {
				WinGetTitle, lastTabName, Google Chrome
				lastTabNumber := youTubeTabSelect

				return true
			}
			youTubeTabCounter += 1
		}
		
		i += 1
		if (i > 20){
			return false
		}
	
		ControlSend, Chrome_RenderWidgetHostHWND1, {Control Down}{Tab}{Control Up}, Google Chrome
		Sleep, 100
	}
}