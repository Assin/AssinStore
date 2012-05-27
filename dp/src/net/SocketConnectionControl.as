package net {
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	
	
	public class SocketConnectionControl {
		//客户端编号 1-7     (-1表示主控制客户端)
		private var clientID:int;
		//处理socket数据回调的客户端函数
		private var dataCallBackFun:Function;
		//连接的socket
		private var socket:Socket;
		//socket地址
		public var socketAddress:String;
		//socket端口
		public var socketPort:int;
		
		public function SocketConnectionControl(clientId:int, dataFun:Function) {
			this.clientID = clientId;
			this.dataCallBackFun = dataFun;
		}
		
		public function initSocket():void {
			this.socket = new Socket();
			this.socket.addEventListener(Event.CONNECT, onConnect);
			this.socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataIn);
			this.socket.connect(this.socketAddress, this.socketPort);
		}
		
		//处理socket回调数据
		private function onSocketDataIn(e:ProgressEvent):void {
			
			if (this.dataCallBackFun != null) {
				var byteArray:ByteArray = new ByteArray();
				this.socket.readBytes(byteArray, 0, this.socket.bytesAvailable);
				var length:int = byteArray.readInt();
				trace(length);
				var content:String = byteArray.readUTFBytes(byteArray.bytesAvailable);
				trace(content);
				this.dataCallBackFun(length, content);
			}
		}
		
		//广播数据方法
		public function sendObjectData(data:Object):void {
			if (this.socket.connected) {
				var jsonString:String = JSON.encode(data);
				var byteArray:ByteArray = new ByteArray();
				var contentArray:ByteArray = new ByteArray();
				byteArray.position = 0;
				contentArray.writeUTFBytes(jsonString);
				byteArray.writeInt(contentArray.length);
				byteArray.writeBytes(contentArray, 0, contentArray.bytesAvailable);
				byteArray.position = 0;
				this.socket.writeBytes(byteArray, 0, byteArray.bytesAvailable);
				
				this.socket.flush();
			}
		}
		
		private function onConnect(e:Event):void {
			this.socket.removeEventListener(Event.CONNECT, onConnect);
		}
		
		
	}
}