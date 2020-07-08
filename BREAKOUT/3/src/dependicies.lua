--This file contain all the dependicies that we need or our file to run!!

--requiring all the constants
require("src/constants")

push = require("lib/push")
Class = require("lib/class")

--initializing the state machine..
require("src/StateMachine")

--including the quad
require("src/Util")

require("src/Paddle")

require("src/Ball")

require("src/Brick")

require("src/LevelMaker")
--different states within the game
require("src/states/BaseState")
require("src/states/StartState")
require("src/states/PlayState")
