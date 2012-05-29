/*＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿
|creator : EIA
|date : 2011/06/ (last update)
|verson : 1.05
|way : inNam: object id,inVal: object value,inWay: object ways
|modify:
|       1.2010/01/22 update;
|       2.2010/02/03 update: resetConstructor;
|       3.2010/03/22 update: loose coupling;
|       4.2010/04/11 update: dispatChEvent;
|       5.2010/04/15 update: getBtnNum;
|       6.2010/04/18 update: dispatchEvent;
|       7.2010/06/30 update: resetMenu;
|       8.2010/11/12 update: renderMenu;
|       9.2010/11/12 update: dispatChEvent - false;
|      10.2011/02/16 update: resetMenu;
|      11.2011/06/09 update: lockMenu;
|      12.2012/02/17 update: disableLock;
|
*/
package com.moulin_orange.as3
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class GoBackMenu extends MovieClip
	{
		private var iMax:uint;
		private var _menuFocusID:int = -1;
		private var _btnInterface:IBtn;
		public var lockMenu:Boolean = true;
		public static const GOBACKMENU_CLICK:String = "GoBackMenuIsCLICK";
		private var _removeClickID:int = -1;
		public function GoBackMenu():void 
		{
			renderMenu();
		}
		private function menuMouseClickHandler(evt:MouseEvent):void
		{
			//trace(evt.currentTarget+" "+evt.currentTarget.id);
			_menuFocusID = evt.currentTarget.id;
			chooseMenu();
			//evt.currentTarget.dispatchEvent(new Event(GoBackMenu_CLICK,true));
			//evt.currentTarget.dispatchEvent(new Event(GoBackMenu_CLICK));
			//evt.currentTarget.dispatchEvent(new Event("GoBackMenuIsCLICK"));
			evt.currentTarget.parent.dispatchEvent(new Event("GoBackMenuIsCLICK"));
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, menuMouseClickHandler);
		}
		private function chooseMenu():void {
			for (var i:uint = 0; i < iMax; i++ ) {
				var tempMC:MovieClip = this.getChildAt(i) as MovieClip;
				if (i == _menuFocusID) {
					//tempMC.remEvent();
					tempMC.btnIsFocus();
					if(lockMenu){
						tempMC.removeEventListener(MouseEvent.CLICK, menuMouseClickHandler);
					}
				}else {
					//tempMC.addEvent();
					tempMC.btnKillFocus();
					if(i !=_removeClickID ){
						tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
					}
				}
			}
		}
		public function set menuFocusName(_setName:String):void {
			for (var i:uint = 0; i < iMax; i++ ) {
				if (this.getChildAt(i).name == _setName ) {
					_menuFocusID = i;
					break;
				}else {
					_menuFocusID = -1;
				}
			}
			chooseMenu();
		}
		
		public function get menuFocusName():String {
			return this.getChildAt(_menuFocusID).name;
		}
		public function set menuFocusID(_setID:int):void {
			//trace("_setID ="+_setID);
			_menuFocusID = _setID;
			chooseMenu();
		}
		public function get menuFocusID():int { return _menuFocusID; };
		public function resetConstructor():void {
			iMax = this.numChildren;
			for (var i:uint = 0; i < iMax; i++ ) {
				var tempMC:MovieClip = getChildAt(i) as MovieClip;
				tempMC.id = i;
				tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
			}
		}
		public function get btnNum():uint{
			return iMax;
		}
		public function resetMenu():void {
			for (var i:uint = 0; i < iMax; i++ ) {
				var tempMC:MovieClip = this.getChildAt(i) as MovieClip;
				tempMC.btnKillFocus();
				if(i !=_removeClickID ){
					tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
				}
			}
			_menuFocusID = -1;
		}
		public function renderMenu():void {
			//trace("renderMenu");
			iMax = numChildren;
			for (var i:uint = 0; i < iMax; i++ ) {
				var tempMC:MovieClip = getChildAt(i) as MovieClip;
				tempMC.id = i;
				if(i !=_removeClickID ){
					tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
				}else {
					tempMC.removeEventListener(MouseEvent.CLICK, menuMouseClickHandler);
				}
			}
		}
		//////////////// updage 120217 ////////////////
		public function disableClickMenByName($name:String):void {
			trace( "GoBackMenu.disableClickMenByName > $name : " + $name );
			for (var i:uint = 0; i < iMax; i++ ) {
				if (this.getChildAt(i).name == $name ) {
					_removeClickID = i;
					break;
				}else {
				}
			}
			var tempMC:MovieClip = this.getChildByName($name) as MovieClip;
			tempMC.removeEventListener(MouseEvent.CLICK, menuMouseClickHandler);
		}
		public function disableClickMenByID($id:uint):void {
			trace( "GoBackMenu.disableClickMenByID > $id : " + $id );
			_removeClickID = $id;
			var tempMC:MovieClip = this.getChildAt($id) as MovieClip;
			tempMC.removeEventListener(MouseEvent.CLICK, menuMouseClickHandler);
		}
		public function enableClickMenByName($name:String):void {
			trace( "GoBackMenu.enableClickMenByName > $name : " + $name );
			var tempMC:MovieClip = this.getChildByName($name) as MovieClip;
			// not ready //
			tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
		}
		public function enableClickMenByID($id:uint):void {
			trace( "GoBackMenu.enableClickMenByID > $id : " + $id );
			var tempMC:MovieClip = this.getChildAt($id) as MovieClip;
			// not ready //
			tempMC.addEventListener(MouseEvent.CLICK, menuMouseClickHandler);
		}
	}
}