package {

	import flash.net.SharedObject;
	import flash.system.Capabilities;

	public class SaveManager {

		// ---------------------------------------

		// - This code line will create a save variable for storing user preferences and game configuration.
		// - Change AylessNoyressGAME-NAME to a proper name based on the game name.

		public static var save: SharedObject = SharedObject.getLocal("AylessNoyressGAME-NAME");

		// ---------------------------------------

		public static function loadSaveContent(): void {

			// ---------------------------------------

			// - This code line removes every data stored in save variable.
			// - Its use is only for testing, can't be uncommented when publishing a new game version.

			// save.clear();

			// ---------------------------------------

			// - From here on, all variables can be writted.
			// - The variables must follow the following structure to be managed independently and avoid a wrong behavior:
			// if (save.data.VARIABLE-NAME == null) save.data.VARIABLE-NAME = VALUE;

			if (save.data.musicEnabled == null) save.data.musicEnabled = true;

			// ---------------------------------------

			loadLanguage();

			// ---------------------------------------

			// - .flush() method must be called every time you change a value from save variable.
			// - If not, data can be lost. Careful.

			save.flush();

			// ---------------------------------------
		}

		public static function loadLanguage(): void {

			// ---------------------------------------

			// - This code block will check the device language and adjust the game language to match with it.
			// - If a language is not supported, default will always be english.

			if (save.data.language == null) {

				switch (Capabilities.language) {

					case "es":
						save.data.language = "Spanish";
						break;
					case "en":
						save.data.language = "English";
						break;
					default:
						save.data.language = "English";
						break;
				}
			}

			// ---------------------------------------
		}



	}
}