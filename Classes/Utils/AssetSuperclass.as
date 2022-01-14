package {

	import flash.display.Sprite;
	import flash.display.Bitmap;

	public class AssetSuperclass extends Sprite {

		public var object: Bitmap;

		public function AssetSuperclass(scaled: Number, object: Sprite) {

			init(scaled, object);
		}

		private function init(scaled: Number, o: Sprite): void {

			object = new BitmapConvertion().convertObject(scaled, o);
			object.x = 0 - object.width / 2;
			object.y = 0 - object.height / 2;
			addChild(object);
		}

		public function setPos(posX: Number, posY: Number): void {

			object.x = posX;
			object.y = posY;
		}


	}
}