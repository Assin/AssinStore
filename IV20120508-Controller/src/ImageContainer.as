package {
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class ImageContainer extends Sprite {
		public var imagesArr:Array;
		public var mainStage:Stage;
		public function ImageContainer() {
			super();
		}
		
		public function initImages():void {
			for each (var si:ScaleImage in this.imagesArr) {
				si.x = Math.random() * 200;
				si.y = Math.random() * 200;
				si.mainStage = this.mainStage;
				this.addChild(si);
			}
		}
	}
}