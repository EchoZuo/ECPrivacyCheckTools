# ECPrivacyCheckTools 3.0 Roadmap

ECPrivacyCheckTools 3.0 is a planned modernization of the existing Objective-C library. The current `2.0.0` release remains the latest official release until 3.0 work is complete.

## 1. Audit

- Review existing permission checks against current Apple SDKs.
- Identify deprecated APIs, behavior changes, and compatibility gaps.
- Triage existing issues and document supported use cases.

## 2. Core Modernization

- Update permission-state handling where current APIs require it.
- Keep the core library lightweight and preserve practical Objective-C integration.
- Modernize the example project as the implementation evolves.

## 3. Modern Distribution

- Add native Swift-friendly interfaces where appropriate.
- Add Swift Package Manager support.
- Review CocoaPods packaging and installation documentation.

## 4. Quality & Security

- Add automated tests for permission-state behavior.
- Add CI for build and regression checks.
- Improve Chinese and English documentation.
- Perform privacy- and security-focused review of permission-related code.

## 5. 3.0 Release

- Define supported platform and SDK requirements based on completed validation.
- Publish migration notes and updated examples.
- Release `3.0.0` only after the modernization and validation work is complete.
