'use strict'

describe 'isArray" auxiliary function', ->
	it 'should return true when an array declared with brackets is passed', ->
		expect(Marathon._isArray([1, 2, 3])).toBeTruthy()

	it 'should return true when an array object is passed', ->
		expect(Marathon._isArray(new Array())).toBeTruthy()

	it 'should return false when an array is not passed', ->
		expect(Marathon._isArray()).toBeFalsy()
		expect(Marathon._isArray(1)).toBeFalsy()
		expect(Marathon._isArray("aadsasda")).toBeFalsy()

describe 'shiftLeft auxiliary function', ->
	it 'should shift left the elements of an array', ->
		expect(Marathon._shiftLeft([1, 2, 3])).toEqual([2, 3, 1])

	it 'should an empty array when an empty array is passed', ->
		expect(Marathon._shiftLeft([])).toEqual([])

	it 'should return undefined passing something different to an array', ->
		expect(Marathon._shiftLeft()).toBeUndefined()
		expect(Marathon._shiftLeft(1)).toBeUndefined()
		expect(Marathon._shiftLeft('a')).toBeUndefined()

describe 'dotProduct auxiliary function', ->
	it 'should calculate the "dot product" between two given three-dimensional vectors', ->
		v1 = x: 1, y: 1, z: 1
		v2 = x: 1, y: 2, z: 3
		expect(Marathon._dotProduct(v1, v2)).toBe(6)

describe 'module auxiliary function', ->
	it 'should calculate the module of a given vector', ->
		v1 = x: 1, y: 0, z: 0
		expect(Marathon._module(v1)).toBe(1)

describe 'pedometer', ->
	pedometer = null
	threshold = 0.95
	samplesBeforeEvaluation = 5
	n = 15


	beforeEach ->
		pedometer = new Marathon.Pedometer(threshold, samplesBeforeEvaluation)

	it 'should create a pedometer with default values for "threshold" and "samples before evaluation" fields', ->
		pedometer = new Marathon.Pedometer
		expect(pedometer._threshold).toBe(0.97)
		expect(pedometer._samplesBeforeEvaluation).toBe(10)
		expect(pedometer._n).toBe(55)
		expect(pedometer._d.length).toBe(10)

	it 'should create a pedometer with given values for "threshold" and "samples before evaluation" fields', ->
		_n = 0
		_n += i for i in [1..samplesBeforeEvaluation] by 1
		expect(pedometer._threshold).toBe(threshold)
		expect(pedometer._samplesBeforeEvaluation).toBe(samplesBeforeEvaluation)
		expect(pedometer._n).toBe(_n)
		expect(pedometer._d.length).toBe(samplesBeforeEvaluation)

	it 'should calculate weigthed moving average', ->
		_d = [1, 0.95, 0.96, 0.94, 1]
		pedometer._d = _d
		wma = (1*1 + 2*0.95 + 3*0.96 + 4*0.94 + 5*1)/n
		expect(pedometer._computeWeigthedMovingAverage().toFixed(3)).toBe(wma.toFixed(3))

	it 'should return 1 calculating weigthed moving average at the beginning', ->
		wma = pedometer._computeWeigthedMovingAverage()
		expect(wma).toBe(1)

	it 'should not compute a vector if it is null', ->
		vector = x:0, y:0, z:0
		pedometer.computeVector(vector)
		expect(pedometer._previousVector).toEqual(x:1, y:1, z:1)

	it 'should not increment the step count computing a vector because the sample count has not been completed', ->
		vector = x:0, y:-1, z:0
		steps = pedometer.computeVector(vector)
		expect(pedometer._previousVector).toEqual(vector)
		expect(steps).toBe(0)

	it 'should not increment the step count computing a vector because the movement is greater than the threshold', ->
		vector = x:0, y:0.5, z:0
		steps = pedometer.computeVector(vector) for i in [0...samplesBeforeEvaluation] by 1
		expect(steps).toBe(0)

	it 'should increment the step count computing a vector because the movement is lesser than the threshold', ->
		vector = x:0, y:-1, z:0
		steps = pedometer.computeVector(vector) for i in [0...samplesBeforeEvaluation] by 1
		expect(steps).toBe(1)

	it 'should be able to reset the counter', ->
		pedometer._steps = 10
		pedometer.resetCounter()
		expect(pedometer._steps).toBe(0)

	it 'should be able to return the number of steps', ->
		expect(pedometer.getStepCount()).toBe(pedometer._steps)






describe 'converter', ->
	it 'should convert steps to meters', ->
		steps = 5
		expect(Marathon.Converter.stepsToMeters(steps)).toBe(steps * Marathon.Converter.STEP_METER_CONVERSION)

	it 'should convert meters to steps', ->
		meters = 10
		expect(Marathon.Converter.metersToSteps(meters)).toBe(meters / Marathon.Converter.STEP_METER_CONVERSION)