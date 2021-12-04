 Client -> | User Auth | -> | API | -> | Services |

Client
 - web
 - ios
 - android

User Auth
  - AWS Cognito
  - SSO Coinbase

API
  - AWS API Gateway
  - GET    /contests                            -> list all future/active contests (similar to DK sign in)
                                                -> can be filtered based on PAST/ACTIVE/FUTURE contests
  - GET    /contests/:contest_id                -> Information for a particular contest including rules for entry, scoring criteria, and leaderboard
  - POST   /contests                            -> Creates a new contests. Admin only tool.
  - GET    /users/:user_id/lineups              -> list all lineups a user has configured
  - GET    /users/:user_id/contests             -> list all active contests a user has submitted a line up as an entry
  - GET    /lineups/new                         -> create a lineup of slots that can be populated with crypto_assets
  - PATCH  /lineups/:lineup_id/update           -> update line up slots to reference crypto assets
  - DELETE /lineups/:lineup_id                  -> mark lineup as deleted
  - POST   /contest_entries                     -> creates a ContestEntry by submitting a lineup to a contest
  - DELETE /contest_entries/:contest_entry_id   -> remove contest entry from contest
  - GET    /crypto_assets                       -> paginated list of crypto_assets
  - GET    /crypto_assets/:crypto_asset_id      -> full data for particular crypto asset
 
 Services
  - Static Web Pages
    - landing page (web)
    - sign up/sign in

  - CryptoMetrics Collector
    - responsbile for getting metrics for each crypto asset we support
    - will need to be run periodically
    - at first, this will just be daily price for each crypto asset from CoinBase API

  - Contest Score Updater
    - run periodically (daily at first)
    - for each contest, it calculates the number of points scored per crypto asset based on the contest rules and the metrics collected from the crypto metrics collector
    - it will then update the number of points scored per contest entry

  - LeaderBoard
    - should be able to show leader board per contest
    - possibly some type of aggregate leader board for power users

  - Coinbase Data Parser
    - We want to outsource as much as the data collection to Coinbase as possible
    - New crypto assets will be added to our system when they are added to coin base
    - Crypto assets will be removed from our system when they are removed from coin base
    - Descriptions/white paper urls/ other meta data will be updated when coin base updates them