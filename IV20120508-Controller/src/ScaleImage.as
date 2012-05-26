package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class ScaleImage extends Sprite {
		public var vx:Number = 0;
		public var vy:Number = 0;
		public var oldX:Number;
		public var oldY:Number;
		public var mainStage:Stage;
		
		private var fraction:Number = .9;
		private var bounce:Number = -.4;
		
		public var index:int;
		public function ScaleImage(vx:Number = 0, vy:Number = 0) {
			super();
			this.vx = vx;
			this.vy = vy;
			this.init();
		}
		
		private function init():void {
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		private function onEnterFrame(e:Event):void {
			this.getBounce(this);
			if (Math.abs(this.vx) < 1 && Math.abs(this.vy) < 1) {
				this.vx = 0;
				this.vy = 0;
			} else {
				this.vx *= fraction;
				this.vy *= fraction;
				this.x += this.vx;
				this.y += this.vy;
			}
		}
		private function getBounce(image:ScaleImage):void {
			if (image.x + image.width > mainStage.stageWidth) {
				image.x = mainStage.stageWidth - image.width;
				image.vx *= bounce;
			} else if (image.x < 0) {
				image.x = 0;
				image.vx *= bounce;
			}
			if (image.y < 0) {
				this.sendImage();
				image.y = 0;
				image.vy *= bounce;
			} else if (image.y + image.height > mainStage.stageHeight) {
				image.y = mainStage.stageHeight - image.height;
				image.vy *= bounce;
			}
		}
		private function trackvelocity(e:Event):void {
			this.vx = this.x - this.oldX;
			this.vy = this.y - this.oldY;
			this.oldX = this.x;
			this.oldY = this.y;
		}
		private function onMouseDown(e:MouseEvent):void {
			this.parent.setChildIndex(this, this.parent.numChildren - 1);
			this.startDrag();
			this.oldX = this.x;
			this.oldY = this.y;
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.addEventListener(Event.ENTER_FRAME, trackvelocity);
		}
		private function onMouseOut(e:MouseEvent):void {
			this.onMouseUp(e);
		}
		private function onMouseUp(e:MouseEvent):void {
			this.stopDrag();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.removeEventListener(Event.ENTER_FRAME, trackvelocity);
		}
		
		private function sendImage():void{
			DataManager.getInstance().sendSocketData(this.index);
		}
		
	}
}