;Controll YouTube like a boss
;Author: Luca (Diamantenmine)

#SingleInstance, Force
#NoEnv
SetTitleMatchMode, 2
SendMode Input
SetWorkingDir %A_ScriptDir%
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

Numpad1::
NumpadEnd::
sendKeyToYt("k")
return
Numpad2::
NumpadDown::
sendKeyToYt("j")
return
Numpad3::
NumpadPgDn::
sendKeyToYt("l")
return
Numpad4::
NumpadLeft::
sendKeyToYt("{Up}")
return
Numpad6::
NumpadRight::
sendKeyToYt("{Down}")
return
NumpadDiv::
sendKeyToYt("+p")
return
NumpadMult::
sendKeyToYt("+n")
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
sendKeyToYt(key)
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
		ControlSend, Chrome_RenderWidgetHostHWND1, %key%, Google Chrome
		return
	}


	ControlSend,, ^1, Google Chrome
	
	Sleep, 100
	
	Loop
	{
		IfWinExist, YouTube
		{	
			if (youTubeTabCounter == youTubeTabSelect) {
				ControlSend, Chrome_RenderWidgetHostHWND1, %key%, Google Chrome

				WinGetTitle, lastTabName, Google Chrome
				lastTabNumber := youTubeTabSelect

				return
			}
			youTubeTabCounter += 1
		}
		
		i += 1
		if (i > 20){
			return
		}
	
		ControlSend, Chrome_RenderWidgetHostHWND1, {Control Down}{Tab}{Control Up}, Google Chrome
		Sleep, 100
	}
}