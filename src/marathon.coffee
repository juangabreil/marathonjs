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

Converter =
	STEP_METER_VALUE : 0.762

	stepsToMeters : (steps) ->
		steps * @STEP_METER_VALUE

	metersToSteps : (meters) ->
		meters / @STEP_METER_VALUE

class Pedometer
	_steps: 0

	_sampleCount: 0

	_previousVector: x: 1, y: 1, z: 1

	getSteps: -> @_steps

	constructor: (@_threshold=0.97, @_sample_before_evaluation=10)->
		@_d = []
		@_n = 0
		for i in [0...@_sample_before_evaluation] by 1
			@_d.push(1)
			@_n += (i + 1)


	computeWeigthedMovingAverage = (d,s,n) ->
		wma = 0
		for i in [1..s] by 1
			wma += i*d[i-1]
		wma/n

	computeVector: (vector) ->
		if vector.x isnt 0 or vector.y isnt 0 or vector.z isnt 0
			shiftLeft(@_d)
			@_d[@_sample_before_evaluation - 1] = dotProduct(@_previousVector, vector)/(module(@_previousVector) * module(vector))
			@_sampleCount++
			@_previousVector = x: vector.x, y: vector.y, z:vector.z

		if @_sampleCount is @_sample_before_evaluation
			@_sampleCount = 0
			@_steps++ if computeWeigthedMovingAverage(@_d, @_sample_before_evaluation, @_n) < @_threshold

		return @_steps

	resetCounter: -> @_steps = 0

	
root.Converter = Converter
root.Pedometer = Pedometer