#Arma 3 Server Notes#


##SERVER MANAGEMENT##

```
    #login < password > : Admin login
    #logout : Admin logout
    #lock : Lock server (Auto unlocks at end of mission)
    #unlock : Unlocks server
    #missions : Stops mission, reloads mission list
    #reassign : Moves all players from their unit selection slots back into the lobby
    #restart : returns the mission to the unit selection screen, with all players in their slots ansd restarts the mission
    #shutdown: shuts the server down
    #Init : Reloads file defined by -config command line parameter
```

###PLAYER MANAGEMENT###

```
    #userlist : Displays the list of users on the server (use pgup to scroll up)
    #kick < Server Player ID > (First entry for a player using #userlist)
    #kick < nickName > (Second entry for a player using #userlist
    #kick < Player UID > (Third entry for a player using #userlist)

    #exec kick < Server Player ID > (First entry for a player using #userlist)
    #exec kick < nickName > (Second entry for a player using #userlist
    #exec kick < Player UID > (Third entry for a player using #userlist)

    #exec ban < Server Player ID > (First entry for a player using #userlist)
    #exec ban < nickName > (Second entry for a player using #userlist
    #exec ban < Player UID > (Third entry for a player using #userlist)
```

###DEBUGGING###

```
    #monitor 10 : Activates the server monitor which reports Bandwidth and memory useage Every * seconds via chat window)
    #monitor 0 : Deactivates the server monitor
    #debug off : Deactivates debugging
    #debug 30 : Debug reporting interval (Default is 10 seconds
    #debug von
    #debug console
    #debug checkFile expansion\Dta\ui.pbo
    #debug userSent <username>
    #debug userInfo <username>
    #debug userQueue <username>
    #debug JIPQueue <username>
    #debug totalSent 10
  ```
