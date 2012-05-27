package view.map {
	import data.IDispose;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import data.GameConfig;
	import gs.TweenLite;
	
	public class MapElement extends Sprite implements IDispose {
		
		public function MapElement() {
			super();
		}
		
		public function setLocationByColRow(col:int, row:int):void {
			this.x = col * GameConfig.MAPTILE_WIDTH;
			this.y = row * GameConfig.MAPTILE_HEIGH;
		}
		
		public function moveToColRowByTween(col:int, row:int, onCompleteCallBack:Function = null):void {
			var targetPoint:Point = new Point(col * GameConfig.MAPTILE_WIDTH, row * GameConfig.MAPTILE_HEIGH);
			TweenLite.to(this, 0.5, {x:targetPoint.x, y:targetPoint.y, onComplete:function():void {
				if (onCompleteCallBack != null) {
					onCompleteCallBack();
				}
			}})
		}
		
		public function dispose():void {
		}
	}
}