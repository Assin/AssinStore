package {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class RotationImage extends Sprite {
		private var _bitmap:Bitmap;
		public var index:int = -1;
		public function RotationImage(bitmap:Bitmap) {
			super();
			this._bitmap = bitmap;
			this.addChild(this._bitmap);
			this._bitmap.x = -this._bitmap.width / 2;
			this._bitmap.y = -this._bitmap.height / 2;
		}
		
		public function get bitmap():Bitmap
		{
			return _bitmap;
		}

	}
}