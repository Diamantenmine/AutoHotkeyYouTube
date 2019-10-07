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
Numpad7::
youTubeTabSelect := 0
return
Numpad8::
youTubeTabSelect := 1
return
Numpad9::
youTubeTabSelect := 2
return

Numpad1::
sendKeyToYt("k")
return
Numpad2::
sendKeyToYt("j")
return
Numpad3::
sendKeyToYt("l")
return
Numpad4::
sendKeyToYt("{Up}")
return
Numpad6::
sendKeyToYt("{Down}")
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
		if (i > 10){
			return
		}
	
		ControlSend, Chrome_RenderWidgetHostHWND1, {Control Down}{Tab}{Control Up}, Google Chrome
		Sleep, 100
	}
}