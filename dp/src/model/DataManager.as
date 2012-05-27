package model {
	import com.adobe.serialization.json.JSON;
	
	import data.Global;
	import data.RoleType;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import net.SocketConnectionControl;
	
	public class DataManager {
		private static var instance:DataManager;
		
		public var originalMapTileStopDataTable:Array = [[1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
			1, 1, 0, 1, 1, 1, 1, 1, 1], [1, 0,
				1, 0,
				0, 1,
				1, 1,
				0, 0,
				0, 0,
				1, 1,
				1, 0,
				0, 1,
				0, 1],
			[1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 1, 1, 0, 1], [1, 0,
					0, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 0,
					0, 1],
			[1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0,
				0, 1, 0, 0, 0, 1, 0, 1, 1], [0, 1,
					1, 1,
					0, 1,
					1, 1,
					0, 1,
					1, 0,
					1, 1,
					1, 0,
					1, 1,
					1, 0],
			[0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1,
				1, 1, 0, 1, 1, 1, 0, 1, 0], [1, 1,
					0, 1,
					0, 0,
					0, 1,
					0, 1,
					1, 0,
					1, 0,
					0, 0,
					1, 0,
					1, 1],
			[1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 1], [1, 0,
					0, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 0,
					0, 1],
			[1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1,
				0, 1, 0, 0, 0, 1, 0, 1, 1], [0, 1,
					0, 1,
					1, 1,
					0, 1,
					1, 1,
					1, 1,
					1, 0,
					1, 1,
					1, 0,
					1, 0],
			[0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1,
				0, 1, 1, 1, 0, 1, 1, 1, 0], [1, 1,
					0, 1,
					0, 0,
					0, 1,
					0, 0,
					0, 0,
					1, 0,
					0, 0,
					1, 0,
					1, 1],
			[1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 1], [1, 0,
					1, 1,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					1, 1,
					0, 1],
			[1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0,
				0, 1, 1, 1, 0, 0, 1, 0, 1], [1, 1,
					1, 1,
					1, 1,
					0, 1,
					1, 1,
					1, 1,
					1, 0,
					1, 1,
					1, 1,
					1, 1]];
		
		public var originalMapTileGoldDataTable:Array = [[0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1,
			1, 1, 0, 1, 1, 1, 1, 1, 1], [1, 0,
				1, 0,
				0, 1,
				1, 1,
				0, 0,
				0, 0,
				1, 1,
				1, 0,
				0, 1,
				0, 1],
			[1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 1, 1, 0, 1], [1, 0,
					0, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 1,
					1, 0,
					0, 1],
			[1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0,
				0, 1, 0, 0, 0, 1, 0, 1, 1], [0, 1,
					1, 1,
					0, 1,
					1, 1,
					0, 1,
					1, 0,
					1, 1,
					1, 0,
					1, 1,
					1, 0],
			[0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0,
				0, 0, 0, 1, 1, 1, 0, 1, 0], [1, 1,
					0, 1,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					1, 0,
					1, 1],
			[1, 0, 0, 1, 1, 1, 1, 0, 0, 2, 2,
				0, 0, 1, 1, 1, 1, 0, 0, 1], [1, 0,
					0, 1,
					1, 1,
					1, 0,
					0, 2,
					2, 0,
					0, 1,
					1, 1,
					1, 0,
					0, 1],
			[1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 1, 0, 1, 1], [0, 1,
					0, 1,
					1, 1,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					1, 1,
					1, 0,
					1, 0],
			[0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1,
				0, 1, 1, 1, 0, 1, 1, 1, 0], [1, 1,
					0, 1,
					0, 0,
					0, 1,
					0, 0,
					0, 0,
					1, 0,
					0, 0,
					1, 0,
					1, 1],
			[1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 0, 0, 1], [1, 0,
					1, 1,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					0, 0,
					1, 1,
					0, 1],
			[1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0,
				0, 1, 1, 1, 0, 0, 1, 0, 1], [1, 1,
					1, 1,
					1, 1,
					0, 1,
					1, 1,
					1, 1,
					1, 0,
					1, 1,
					1, 1,
					1, 1]]
			;
		
		
		private var socketConnectionControl:SocketConnectionControl;
		
		public function getMapTileDataTable():Array {
			var mapTileDataTable:Array = [];
			var mapTileVO:MapTileVO;
			
			for (var i:int = 0; i < originalMapTileStopDataTable.length; i++) {
				mapTileDataTable.push([]);
				
				for (var j:int = 0; j < originalMapTileStopDataTable[i].length; j++) {
					mapTileVO = new MapTileVO();
					mapTileVO.col = i;
					mapTileVO.row = j;
					mapTileVO.stopValue = originalMapTileStopDataTable[i][j];
					mapTileVO.goldValue = originalMapTileGoldDataTable[i][j];
					mapTileDataTable[i].push(mapTileVO);
				}
			}
			return mapTileDataTable;
			
			
		}
		
		public static function getInstance():DataManager {
			if (instance == null) {
				instance = new DataManager();
			}
			return instance;
		}
		
		public function initSocket():void {
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE,function(e:Event):void{
				var xml:XML = new XML(e.target.data);
				socketConnectionControl = new SocketConnectionControl(1, onSocketDataResponse);
				socketConnectionControl.socketAddress = xml.child("ip").toString();
				socketConnectionControl.socketPort = int(xml.child("port").toString());
				socketConnectionControl.initSocket();
			});
			urlLoader.load(new URLRequest("config.xml"));
		}
		
		private function onSocketDataResponse(length:int, content:String):void {
			var object:Object = JSON.decode(content);
			
			if (Global.currentRoleType == RoleType.EXPLORER) {
				switch (object.key) {
					case "draw":
						Global.main.drawMain.showTrack(object.track, object.color, object.erasing);
						break;
				}
			} else if (Global.currentRoleType == RoleType.CONTROLLER) {
				switch (object.key) {
					case "move":
						Global.main.map.roleViewMoveToColRowByTween(object.x, object.y, Global.main.map.onRoleViewMoveComplete);
						break;
				}
			}
		}
		
		public function sendObjectToSocket(object:Object):void {
			this.socketConnectionControl.sendObjectData(object);
		}
		
		public function DataManager() {
		}
	}
}