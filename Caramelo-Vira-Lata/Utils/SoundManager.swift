import AVFoundation

enum Sound: String, CaseIterable {
    case background
    case option1
    case option2
    case option3
    case option4
    case option5
    case option6
}

class SoundManager {
    static let shared = SoundManager()
    
    private var soundDict: [Sound:AVAudioPlayer?] = [:]
    
    init() {
        for sound in Sound.allCases {
            soundDict[sound] = getAudioPlayer(sound: sound)
        }
    }
    
    private func getAudioPlayer(sound: Sound) -> AVAudioPlayer? {
        let extensions = ["mp3", "wav", "m4a"]
        
        for ext in extensions {
            if let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ext) {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    print("✅ Carregado com sucesso: \(sound.rawValue).\(ext)")
                    return player
                } catch {
                    print("❌ Erro ao carregar \(sound.rawValue).\(ext): \(error.localizedDescription)")
                }
            } else {
                print("❌ Arquivo não encontrado: \(sound.rawValue).\(ext)")
            }
        }
        
        print("❌ Nenhum arquivo de som válido encontrado para: \(sound.rawValue)")
        return nil
    }
    
    func playLoop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    func play(sound: Sound, from time: TimeInterval = 0) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.currentTime = time
        audioPlayer.play()
    }
    
    
    func pause(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.pause()
    }
    
    func stop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.currentTime = 0
        audioPlayer.pause()
    }
    func fadeOutAndStop(sound: Sound, duration: TimeInterval) {
        guard let audioPlayer = soundDict[sound, default: nil], audioPlayer.isPlaying else { return }
        
        let steps = 15
        let timePerStep = duration / Double(steps)
        let volumeStep = audioPlayer.volume / Float(steps)
        
        var currentStep = 0
        
        Timer.scheduledTimer(withTimeInterval: timePerStep, repeats: true) { timer in
            if currentStep < steps {
                audioPlayer.volume -= volumeStep
                currentStep += 1
            } else {
                timer.invalidate()
                audioPlayer.stop()
                audioPlayer.volume = 1.0
            }
        }
    }
    
 
}
