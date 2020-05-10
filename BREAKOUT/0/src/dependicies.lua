--This file contain all the dependicies that we need or our file to run!!

--requiring all the constants
require("src/constants")

push = require("lib/push")
Class = require("lib/class")

--initializing the state machine..
require("src/StateMachine")

--different states within the game
require("src/states/BaseState")
require("src/states/Play")
