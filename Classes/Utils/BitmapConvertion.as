package {

	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;

	public class BitmapConvertion {

		public function convertObject(scale: Number, obj: Sprite): Bitmap {

			var matrix: Matrix = new Matrix();
			matrix.scale(scale, scale);

			var smallBMD: BitmapData = new BitmapData(obj.width * scale, obj.height * scale, true, 0x000000);
			smallBMD.drawWithQuality(obj, matrix, null, null, null, false, "high");
			var bitmap: Bitmap = new Bitmap(smallBMD, PixelSnapping.NEVER, true);

			return bitmap;
		}

		public function convertBackground(screenW: Number, screenH: Number, obj: Sprite): Bitmap {

			obj.scaleX = screenW / 1280;
			obj.scaleY = screenH / 720;

			var matrix: Matrix = new Matrix();
			matrix.scale(obj.scaleX, obj.scaleY);

			var smallBMD: BitmapData = new BitmapData(obj.width, obj.height, true, 0x000000);
			smallBMD.drawWithQuality(obj, matrix, null, null, null, false, "high");
			var bitmap: Bitmap = new Bitmap(smallBMD, PixelSnapping.NEVER, true);

			return bitmap;
		}


	}
}