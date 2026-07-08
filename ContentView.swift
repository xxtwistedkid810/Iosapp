import SwiftUI

@main
struct OTPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var pcIP: String = "192.168.1.100"
    @State private var code: String = "------"
    @State private var status: String = "Enter this code on your PC lock screen."
    @State private var isLocked: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [Color.black, Color(red: 0.05, green: 0.05, blue: 0.1)],
                    startPoint: .top, endPoint: .bottom
                ).ignoresSafeArea()

                VStack(spacing: 28) {
                    Text("PC LOCK")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    // Code card
                    VStack(spacing: 8) {
                        Text("ACCESS CODE")
                            .font(.caption.bold())
                            .foregroundStyle(.gray)
                        Text(code)
                            .font(.system(size: 52, weight: .heavy, design: .monospaced))
                            .foregroundStyle(.green)
                            .frame(minWidth: 220)
                            .padding(20)
                            .background(RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.white.opacity(0.06))
                                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.green.opacity(0.4))))
                    }

                    // PC IP
                    HStack {
                        Text("PC IP").foregroundStyle(.gray).frame(width: 60, alignment: .leading)
                        TextField("192.168.1.100", text: $pcIP)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .keyboardType(.decimalPad)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.08)))
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal, 24)

                    Button(action: refreshCode) {
                        Label("Get Code", systemImage: "arrow.clockwise")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .padding(.horizontal, 24)

                    Button(action: lockPC) {
                        Label("Lock PC", systemImage: "lock.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .padding(.horizontal, 24)

                    Text(status)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }
            .navigationBarHidden(true)
        }
    }

    private func baseURL() -> String {
        let ip = pcIP.trimmingCharacters(in: .whitespaces)
        return "http://\(ip):8080"
    }

    private func refreshCode() {
        guard let url = URL(string: "\(baseURL())/code") else { return }
        fetch(url) { result in
            if let r = result, let c = extractCode(r) {
                DispatchQueue.main.async {
                    code = c
                    status = "Enter this code on your PC lock screen."
                }
            } else {
                DispatchQueue.main.async { status = "Could not reach PC. Is lockd running?" }
            }
        }
    }

    private func lockPC() {
        guard let url = URL(string: "\(baseURL())/lock") else { return }
        fetch(url) { _ in
            DispatchQueue.main.async { status = "Lock command sent to PC." }
        }
    }

    private func fetch(_ url: URL, completion: @escaping (String?) -> Void) {
        var req = URLRequest(url: url, timeoutInterval: 5)
        req.httpMethod = "GET"
        URLSession.shared.dataTask(with: req) { data, _, _ in
            if let data = data, let s = String(data: data, encoding: .utf8) {
                completion(s)
            } else {
                completion(nil)
            }
        }.resume()
    }

    private func extractCode(_ json: String) -> String? {
        if let range = json.range(of: "\"code\"\\s*:\\s*\"([0-9]+)\"", options: .regularExpression) {
            let match = json[range]
            if let v = match.range(of: "[0-9]+", options: .regularExpression) {
                return String(match[v])
            }
        }
        return nil
    }
}
