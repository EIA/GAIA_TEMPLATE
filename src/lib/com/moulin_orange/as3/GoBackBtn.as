/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2010/08/20 (last update)
|verson : 1.04
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2010/01/22 update;
|       2.2010/02/02 update: import flash.text.TextField;
|       3.2010/03/22 update: implement;
|       4.2010/06/08 update: btnGoto();
|       5.2010/08/20 update: releaseOutside;
|
*/
package com.moulin_orange.as3
{	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	public class GoBackBtn extends MovieClip implements IBtn
	{
		private var _go:uint = 1;
		private var _minFrame:uint;
		private var _maxFrame:uint;
		private var _mouseIsDown:Boolean = false;
		public  var enableReleaseOutside:Boolean = false;
		public function GoBackBtn(s:String = "st"):void 
		{
			//trace("GoBackBtn");
			stop();
			buttonMode = true;
			_minFrame = 1;
			_maxFrame = this.totalFrames;
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler );
			addEventListener(MouseEvent.MOUSE_OUT , mouseOutHandler  );
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler );
		}
		private function mouseOverHandler(evt:MouseEvent):void
		{
			this._go = _maxFrame;
			addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
		}
		private function mouseOutHandler(evt:MouseEvent):void
		{
			if(!enableReleaseOutside){
				this._go = _minFrame;
				addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
			}else{
				if(!_mouseIsDown){ // not actually work;
					this._go = _minFrame;
					addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
				}
			}
		}
		private function mouseDownHandler(evt:MouseEvent):void{
			//trace("MouseDown");
			_mouseIsDown = true;
			if(enableReleaseOutside)stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		private function mouseUpHandler(evt:MouseEvent):void{
			_mouseIsDown = false;
			//trace("MouseUp");
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			this._go = _minFrame;
			addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
		}
		private function enterFrameHandler(evt:Event):void
		{
			//trace("onf " + "evt.target.+go =" + this._go + " evt.target.currentFrame =" + this.currentFrame + " " + this.name + " " + this._maxFrame+ " " + this._minFrame);
			if ( this.currentFrame- this._go == 0)
			{
				stop();
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else if ( this.currentFrame- this._go > 0)
			{
				prevFrame();
			}
			else if ( this.currentFrame- this._go < 0)
			{
				play();
			}
		}
		public function addEvent():void {
			if(!hasEventListener(Event.ENTER_FRAME)){
				addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
			}
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler );
			this.addEventListener(MouseEvent.MOUSE_OUT , mouseOutHandler  );
			this._go = this._minFrame;
			this.buttonMode = true;
		}
		public function remEvent():void {
			if(!hasEventListener(Event.ENTER_FRAME)){
				addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
			}
			removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler );
			removeEventListener(MouseEvent.MOUSE_OUT , mouseOutHandler  );
			this._go = this._maxFrame;
			this.buttonMode = false;	
		}
		public function set minFrame(_value:uint):void {
			this._minFrame = _value;
			addEvent();
		}
		public function get minFrame():uint { return this._minFrame; }
		public function set maxFrame(_value:uint ):void {
			this._maxFrame = _value;
			addEvent();
		}
		public function get maxFrame():uint { return this._maxFrame; }
		public function btnIsFocus(): void {
			//trace("btnIsFocus");
			remEvent();
		}
		public function btnKillFocus():void {
			//trace("btnKillFocus");
			addEvent();
		}
		public function btnGoto(goInp:uint):void {
			if(!hasEventListener(Event.ENTER_FRAME)){
				addEventListener(Event.ENTER_FRAME    , enterFrameHandler );
			}
			this._go = goInp;
		}
		public function get mouseIsDown():Boolean { return _mouseIsDown };
	}
}