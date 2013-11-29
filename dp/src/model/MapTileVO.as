package model {
	import data.IDispose;
	//author yanghongbin
	public class MapTileVO implements IDispose {
		public var col:int;
		public var row:int;
		public var stopValue:int;
		public var goldValue:int;
		
		public function get walkable():Boolean {
			return (stopValue == 1) ? true : false;
		}
		
		public function get hasGold():Boolean {
			return (goldValue > 0) ? true : false;
		}
		
		public function MapTileVO() {
		}
		
		public function dispose():void {
		}
	}
}