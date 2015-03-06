# This imports all the layers for "framer-navigation-interaction" into framerNavigationInteractionLayers
sketch = Framer.Importer.load "imported/framer-navigation-interaction"

# Import layer groups from sketch and store original position
for layerGroupName of sketch
	window[layerGroupName] = sketch[layerGroupName]
	window[layerGroupName].origin = window[layerGroupName].frame


# Set up group of intensity numbers
itnCont = new Layer
	x: 568
	y: 100
	width:156
	height: 870
	backgroundColor: null

itn = {}
for i in [1, 2, 3, 4, 5]
	number = new Layer
		width: 156
		height: 205
		y: ((i - 1) * 122)
		backgroundColor: null
	
	number.style = {
		'font-family': 'Avenir-Light'
		'font-size': '150px'
		'color': '#FFFFFF'
		'line-height': '205px'
		'text-align': 'center'
	}
	
	number.states.animationOptions = 
		curve: "spring(600, 30, 0)"
		time: 0.2
	
	number.html = i
	number.origin = number.frame
	itnCont.addSubLayer number
	itn['n' + i] = number

itn['n1'].states.add
	n1: { scale: 2, y: 60, color: '#FFFFFF'}
	n2: { scale: 1,  y: itn.n1.origin.y, color: '#ECC2C2' }
	n3: { scale: 1,  y: itn.n1.origin.y, color: '#ECC2C2' }
	n4: { scale: 1,  y: itn.n1.origin.y, color: '#ECC2C2' }
	n5: { scale: 1,  y: itn.n1.origin.y, color: '#ECC2C2' }

itn['n2'].states.add
	n1: { scale: 1, y: itn.n2.origin.y + 120, color: '#ECC2C2'}
	n2: { scale: 2, y: itn.n2.origin.y + 60, color: '#FFFFFF'}
	n3: { scale: 1,  y: itn.n2.origin.y, color: '#ECC2C2' }
	n4: { scale: 1,  y: itn.n2.origin.y, color: '#ECC2C2' }
	n5: { scale: 1,  y: itn.n2.origin.y, color: '#ECC2C2' }

itn['n3'].states.add
	n1: { scale: 1, y: itn.n3.origin.y + 120, color: '#ECC2C2'}
	n2: { scale: 1, y: itn.n3.origin.y + 120, color: '#ECC2C2'}
	n3: { scale: 2, y: itn.n3.origin.y + 60, color: '#FFFFFF'}
	n4: { scale: 1,  y: itn.n3.origin.y, color: '#ECC2C2' }
	n5: { scale: 1,  y: itn.n3.origin.y, color: '#ECC2C2' }

itn['n4'].states.add
	n1: { scale: 1, y: itn.n4.origin.y + 120, color: '#ECC2C2'}
	n2: { scale: 1, y: itn.n4.origin.y + 120, color: '#ECC2C2'}
	n3:	{ scale: 1, y: itn.n4.origin.y + 120, color: '#ECC2C2'}
	n4: { scale: 2, y: itn.n4.origin.y + 60, color: '#FFFFFF'}
	n5: { scale: 1,  y: itn.n4.origin.y, color: '#ECC2C2' }
	
itn['n5'].states.add
	n1: { scale: 1, y: itn.n5.origin.y + 120, color: '#ECC2C2'}
	n2: { scale: 1, y: itn.n5.origin.y + 120, color: '#ECC2C2'}
	n3: { scale: 1, y: itn.n5.origin.y + 120, color: '#ECC2C2'}
	n4: { scale: 1, y: itn.n5.origin.y + 120, color: '#ECC2C2'}
	n5: { scale: 2, y: itn.n5.origin.y + 60, color: '#FFFFFF'}

itnSwitch = (state) ->
	for i of itn 
		itn[i].states.switch state

itnSnap = (y) ->
	itnCont.animate
		properties:
			y: y
		time: 0.5
		curve: "spring(600, 30, 0)"

itnSwitch 'n1'

# DRAG EVENT	
itnCont.draggable.enabled = true
itnCont.draggable.speedX = 0

stage = (n) -> 
	switch n 
		when 0 then itnCont.y >= 150
		when 1 then itnCont.y > 0
		when 2 then itnCont.y < 0 && itnCont.y > -100
		when 3 then itnCont.y < -100 && itnCont.y > -200
		when 4 then itnCont.y < -200 && itnCont.y > -330
		when 5 then itnCont.y < -300 && itnCont.y > -430
		when 6 then itnCont.y < -430 && itnCont.y

itnCont.on Events.DragMove, ->
	if stage 0
		itnCont.y = 150
	else if stage 1
		itnSwitch 'n1'
	else if stage 2
		itnSwitch 'n2'
	else if stage 3 
		itnSwitch 'n3'
	else if stage 4
		itnSwitch 'n4'
	else if stage 5
		itnSwitch 'n5'
	else if stage 6
		itnCont.y = -430

itnCont.on Events.DragEnd, ->
	if stage(0) || stage(1)
		itnSnap 100
	else if stage 2
		itnSnap -22
	else if stage 3 
		itnSnap -140
	else if stage 4
		itnSnap -262
	else 
		itnSnap	 -379
		
		
# CUT OFF BOTTOM
bottom = new Layer
 	y: 400
 	width: 750
 	backgroundColor: 'black'
 	height: 1000
 	z: 1

#bring back list item
listItem.draggable.enabled = true


if Utils.isMobile()		
	Framer.Device.setContentScale(1.92, true)



