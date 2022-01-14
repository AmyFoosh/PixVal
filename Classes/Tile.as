package {

	public class Tile extends AssetSuperclass {

		// ---------------------------------------

		// UTILS

		public var tileName: String;
		private var display;

		// ---------------------------------------

		public function Tile(scaled: Number, tileName: String) {

			this.tileName = tileName;

			loadTileDisplay();
			super(scaled, display);
		}

		// ---------------------------------------

		// DISPLAY

		private function loadTileDisplay(): void {

			switch (tileName) {

				case "Ground":
					display = new TileGround;
					break;
				case "Water":
					display = new TileWater;
					break;
			}
		}

		// ---------------------------------------

		// GET

		public function get getTileName(): String {

			return tileName;
		}

		// ---------------------------------------

		// SET

		public function set setTileName(value: String): void {

			tileName = value;
		}

		// ---------------------------------------

		
	}
}