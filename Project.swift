import ProjectDescription

let project = Project(
    name: "OTPApp",
    targets: [
        Target(
            name: "OTPApp",
            platform: .iOS,
            product: .app,
            bundleId: "com.example.OTPApp",
            deploymentTarget: .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [:],
                    "UIApplicationSupportsIndirectInputEvents": true
                ]
            ),
            sources: [
                "AppDelegate.swift",
                "ViewController.swift"
            ],
            settings: .settings(
                base: [
                    "GENERATE_INFOPLIST_FILE": "YES",
                    "CODE_SIGN_STYLE": "Automatic",
                    "ENABLE_BITCODE": "NO",
                    "SWIFT_VERSION": "5.0"
                ]
            )
        )
    ]
)
