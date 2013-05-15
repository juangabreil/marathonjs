'use strict'

root = exports ? this

shiftLeft = (array) ->
	len = array.length
	for i in [1...len] by 1
		array[i-1] = array[i]
	return array

dotProduct = (v1, v2) ->
	v1.x*v2.x + v1.y*v2.y + v1.z*v2.z

module = (v) ->
	Math.sqrt v.x*v.x + v.y*v.y + v.z*v.z

class Pedometer
	_steps: 0

	_d: null

	_previousVector: null

	_threshold: null

	constructor: (@_threshold)->
		@_d = []
		for i in [0...10]
			@_d.push(1)
		@_previousVector = x: 1, y: 1, z: 1

	computeWeigthedMovingAverage = ->
		wma = 0
		for i in [1...10]
			wma += i*@_d[i-1]
		wma/55

	computeVector: (vector) ->
		if vector.x isnt 0 or vector.y isnt 0 or vector.z isnt 0
			shiftLeft(@_d)
			@_d[9] = dotProduct(@_previousVector, vector)/(module(@_previousVector) * module(vector))
			@_previousVector = vector

		@_steps++ if computeWeigthedMovingAverage() < @_threshold

		return @_steps

	getSteps: -> @_steps

root.Pedometer = Pedometer