/**
 * @author Gapple
 * @QQ 821168116
 * @mail lzmst@126.com
 */
package data {
	import model.MapTileVO;
	
	import view.map.MapTile;

	/**
	 * @class Global
	 * @data  May 12, 2012
	 * @declaration public class Global
	 */

	public class Global {
		public static var currentRoleType:String;
		/**
		 * 存放当前地图的格子数据VO 二维列表 MapTileVO.as
		 */
		public static var currentMapTileDataTable:Array;
		/**
		 * 存放当前地图的显示格子  二维列表  MapTile.as
		 */
		public static var currentMapTileViewTable:Array;
		
		public static var main:Main;

		/**
		 * 获得格子是否可以行走
		 * @param col
		 * @param row
		 * @return
		 *
		 */
		public static function getMapTileWalkable(col:int, row:int):Boolean {
			return currentMapTileDataTable[row][col].walkable;
		}

		public static function getMapTileData(col:int, row:int):MapTileVO {
			return currentMapTileDataTable[row][col]as MapTileVO;
		}
		
		public static function getMapTileView(col:int, row:int):MapTile {
			return currentMapTileViewTable[row][col]as MapTile;
		}
	}
}