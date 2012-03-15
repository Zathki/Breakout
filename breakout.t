%By: Alex Kidd
import GUI

setscreen ("graphics:800:600")
setscreen ("nocursor")
randomize

colorback (7)
color (grey)
cls

%Player 1
var x : int := 270
var x2 : int := 50
var xsize : int := 80

var x4 : int := 270
var x5 : int := 50

%1P or 2P
var player : int := 1
var player1, player2 : int

%Replay
var replay : string (1)

%Determines If Player has Started Balls Moving
var start : int := 1

%Determines if Level is Boss Level
var boss : int := 0
var boss1 : int := 5
var boss2 : int := 10 %Face must be destroyed last
var boss3 : int := 15 %Twice the Health
var boss4 : int := 20 %Regeneration
var boss5 : int := 25 %Everything and Fast Regeneration

%Regeneration Check
var regenerate : int := 0
var regenerated : int := 0

%Ball
var ballnum : int := 1
var ballcount : int := 1
var ballcount2 : string
var x3 : flexible array 1 .. ballnum of int
x3 (1) := x + 38
var y3 : flexible array 1 .. ballnum of int
y3 (1) := 33
var ball : flexible array 1 .. ballnum of int

%Ball Randomize
var randx : flexible array 1 .. ballnum of int
var randy : flexible array 1 .. ballnum of int
randx (1) := 0
randy (1) := 0

%Ball Change
var xchange : flexible array 1 .. ballnum of int
var ychange : flexible array 1 .. ballnum of int
xchange (1) := 0
ychange (1) := 0
var ballsize : int := 3
var bcol : int := 14

%Determines if Key is Pressed
var chars : array char of boolean

%Determines If User Wants Help
var help : string (1)

%Determines if Key is Pressed after Winning the Game
var null : string (1)

%Points
var points : int := 0
var points2 : string := '0'
var points3 : int := 50
var points4 : string

%Level
var level : int := 1
var level2 : string := '1'

%Different Fonts
var font1, font2, font3 : int
font1 := Font.New ("sans serif:24:bold")
font2 := Font.New ("sans serif:10:bold")
font3 := Font.New ("sans serif:40:bold")

%Lives
var lives : int := 5
var lives2 : string := '5'

%Variable for Drawing Blocks
var a : int := 70
var b : int := 325

%Variable For Redrawing Random Block
var z : int := 0

%Determines whether there is a block or not
var space : int := 0

%How many blocks are drawn
var blocknum : int := 1

var block : flexible array 1 .. blocknum of int
var block2 : flexible array 1 .. blocknum of int
var block3 : array 1 .. 56 of int
var block4 : array 1 .. 56 of int
var col : flexible array 1 .. blocknum of int
var blockchange : int := 1
var blockchange2 : int := 1

%Blocks Left Counter
var blockleft : int
var blockleft2 : string

%Slider Bar
var scrollbar : int
var scrollbar2 : int

%Text Box
var textbox : int

%Speed
var speed : int := 5
var speed2 : string := '5'

%When to Create Extra Ball
var extraball : int := 50
var extraball2 : string

%Powerups
var poweruptotal : int := 5
var poweruptotal2 : string
poweruptotal2 := intstr (poweruptotal)
var powerup : string := 'ball'
var pblock : int := 0
var drawpblock : int := 50
var usepowerup : int := 5
var poweroff : int := 0
var power : int := 0
var slowswitch : int := 50

%Open Codes
var opencodes := 0

procedure singleplayer
    GUI.Quit
    player := 1
end singleplayer
procedure multiplayer
    GUI.Quit
    player := 2
end multiplayer

procedure SpeedBar (speed3 : int)
    speed2 := intstr (speed3)
    speed := speed3
    drawfillbox (130, 230, 230, 260, brightgreen)
    Font.Draw ("Speed:", 130, 230, font2, black)
    Font.Draw (speed2, 200, 230, font2, black)
end SpeedBar

procedure ExtraBallBar (extraball3 : int)
    extraball2 := intstr (extraball3)
    extraball := extraball3
    drawfillbox (90, 150, 305, 180, brightgreen)
    Font.Draw ("Points Needed For Extra Ball:", 90, 150, font2, black)
    Font.Draw (extraball2, 285, 150, font2, black)
    points3 := extraball
end ExtraBallBar

procedure LivesBar (lives3 : int)
    lives2 := intstr (lives3)
    lives := lives3
    drawfillbox (430, 230, 530, 260, brightgreen)
    Font.Draw ("Lives:", 430, 230, font2, black)
    Font.Draw (lives2, 500, 230, font2, black)
end LivesBar

procedure LevelBar (level3 : int)
    level := level3
    level2 := intstr (level3)
    drawfillbox (420, 150, 530, 180, brightgreen)
    Font.Draw ("Level:", 420, 150, font2, black)
    Font.Draw (level2, 500, 150, font2, black)
end LevelBar

procedure EnterCode (code : string)
    opencodes := 0
    if code = "Balls Everywhere" or code = "balls everywhere" then
	Font.Draw ("Code Activated", 260, 280, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (100, 70, 150, 1, 100, 50, ExtraBallBar, 1, 1, 1)
	GUI.Hide (scrollbar2)
	Font.Draw ("Secret Extra Ball Setting!!!", 100, 100, font2, black)
    end if
    if code = "I Hate This Level" or code = "i hate this level" then
	Font.Draw ("Code Activated", 260, 280, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (400, 100, 150, 1, 100, 1, LevelBar, 1, 1, 1)
	Font.Draw ("Secret Level Selector!!!", 410, 130, font2, black)
	Font.Draw ("Level:", 420, 150, font2, black)
	Font.Draw ("1", 500, 150, font2, black)
    end if
    if code = "Super Power" or code = "super power" and player = 1 then
	Font.Draw ("Code Activate", 260, 280, font2, black)
	poweruptotal := 999999
	poweruptotal2 := intstr (poweruptotal)
    end if
    GUI.Dispose (textbox)
    drawfillbox (215, 320, 450, 340, brightgreen)
end EnterCode

loop
    loop
	cls
	Font.Draw ("Breakout", 205, 250, font3, brightred)     %Title
	locate (12, 35)
	put "Version 5.0"
	locate (13, 34)
	put "By: Alex Kidd"
	locate (23, 34)
	put "Press H for Help."
	locate (24, 27)
	put "Press any other Key to Continue"
	getch (help)
	if help = 'h' or help = 'H' then
	    cls
	    Font.Draw ("Breakout", 240, maxy - 22, font1, brightred)     %Title
	    Font.Draw ("Help", 275, maxy - 57, font1, brightred)
	    locate (6, 6)
	    put "Controls:" ..
	    locate (7, 10)
	    put "Player 1 Uses Left and Right Arrows."
	    locate (8, 10)
	    put "Press Up to Release Ball(s)."
	    locate (24, 30)
	    put "Press any Key to Continue"
	    getch (null)
	end if
	exit when help not= 'h' and help not= 'H'
    end loop

    cls
    GUI.SetBackgroundColor (brightgreen)
    Font.Draw ("Breakout", 205, 350, font3, black)             %Title
    player1 := GUI.CreateButton (160, 300, 0, "1 Player", singleplayer)
    player2 := GUI.CreateButton (400, 300, 0, "2 Player", multiplayer)

    loop
	exit when GUI.ProcessEvent
    end loop
    GUI.Hide (player1)
    GUI.Hide (player2)
    GUI.ResetQuit
    if player = 1 then
	Font.Draw ("1 PLAYER", 280, 387, font2, black)
	Font.Draw ("Points Needed For Extra Ball:", 90, 150, font2, black)
	Font.Draw ("Select 100 To Never Get An Extra Ball.", 80, 130, font2, black)
	Font.Draw ('50', 285, 150, font2, black)
	scrollbar2 := GUI.CreateHorizontalScrollBarFull (100, 100, 150, 20, 100, 50, ExtraBallBar, 5, 5, 1)

	Font.Draw ("Speed:", 130, 230, font2, black)
	Font.Draw ('5', 200, 230, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (100, 200, 150, 0, 20, 5, SpeedBar, 1, 1, 1)

	Font.Draw ("Lives:", 430, 230, font2, black)
	Font.Draw ('5', 500, 230, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (400, 200, 150, 1, 100, 5, LivesBar, 5, 5, 1)

	var quitButton : int := GUI.CreateButton (280, 10, 150, "Continue", GUI.Quit)

	loop
	    if hasch and opencodes = 0 then
		getch (null)
		if null = 'c' or null = 'C' then
		    opencodes := 1
		    drawfillbox (215, 260, 450, 340, brightgreen)
		    Font.Draw ("Enter Cheat Code:", 260, 330, font2, black)
		    textbox := GUI.CreateTextField (210, 300, 210, "", EnterCode)
		end if
	    end if
	    exit when GUI.ProcessEvent
	end loop
    elsif player = 2 then
	Font.Draw ("2 PLAYER", 280, 387, font2, black)
	Font.Draw ("Points Needed For Extra Ball:", 90, 150, font2, black)
	Font.Draw ("Select 100 To Never Get An Extra Ball.", 80, 130, font2, black)
	Font.Draw ('50', 285, 150, font2, black)
	scrollbar2 := GUI.CreateHorizontalScrollBarFull (100, 100, 150, 20, 100, 50, ExtraBallBar, 5, 5, 1)

	Font.Draw ("Speed:", 130, 230, font2, black)
	Font.Draw ('5', 200, 230, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (100, 200, 150, 0, 20, 5, SpeedBar, 1, 1, 1)

	Font.Draw ("Lives:", 430, 230, font2, black)
	Font.Draw ('5', 500, 230, font2, black)
	scrollbar := GUI.CreateHorizontalScrollBarFull (400, 200, 150, 1, 100, 5, LivesBar, 5, 5, 1)

	var quitButton : int := GUI.CreateButton (280, 10, 150, "Continue", GUI.Quit)

	loop
	    if hasch and opencodes = 0 then
		getch (null)
		if null = 'c' or null = 'C' then
		    opencodes := 1
		    drawfillbox (215, 260, 450, 340, brightgreen)
		    Font.Draw ("Enter Cheat Code:", 260, 330, font2, black)
		    textbox := GUI.CreateTextField (210, 300, 210, "", EnterCode)
		end if
	    end if
	    exit when GUI.ProcessEvent
	end loop
    end if

    %Game Loop
    loop
	setscreen ("offscreenonly")
	colour (black)

	level2 := intstr (level)

	if boss1 = level then
	    %Setup Boss 1
	    boss := boss1
	    boss1 := boss1 + 25
	    a := 195
	    blocknum := 56
	    new block, blocknum
	    new block2, blocknum
	    new col, blocknum
	    for i : 1 .. 54
		col (i) := blue
		block (i) := a
		block2 (i) := b
		a := a + 45
		if a > 350 then
		    a := 150
		    b := b - 10
		end if
	    end for
	    block (4) := 195
	    block2 (4) := 215
	    col (4) := blue
	    block (55) := 240
	    block2 (55) := 215
	    col (55) := blue
	    block (56) := 285
	    block2 (56) := 215
	    col (56) := blue
	    col (11) := green
	    col (13) := green
	    for i : 46 .. 48
		col (i) := grey
	    end for
	elsif boss2 = level then
	    %Setup Boss 2
	    boss := level
	    boss2 := boss2 + 25
	    a := 195
	    blocknum := 56
	    new block, blocknum
	    new block2, blocknum
	    new col, blocknum
	    for i : 1 .. 54
		col (i) := red
		block (i) := a
		block2 (i) := b
		a := a + 45
		if a > 350 then
		    a := 150
		    b := b - 10
		end if
	    end for
	    block (4) := 195
	    block2 (4) := 215
	    col (4) := red
	    block (55) := 240
	    block2 (55) := 215
	    col (55) := red
	    block (56) := 285
	    block2 (56) := 215
	    col (56) := red
	    col (11) := grey
	    col (13) := grey
	    for i : 46 .. 48
		col (i) := grey
	    end for
	elsif boss3 = level then
	    %Setup Boss 3
	    boss := level
	    boss3 := boss3 + 25
	    a := 195
	    blocknum := 56
	    new block, blocknum
	    new block2, blocknum
	    new col, blocknum
	    for i : 1 .. 54
		col (i) := 50
		block (i) := a
		block2 (i) := b
		a := a + 45
		if a > 350 then
		    a := 150
		    b := b - 10
		end if
	    end for
	    block (4) := 195
	    block2 (4) := 215
	    col (4) := 50
	    block (55) := 240
	    block2 (55) := 215
	    col (55) := 50
	    block (56) := 285
	    block2 (56) := 215
	    col (56) := 50
	    col (11) := yellow
	    col (13) := yellow
	    for i : 46 .. 48
		col (i) := 29
	    end for
	elsif boss4 = level then
	    %Setup Boss 4
	    boss := level
	    boss4 := boss4 + 25
	    a := 195
	    blocknum := 56
	    new block, blocknum
	    new block2, blocknum
	    new col, blocknum
	    for i : 1 .. 54
		col (i) := 27
		block (i) := a
		block2 (i) := b
		a := a + 45
		if a > 350 then
		    a := 150
		    b := b - 10
		end if
	    end for
	    block (4) := 195
	    block2 (4) := 215
	    col (4) := 27
	    block (55) := 240
	    block2 (55) := 215
	    col (55) := 27
	    block (56) := 285
	    block2 (56) := 215
	    col (56) := 27
	    col (11) := 31
	    col (13) := 31
	    for i : 46 .. 48
		col (i) := 29
	    end for
	else
	    %Blocks Co-Ordinates
	    randint (blocknum, 30, 100)
	    if player = 1 then
		new block, blocknum + 1
		new block2, blocknum + 1
		new col, blocknum + 1
		pblock := blocknum + 1
	    else
		new block, blocknum
		new block2, blocknum
		new col, blocknum
	    end if

	    %Setting Co-ordinates for Blocks
	    for i : 1 .. blocknum
		randint (col (i), 50, maxcol)
		block (i) := a
		block2 (i) := b
		randint (space, 1, 3)
		if space = 1 or space = 2 then
		    a := a + 50
		else
		    a := a + 100
		end if
		if a > 420 then
		    a := 70
		    b := b - 15
		end if
	    end for
	    a := 75
	    if player = 1 then
		block (pblock) := 260
		block2 (pblock) := 370
		col (pblock) := brightgreen
	    end if
	end if

	if level = boss then
	    for i : 1 .. 56
		block3 (i) := block (i)
		block4 (i) := block2 (i)
	    end for
	end if
	blockleft := blocknum

	%Main Game Loop
	loop
	    if player = 1 then
		if drawpblock not= 50 then
		    drawpblock := drawpblock + 1
		end if
		if usepowerup not= 50 then
		    usepowerup := usepowerup + 1
		end if
		if poweroff not= 500 then
		    poweroff := poweroff + 1
		end if
		if slowswitch not= 50 then
		    slowswitch := slowswitch + 1
		end if
	    end if
	    ballcount2 := intstr (ballcount)
	    blockleft2 := intstr (blockleft)
	    points4 := intstr (points3 - points)
	    if level = boss4 - 25 then
		regenerate := regenerate + 1
	    end if

	    delay (speed)
	    %Size of Paddle
	    x2 := x + xsize
	    if player = 2 then
		x5 := x4 + 80
	    end if

	    %Draws Everything on Screen
	    cls
	    for i : 1 .. blocknum
		drawfillbox (block (i), block2 (i), block (i) + 45, block2 (i) + 10, col (i))
	    end for
	    if level not= boss and player = 1 and drawpblock = 50 then
		drawbox (block (pblock), block2 (pblock), block (pblock) + 15, block2 (pblock) + 10, col (pblock))
	    end if
	    drawfillbox (0, 0, 30, maxy, 10)         %Left side of play area
	    drawfillbox (500, 0, maxx, maxy, 10)         %Right side of play area
	    for i : 1 .. ballnum
		if x3 (i) not= 34 then
		    drawfilloval (x3 (i), y3 (i), ballsize, ballsize, bcol)     %Ball
		end if
	    end for
	    if player = 2 then
		drawfillbox (x4, 20, x5, 30, brightblue) %Player2
	    end if
	    drawfillbox (x, 20, x2, 30, red)         %Player1
	    Font.Draw ("Breakout", 502, maxy - 22, font1, black)         %Title
	    Font.Draw ("Level", 505, 340, font2, black)         %Level
	    Font.Draw (level2, 555, 340, font2, black)         %Level
	    Font.Draw ("Points", 505, 320, font2, black)         %Points
	    Font.Draw (points2, 555, 320, font2, black)         %Points
	    Font.Draw ("Lives", 505, 300, font2, black)         %Lives
	    Font.Draw (lives2, 555, 300, font2, black)         %Lives
	    Font.Draw ("Blocks in Level", 505, 240, font2, black)                 %Blocks
	    Font.Draw (blockleft2, 605, 240, font2, black)         %Blocks
	    Font.Draw ("Balls in Play", 505, 220, font2, black)         %Balls
	    Font.Draw (ballcount2, 605, 220, font2, black)         %Balls
	    Font.Draw ("Extra Ball", 505, 200, font2, black)
	    Font.Draw (points4, 605, 200, font2, black)
	    if player = 1 then
		Font.Draw ("# of Powerups", 505, 100, font2, black)
		Font.Draw (poweruptotal2, 590, 100, font2, black)
		Font.Draw ("Powerup", 505, 120, font2, black)
		Font.Draw (powerup, 590, 120, font2, black)
	    end if
	    View.Update

	    %Winning Game
	    exit when blockleft = 0

	    %Losing Game
	    exit when lives = 0

	    %Player 1 Movement
	    Input.KeyDown (chars)
	    if chars (KEY_LEFT_ARROW) and x > 34 then
		x := x - 4
	    end if
	    if chars (KEY_RIGHT_ARROW) and x2 < 496 then
		x := x + 4
	    end if

	    %Player 2 Movement
	    if player = 2 then
		if chars ('a') and x4 > 34 then
		    x4 := x4 - 4
		end if
		if chars ('d') and x5 < 496 then
		    x4 := x4 + 4
		end if
	    end if

	    %Using PowerUps
	    if player = 1 then
		if chars (KEY_DOWN_ARROW) and slowswitch = 50 then
		    if powerup = 'ball' then
			powerup := 'paddle'
		    elsif powerup = 'paddle' then
			powerup := 'float'
		    elsif powerup = 'float' then
			powerup := 'ultimate'
		    elsif powerup = 'ultimate' then
			powerup := 'ball'
		    end if
		    slowswitch := 0
		end if
		if chars (KEY_CTRL) and poweruptotal > 0 and usepowerup = 50 then
		    usepowerup := 0
		    if powerup = 'ultimate' and poweruptotal >= ballcount * 5 then
			power := 1
			poweroff := 0
			bcol := white
		    elsif powerup = 'float' and poweruptotal >= ballcount then
			for i : 1 .. ballnum
			    if x3 (i) not= 34 then
				ychange (i) := 2
			    end if
			end for
			poweruptotal := poweruptotal - ballcount
			poweruptotal2 := intstr (poweruptotal)
		    elsif powerup = 'paddle' and x2 < 486 then
			xsize := xsize + 10
			poweruptotal := poweruptotal - 1
			poweruptotal2 := intstr (poweruptotal)
			if xsize = 80 then
			    poweroff := 0
			end if
		    elsif powerup = 'ball' then
			ballsize := ballsize + 1
			poweruptotal := poweruptotal - 1
			poweruptotal2 := intstr (poweruptotal)
			if ballsize = 3 then
			    poweroff := 0
			end if
		    end if
		end if
	    end if

	    %Turns Off Powerups
	    if player = 1 then
		if poweroff = 500 and xsize > 80 then
		    xsize := xsize - 10
		    ballsize := ballsize - 1
		    power := 0
		    poweroff := 0
		    bcol := 14
		end if
	    end if

	    %Randomizes Starting Ball Direction
	    if start = 1 then
		for i : 1 .. ballnum
		    x3 (i) := x + 38
		    y3 (i) := 30 + ballsize
		end for
		if chars (KEY_UP_ARROW) then
		    for i : 1 .. ballnum
			randint (randx (i), 1, 2)
			if randx (i) = 1 then
			    xchange (i) := -2
			else
			    xchange (i) := 2
			end if
			ychange (i) := 2

		    end for
		    start := 0
		end if
	    end if

	    %Ball Hit Powerup Block
	    if level not= boss and player = 1 and drawpblock = 50 then
		for i : 1 .. ballnum
		    if x3 (i) > block (pblock) - ballsize and x3 (i) < block (pblock) + 45 + ballsize and y3 (i) > block2 (pblock) - ballsize and y3 (i) < block2 (pblock) + 10 + ballsize then
			if power = 0 then
			    if x3 (i) < block (pblock) + 1 or x3 (i) > block (pblock) + 44 then
				xchange (i) := -xchange (i)
				x3 (i) := x3 (i) + xchange (i)
			    else
				ychange (i) := -ychange (i)
				y3 (i) := y3 (i) + ychange (i)
			    end if
			end if
			poweruptotal := poweruptotal + 1
			poweruptotal2 := intstr (poweruptotal)
			drawpblock := 0
		    end if
		end for
	    end if

	    %Boss Movement Change
	    if boss = level then
		for i : 1 .. blocknum
		    if block4 (i) > maxy - 30 or block4 (i) < 200 then
			blockchange2 := -blockchange2
		    end if
		    if block3 (i) < 60 or block3 (i) > 410 then
			blockchange := -blockchange
		    end if
		    exit when block4 (i) > maxy - 15 or block4 (i) < 200
		    exit when block3 (i) < 60 or block3 (i) > 410
		end for
		for i : 1 .. blocknum
		    if block (i) not= maxx then
			block (i) := block (i) + blockchange
			block2 (i) := block2 (i) + blockchange2
		    end if
		    block3 (i) := block3 (i) + blockchange
		    block4 (i) := block4 (i) + blockchange2
		end for
	    end if

	    %Level 4 Boss Regeneration
	    if level = boss4 - 25 then
		if regenerate > 100 div ballcount then
		    randint (z, 1, 56)
		    if block (z) = maxx then
			block (z) := block3 (z)
			block2 (z) := block4 (z)
			blockleft := blockleft + 1
			regenerate := 0
		    end if
		end if
	    end if

	    %Player Missing/Hitting The Ball
	    for i : 1 .. ballnum
		if y3 (i) < 10 then
		    ballcount := ballcount - 1
		    y3 (i) := 11
		    x3 (i) := 34
		    xchange (i) := 0
		    ychange (i) := 0
		end if
		if x3 (i) > x - 1 and x3 (i) < x2 + 1 and y3 (i) > 23 and y3 (i) < 30 + ballsize then
		    ychange (i) := 2
		end if
		if player = 2 then
		    if x3 (i) > x4 - 1 and x3 (i) < x5 + 1 and y3 (i) > 23 and y3 (i) < 30 + ballsize then
			ychange (i) := 2
		    end if
		end if
		%Ball Direction Change
		if y3 (i) > maxy - ballsize or y3 (i) < 3 then
		    ychange (i) := -ychange (i)
		    y3 (i) := y3 (i) + ychange (i)
		end if
		if x3 (i) > 499 - ballsize or x3 (i) < 30 + ballsize then
		    xchange (i) := -xchange (i)
		    x3 (i) := x3 (i) + xchange (i)
		end if
	    end for

	    if ballcount = 0 then
		points3 := points + extraball
		lives := lives - 1
		lives2 := intstr (lives)
		ballnum := 1
		ballcount := 1
		start := 1
		new x3, ballnum
		new y3, ballnum
		new xchange, ballnum
		new ychange, ballnum
		new randx, ballnum
		new randy, ballnum
		x3 (1) := x + 38
		y3 (1) := 33
		xchange (1) := 0
		ychange (1) := 0
	    end if

	    %Ball Hitting Other Balls
	    for i : 1 .. ballnum
		for i2 : 1 .. ballnum
		    if x3 (i) > x3 (i2) - 3 and x3 (i) < x3 (i2) + 3 and y3 (i) > y3 (i2) - 3 and y3 (i) < y3 (i2) + 3 and i not= i2 then
			if xchange (i) = xchange (i2) and ychange (i) = ychange (i2) then
			    xchange (i2) := -xchange (i2)
			    x3 (i2) := x3 (i2) + xchange (i2) + xchange (i2)
			    x3 (i) := x3 (i) + xchange (i) + xchange (i2)
			elsif xchange (i) not= xchange (i2) and ychange (i) not= ychange (i2) then
			    xchange (i2) := -xchange (i2)
			    ychange (i2) := -ychange (i2)
			    x3 (i2) := x3 (i2) + xchange (i2)
			    y3 (i2) := y3 (i2) + ychange (i2)
			    xchange (i) := -xchange (i)
			    ychange (i) := -ychange (i)
			    x3 (i) := x3 (i) + xchange (i)
			    y3 (i) := y3 (i) + ychange (i)
			elsif xchange (i) = xchange (i2) then
			    ychange (i2) := -ychange (i2)
			    y3 (i2) := y3 (i2) + ychange (i2)
			    ychange (i) := -ychange (i)
			    y3 (i) := y3 (i) + ychange (i) + ychange (i)
			else
			    xchange (i2) := -xchange (i2)
			    x3 (i2) := x3 (i2) + xchange (i2)
			    xchange (i) := -xchange (i)
			    x3 (i) := x3 (i) + xchange (i)
			end if
		    end if
		end for
	    end for

	    %Ball Hitting Blocks
	    for i2 : 1 .. ballnum
		for i : 1 .. blocknum
		    if x3 (i2) > block (i) - ballsize and x3 (i2) < block (i) + 45 + ballsize and y3 (i2) > block2 (i) - ballsize and y3 (i2) < block2 (i) + 10 + ballsize then
			if power = 0 then
			    if x3 (i2) < block (i) + 1 or x3 (i2) > block (i) + 44 then
				xchange (i2) := -xchange (i2)
				x3 (i2) := x3 (i2) + xchange (i2)
			    else
				ychange (i2) := -ychange (i2)
				y3 (i2) := y3 (i2) + ychange (i2)
			    end if
			end if
			if level = boss2 - 25 then
			    if i = 11 or i = 13 or i = 46 or i = 47 or i = 48 then
				if blockleft <= 5 then
				    block (i) := maxx
				    block2 (i) := maxy
				    blockleft := blockleft - 1
				    blockleft2 := intstr (blockleft)
				    points := points + 1
				    points2 := intstr (points)
				end if
			    else
				block (i) := maxx
				block2 (i) := maxy
				blockleft := blockleft - 1
				blockleft2 := intstr (blockleft)
				points := points + 1
				points2 := intstr (points)
			    end if
			elsif level = boss3 - 25 then
			    if col (i) = 50 then
				col (i) := green
			    elsif col (i) = yellow then
				col (i) := red
			    elsif col (i) = 29 then
				col (i) := grey
			    elsif col (i) = green or col (i) = red or col (i) = grey then
				block (i) := maxx
				block2 (i) := maxy
				blockleft := blockleft - 1
				blockleft2 := intstr (blockleft)
				points := points + 1
				points2 := intstr (points)
			    end if
			else
			    block (i) := maxx
			    block2 (i) := maxy
			    blockleft := blockleft - 1
			    blockleft2 := intstr (blockleft)
			    points := points + 1
			    points2 := intstr (points)
			end if
			if points = points3 and extraball not= 100 then
			    points3 := points3 + extraball
			    ballnum := ballnum + 1
			    ballcount := ballcount + 1
			    new x3, ballnum
			    new y3, ballnum
			    new xchange, ballnum
			    new ychange, ballnum
			    new randx, ballnum
			    new randy, ballnum
			    x3 (ballnum) := x3 (i2)
			    y3 (ballnum) := y3 (i2)
			    randint (randx (ballnum), 1, 2)
			    randint (randy (ballnum), 1, 2)
			    if randx (ballnum) = 1 then
				xchange (ballnum) := -2
			    else
				xchange (ballnum) := 2
			    end if
			    if randy (ballnum) = 1 then
				ychange (ballnum) := -2
			    else
				ychange (ballnum) := 2
			    end if
			end if
		    end if
		end for
		x3 (i2) := x3 (i2) + xchange (i2)
		y3 (i2) := y3 (i2) + ychange (i2)
	    end for
	end loop

	colour (brightred)
	exit when lives = 0

	level := level + 1
	lives := lives + 1
	lives2 := intstr (lives)
	ballnum := ballcount
	new x3, ballnum
	new y3, ballnum
	new xchange, ballnum
	new ychange, ballnum
	new randx, ballnum
	new randy, ballnum
	x := 270
	x2 := 50
	x4 := 270
	x5 := 50
	for i : 1 .. ballnum
	    x3 (i) := x + 38
	    y3 (i) := 33
	    xchange (i) := 0
	    ychange (i) := 0
	end for
	a := 70
	b := 325
	start := 1
	space := 0
	drawpblock := 100
	usepowerup := 100

	Font.Draw ("YOU WIN", 140, maxy div 2, font3, brightred)
	locate (20, 20)
	put "Press any Key to Continue." ..
	View.Update
	getch (null)
    end loop

    loop
	Font.Draw ("YOU LOSE", 140, maxy div 2, font3, brightred)
	locate (20, 20)
	put "Would you like to retry?" ..
	View.Update
	getch (replay)
	exit when replay = 'y' or replay = 'Y'
	exit when replay = 'n' or replay = 'N'
    end loop

    level := 1
    lives := 3
    lives2 := intstr (lives)
    ballnum := 1
    ballcount := 1
    new x3, ballnum
    new y3, ballnum
    new xchange, ballnum
    new ychange, ballnum
    new randx, ballnum
    new randy, ballnum
    xchange (1) := 0
    ychange (1) := 0
    x := 270
    x2 := 50
    x3 (1) := x + 38
    y3 (1) := 33
    points := 0
    points2 := intstr (points)
    a := 70
    b := 325
    start := 1
    points3 := extraball
    space := 0
    boss := 1
    boss1 := 5
    boss2 := 10
    boss3 := 15
    boss4 := 20
    boss5 := 25
    poweruptotal := 5
    usepowerup := 0

    exit when replay = 'n' or replay = 'N' or replay = 'no' or replay = 'No'
end loop

cls
var x0 : array 1 .. 100 of int
var y0 : array 1 .. 100 of int
var x2change : array 1 .. 100 of int
var y2change : array 1 .. 100 of int
var l, m, n, o : int
for bye : 1 .. 100
    randint (l, 1, maxx - 50)
    randint (m, 1, maxy - 10)
    randint (n, 1, 2)
    randint (o, 1, 2)
    x0 (bye) := l
    y0 (bye) := m
    if n = 1 then
	x2change (bye) := 1
    else
	x2change (bye) := -1
    end if
    if o = 1 then
	y2change (bye) := 1
    else
	y2change (bye) := -1
    end if
end for

loop
    cls
    for bye : 1 .. 100
	Font.Draw ("BYE", x0 (bye), y0 (bye), font2, brightgreen)
	if x0 (bye) > maxx - 50 then
	    x2change (bye) := -1
	elsif x0 (bye) < 2 then
	    x2change (bye) := 1
	elsif y0 (bye) < 2 then
	    y2change (bye) := 1
	elsif y0 (bye) > maxy - 15 then
	    y2change (bye) := -1
	end if
	x0 (bye) := x0 (bye) + x2change (bye)
	y0 (bye) := y0 (bye) + y2change (bye)
    end for
    View.Update
end loop

