import Foundation

extension CGM {
    final class Provider: BaseProvider, CGMProvider {
        @Injected() var apsManager: APSManager!
        @Injected() private var settingsManager: SettingsManager!
        private let processQueue = DispatchQueue(label: "PreferencesEditorProvider.processQueue")

        var preferences: Preferences {
            settingsManager.preferences
        }

        func savePreferences(_ preferences: Preferences) {
            processQueue.async {
                var prefs = preferences
                prefs.timestamp = Date()
                self.storage.save(prefs, as: OpenAPS.Settings.preferences)
            }
        }
    }
}
