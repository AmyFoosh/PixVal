package {

	import flash.display.Sprite;

	public class ScreenController extends Sprite {

		// ---------------------------------------

		// Here are the screens.

		private var playScreen: PlayScreen;

		// ---------------------------------------

		public function ScreenController() {

			init();
		}

		private function init(): void {

			playScreen = new PlayScreen(DocumentClass.scaled, DocumentClass.scaled2, DocumentClass.screenW, DocumentClass.screenH);
			addChild(playScreen);
		}



	}
}