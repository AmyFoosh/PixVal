package {

	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.desktop.SystemIdleMode;
	import flash.display.StageOrientation;

	public class DocumentClass extends Sprite {

		// ---------------------------------------

		// - These variables are used for scaling the content.
		// - screenW will get Screen Width from current device, the same for screenH with Screen Height.
		// - scaled will calculate a value between current device resolution and original app resolution.
		// - That will resize correctly the game to any device with any resolution.
		// - scaled2 is used for speed. you have to multiply any movement with scaled2 to create a desirable result on any device.

		public static var scaled: Number;
		public static var scaled2: Number;
		public static var screenW: int;
		public static var screenH: int;

		// ---------------------------------------

		// This fps variable will control project fps.

		private var fps: int;

		// ---------------------------------------

		// screenController is a container. Will store all game screens.
		// Its function is to show the user the correct screen and to keep separated its functionality with DocumentClass.

		private var screenController: ScreenController;

		// ---------------------------------------

		public function DocumentClass() {

			init();
		}

		private function init(): void {

			configureGame();
			addListeners();

			// ---------------------------------------

			// loadSaveContent() calls a function to initialize SaveManager variables and enable its use.

			SaveManager.loadSaveContent();

			// ---------------------------------------

			// These code lines will add screenController to the screen so it can show game screens.

			screenController = new ScreenController();
			addChild(screenController);

			// ---------------------------------------
		}

		private function configureGame(): void {

			// ---------------------------------------

			// - The following code lines are used to destroy and recreate the stage in order.
			// - They are used to match with any device resolution.

			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			// ---------------------------------------

			// This code line will set the drawing quality to LOW, for best game performance.

			stage.quality = StageQuality.LOW;

			// ---------------------------------------

			// - scaled will get a value based on dividing the width of the current device with the original value of the application.
			// This will let you know how much an object needs to stretch or shrink to look good at all resolutions on all devices.
			// - scaled2 is almost similar, but for speed instead drawings.
			// - screenW and screenH simply get the width and height of the device for easy access.

			scaled = stage.stageWidth / 1280;
			scaled2 = stage.stageHeight / 720;
			screenW = stage.stageWidth;
			screenH = stage.stageHeight;

			// ---------------------------------------

			// - fps will set the game fps to a desirable value and will be passed to stage.frameRate to perform this action.
			// - Mobile standard is 60 fps, so choosing, for example, 120 fps is useless since not all device can support it.

			fps = 60;
			stage.frameRate = fps;

			// ---------------------------------------

			// The following code lines in order are to enable multitouch mode and avoid device for blocking screen while game is open.

			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;

			// ---------------------------------------
		}

		private function addListeners(): void {

			// ---------------------------------------

			// - These code lines in order are to check when the user press the BACK key, exit and enters the application.
			// - Certain functions will be called to control and prevent the game for a non desirable behavior.

			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, preventDefaultExit, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, inactive, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, active, false, 0, true);

			// ---------------------------------------

			// This code line will check if the device is rotated horizontally to left or right and adjust content based on that.

			addEventListener(Event.ENTER_FRAME, checkDeviceOrientation, false, 0, true);

			// ---------------------------------------
		}

		private function preventDefaultExit(event: KeyboardEvent): void {

			// ---------------------------------------

			// This prevents the mobile from closing the game when user press BACK key.

			if (event.keyCode == Keyboard.BACK) event.preventDefault();

			// ---------------------------------------
		}

		private function inactive(event: Event): void {

			// ---------------------------------------

			// When the user exits the application, fps become 0 to avoid consuming a lot of battery.

			stage.frameRate = fps;
		}

		private function active(event: Event): void {

			// ---------------------------------------

			// Once the user goes back to the application, we restore fps original value.

			stage.frameRate = fps;
		}

		private function checkDeviceOrientation(event: Event): void {

			// ---------------------------------------

			// This will check if the device is rotated left or right.
			// If rotated right, we adjust the content to left and the opposite.

			switch (stage.deviceOrientation) {

				case StageOrientation.ROTATED_RIGHT:
					stage.setOrientation(StageOrientation.ROTATED_LEFT);
					break;

				case StageOrientation.ROTATED_LEFT:
					stage.setOrientation(StageOrientation.ROTATED_RIGHT);
					break;
			}

			// ---------------------------------------
		}



	}
}