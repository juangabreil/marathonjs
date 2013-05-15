'use strict'

describe 'pedometer', ->
	it 'should publish pedometer', ->
		expect(typeof Pedometer).toBe('function')