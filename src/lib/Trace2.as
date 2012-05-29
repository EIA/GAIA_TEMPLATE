package
{
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.Security;
   
   /**
    * Print message both on flash and browser console.
    * @usage
    * Trace2('Hello World');
    */   
   public function Trace2(...args):void
   {
      var isBrowser:Boolean = (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
      var isConsole:Boolean = ExternalInterface.available && (Security.sandboxType == "remote" || Security.sandboxType == "localTrusted");
      
      if (isBrowser && isConsole)
      {
         ExternalInterface.call("console.log" , args);
      }
      trace.apply(null, args);
   }
   
   // --------------------- LINE ---------------------
   
}