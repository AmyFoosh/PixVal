package {

	import flash.display.Sprite;
	import flash.events.TouchEvent;
	import flash.events.Event;

	public class Joystick extends Sprite {

		// ---------------------------------------

		private var scaled: Number;
		private var screenW: int;
		private var screenH: int;

		// ---------------------------------------

		// This variable must be called when we want to check if the user is using the joystick.

		private var joystickIsClicked: Boolean;

		// ---------------------------------------

		// These variables will tell where the joystick is pointing, so content can be moved in that direction.

		private var angle: Number;
		private var dirX: Number;
		private var dirY: Number;

		// ---------------------------------------

		// These variables are just a container to choose a custom joystick and pass them to variables from below.

		private var joyBG: Sprite;
		private var joyAnalog: Sprite;
		private var joyArea: Sprite;

		// ---------------------------------------

		// These variables are the images that will represent the joystick.

		public var joystickBG: AssetSuperclass;
		public var joystickAnalog: AssetSuperclass;
		private var joystickAreaBG: BackgroundSuperclass;

		// ---------------------------------------

		// - This code lines will store starting joystick coordinates.
		// - When the user stops using the joystick, will return to this position.

		private var startPosX: int;
		private var startPosY: int;

		// ---------------------------------------

		public function Joystick(scaled: Number, screenW: int, screenH: int, joystickBG: Sprite, joystickAnalog: Sprite, joystickArea) {

			this.scaled = scaled;
			this.screenW = screenW;
			this.screenH = screenH;

			joystickIsClicked = false;

			joyBG = joystickBG;
			joyAnalog = joystickAnalog;
			joyArea = joystickArea;

			init();
		}

		public function setStartPos(posX: int, posY: int): void {

			// ---------------------------------------

			// - This function must be called once the joystick is initialized and added to stage.
			// - Here, the joystick will know where to move its content once the player releases it.
			// - This is also the initial joystick position.

			startPosX = joystickAnalog.x = joystickBG.x = posX;
			startPosY = joystickAnalog.y = joystickBG.y = posY;

			// ---------------------------------------
		}

		private function init(): void {

			addEventListener(Event.ADDED_TO_STAGE, canAddContent, false, 0, true);
		}

		private function canAddContent(event: Event): void {

			removeEventListener(Event.ADDED_TO_STAGE, canAddContent, false);

			addContent();
			addListeners();
		}

		private function addContent(): void {

			joystickBG = new AssetSuperclass(scaled, joyBG);
			addChild(joystickBG);

			joystickAnalog = new AssetSuperclass(scaled, joyAnalog);
			addChild(joystickAnalog);

			joystickAreaBG = new BackgroundSuperclass(screenW, screenH, joyArea);
			addChild(joystickAreaBG);
		}

		private function addListeners(): void {

			// ---------------------------------------

			// These listeners are to check when the user is touching the joystick area.

			joystickAreaBG.addEventListener(TouchEvent.TOUCH_BEGIN, joystickClicked, false, 0, true);
			joystickAreaBG.addEventListener(TouchEvent.TOUCH_END, joystickUnclicked, false, 0, true);
			joystickAreaBG.addEventListener(TouchEvent.TOUCH_OUT, joystickUnclicked, false, 0, true);

			// ---------------------------------------
		}

		public function adjustContent(): void {

			joystickBG.x = startPosX;
			joystickBG.y = startPosY;
		}

		private function joystickClicked(event: TouchEvent): void {

			// ---------------------------------------

			// This boolean value is used to check if the user has touched the joystick and move content based on that.

			setJoystickIsClicked = true;

			// ---------------------------------------

			// This code will locate the joystick to the user finger point.

			joystickBG.x = event.localX;
			joystickBG.y = event.localY;

			joystickAnalog.x = event.localX;
			joystickAnalog.y = event.localY;

			joystickAnalog.startTouchDrag(event.touchPointID);

			// ---------------------------------------
		}

		private function joystickUnclicked(event: TouchEvent): void {

			setJoystickIsClicked = false;

			joystickAnalog.stopTouchDrag(event.touchPointID);
		}

		public function tick(): void {

			if (joystickIsClicked) {

				checkJoystickAnalogLimits();
				calculateDirection();

			} else {

				adjustContent();

				joystickAnalog.x += (joystickBG.x - joystickAnalog.x) / 5;
				joystickAnalog.y += (joystickBG.y - joystickAnalog.y) / 5;
			}
		}

		private function checkJoystickAnalogLimits(): void {

			// ---------------------------------------

			// This code will prevent the joystick from being too far away from its background.

			if (joystickAnalog.x > joystickBG.x + joystickBG.width / 2.5) {

				joystickAnalog.x = joystickBG.x + joystickBG.width / 2.5;

			} else if (joystickAnalog.x < joystickBG.x - joystickBG.width / 2.5) {

				joystickAnalog.x = joystickBG.x - joystickBG.width / 2.5;
			}

			if (joystickAnalog.y > joystickBG.y + joystickBG.height / 2.5) {

				joystickAnalog.y = joystickBG.y + joystickBG.height / 2.5;

			} else if (joystickAnalog.y < joystickBG.y - joystickBG.height / 2.5) {

				joystickAnalog.y = joystickBG.y - joystickBG.height / 2.5;
			}

			// ---------------------------------------
		}

		private function calculateDirection(): void {

			// ---------------------------------------

			// This code indicates to where is pointing the joystick once is clicked.

			var valueX: Number = joystickBG.x - joystickAnalog.x;
			var valueY: Number = joystickBG.y - joystickAnalog.y;

			setAngle = Math.atan2(valueY, valueX);

			setDirX = Math.cos(angle);
			setDirY = Math.sin(angle);

			// ---------------------------------------
		}

		public function set setAngle(value: Number): void {

			angle = value;
		}

		public function set setDirX(value: Number): void {

			dirX = value;
		}

		public function set setDirY(value: Number): void {

			dirY = value;
		}

		public function set setJoystickIsClicked(value: Boolean): void {

			joystickIsClicked = value;
		}

		public function get getAngle(): Number {

			return angle;
		}

		public function get getDirX(): Number {

			return dirX;
		}

		public function get getDirY(): Number {

			return dirY;
		}

		public function get getJoystickIsClicked(): Boolean {

			return joystickIsClicked;
		}



	}
}