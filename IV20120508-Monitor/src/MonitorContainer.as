package {
	import com.greensock.TweenLite;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	
	public class MonitorContainer extends Sprite {
		
		private var currentBigBitmap:MonitorImage;
		private var nextBigBitmap:MonitorImage;
		public var mainStage:Stage;
		
		private var cacheQueue:Array = [];
		
		private var isPlaying:Boolean;
		
		public function MonitorContainer() {
			super();
		}
		
		public function init():void {
			DataManager.getInstance().onSocketDataCallBack = onSocketDataCallBackHandler;
		}
		
		/**
		 * 当数据返回时候调用
		 * @param data
		 *
		 */
		private function onSocketDataCallBackHandler(data:int):void {
			cacheQueue.push(data);
			this.getAndShow();
		}
		
		private function getAndShow():void {
			if (isPlaying == false) {
				if (cacheQueue.length > 0) {
					this.nextBigBitmap = new MonitorImage();
					this.nextBigBitmap.update(this.getBitmapDataByImageIndex(cacheQueue.shift()));
					this.startImageChange(nextBigBitmap);
				}
			}
		}
		
		private function getBitmapDataByImageIndex(index:int):BitmapData {
			var bitmap:Bitmap = ContentDisplay(LoaderMax.getContent("images/" + String(index) +
				".jpg")).rawContent as
				Bitmap;
			return bitmap.bitmapData.clone();
		}
		
		private function startImageChange(nbb:MonitorImage):void {
			isPlaying = true;
			
			if (this.currentBigBitmap != null && this.contains(this.currentBigBitmap)) {
				var targetX:Number = this.currentBigBitmap.width * -1;
				TweenLite.to(this.currentBigBitmap, 0.5, {x:targetX, onComplete:function():void {
					removeChild(currentBigBitmap);
					currentBigBitmap.dispose();
					currentBigBitmap = null;
					showNext(nbb);
				}});
			} else {
				showNext(nbb);
			}
		}
		
		private function showNext(nbb:MonitorImage):void {
			isPlaying = true;
			nbb.x = this.mainStage.stageWidth / 2;
			nbb.y = this.mainStage.stageHeight;
			var targetPoint:Point = new Point(this.mainStage.stageWidth / 2, this.mainStage.stageHeight *
				0.4);
			nbb.alpha = 0
			this.addChild(nbb);
			TweenLite.to(nbb, 0.5, {alpha:1, x:targetPoint.x, y:targetPoint.y, scaleX:1.5, scaleY:1.5, onComplete:function():void {
				currentBigBitmap = nbb;
				isPlaying = false;
				getAndShow();
			}});
		}
	}
}