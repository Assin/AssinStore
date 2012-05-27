package view.map {
	import data.GameConfig;
	import data.Global;
	import data.IDispose;
	import data.RoleType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import model.DataManager;
	import model.SoundManager;
	
	public class Map extends Sprite implements IDispose {
		public var tileContainer:Sprite;
		public var roleView:RoleView;
		private var isRoleViewMoving:Boolean;
		
		public function Map() {
			super();
		}
		
		public function initMap(mapTileDataTable:Array):void {
			tileContainer = new Sprite();
			tileContainer.mouseChildren = false;
			tileContainer.mouseEnabled = false;
			this.addChild(tileContainer);
			
			var mapTile:MapTile;
			var mapTileViewDataTable:Array = [];
			
			for (var i:int = 0; i < mapTileDataTable.length; i++) {
				mapTileViewDataTable.push([]);
				
				for (var j:int = 0; j < mapTileDataTable[i].length; j++) {
					mapTile = new MapTile();
					mapTile.mapTileVO = mapTileDataTable[i][j];
					mapTileViewDataTable[i].push(mapTile);
					
					if (Global.currentRoleType == RoleType.CONTROLLER) {
						tileContainer.addChild(mapTile);
					}
				}
			}
			Global.currentMapTileViewTable = mapTileViewDataTable;
			
			if (Global.currentRoleType == RoleType.EXPLORER) {
				tileContainer.graphics.beginFill(0x000000);
				tileContainer.graphics.drawRect(0, 0, this.width, this.height);
				tileContainer.graphics.endFill();
			}
			
		}
		
		public function initRoleView():void {
			roleView = new RoleView();
			roleView.setLocationByColRow(0, 0);
			this.addChild(roleView);
		}
		
		public function initKeyboardEvent():void {
			if (Global.currentRoleType == RoleType.CONTROLLER) {
				return ;
			}
			
			if (stage) {
				this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDownHandler);
			} else {
				this.addEventListener(Event.ADDED_TO_STAGE, function(evt:Event):void {
					removeEventListener(evt.type, arguments.callee);
					stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDownHandler);
				});
			}
			
		}
		
		private function onStageKeyDownHandler(e:KeyboardEvent):void {
			if (this.isRoleViewMoving) {
				return ;
			}
			var currentRoleViewLocationCol:int = this.roleView.col;
			var currentRoleViewLocationRow:int = this.roleView.row;
			var targetCol:int = currentRoleViewLocationCol;
			var targetRow:int = currentRoleViewLocationRow;
			trace("currentRoleViewLocation:", currentRoleViewLocationCol, currentRoleViewLocationRow);
			
			if (e.keyCode == Keyboard.UP) {
				//上
				if (currentRoleViewLocationRow > 0)
					targetRow = currentRoleViewLocationRow - 1;
			} else if (e.keyCode == Keyboard.DOWN) {
				//下
				if (currentRoleViewLocationRow < GameConfig.MAPTILE_ROW_NUM - 1)
					targetRow = currentRoleViewLocationRow + 1;
			} else if (e.keyCode == Keyboard.LEFT) {
				//左
				if (currentRoleViewLocationCol > 0)
					targetCol = currentRoleViewLocationCol - 1;
			} else if (e.keyCode == Keyboard.RIGHT) {
				//右
				if (currentRoleViewLocationCol < GameConfig.MAPTIlE_COL_NUM - 1)
					targetCol = currentRoleViewLocationCol + 1;
			}
			
			if (targetCol != currentRoleViewLocationCol || targetRow != currentRoleViewLocationRow) {
				trace("moveToTarget:", targetCol, targetRow);
				
				if (Global.getMapTileWalkable(targetCol, targetRow)) {
					roleViewMoveToColRowByTween(targetCol, targetRow, onRoleViewMoveComplete);
					var obj:Object = {};
					obj["key"] = "move";
					obj["x"] = targetCol;
					obj["y"] = targetRow;
					DataManager.getInstance().sendObjectToSocket(obj);
				}
			}
		}
		
		/**
		 * 让人物进行移动，被动还是主动的都使用这个接口
		 * @param col
		 * @param row
		 * @param complete
		 *
		 */
		public function roleViewMoveToColRowByTween(col:int, row:int, complete:Function):void {
			if (this.isRoleViewMoving) {
				return ;
			}
			this.isRoleViewMoving = true;
			this.roleView.moveToColRowByTween(col, row, complete);
		}
		
		public function onRoleViewMoveComplete():void {
			var mapTile:MapTile = Global.getMapTileView(this.roleView.col, this.roleView.row);
			
			if (mapTile.mapTileVO.hasGold) {
				//如果有金币就消除
				mapTile.mapTileVO.goldValue = 0;
				mapTile.updateView();
				Global.main.txtGold.text = String((int(Global.main.txtGold.text)) + 1);
				SoundManager.inst.playSound("GoldSound",1,0,1);
			}
			this.isRoleViewMoving = false;
		}
		
		public function dispose():void {
		}
	}
}