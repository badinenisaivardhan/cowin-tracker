# cowin-tracker
Cowin Tracker Track The Distict Wise And Send Alert To Group/Channel Using Telegram BOT Using Powershell\
\
#####\
Step 1: Get Telegram Bot ID And Chat ID , For Reference Please Check Telegram Website Docs \
Step 2 : Add The Your Personal Chat ID To $chatid, And Your Telegram BotID To $botid. in Telegram Function Block\
Step 3 : Find The District Code From Cowin Website, In My Case Warangal-Urban Code is 610 and assign it to -DisID "Your District ID"\
Step 4 : Schedule It in A Widnows Server Using Task Scheduler, Run The Script For Every 5 mins\
Step 5 : Book Slot And Get Vaccinated..!!\
#####\
\
Note : The Default Code Give Us All Update Including Free,Paid, Covaxin, Covisheld, Sputnik V , Dose1 , Dose 2 Notifications\
\
If You Need Only Free Vaccine Update Then Add this line in if block:\
($response.centers[$i].sessions[$j].available_capacity -gt 0)-and($response.centers[$i].fee_type -ne 'Paid')\
\
![Capture](https://user-images.githubusercontent.com/24708206/121633390-57b52700-caa0-11eb-8a37-5f110977a07a.JPG)\
\
Stay Home .. Stay Safe

