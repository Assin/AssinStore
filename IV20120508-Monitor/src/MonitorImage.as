package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class MonitorImage extends Sprite {
		private var bitmap:Bitmap;
		
		public function MonitorImage() {
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public function update(bd:BitmapData):void {
			this.bitmap = new Bitmap(bd);
			this.addChild(this.bitmap);
			this.bitmap.smoothing = true;
			this.bitmap.x = -(this.bitmap.width / 2);
			this.bitmap.y = -(this.bitmap.height / 2);
		}
		
		public function dispose():void{
			this.bitmap.bitmapData.dispose();
			this.bitmap = null;
		}
	}
}