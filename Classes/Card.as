package {

	public class Card extends AssetSuperclass {

		// ---------------------------------------

		// UTILS AND DISPLAY

		private var scaled: Number;
		private var cardName: String;
		private var cardDisplay;

		// ---------------------------------------

		public function Card(scaled: Number, cardName: String) {

			// ---------------------------------------

			this.scaled = scaled;
			this.cardName = cardName;

			// ---------------------------------------

			loadCardDisplay();
			super(scaled, cardDisplay);

			// ---------------------------------------
		}

		private function loadCardDisplay(): void {

			amyDisplay();
			artemisDisplay();
			horyDisplay();
			lucyDisplay();
			nealDisplay();
			ringDisplay();
			sselyaDisplay();
			valeeyDisplay();
		}

		private function amyDisplay(): void {

			switch (cardName) {

				case "Amy":
					cardDisplay = new AmyCardStanding();
					break;
			}
		}

		private function artemisDisplay(): void {

			switch (cardName) {

				case "Artemis":
					cardDisplay = new ArtemisCardStanding();
					break;
			}
		}

		private function horyDisplay(): void {

			switch (cardName) {

				case "Hory":
					cardDisplay = new HoryCardStanding();
					break;
			}
		}

		private function lucyDisplay(): void {

			switch (cardName) {

				case "Lucy":
					cardDisplay = new LucyCardStanding();
					break;
			}
		}

		private function nealDisplay(): void {

			switch (cardName) {

				case "Neal":
					cardDisplay = new NealCardStanding();
					break;
			}
		}

		private function ringDisplay(): void {

			switch (cardName) {

				case "Ring":
					cardDisplay = new RingCardStanding();
					break;
			}
		}

		private function sselyaDisplay(): void {

			switch (cardName) {

				case "Sselya":
					cardDisplay = new SselyaCardStanding();
					break;
			}
		}

		private function valeeyDisplay(): void {

			switch (cardName) {

				case "Valeey":
					cardDisplay = new ValeeyCardStanding();
					break;
			}
		}




	}
}