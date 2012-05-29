package 
{
	import com.gaiaframework.core.GaiaMain;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import pages.Pages;
	
	/**
	 * ...
	 * @author EIA
	 */
	[SWF(width = 1366, height = 768,backgroundColor = 0xffffff, frameRate = 30)]
	public class Main extends GaiaMain 
	{
		private var _bg:Sprite;
		public function Main():void 
		{
			super();
			siteXML = "xml/site.xml";
		}
		override protected function onAddedToStage(event:Event):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			super.onAddedToStage(event);
			//
			_initBg();
		}
		///////////////////////////////// init /////////////////////////////////
		private function _initBg():void {
			trace("_initBg");
			addChild(_bg = new Sprite());
			_bg.graphics.beginFill(0xcfced3);
			_bg.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			//
			TweenLite.to(_bg, 0, { alpha:0, ease:Strong.easeOut } );
			TweenLite.to(_bg, 20, { alpha:1, ease:Strong.easeOut } );
		}
	}
}