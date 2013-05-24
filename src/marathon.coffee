'use strict'

root = exports ? this

isArray = (value) ->
  typeof value isnt 'undefined' and
  value and
  typeof value is 'object' and
  value instanceof Array and
  typeof value.length is 'number' and
  typeof value.splice is 'function' and not ( value.propertyIsEnumerable 'length' )

shiftLeft = (array) ->
	if isArray array
		len = array.length
		first = array[0]
		for i in [1...len] by 1
			array[i-1] = array[i]
		array[len-1] = first
		return array

dotProduct = (v1, v2) ->
	v1.x*v2.x + v1.y*v2.y + v1.z*v2.z

module = (v) ->
	Math.sqrt v.x*v.x + v.y*v.y + v.z*v.z

Converter =
	STEP_METER_CONVERSION : 0.762

	stepsToMeters : (steps) ->
		steps * @STEP_METER_CONVERSION

	metersToSteps : (meters) ->
		meters / @STEP_METER_CONVERSION

class Pedometer
	_steps: 0

	_sampleCount: 0

	_previousVector: x: 1, y: 1, z: 1

	_computeWeigthedMovingAverage :  ->
		wma = 0
		for i in [1..@_samplesBeforeEvaluation] by 1
			wma += i*@_d[i-1]
		wma/@_n

	getStepCount: -> @_steps

	constructor: (@_threshold=0.97, @_samplesBeforeEvaluation=10)->
		@_d = []
		@_n = 0
		for i in [0...@_samplesBeforeEvaluation] by 1
			@_d.push(1)
			@_n += (i + 1)



	computeVector: (vector) ->
		if vector.x isnt 0 or vector.y isnt 0 or vector.z isnt 0
			shiftLeft(@_d)
			@_d[@_samplesBeforeEvaluation - 1] = dotProduct(@_previousVector, vector)/(module(@_previousVector) * module(vector))
			@_sampleCount++
			@_previousVector = x: vector.x, y: vector.y, z:vector.z

			if @_sampleCount is @_samplesBeforeEvaluation
				@_sampleCount = 0
				@_steps++ if @_computeWeigthedMovingAverage(@_d, @_samplesBeforeEvaluation, @_n) < @_threshold

		return @_steps

	resetCounter: -> @_steps = 0

root.Marathon or= {}	
root.Marathon.Converter = Converter
root.Marathon.Pedometer = Pedometer
root.Marathon._isArray = isArray
root.Marathon._shiftLeft = shiftLeft
root.Marathon._dotProduct = dotProduct
root.Marathon._module = module