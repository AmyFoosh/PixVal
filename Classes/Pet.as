package {

	public class Pet extends Entity {

		public function Pet(scaled: Number, scaled2: Number) {

			// ---------------------------------------

			super(scaled, scaled2);

			// ---------------------------------------

			// STATS

			health = 10;
			healthOriginalValue = health;

			attack = 1;
			attackOriginalValue = attack;

			defense = 0;
			defenseOriginalValue = defense;

			movementSpeed = 0;
			movementSpeedOriginalValue = 1 * scaled2;
			movementSpeedIncrement = 0.25 * scaled2;

			// ---------------------------------------

			// DISPLAY	

			loadPetDisplay();

			// ---------------------------------------
		}

		// ---------------------------------------

		// DISPLAY

		private function loadPetDisplay(): void {

			var random: Number = Math.ceil(Math.random() * 8);

			switch (random) {

				case 1:
					display = new AssetSuperclass(scaled, new ScarecrowAmy);
					break;
				case 2:
					display = new AssetSuperclass(scaled, new ScarecrowArtemis);
					break;
				case 3:
					display = new AssetSuperclass(scaled, new ScarecrowHory);

					health *= 1.5;
					attack *= 1.5;
					defense *= 1.5;

					movementSpeedOriginalValue *= 1.5;
					movementSpeedIncrement *= 1.5;
					break;
				case 4:
					display = new AssetSuperclass(scaled, new ScarecrowLucy);
					break;
				case 5:
					display = new AssetSuperclass(scaled, new ScarecrowNeal);
					break;
				case 6:
					display = new AssetSuperclass(scaled, new ScarecrowRing);
					break;
				case 7:
					display = new AssetSuperclass(scaled, new ScarecrowSselya);
					break;
				case 8:
					display = new AssetSuperclass(scaled, new ScarecrowValeey);
					break;
			}

			addChild(display);
		}

		public function move(angle: Number): void {

			// ---------------------------------------

			// DEBUFFS

			tickDebuffs();
			if (stunned) return;
			if (knockback) return;

			// ---------------------------------------

			// MOVEMENT

			movementSpeed += movementSpeedIncrement;

			if (movementSpeed > movementSpeedOriginalValue) movementSpeed = movementSpeedOriginalValue;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			// ---------------------------------------

			// LIMITS

			// petLimits(ground);

			// ---------------------------------------
		}

		private function petLimits(ground: Object): void {

			// X COORD

			if (x < ground.x - ground.width / 2) {

				x = ground.x - ground.width / 2;

			} else if (x > ground.x + ground.width / 2) {

				x = ground.x + ground.width / 2;
			}

			// Y COORD

			if (y < ground.y - ground.height / 2) {

				y = ground.y - ground.height / 2;

			} else if (y > ground.y + ground.height / 2) {

				y = ground.y + ground.height / 2
			}
		}




	}
}