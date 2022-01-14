package {

	import flash.display.Sprite;
	import flash.events.TouchEvent;

	public class CharacterSelector extends Sprite {

		// ---------------------------------------

		// UTILS

		private var scaled: Number;
		private var scaled2: Number;
		private var screenW: int;
		private var screenH: int;

		private var playerKit: String;

		// ---------------------------------------

		// AVAIABLE CHARACTERS

		private var sselya: Player;
		private var amy: Player;
		private var artemis: Player;
		private var ring: Player;
		private var neal: Player;
		private var hory: Player;
		private var valeey: Player;
		private var lucy: Player;

		// ---------------------------------------

		public function CharacterSelector(scaled: Number, scaled2: Number, screenW: int, screenH: int) {

			this.scaled = scaled;
			this.scaled2 = scaled2;
			this.screenW = screenW;
			this.screenH = screenH;

			init();
		}
		
		public function getPlayerKit(): String {
			
			return playerKit;
		}

		private function init(): void {

			var subDivision: int = screenW / 8;
			var limits: int = subDivision / 2;

			sselya = new Player(scaled * 0.8, scaled2, "Sselya");
			addChild(sselya);

			amy = new Player(scaled * 0.8, scaled2, "Amy");
			addChild(amy);

			artemis = new Player(scaled * 0.8, scaled2, "Artemis");
			addChild(artemis);

			ring = new Player(scaled * 0.8, scaled2, "Ring");
			addChild(ring);

			neal = new Player(scaled * 0.8, scaled2, "Neal");
			addChild(neal);

			hory = new Player(scaled * 0.8, scaled2, "Hory");
			addChild(hory);

			valeey = new Player(scaled * 0.8, scaled2, "Valeey");
			addChild(valeey);

			lucy = new Player(scaled * 0.8, scaled2, "Lucy");
			addChild(lucy);

			sselya.x = subDivision * 1 - limits;
			sselya.y = screenH / 2;

			amy.x = subDivision * 2 - limits;
			amy.y = screenH / 2;

			artemis.x = subDivision * 3 - limits;
			artemis.y = screenH / 2;

			ring.x = subDivision * 4 - limits;
			ring.y = screenH / 2;

			neal.x = subDivision * 5 - limits;
			neal.y = screenH / 2;

			hory.x = subDivision * 6 - limits;
			hory.y = screenH / 2;

			valeey.x = subDivision * 7 - limits;
			valeey.y = screenH / 2;

			lucy.x = subDivision * 8 - limits;
			lucy.y = screenH / 2;


			amy.addEventListener(TouchEvent.TOUCH_TAP, amySelected, false, 0, true);
			artemis.addEventListener(TouchEvent.TOUCH_TAP, artemisSelected, false, 0, true);
			hory.addEventListener(TouchEvent.TOUCH_TAP, horySelected, false, 0, true);
			lucy.addEventListener(TouchEvent.TOUCH_TAP, lucySelected, false, 0, true);
			neal.addEventListener(TouchEvent.TOUCH_TAP, nealSelected, false, 0, true);
			ring.addEventListener(TouchEvent.TOUCH_TAP, ringSelected, false, 0, true);
			sselya.addEventListener(TouchEvent.TOUCH_TAP, sselyaSelected, false, 0, true);
			valeey.addEventListener(TouchEvent.TOUCH_TAP, valeeySelected, false, 0, true);
		}

		private function amySelected(event: TouchEvent): void {

			playerKit = "Amy";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function artemisSelected(event: TouchEvent): void {

			playerKit = "Artemis";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function horySelected(event: TouchEvent): void {

			playerKit = "Hory";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function lucySelected(event: TouchEvent): void {

			playerKit = "Lucy";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function nealSelected(event: TouchEvent): void {

			playerKit = "Neal";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function ringSelected(event: TouchEvent): void {

			playerKit = "Ring";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function sselyaSelected(event: TouchEvent): void {

			playerKit = "Sselya";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}

		private function valeeySelected(event: TouchEvent): void {

			playerKit = "Valeey";
			dispatchEvent(new CharacterSelectorEvent(CharacterSelectorEvent.CHARACTER_SELECTED));
		}



	}
}