/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2010/06/09 (last update)
|verson : 1.00
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2010/09/23 create;
|       2.2012/02/03 update:jumpto;
|
*/
package com.moulin_orange.as3.display{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.text.TextField;
	public class GoToMovieClip extends MovieClip implements IGoToMovieClip{
		public const dec:String = "[ display.GoToMovieClip ]";
		private var _go:int;
		public function GoToMovieClip():void {
			stop();	
			this._go = 1;
			//trace(this.name + " : " + dec);
		}
		private function _EFF(evt:Event):void{
			//trace("EFF "+evt.target._go+" "+evt.target.name+" "+evt.target.currentFrame);
			if (evt.target.currentFrame-evt.target._go == 0)
			{
				evt.target.stop();
				evt.target.removeEventListener(Event.ENTER_FRAME, _EFF);
			}
			else if (evt.currentTarget.currentFrame-evt.currentTarget._go> 0)
			{
				evt.target.prevFrame();
			}
			else if (evt.target.currentFrame-evt.target._go < 0)
			{
				evt.target.play();
			}
		}
		public function goto(_frame:int):void { 
			this._go = (_frame == -1)?this.totalFrames:_frame;
			this.addEventListener(Event.ENTER_FRAME, _EFF);
			//trace("GoToMovieClip.goto > _frame : " + _go);
		}
		public function jumpto(_frame:int):void { 
			this._go = (_frame == -1)?this.totalFrames:_frame;
			gotoAndStop(this._go);
			this.addEventListener(Event.ENTER_FRAME, _EFF);
			//trace("GoToMovieClip.goto > _frame : " + _go);
		}
	}
}
