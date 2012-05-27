package view.map {
	import data.GameConfig;
	import data.IDispose;
	
	import flash.display.Sprite;
	
	import model.MapTileVO;
	
	public class MapTile extends MapElement {
		private var _mapTileVO:MapTileVO;
		private var _goldIcon:GoldIcon;
		public function MapTile() {
			super();
		}
		
		public function get mapTileVO():MapTileVO {
			return _mapTileVO;
		}
		
		public function set mapTileVO(value:MapTileVO):void {
			_mapTileVO = value;
			
			if (_mapTileVO != null)
				this.update();
		}
		
		private function update():void {
			this.setLocationByColRow(_mapTileVO.row, _mapTileVO.col);
			this.updateView();
		}
		
		public function updateView():void{
			//根据VO数据 改变显示
			if(this._goldIcon != null)
			{
				if(this.contains(this._goldIcon)){
					this.removeChild(this._goldIcon);
				}
				this._goldIcon = null;
			}
			if(_mapTileVO.hasGold)
			{
				this._goldIcon = new GoldIcon();
				this.addChild(this._goldIcon);
			}
		}
		
		
		
		private function removeGold():void{
			
		}
		
	}
}