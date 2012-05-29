package _extension
{
   import com.gaiaframework.api.Gaia;
   import com.gaiaframework.api.IBase;
   import com.gaiaframework.templates.AbstractBase;
   
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   /**
    * A extension for GAIA framework. You can easily test transitionIn and transitionOut by pressing I/O on your keyboard separately.
    * @author cjboy1984@gmail.com
    * @usage
    * GaiaTest.init(this);
    * // if you want to disable this functionality
    * GaiaTest.enabled = false;
    */
   public class GaiaTest
   {
      private static var _instance:GaiaTest;
      
      private var target:AbstractBase;
      private var _enabled:Boolean;
      
      private var transitIn:Function;
      private var transitOut:Function;
      
      public function GaiaTest(ptv:PrivateClass)
      {
         _enabled = true;
      }
      
      // --------------------- LINE ---------------------
      
      public static function init($target:AbstractBase):void
      {
         getInstance().target = $target;
         
         if (getInstance().target.stage)
         {
            getInstance().target.stage.addEventListener(KeyboardEvent.KEY_UP, getInstance().onKeyUPUP);
         }
         else
         {
            trace('Err: You should call GaiaTest.init(this) after the Event.ADDED_TO_STAGE was triggered.');
         }
      }
      
      public static function get enabled():Boolean { return getInstance()._enabled; }
      public static function set enabled(v:Boolean):void { getInstance()._enabled = v; }
      
      // --------------------- LINE ---------------------
      
      public static function getInstance():GaiaTest
      {
         if (!_instance)
         {
            _instance = new GaiaTest(new PrivateClass());
         }
         
         return _instance;
      }
      
      // ################### protected ##################
      
      // #################### private ###################
      
      private function onKeyUPUP(e:KeyboardEvent):void
      {
		  trace('onKeyUPUP: ' + e.keyCode);
         if (!_enabled) return;

         switch(e.keyCode)
         {
            case 38:
               target.transitionIn();
               break;
            case 40:
               target.transitionOut();
               break;
         }
      }
      
      // --------------------- LINE ---------------------
      
   }
   
}

class PrivateClass
{
   public function PrivateClass()
   {
   }
}