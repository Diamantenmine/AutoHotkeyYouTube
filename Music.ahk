;Controll YouTube like a boss

#SingleInstance, Force
SetTitleMatchMode, 2
youTubeTabSelect := 0
return

Numpad7::youTubeTabSelect := 0
Numpad8::youTubeTabSelect := 1
Numpad9::youTubeTabSelect := 2

Numpad1::
i := 0
youTubeTabCounter := 0

ControlFocus, ahk_exe firefox.exe
ControlSend, ahk_parent, ^1, ahk_exe firefox.exe
Sleep, 100

Loop
{
	IfWinExist, YouTube
	{	
		if (youTubeTabCounter == youTubeTabSelect) {
			ControlSend, ahk_parent, k, ahk_exe firefox.exe
			break
		}
		youTubeTabCounter += 1
	}
	
	i += 1c
	if (i > 10){
		return
	}

	ControlFocus, ahk_exe firefox.exe
	ControlSend, ahk_parent, {Control Down}{Tab}{Control Up}, ahk_exe firefox.exe
	Sleep, 100
}

return