package {

	public class Particle extends AssetSuperclass {

		// ---------------------------------------

		// UTILS

		private var scaled: Number;
		private var scaled2: Number;

		private var angle: Number;
		private var mustDelete: Boolean;

		private var particleName: String;
		private var display;

		// ---------------------------------------

		// STATS

		private var flyingTime: int;
		private var movementSpeed: Number;

		// ---------------------------------------

		public function Particle(scaled: Number, scaled2: Number, particleName: String) {

			// ---------------------------------------

			// UTILS

			this.scaled = scaled;
			this.scaled2 = scaled2;

			angle = Math.random() * 360 * Math.PI / 180;
			mustDelete = false;

			this.particleName = particleName;

			// ---------------------------------------

			// STATS

			flyingTime = 10 + Math.ceil(Math.random() * 20);
			movementSpeed = Math.ceil(Math.random() * 5) * scaled2;

			// ---------------------------------------

			// DISPLAY

			loadDisplay();
			super(scaled, display);

			// ---------------------------------------
		}

		// ---------------------------------------

		// DISPLAY

		private function loadDisplay(): void {

			switch (particleName) {

				case "ParticleDamage":
					display = new ParticleDamage();
					break;
				case "ParticlePoison":
					display = new ParticlePoison();
					break;
				case "ParticleSlow":
					display = new ParticleSlow();
					break;
				case "ParticleSpawn":
					display = new ParticleSpawn();
					break;
				case "ParticleStun":
					display = new ParticleStun();
					break;
			}
		}

		// ---------------------------------------

		// MOVEMENT

		public function move(): void {

			movementSpeed *= 0.95;

			x -= Math.cos(angle) * movementSpeed;
			y -= Math.sin(angle) * movementSpeed;

			flyingTime--;

			if (flyingTime <= 0) mustDelete = true;
		}

		// ---------------------------------------

		// GET

		public function getMustDelete(): Boolean {

			return mustDelete;
		}

		// ---------------------------------------


	}
}