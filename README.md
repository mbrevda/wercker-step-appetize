# Appetize Wercker Step ⬆️ ☁️ 📲
Upload an app to [Appetize](https://appetize.io) for instant streaming build previews from a  [Wercker](http://www.wercker.com/) pipeline/build step.


# Options
* `token`: (required) A valid Appetize token. Get yours [here](https://appetize.io/docs#request-api-token)
* `path`: (required) The path to built application
* `platform`: `ios` or `android`

# Usage
Use this step as you would any other. After running, the step will print the url to see the app preview. After uploading, the environmental variable `APPETIZE_APPKEY` will be set to the Appetize `publicKey`. Additionally, the key will be saved to `.appetize_appkey` for usage in other pipelines.

# Example
```yml
box: node

build:
  steps:
    - script:
      name: build apk
      code: ./gradelw build
    - mbrevda/appetize:
      token: $TOKEN
      path: app/build/output/my.app.apk
      platform: android
deploy:
  steps:
    ...
 ```
