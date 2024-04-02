:start
sc stop WaaSMedicSvc
sc stop wuauserv
sc config wuauserv obj= ".\Guest" password= ""
timeout 2
goto start