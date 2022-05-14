package {

	import flash.display.Sprite;

	public class CircularCollision {

		public static function circularHitTestObject(a: Sprite, b: Sprite): Boolean {

			var radA: Number = a.width / 2;
			var radB: Number = b.width / 2;
			var radius: Number = radA + radB;

			return (radius > distanceBetween(a, b)) ? true : false;
		}

		public static function distanceNumber(a: Sprite, b: Sprite): Number {

			return distanceBetween(a, b);
		}

		private static function distanceBetween(a: Sprite, b: Sprite): Number {

			var dx: Number = a.x - b.x;
			var dy: Number = a.y - b.y;

			return Math.sqrt((dx * dx) + (dy * dy));
		}

		public static function getClosestObject(object: Sprite, array: Array): Array {

			var distances: Array = new Array();
			var distance: Number;

			for (var i: int = 0; i < array.length; i++) {

				distance = CircularCollision.distanceNumber(object, array[i]);
				distances.push(distance);
			}

			distances.sort(Array.NUMERIC);

			return distances;
		}




	}
}