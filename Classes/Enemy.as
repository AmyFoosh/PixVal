package {

	public class Enemy extends Entity {

		// ---------------------------------------

		// UTILS

		private var enemyName: String;

		// ---------------------------------------

		public function Enemy(scaled: Number, scaled2: Number, enemyName: String) {

			// ---------------------------------------

			super(scaled, scaled2);

			// ---------------------------------------

			// UTILS

			this.enemyName = enemyName;

			// ---------------------------------------

			// DISPLAY

			loadDisplay();

			// ---------------------------------------

			// STATS

			loadStartingStats();

			// ---------------------------------------
		}

		// ---------------------------------------

		// DISPLAY

		private function loadDisplay(): void {

			switch (enemyName) {

				case "Scarecrow":
					loadScarecrowDisplay();
					break;
			}
		}

		private function loadScarecrowDisplay(): void {

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

		// ---------------------------------------

		// STATS

		private function loadStartingStats(): void {

			health = 3;
			healthOriginalValue = health;

			attack = 1;
			attackOriginalValue = attack;

			defense = 0;
			defenseOriginalValue = defense;

			movementSpeed = 0;
			movementSpeedOriginalValue = 1 * scaled2;
			movementSpeedIncrement = 0.25 * scaled2;
		}

		// ---------------------------------------

		// MOVEMENT

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

			x -= Math.cos(angle) * (movementSpeed * (1 - slowedAmount));
			y -= Math.sin(angle) * (movementSpeed * (1 - slowedAmount));

			// ---------------------------------------

			// LIMITS

			// enemyLimits(ground);

			// ---------------------------------------
		}

		private function enemyLimits(ground: Object): void {

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