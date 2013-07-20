;RGUI-like AutoHotKey macros for copying code from Notepad++ to Julia console for REPL-oriented development
;   control-F5 will select the current line of text in Notepad++
;   control-F6 pastes the clipboard contents into the Julia console, presses <Enter>
;              then re-activates Notepad++ and moves the cursor down a line.
 
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;
; # = windows key
; ^ = control 
; ! = alt
; + = shift 
 
;select and copy current line in Notepad++, which is assumed to be the active window
^f5::
Send,{Home}+{End}^c
return
 
;copy clipboard to julia console
; then re-activate Notepad++ and move the cursor down to support stepping through
^f6::
Send,^c
WinGetActiveTitle, InitTitle
IfWinExist, julia.bat
{
	WinActivate
	; MouseMove, 60, 60
	; MouseClick, Right
	send !{SPACE}EP
	Send,{Enter}
    	if RegExMatch(InitTitle, "- Notepad\+\+$")
	{
		WinActivate,%InitTitle%
		Send,{Down}
	}
}
else
    MsgBox Julia console not found.
return