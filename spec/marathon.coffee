'use strict'

describe 'pedometer', ->
	it 'should publish pedometer', ->
		expect(typeof Pedometer).toBe('function')

describe 'converter', ->
	it 'should publish converter', ->
		expect(typeof Converter).toBe('object')