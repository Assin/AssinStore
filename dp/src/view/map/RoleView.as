package view.map {
	import data.IDispose;
	import flash.geom.Point;
	import flash.display.Sprite;
	import data.GameConfig;
	import gs.TweenLite;
	
	public class RoleView extends MapElement {
		public var col:int;
		public var row:int;
		
		public function RoleView() {
			super();
		}
		
		override public function setLocationByColRow(col:int, row:int):void {
			super.setLocationByColRow(col, row);
			this.col = col;
			this.row = row;
		}
		
		override public function moveToColRowByTween(_col:int, _row:int, onCompleteCallBack:Function = null):void {
			var targetPoint:Point = new Point(_col * GameConfig.MAPTILE_WIDTH, _row * GameConfig.MAPTILE_HEIGH);
			var targetCol:int = _col;
			var targetRow:int = _row;
			TweenLite.to(this, 0.2, {x:targetPoint.x, y:targetPoint.y, onComplete:function():void {
				col = targetCol;
				row = targetRow;
				if (onCompleteCallBack != null) {
					onCompleteCallBack();
				}
			}})
		}
		
		override public function dispose():void {
		}
	}
}