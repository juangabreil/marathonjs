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
	it 'should publish pedometer', ->
		expect(typeof Marathon.Pedometer).toBe('function')

describe 'converter', ->
	it 'should publish converter', ->
		expect(typeof Marathon.Converter).toBe('object')