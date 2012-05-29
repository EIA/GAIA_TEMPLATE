/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2011/07/09 (last update)
|verson : 1.00
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2011/07/09 create;
|
*/
package com.moulin_orange.as3.display {
	import flash.display.BitmapData;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsTrianglePath;
	import flash.display.IGraphicsData;
	import flash.display.MovieClip;
	public class TransformPIC extends MovieClip{
		public const dec:String = "[ display.TransformPIC ]";
		private var _bitmapData:BitmapData;
		private var _tlx:Number = 0;
		private var _tly:Number = 0;
		private var _trx:Number = 0;
		private var _try:Number = 0;
		private var _blx:Number = 0;
		private var _bly:Number = 0;
		private var _brx:Number = 0;
		private var _bry:Number = 0;
		//
		private var _smooth:Boolean = false;
		//
		public function TransformPIC():void {
			stop();	
			trace(this.name + " : " + dec);
		}
		public function setBitmapData($bitmapData:BitmapData):void {
			_bitmapData = $bitmapData;
		}
		public function setPos($TLX:Number, $TLY:Number, $TRX:Number, $TRY:Number, $BLX:Number, $BLY:Number, $BRX:Number, $BRY:Number):void {
			_tlx = $TLX;
			_tly = $TLY;
			_trx = $TRX;
			_try = $TRY;
			_blx = $BLX;
			_bly = $BLY;
			_brx = $BRX;
			_bry = $BRY;
			_drawBitmap();
		}
		public function setSmooth($smooth:Boolean):void {
			_smooth = $smooth;
			_drawBitmap();
		}
		private function _drawBitmap():void {
			//trace("_drawBitmap _smooth: " + _smooth);
			graphics.clear();
			
			////////////////////////////////////// beginBitmapFill & drawTriangles////////////////////////////////////// 
			/*
			//graphics.lineStyle(1, 0x000000, .3);
			graphics.beginBitmapFill(_bitmapData, null, true, _smooth);
			
			//graphics.drawRect(_tlx, _tly, (_brx - _tlx), (_bry - _tly) );
			//graphics.drawTriangles(Vector.<Number>([ _tlx, _tly,  _trx, _try,  _blx, _bly]));
			graphics.drawTriangles(Vector.<Number>([ _tlx, _tly,  _trx, _try,  _blx, _bly, _brx, _bry]),
								   Vector.<int>([0, 1, 2, 1, 3, 2]),
								   Vector.<Number>([0,0, 1,0, 0,1, 1,1]));
			*/
			////////////////////////////////////// beginBitmapFill & drawTriangles////////////////////////////////////// 
								   
			////////////////////////////////////// GraphicsBitmapFill & GraphicsTrianglePath////////////////////////////////////// 
			var _graphics:GraphicsBitmapFill = new GraphicsBitmapFill(_bitmapData, null, true, _smooth);
			//
			var _path:GraphicsTrianglePath = new GraphicsTrianglePath(Vector.<Number>([ _tlx, _tly,  _trx, _try,  _blx, _bly, _brx, _bry]),
												Vector.<int>([0, 1, 2, 1, 3, 2]),
												Vector.<Number>([0, 0, 1, 0, 0, 1, 1, 1]));
												
			var _drawing:Vector.<IGraphicsData> = new Vector.<IGraphicsData>();
			_drawing.push(_graphics, _path);
			
			graphics.drawGraphicsData(_drawing);
			////////////////////////////////////// GraphicsBitmapFill & GraphicsTrianglePath////////////////////////////////////// 
		}
	}
}