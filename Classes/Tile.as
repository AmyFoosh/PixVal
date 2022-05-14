package {

	import flash.display.Sprite;

	public class Tile extends AssetSuperclass {

		// ---------------------------------------

		// UTILS

		// What type of tile will be. Options are: Water or Ground.
		public var tileTpye: String;

		// Tile appearence.
		private var display: Sprite;

		// ---------------------------------------

		public function Tile(scaled: Number, tileType: String) {

			// ---------------------------------------

			// TILE SETUP.

			// This variable is needed for player, pets and enemies collisions.
			this.tileTpye = tileType;

			// Choose tile appearence.
			if (tileType == "Ground") display = new Tile1;
			if (tileType == "Water") display = new Tile2;

			// Add tile.
			super(scaled, display);

			// ---------------------------------------
		}


	}
}