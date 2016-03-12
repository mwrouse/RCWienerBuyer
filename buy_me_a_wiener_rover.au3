#RequireAdmin
#pragma compile(Console, true)

#include <Date.au3>
#include <Inet.au3>
#include <IE.au3>
#Include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <Array.au3>

Global $twitter = "https://twitter.com/"
Global $account = "oscarmayer"

; Do a test account if it's not compiled
If Not @Compiled Then
  $account = "michaelwrouse"
EndIf

Global $URL = $twitter & $account
Global $TWEET_URL = $URL & "/status/" ; URL To get an individual tweet

main()


Func main()
   ConsoleWrite("Monitor For RC Wiener Rover" & @CRLF & @TAB & "By: Michael Rouse (Dec 2015)" & @CRLF & @CRLF)
   ConsoleWrite("Monitoring @" & $account & " for Fancy links" & @CRLF & @CRLF)
   ConLog("Program Started" & @CRLF)

   $lastTweet = ""

   while (true)
	  ; Get source of the page without any extra junk
	  $source = Strip(_INetGetSource($URL, True))

	  ; Use Regular Expressions to match the list of tweets
	  $tweets = StringRegExp($source, '<li(?:.*?)data-item-id="(.*?)"(?:.*?)data-item-type="tweet">', 3)

	  ; Check if tweets were found (in-case the HTML doesn't get downloaded or something)
	  If (IsArray($tweets)) Then
		 ; Mark the newest tweet available
		 $newestTweet = $tweets[0]

		 ; Check if the tweet is new
		 If ($newestTweet <> $lastTweet) Then
			If ($lastTweet <> "") Then
			   ; Get the the source of the permalink page for the tweet
			   $newSrc = Strip(_INetGetSource($TWEET_URL & $newestTweet, True))

			   ; Check if there is a fancy.com link in the tweet
			   If (StringRegExp($newSrc, 'data-expanded-url="https://fancy.com/things/(.*?)"') Or StringInStr($newSrc, 'data-expanded-url="https://fancy.com')) Then
				  ; New tweet is about the RC Wiener being for sale, FUCKING BUY IT!
				  ConLog("PRODUCT IS FOR SALE, initiating buying actions.")

				  ; SOUND THE ALARM!
				  SoundPlay(@ScriptDir & "/alarm.wav")

				  ; Disable user input
				  BlockInput(1)

				  ; Try and buy
				  Buy_RC_Wiener($newestTweet)

				  ConLog("Purchasing actions finished... Hopefully the purchases were good.")

				  ; Re-enable user input
				  BlockInput(0)

				  ExitLoop
			   Else
				  ; Not a tweet about the product
				  SoundPlay(@ScriptDir & "/tweet.mp3")
				  ConLog("New tweet detected, but not about the product being for sale.")
			   EndIf

			EndIf

			; Update the last tweet so it doesn't trigger again
			$lastTweet = $newestTweet
		 EndIf
	  EndIf
   WEnd

   ConLog(@CRLF & @CRLF & @CRLF & "The program is finished, press the Enter key to exit...")
   ConsoleWait()

EndFunc


Func Buy_RC_Wiener($id)
   ; Tweets with Fancy links have an iFrame, this is how you access that iFrame.
   $buy_url = "https://twitter.com/i/pay/status/"

   $oIE = _IECreate($buy_url & $id, 0)

   ; Find all the buttons on the page
   $btns = _IETagNameGetCollection($oIE, "button")

   For $btn in $btns
	  ; Look for the Buy now button
	  If ($btn.innerText == " Buy now " Or $btn.innerText == "Buy now") Then
		 ; Click it once (to buy now), not you must have paymenet and shipping info saved on Twitter already
		 _IEAction($btn, "click")
		 Sleep(500)

		 ; Click again to confirm the purchase
		 _IeAction($btn, "click")
		 Sleep(250)
		ExitLoop
	  EndIf
   Next
EndFunc

; Write a log message to the console
Func ConLog($msg)
   ConsoleWrite("[" & @YEAR& "-" & @MDAY & "-" & @MON & " " & @HOUR & ":" & @MIN & ":" & @SEC & "] " & $msg & @CRLF)
EndFunc

Func ConsoleWait()
   Do
   Until Not (ConsoleRead() == "")
EndFunc

