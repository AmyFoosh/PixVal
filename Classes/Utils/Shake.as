package {

	import flash.display.Sprite;

	public class Shake {

		public var screenShakeAmount: int;
		private var numberShake: int;

		public function Shake(screenShakeAmount: int) {

			this.screenShakeAmount = screenShakeAmount;
			numberShake = 4;
		}

		public function setShakeAmount(amount: int): void {

			screenShakeAmount = amount;
		}

		public function shakeTick(object: Sprite): void {

			// ---------------------------------------

			// SCREEN SHAKE.

			switch (numberShake) {

				case 1:
					object.x += screenShakeAmount;
					break;
				case 2:
					object.x -= screenShakeAmount;
					break;
				case 3:
					object.y += screenShakeAmount;
					break;
				case 4:
					object.y -= screenShakeAmount;
					break;
			}

			numberShake--;

			if (numberShake == 0) numberShake = 4;
		}


	}
}