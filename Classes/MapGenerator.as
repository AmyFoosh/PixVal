package {

	public class MapGenerator {

		// ---------------------------------------

		// UTILS

		// This will store a 2 dimensions array with a number grid to create the map.
		private var map: Array;

		// This will be the area that can be walked by the player, pets an enemies.
		public var initialSize: int;

		// This will store the map max size.
		public var maxSize: int;

		// ---------------------------------------

		public function MapGenerator(initialSize: int, maxSize: int) {

			map = new Array();

			this.initialSize = initialSize;
			this.maxSize = maxSize;

			createBlankMap();
		}

		/*
			This function creates the map array as a 2 dimensions array.
			Right now is just filled with 0.
		*/

		private function createBlankMap(): void {

			var array: Array = new Array();

			for (var i: int = 0; i < maxSize; i++) {

				for (var j: int = 0; j < maxSize; j++) {

					array.push(0);
				}

				map.push(array);
				array = new Array();
			}

			addMapZone();
		}


		/*
			This function will create the initial 3x3 area where player can walk.
			It can be increased lately.
			Initial area is filled with 1.
		*/

		public function addMapZone(): void {

			var middle: int = maxSize / 2;
			var middle2: int = initialSize / 2;

			for (var i: int = middle - middle2; i < middle + middle2 + 1; i++) {

				for (var j: int = middle - middle2; j < middle + middle2 + 1; j++) {

					map[i][j] = 1;
				}
			}
		}


		/*
			This function returns the map so the PlayScreen class can create a
			based tile map with map array indications.
		*/

		public function getMapPlain(): Array {

			return map;
		}


		/*
			This function increases map zone that can be walked by the player.
		*/

		public function expandMap(): void {

			initialSize += 2;
			addMapZone();
		}



	}
}