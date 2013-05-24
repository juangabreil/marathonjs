/* marathon-js v0.0.1 - 2013/5/24
   http://github.com/juangabreil/marathonjs
   Copyright (c) 2013 Juan Gabriel Jimenez - Licensed , , , ,  */
!function(){"use strict";var a,b,c,d,e,f,g;f="undefined"!=typeof exports&&null!==exports?exports:this,d=function(a){return"undefined"!=typeof a&&a&&"object"==typeof a&&a instanceof Array&&"number"==typeof a.length&&"function"==typeof a.splice&&!a.propertyIsEnumerable("length")},g=function(a){var b,c,e,f;if(d(a)){for(e=a.length,b=a[0],c=f=1;e>f;c=f+=1)a[c-1]=a[c];return a[e-1]=b,a}},c=function(a,b){return a.x*b.x+a.y*b.y+a.z*b.z},e=function(a){return Math.sqrt(a.x*a.x+a.y*a.y+a.z*a.z)},a={STEP_METER_CONVERSION:.762,stepsToMeters:function(a){return a*this.STEP_METER_CONVERSION},metersToSteps:function(a){return a/this.STEP_METER_CONVERSION}},b=function(){function a(a,b){var c,d,e;for(this._threshold=null!=a?a:.97,this._samplesBeforeEvaluation=null!=b?b:10,this._d=[],this._n=0,c=d=0,e=this._samplesBeforeEvaluation;e>d;c=d+=1)this._d.push(1),this._n+=c+1}return a.prototype._steps=0,a.prototype._sampleCount=0,a.prototype._previousVector={x:1,y:1,z:1},a.prototype._computeWeigthedMovingAverage=function(){var a,b,c,d;for(b=0,a=c=1,d=this._samplesBeforeEvaluation;d>=c;a=c+=1)b+=a*this._d[a-1];return b/this._n},a.prototype.getStepCount=function(){return this._steps},a.prototype.computeVector=function(a){return(0!==a.x||0!==a.y||0!==a.z)&&(g(this._d),this._d[this._samplesBeforeEvaluation-1]=c(this._previousVector,a)/(e(this._previousVector)*e(a)),this._sampleCount++,this._previousVector={x:a.x,y:a.y,z:a.z},this._sampleCount===this._samplesBeforeEvaluation&&(this._sampleCount=0,this._computeWeigthedMovingAverage(this._d,this._samplesBeforeEvaluation,this._n)<this._threshold&&this._steps++)),this._steps},a.prototype.resetCounter=function(){return this._steps=0},a}(),f.Marathon||(f.Marathon={}),f.Marathon.Converter=a,f.Marathon.Pedometer=b,f.Marathon._isArray=d,f.Marathon._shiftLeft=g,f.Marathon._dotProduct=c,f.Marathon._module=e}.call(this);