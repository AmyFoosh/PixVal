package {

	import flash.display.Sprite;
	import flash.events.Event;

	public class ScreenSuperclass extends Sprite {

		public var scaled: Number;
		public var scaled2: Number;
		public var screenW: int;
		public var screenH: int;

		public function ScreenSuperclass(scaled: Number, scaled2: Number, screenW: int, screenH: int) {

			this.scaled = scaled;
			this.scaled2 = scaled2;
			this.screenW = screenW;
			this.screenH = screenH;

			init();
		}

		private function init(): void {

			addEventListener(Event.ADDED_TO_STAGE, canAddContent, false, 0, true);
		}

		private function canAddContent(event: Event): void {

			removeEventListener(Event.ADDED_TO_STAGE, canAddContent, false);

			initializeVariables();
			addContent();
			adjustContent();
			addListeners();
		}

		public function initializeVariables(): void {

			// This function must be overrited.
		}

		public function addContent(): void {

			// This function must be overrited.
		}

		public function adjustContent(): void {

			// This function must be overrited.
		}

		public function addListeners(): void {

			// This function must be overrited.
		}

		public function removeListeners(): void {

			// This function must be overrited.
		}


	}
}