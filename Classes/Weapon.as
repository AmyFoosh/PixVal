package {

	public class Weapon extends AssetSuperclass {

		// ---------------------------------------

		// UTILS

		private var scaled: Number;
		private var scaled2: Number;

		private var angle: Number;
		private var mustDelete: Boolean;
		private var throwingWeapon: Boolean;
		private var canDealDamage: Boolean;

		// ---------------------------------------

		// DISPLAY

		private var weaponName: String;
		private var weaponDisplay;

		// ---------------------------------------

		// STATS

		private var attack: Number;
		private var flyingTime: int;

		private var movementSpeed: Number;
		private var movementSpeedOriginalValue: Number;
		private var movementSpeedIncrement: Number;

		private var pierce: int;
		private var pierceOriginalValue: int;

		// ---------------------------------------

		public function Weapon(scaled: Number, scaled2: Number, angle: Number, weaponName: String, attack: Number, movementSpeed: Number, flyingTime: int) {

			// ---------------------------------------

			// UTILS

			this.scaled = scaled;
			this.scaled2 = scaled2;

			this.angle = angle;
			mustDelete = false;
			throwingWeapon = false;
			canDealDamage = true;

			// ---------------------------------------

			// STATS

			this.attack = attack;
			this.flyingTime = flyingTime;

			this.movementSpeed = 0;
			movementSpeedOriginalValue = movementSpeed * scaled2;
			movementSpeedIncrement = 1 * scaled2;

			// ---------------------------------------

			// DISPLAY

			this.weaponName = weaponName;
			loadWeaponDisplay();
			super(scaled, weaponDisplay);

			// ---------------------------------------
		}

		// ---------------------------------------

		// DISPLAY

		private function loadWeaponDisplay(): void {

			switch (weaponName) {

				case "Bullet":
					weaponDisplay = new Bullet();
					rotation = angle / Math.PI * 180;
					throwingWeapon = true;
					break;
				case "Amy":
					weaponDisplay = new AmyWeaponSpearHalfmoon();
					rotation = angle / Math.PI * 180;
					flyingTime = 15;
					movementSpeedOriginalValue = 1 * scaled2;
					movementSpeedIncrement = 1 * scaled2;
					pierce = 3;
					pierceOriginalValue = pierce;
					break;
				case "Artemis":
					weaponDisplay = new ArtemisWeaponSword();
					rotation = angle / Math.PI * 180;
					flyingTime = 15;
					movementSpeedOriginalValue = 1 * scaled2;
					movementSpeedIncrement = 1 * scaled2;
					pierce = 3;
					pierceOriginalValue = pierce;
					break;
				case "Lucy":
					weaponDisplay = new LucyWeaponMark();
					flyingTime = 10;
					break;
				case "Neal":
					weaponDisplay = new NealWeaponKnife();
					rotation = angle / Math.PI * 180;
					throwingWeapon = true;
					break;
				case "Ring":
					weaponDisplay = new RingWeaponMetal();
					rotation = angle / Math.PI * 180;
					throwingWeapon = true;
					break;
				case "Sselya":
					weaponDisplay = new SselyaWeaponPotion();
					rotation = angle / Math.PI * 180;
					throwingWeapon = true;
					break;
				case "SselyaSplash":
					weaponDisplay = new SselyaWeaponSplash();
					flyingTime = 20;
					pierce = 5;
					pierceOriginalValue = pierce;
					break;
				case "Valeey":
					weaponDisplay = new ValeeyWeaponDagger();
					rotation = angle / Math.PI * 180;
					throwingWeapon = true;
					break;
			}
		}

		public function setStartingPosition(object: Object, distance: Number): void {

			x = object.x - Math.cos(angle) * distance * scaled;
			y = object.y - Math.sin(angle) * distance * scaled;
		}

		// ---------------------------------------

		// MOVEMENT

		public function move(): void {

			switch (weaponName) {

				case "Bullet":
					bulletMovement();
					break;
				case "Amy":
					amyMovement();
					break;
				case "Artemis":
					artemisMovement();
					break;
				case "Lucy":
					lucyMovement();
					break;
				case "Neal":
					nealMovement();
					break;
				case "Ring":
					ringMovement();
					break;
				case "Sselya":
					sselyaMovement();
					break;
				case "SselyaSplash":
					sselyaSplashMovement();
					break;
				case "Valeey":
					valeeyMovement();
					break;
			}
		}

		private function bulletMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function amyMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function artemisMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function lucyMovement(): void {

			movementSpeedOriginalValue *= 0.8;

			y -= movementSpeedOriginalValue;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function nealMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function ringMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function sselyaMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function sselyaSplashMovement(): void {

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		private function valeeyMovement(): void {

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;

			if (flyingTime % 4 == 0) rotation += 90;
		}

		// ---------------------------------------

		// GET

		public function get getWeaponName(): String {

			return weaponName;
		}

		public function get getMustDelete(): Boolean {

			return mustDelete;
		}

		public function get getThrowingWeapon(): Boolean {

			return throwingWeapon;
		}

		public function get getCanDealDamage(): Boolean {

			return canDealDamage;
		}
		
		public function get getPierce(): int {
			
			return pierce;
		}
		
		public function get getPierceOriginalValue(): int {
			
			return pierceOriginalValue;
		}
		
		// ---------------------------------------

		// SET

		public function set setMustDelete(value: Boolean): void {

			mustDelete = value;
		}

		public function set setCanDealDamage(value: Boolean): void {

			canDealDamage = value;
		}
		
		public function set setPierce(value: int): void {
			
			pierce = value;
		}
		
		public function set setPierceOriginalValue(value: int): void {
			
			pierceOriginalValue = value;
		}

		// ---------------------------------------



	}
}