# Prerequisities
- xcodegen [xcodegen](https://github.com/yonaskolb/XcodeGen)

# How to run build the app?
1) Provide env vars for discogs API:
    - DISCOGS_AUTH_KEY
    - DISCOGS_AUTH_SECRET
2) Generate project file by running `xcodegen generate` 

# TODO:
- Dependency Injection framework
- Unit Tests / Integration Tests
- Retry on download fail (pull to refresh?)
- Download paginated results (currently downloads only first page) / lazy load(?)
- Detail views
