package {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.core.DisplayObjectLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	[SWF(width="400", height = "400", backgroundColor = "#000000", frameRate = "60")]
	public class IV20120508Monitor extends Sprite {
		
		public function IV20120508Monitor() {
			this.init();
		}
		
		private function init():void {
			this.loadConfig();
		}
		
		private function loadConfig():void {
			var configURL:String = "config/config.xml";
			var dataLoader:DataLoader = new DataLoader(configURL, {name:configURL, format:"text", onComplete:onConfigLoadCompleteHandler});
			dataLoader.load();
		}
		
		private function onConfigLoadCompleteHandler(e:LoaderEvent):void {
			var configXML:XML = new XML(DataLoader(e.target).content);
			DataManager.getInstance().parserConfigXML(configXML);
			DataManager.getInstance().initSocket();
			
			var imageURLList:Vector.<String> = DataManager.getInstance().getImageListURLByConfigXML(configXML);
			var loaderMax:LoaderMax = new LoaderMax({onComplete:onLoadImagesCompleteHandler});
			
			for each (var imageURL:String in imageURLList) {
				var imageLoader:ImageLoader = new ImageLoader(imageURL, {name:imageURL});
				loaderMax.append(imageLoader);
			}
			loaderMax.load();
		}
		
		private function onLoadImagesCompleteHandler(e:LoaderEvent):void {
			this.initContainer();
		}
		
		private function initContainer():void {
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			//			this.stage.displayState = StageDisplayState.FULL_SCREEN;
			var monitorContainer:MonitorContainer = new MonitorContainer();
			monitorContainer.mainStage = this.stage;
			monitorContainer.init();
			this.addChild(monitorContainer);
		}
	}
}