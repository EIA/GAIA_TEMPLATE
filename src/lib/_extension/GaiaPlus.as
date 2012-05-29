package _extension
{
   import casts._impls.IMyPreloader;
   
   import com.gaiaframework.api.Gaia;
   import com.gaiaframework.api.IBase;
   import com.gaiaframework.api.IMovieClip;
   import com.gaiaframework.api.IPageAsset;
   
   import flash.events.Event;
   
   public class GaiaPlus
   {
      private static const defaultPageId:String = 'root';
      
      // singleton
      private static var instance:GaiaPlus;
      
      public function GaiaPlus(pvt:PrivateClass)
      {
      }
      
      // --------------------- LINE ---------------------
      
      // Just like Gaia.api (smile :D)
      public static function get api():GaiaPlus
      {
         if (!instance)
         {
            instance = new GaiaPlus(new PrivateClass());
         }
         
         return instance;
      }
      
      // ________________________________________________
      //                                        Preloader
      
      public function setPreloader(asset:IMovieClip):void
      {
         if (!Gaia.api) return;
         
         // old one
         var preloader:casts._impls.IMyPreloader = IMyPreloader(Gaia.api.getPreloader().content);
         preloader.removeBeforePreload();
         
         // new one
         preloader = IMyPreloader(asset.content);
         preloader.addBeforePreload();
         Gaia.api.setPreloader(asset);
      }
      
      // ________________________________________________
      //                                   Lightbox Asset
      
      /**
       * Show asset by given asset-id and page-id. It helps you to control asset's content directly.
       * @param $assetId         : String. Check part of site.xml of GAIA Framework for detail.
       * @param $pageId          : String. Check part of site.xml of GAIA Framework for detail.
       * @param $returnCallback  : A callback function notify the asset is removed or closed.
       * e.g.
       * GaiaPlus.api.showAsset('tvc', 'root', callback);
       * 
       * function callback()
       * {
       *    trace('!!!back!!!');
       * };
       */ 
      public function showAsset($assetId:String, $pageId:String = defaultPageId, $returnCallback:Function = null):void
      {
         var asset:Object = getAsset($assetId, $pageId);
         var assetContent:Object = getAssetContent($assetId, $pageId);
         if (assetContent)
         {
            assetContent.transitionIn();
            
            // return call back (for BaseLightbox)
            if (assetContent.hasOwnProperty('returnCallback'))
            {
               assetContent.returnCallback = $returnCallback;
            }
         }
         else
         {
//            IAsset(asset).load();
         }
      }
      
      /**
       * Hide asset by given asset-id and page-id. It helps you to control asset's content directly.
       * @param $assetId         : String. Check part of site.xml of GAIA Framework for detail.
       * @param $pageId          : String. Check part of site.xml of GAIA Framework for detail.
       * e.g.
       * GaiaPlus.api.hideAsset('tvc', 'root');
       */      
      public function hideAsset($assetId:String, $pageId:String = defaultPageId):void
      {
         var assetContent:Object = getAssetContent($assetId, $pageId);
         if (assetContent)
         {
            assetContent.transitionOut();
         }
      }
      
      // --------------------- LINE ---------------------
      
      public function getAsset($assetId:String, $pageId:String = defaultPageId):Object
      {
         if (!Gaia.api) return null;
         
         var page:IPageAsset = Gaia.api.getPage($pageId);
         if (!page) return null; // page doesn't exist
         if (!page.assets.hasOwnProperty($assetId)) return null; // not an asset
         
         return page.assets[$assetId];
      }
      
      public function getAssetContent($assetId:String, $pageId:String = defaultPageId):Object
      {
         if (!Gaia.api) return null;
         
         var page:IPageAsset = Gaia.api.getPage($pageId);
         if (!page) return null; // page doesn't exist
         if (!page.assets.hasOwnProperty($assetId)) return null; // not an asset
         
         var asset:Object = page.assets[$assetId];
         return asset.content;
      }
      
      // ################### protected ##################
      
      // #################### private ###################
      
      // --------------------- LINE ---------------------
      
   }
   
}

class PrivateClass
{
   function PrivateClass() {}
}
