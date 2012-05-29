package project.pages
{
	import _extension.GaiaTest;
	import com.gaiaframework.templates.AbstractPage;
	import com.gaiaframework.events.*;
	import com.gaiaframework.debug.*;
	import com.gaiaframework.api.*;
	import flash.display.*;
	import flash.events.*;
	import com.greensock.TweenMax;

	public class IndexPage extends AbstractPage
	{	
		public var indexContent:MovieClip;
		public function IndexPage():void {
			super();
			visible = false;
			//
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}
		override public function transitionIn():void 
		{
			super.transitionIn();
			transitionInComplete();
		}
		override public function transitionOut():void 
		{
			super.transitionOut();
			TweenMax.to(this, 0.3, {alpha:0, onComplete:transitionOutComplete});
		}
		
		override public function transitionInComplete():void 
		{
			super.transitionInComplete();
			_indexInit();
		}
		
		private function _indexInit():void {
			visible = true;
			indexContent.playIndex();
		}
		//////////////////////////////////////////////////////////////////////////////////////////////
		private function onAdd(e:Event):void {
			trace('onAdd');
			// debug
			stage.addEventListener(Event.RESIZE, onResize);
			GaiaTest.init(this);
			onResize();
		}
		private function onRemove(e:Event):void {
			stage.removeEventListener(Event.RESIZE, onResize);
		}
		private function onResize(evt:Event = null):void {
			Trace2(stage.stageWidth + " " + stage.stageHeight);
			x = (stage.stageWidth - 960) * .5;
		}
	}
}
