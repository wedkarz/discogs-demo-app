# Prerequisities
- [xcodegen](https://github.com/yonaskolb/XcodeGen) `brew install xcodegen`

# How to build the app?
1) Provide env vars for discogs API (https://api.discogs.com/)
    - DISCOGS_AUTH_KEY
    - DISCOGS_AUTH_SECRET
    
2) Generate project file by running `DISCOGS_AUTH_KEY=yourauthkey DISCOGS_AUTH_SECRET=yourauthsecret xcodegen generate` 
Without auth key resoures returned by API are limited (eg. no thumbnails)

# TODO:
- Dependency Injection framework
- Unit Tests / Integration Tests
- Retry on download fail (pull to refresh?)
- Download paginated results (currently downloads only first page) / lazy load(?)
- Detail views
