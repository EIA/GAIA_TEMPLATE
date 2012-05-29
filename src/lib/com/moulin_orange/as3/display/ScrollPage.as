/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2010/06/03 (last update)
|verson : 1.05;
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2009/06/03 update;
|       2.2009/06/28 update;
|       3.2009/07/10 update;
|       4.2009/08/15 update;
|       5.2011/04/28 update;
|       6.2011/06/14 update;
|       7.2011/07/14 update;
|       8.2012/02/05 update;
|
*/
package com.moulin_orange.as3.display {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.display.SimpleButton;
	public class ScrollPage extends MovieClip {
		private var _rollBody:DisplayObject;
		private var _rollMask:DisplayObject;
		private var _scrollBtn:Sprite;
		private var _scrollYMove:uint;
		private var _scrollPa:Number = 0;
		private var _rollBodyDefaultY:Number;
		private var _rollBodyHeight:Number;
		private var _rollMaskHeight:Number;
		private var _scrollBarHeight:Number;
		private var _wheelPercent:Number = 10;
		private var _enableScroll:Boolean = true;
		public function ScrollPage():void {
			trace("ScrollPage");
		}
		public function rend($rollBody:DisplayObject, $rollMask :DisplayObject, $scrollBtn :Sprite):void {
			trace("$rollBody:  " + $rollBody);
			trace("$rollMask:  " + $rollMask);
			trace("$scrollBtn: " + $scrollBtn);
			_rollBody  = $rollBody;
			_rollMask  = $rollMask;
			_scrollBtn = $scrollBtn;
			//_rollMask.mouseChildren = false;
			//_rollMask.mouseEnabled  = false;
			_rollMask.cacheAsBitmap = true;
			_rollBody.cacheAsBitmap = true;
			_rollBody.mask = _rollMask;
			//
			_rollBodyDefaultY = _rollBody.y;
			_rollMaskHeight   = _rollMask.height;
			_scrollBarHeight  = _rollMaskHeight; //asDefault;
			_setYMove();
			//
			_scrollBtn.addEventListener(MouseEvent.MOUSE_DOWN, _mr);
			//
			_rollBodyHeight = _rollBody.height;
			_scrollBtnVisibleHandler();
		}
		private function _scrollBtnVisibleHandler():void {
			trace("_scrollBtnVisibleHandler");
			trace("ScrollPage > _rollBodyHeight: " + _rollBodyHeight + " _rollMask.height: " + _rollMask.height);
			trace("ScrollPage > _scrollBtn: " + _scrollBtn + " stage: " + stage);
			if ( _rollBodyHeight < _rollMask.height) {
				_scrollBtn.visible = false;
				stage.removeEventListener(MouseEvent.MOUSE_UP,_mu);
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL, _mw);
			}else {
				_scrollBtn.visible = true;
				stage.addEventListener(MouseEvent.MOUSE_UP,_mu);
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mw);
			}
			trace("_scrollBtn.visible: " + _scrollBtn.visible);
		}
		private function _mr(evt:MouseEvent):void {
			trace("_mr");
			trace("_scrollYMove: " + _scrollYMove);
			evt.currentTarget.startDrag(false, new Rectangle(0, 0, 0, _scrollYMove));
			evt.updateAfterEvent();
			evt.currentTarget.addEventListener(Event.ENTER_FRAME,_scrollONF);
		}
		private function _mu(evt:MouseEvent):void {
			trace("_mu");
			_scrollBtn.stopDrag();
			_scrollBtn.removeEventListener(Event.ENTER_FRAME,_scrollONF);
		}
		private function _mw(evt:MouseEvent):void {
			percentChange( -evt.delta / 3 * _wheelPercent);
		}
		public function percentChange(inp:Number):void {
			var _sctempPa:Number = _scrollPa;
			if (_scrollPa + inp < 0){
				_scrollPa = 0;
			}else if (_scrollPa + inp > 100) {
				_scrollPa = 100;
			}else {
				_scrollPa += inp;
			}
			trace("_scrollPa = " + _scrollPa);
			_scMove();
			if (_sctempPa != _scrollPa) {
				_mainMove();
				_sctempPa = _scrollPa;
			}
		}
		private function _scrollONF(evt:Event):void {
			var tempPa:uint = scrollPa;
			_scrollPa = Math.floor((evt.currentTarget.y - 0) / (_scrollYMove-0) * 100);
			//trace("tempPa = " + tempPa + " _scrollPa = " + _scrollPa);
			if(_scrollPa!=tempPa){
				_mainMove();
				tempPa = _scrollPa;
			};
		}
		public function resetPage():void{
			_scrollPa = 0;
			_scMove();
			_mainMove();
		}
		private function _setYMove():void {
			//trace("_scrollBarHeight: " + _scrollBarHeight + " _scrollBtn.height: " + _scrollBtn.height);
			_scrollYMove = _scrollBarHeight - _scrollBtn.height;
		}
		private function _scMove():void //滾動bar
		{
			_scrollBtn.y = Math.floor((_scrollYMove-0) * _scrollPa / 100) + 0;
		};
		private function _mainMove():void //滾動內容
		{
			//_rollBody.y = Math.floor((_rollBody.height - _rollMaskHeight) * -1 * _scrollPa / 100) + _rollBodyDefaultY; //100713
			_rollBody.y = Math.floor((_rollBodyHeight - _rollMaskHeight) * -1 * _scrollPa / 100) + _rollBodyDefaultY; //100713
		}
		//////////////////////////////////////////// getter setter ////////////////////////////////////////////
		public function get scrollPa():Number { return _scrollPa };
		// update:2012/02/05
		public function set scrollPa($scrollPa:Number):void {
			_scrollPa = $scrollPa;
			_scMove();
			_mainMove();
		};
		public function set scrollBarHeight($scrollBarHeight:Number):void {
			_scrollBarHeight = $scrollBarHeight;
			_setYMove();
		};
		public function get scrollBarHeight():Number { return _scrollBarHeight };
		public function get wheelPercent():Number { return _wheelPercent };
		public function set wheelPercent($wheelPercent:Number):void { _wheelPercent = $wheelPercent };
		public function get enableScroll():Boolean { return _enableScroll };
		public function set enableScroll($enableScroll:Boolean):void {
			_enableScroll = $enableScroll;
			switch(_enableScroll) {
				case true:
					_scrollBtn.addEventListener(MouseEvent.MOUSE_DOWN,_mr);
					stage.addEventListener(MouseEvent.MOUSE_UP,_mu);
					stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mw);
				break;
				case false:
					_scrollBtn.removeEventListener(MouseEvent.MOUSE_DOWN,_mr);
					stage.removeEventListener(MouseEvent.MOUSE_UP,_mu);
					stage.removeEventListener(MouseEvent.MOUSE_WHEEL, _mw);
				break;
			}
		}
		public function get rollBodyHeight():Number {
			return _rollBodyHeight;
		}
		public function set rollBodyHeight($rollBodyHeight:Number):void {
			trace("$rollBodyHeight: " + $rollBodyHeight + " _rollBodyHeight: " + _rollBodyHeight);
			_rollBodyHeight = $rollBodyHeight;
			_scrollBtnVisibleHandler();
		}
		public function get rollBodyDefaultY():Number {
			return _rollBodyDefaultY;
		}
		public function set rollBodyDefaultY($rollBodyDefaultY:Number):void {
			_rollBodyDefaultY = $rollBodyDefaultY;
		}
		//////////////////////////////////////////// getter setter ////////////////////////////////////////////
	}
}