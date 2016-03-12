# RCWienerBuyer
The week of Nov. 30 - Dec 4th, 2015 Oscar Mayer was having a promotional sale of 15 RC Wiener Rovers (mini Wiener Mobiles) a day, for $25 on their [Twitter](https://twitter.com/oscarmayer).

For some reason I felt the need to have one.

But being a student, I didn't really have the time to sit and monitor their Twitter account all day long, and as a Computer Science major, of course I wrote a program to do it for me.

---
This program is actually version 3.0, previous versions use the Twitter API which I quickly realised was the wrong choice since they have a rate limit, and on Wednesday, Dec. 2nd, they had sold out in under 30 seconds. 

So I went to [AutoIT](https://www.autoitscript.com/site/autoit/) to easily scrape their Twitter page (not using the Twitter API) and detect when they tweeted the Fancy link.

On the very last day, this script bought me one! 
![Console Output on December 4th](https://raw.githubusercontent.com/mwrouse/RCWienerBuyer/master/result.png)

## Warning
If you run this, and your Twitter account is setup to be able to quickly purchase stuff, I am not responsible for whatever items this script may or may not automatically buy.
