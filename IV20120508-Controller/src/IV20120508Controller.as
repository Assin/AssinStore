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
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	[SWF(width="400", height = "400", backgroundColor = "#000000", frameRate = "60")]
	
	public class IV20120508Controller extends Sprite {
		
		private var bigBitmap:Bitmap;
		
		public function IV20120508Controller() {
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
			
			for (var i:int = 1; i <= DataManager.getInstance().imageCount; i++) {
				var bitmap:Bitmap = (LoaderMax.getContent("images/" + String(i) + ".jpg")as
					ContentDisplay).rawContent as Bitmap;
				bitmap.smoothing = true;
				//				var scaleImage:ScaleImage = new ScaleImage();
				//				scaleImage.index = i;
				//				scaleImage.addChild(bitmap);
				//				DataManager.getInstance().scaleImageList.push(scaleImage);
				
				var rotationImage:RotationImage = new RotationImage(bitmap);
				rotationImage.index = i;
				DataManager.getInstance().rotationImageList.push(rotationImage);
			}
			this.initContainer();
		}
		
		private function initContainer():void {
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
//			this.stage.displayState = StageDisplayState.FULL_SCREEN;
			
			//			var ic:ImageContainer = new ImageContainer();
			//			ic.imagesArr = DataManager.getInstance().scaleImageList;
			//			ic.mainStage = this.stage;
			//			ic.initImages();
			//			this.addChild(ic);
			
			var rc:RotationContainer = new RotationContainer();
			rc.setImages(DataManager.getInstance().rotationImageList);
			rc.mainStage = this.stage;
			rc.x = this.stage.stageWidth;
			rc.y = this.stage.stageHeight;
			this.addChild(rc);
			rc.onClick = onRotationImageClick;
			
			bigBitmap = new Bitmap();
			bigBitmap.x = 20;
			bigBitmap.y = 20;
			this.addChild(bigBitmap);
		}
		
		private function onRotationImageClick(ri:RotationImage):void {
			bigBitmap.bitmapData = ri.bitmap.bitmapData;
			DataManager.getInstance().sendSocketData(ri.index);
		}
	}
}