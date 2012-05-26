package {
	
	public class DataManager {
		private static var instance:DataManager;
		
		public var serverIP:String = "";
		public var serverPort:String = "";
		private var socketConnectionControl:SocketConnectionControl;
		public var onSocketDataCallBack:Function;
		public var imageCount:int;
		
		public var scaleImageList:Array = [];
		public static function getInstance():DataManager {
			if (instance == null) {
				instance = new DataManager();
			}
			return instance;
		}
		
		public function DataManager() {
		}
		
		public function parserConfigXML(xml:XML):void {
			serverIP = xml.child("server").toString();
			serverPort = xml.child("port").toString();
		}
		
		public function initSocket():void {
			socketConnectionControl = new SocketConnectionControl(ClientType.CLIENT_MAIN, onSocketDataResponse);
			socketConnectionControl.socketAddress = serverIP;
			socketConnectionControl.socketPort = int(serverPort);
			socketConnectionControl.initSocket();
		}
		
		private function onSocketDataResponse(data:int):void {
			if (onSocketDataCallBack != null) {
				onSocketDataCallBack(data);
			}
		}
		
		public function sendSocketData(data:int):void{
			socketConnectionControl.sendData(data);
		}
		/**
		 * 获取图片列表路径 
		 * @param configXML
		 * @return 
		 * 
		 */		
		public function getImageListURLByConfigXML(configXML:XML):Vector.<String>{
			var list:Vector.<String> = new Vector.<String>();
			for each(var xml:XML in configXML.child("images").child("image")){
				list.push(xml.@src);
			}
			imageCount = list.length;
			return list;
		}
	}
}