#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CHROME := " - Google Chrome"

^!w::
	WinGetActiveTitle, title
	charsBeforeChrome := StrLen(title) - StrLen(CHROME)
	if (InStr(title, CHROME, true, (charsBeforeChrome + 1)) = (charsBeforeChrome + 1))
	{
		title := SubStr(title, 1, charsBeforeChrome)
	}
	Clipboard = %title%
return