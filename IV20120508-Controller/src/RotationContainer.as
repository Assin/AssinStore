package {
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class RotationContainer extends Sprite {
		private var angle:Number;
		private var degree:Number
		private var total:int;
		private var scale_factor:Number = 0.4;
		private var tween_duration:Number = 0.8;
		
		private var clickX:Number;
		private var clickY:Number;
		
		public var mainStage:Stage;
		
		public var onClick:Function;
		
		public function RotationContainer() {
			super();
			
		}
		
		public function setImages(array:Array):void {
			total = array.length;
			angle = Math.PI * 2 / total;
			degree = Math.round(angle * 180 / Math.PI);
			
			for each (var ri:RotationImage in array) {
				
				var bg_width:Number = ri.width + 10;
				var bg_height:Number = ri.height + 10;
				
				ri.graphics.beginFill(0x666666);
				ri.graphics.drawRect(-bg_width * 0.51, -bg_height * 0.51, bg_width * 1.02,
					bg_height * 1.02);
				ri.graphics.beginFill(0xFFFFFF);
				ri.graphics.drawRect(-bg_width * 0.5, -bg_height * 0.5, bg_width, bg_height);
				ri.graphics.endFill();
				
				ri.buttonMode = true;
				ri.addEventListener(MouseEvent.MOUSE_OVER, tn_over);
				ri.addEventListener(MouseEvent.MOUSE_OUT, tn_out);
				ri.addEventListener(MouseEvent.CLICK, tn_click);
				ri.scaleX = ri.scaleY = scale_factor;
				
				ri.x = Math.cos(this.numChildren * angle) * 200;
				ri.y = Math.sin(this.numChildren * angle) * 200;
				ri.rotation = this.numChildren * degree - 180;
				
				this.addChild(ri);
			}
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
			
		}
		
		private function onMouseDownHandler(e:MouseEvent):void {
			clickX = mainStage.mouseX;
			clickY = mainStage.mouseY;
			mainStage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
		}
		
		private function onEnterFrameHandler(e:Event):void {
			mainStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
			var currentX:Number = mainStage.mouseX;
			var currentY:Number = mainStage.mouseY;
			
			if (currentX < clickX) {
				TweenLite.to(this, tween_duration, {rotation:this.rotation - degree - 20});
			}
			
			if (currentX > clickX) {
				TweenLite.to(this, tween_duration, {rotation:this.rotation + degree + 20});
			}
			
			clickX = currentX;
			clickY = currentY;
		}
		
		private function onMouseUpHandler(e:MouseEvent):void {
			mainStage.removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
			mainStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		}
		
		private function tn_over(e:MouseEvent):void {
			var ri:RotationImage = RotationImage(e.target);
			this.addChild(ri);
			TweenLite.to(ri, tween_duration, {scaleX:1, scaleY:1});
		}
		
		private function tn_out(e:MouseEvent):void {
			var ri:RotationImage = RotationImage(e.target);
			TweenLite.to(ri, tween_duration, {scaleX:scale_factor, scaleY:scale_factor});
		}
		
		private function tn_click(e:MouseEvent):void {
			var ri:RotationImage = RotationImage(e.target);
			
			if (onClick != null)
				onClick(ri);
		}
	}
}