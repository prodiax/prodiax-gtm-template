___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.

___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Prodiax - UX Analytics SDK",
  "categories": ["ANALYTICS", "CONVERSIONS", "DATA_WAREHOUSING", "HEAT_MAP", "SESSION_RECORDING"],
  "brand": {
    "id": "Prodiax",
    "displayName": "Prodiax",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg=="
  },
  "description": "Automatically collect behavioral data and UX analytics with the Prodiax SDK. Features session recording, heat maps, error tracking, and performance monitoring.",
  "containerContexts": [
    "WEB"
  ]
}

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "productId",
    "displayName": "Product ID",
    "simpleValueType": true,
    "notSetText": "Product ID is required.",
    "help": "Your Prodiax Product ID for this application. This is a unique identifier for your product/website.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "[0-9A-Za-z._-]+"
        ]
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "apiEndpoint",
    "displayName": "API Endpoint",
    "simpleValueType": true,
    "defaultValue": "https://api.prodiax.com/track",
    "help": "Custom API endpoint for Prodiax (optional). Leave default unless using a custom backend."
  },
  {
    "type": "SELECT",
    "name": "environment",
    "displayName": "Environment",
    "selectItems": [
      {
        "value": "production",
        "displayValue": "Production"
      },
      {
        "value": "staging",
        "displayValue": "Staging"
      },
      {
        "value": "development",
        "displayValue": "Development"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "production",
    "help": "Environment setting for your application."
  },
  {
    "type": "CHECKBOX",
    "name": "debugMode",
    "checkboxText": "Debug mode",
    "simpleValueType": true,
    "help": "Enables Prodiax debug mode for development. Shows detailed logs in browser console."
  },
  {
    "type": "CHECKBOX",
    "name": "enableScrollTracking",
    "checkboxText": "Enable scroll tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track scroll depth and behavior patterns."
  },
  {
    "type": "CHECKBOX",
    "name": "enableHoverTracking",
    "checkboxText": "Enable hover tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track hover interactions on buttons, links, and interactive elements."
  },
  {
    "type": "CHECKBOX",
    "name": "enableFormTracking",
    "checkboxText": "Enable form tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track form interactions, field focus, and form submissions."
  },
  {
    "type": "CHECKBOX",
    "name": "enableErrorTracking",
    "checkboxText": "Enable error tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track JavaScript errors and exceptions for debugging."
  },
  {
    "type": "CHECKBOX",
    "name": "enableRageClickDetection",
    "checkboxText": "Enable rage click detection",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Detect and track rage clicking behavior (multiple rapid clicks on same element)."
  },
  {
    "type": "CHECKBOX",
    "name": "enableExitIntentTracking",
    "checkboxText": "Enable exit intent tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track when users are about to leave the page (mouse movement toward browser edge)."
  },
  {
    "type": "CHECKBOX",
    "name": "enablePerformanceTracking",
    "checkboxText": "Enable performance tracking",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Track page load performance metrics and Core Web Vitals."
  },
  {
    "type": "CHECKBOX",
    "name": "respectDoNotTrack",
    "checkboxText": "Respect Do Not Track",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Respect browser Do Not Track settings and disable tracking when enabled."
  },
  {
    "type": "CHECKBOX",
    "name": "anonymizeIp",
    "checkboxText": "Anonymize IP addresses",
    "simpleValueType": true,
    "defaultValue": true,
    "help": "Anonymize IP addresses for privacy compliance."
  },
  {
    "type": "TEXT",
    "name": "batchSize",
    "displayName": "Batch Size",
    "simpleValueType": true,
    "defaultValue": "100",
    "help": "Number of events to batch before sending to server (default: 100)."
  },
  {
    "type": "TEXT",
    "name": "batchIntervalMs",
    "displayName": "Batch Interval (ms)",
    "simpleValueType": true,
    "defaultValue": "15000",
    "help": "Time interval in milliseconds to send batched events (default: 15000ms = 15 seconds)."
  }
]

___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const setInWindow = require('setInWindow');
const injectScript = require('injectScript');
const log = require('logToConsole');

const productId = data.productId;
const apiEndpoint = data.apiEndpoint || 'https://api.prodiax.com/track';
const environment = data.environment || 'production';
const debugMode = data.debugMode || false;

// Build configuration object
const config = {
  productId: productId,
  apiEndpoint: apiEndpoint,
  environment: environment,
  debugMode: debugMode,
  enableScrollTracking: data.enableScrollTracking !== false,
  enableHoverTracking: data.enableHoverTracking !== false,
  enableFormTracking: data.enableFormTracking !== false,
  enableErrorTracking: data.enableErrorTracking !== false,
  enableRageClickDetection: data.enableRageClickDetection !== false,
  enableExitIntentTracking: data.enableExitIntentTracking !== false,
  enablePerformanceTracking: data.enablePerformanceTracking !== false,
  respectDoNotTrack: data.respectDoNotTrack !== false,
  anonymizeIp: data.anonymizeIp !== false,
  batchSize: data.batchSize || 100,
  batchIntervalMs: data.batchIntervalMs || 15000
};

(function() {
  log('Prodiax GTM Template - Initializing with config:', config);

  if (!productId) {
    log('Error: Product ID is required');
    return onFailure();
  }

  // Set up Prodiax settings in window object for auto-initialization
  setInWindow('prodiaxSettings', {
    config: config
  });

  // Load Prodiax SDK from CDN
  const sdkUrl = 'https://unpkg.com/prodiax-tracking-sdk@latest/dist/prodiax-sdk.min.js';
  
  injectScript(sdkUrl, onSuccess, onFailure);

  function onSuccess() {
    log('Prodiax SDK loaded successfully');
    
    // The SDK will auto-initialize via prodiaxSettings that we set earlier
    // This is the recommended approach for GTM templates
    log('Prodiax SDK loaded - auto-initialization via prodiaxSettings');
    log('Product ID:', productId);
    log('Environment:', environment);
    log('Debug mode:', debugMode);
    
    data.gtmOnSuccess();
  }

  function onFailure() {
    log('Failed to load Prodiax SDK from:', sdkUrl);
    data.gtmOnFailure();
  }
}());

___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://unpkg.com/prodiax-tracking-sdk@latest/dist/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "prodiaxSettings"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "Prodiax"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]

___TESTS___

scenarios:
- name: TestProdiaxInitialization
  code: |-
    mock('injectScript', function(url, onSuccess, onFailure) {
        // Mock successful script loading
        onSuccess();
    });

    runCode({ 
        productId: "test-product-id",
        environment: "development",
        debugMode: true
    });

    assertApi('gtmOnSuccess').wasCalled();

- name: TestMissingProductId
  code: |-
    runCode({ 
        productId: "",
        environment: "production"
    });

    assertApi('gtmOnFailure').wasCalled();

- name: TestScriptLoadFailure
  code: |-
    mock('injectScript', function(url, onSuccess, onFailure) {
        onFailure();
    });

    runCode({ 
        productId: "test-product-id"
    });

    assertApi('gtmOnFailure').wasCalled();

___NOTES___

Created on 12/19/2024

## Prodiax GTM Template Usage

### Setup Instructions:
1. Import this template into your Google Tag Manager container
2. Create a new tag using the "Prodiax - UX Analytics SDK" template
3. Configure the required Product ID and optional settings
4. Set up appropriate triggers (e.g., All Pages, specific pages)
5. Publish your GTM container

### Configuration Options:
- **Product ID**: Required unique identifier for your application
- **Environment**: Production, Staging, or Development
- **Debug Mode**: Enable detailed console logging
- **Feature Toggles**: Enable/disable specific tracking features
- **Privacy Settings**: Respect Do Not Track, anonymize IPs
- **Performance Settings**: Batch size and interval configuration

### Features Included:
- Session recording and analytics
- Click and hover tracking
- Form interaction monitoring
- Error tracking and reporting
- Performance metrics collection
- Rage click detection
- Exit intent tracking
- Scroll depth analysis

### Migration from Direct Script:
Remove the direct Prodiax script from your HTML and let GTM handle the initialization:

```html
<!-- Remove this -->
<script src="https://unpkg.com/prodiax-tracking-sdk@latest/dist/prodiax-sdk.min.js"></script>
<script>
  window.Prodiax.init({
    productId: 'your-product-id'
  });
</script>

<!-- GTM will handle this automatically via prodiaxSettings -->
```

### Advanced Usage:
You can create additional GTM tags to call Prodiax methods:
- Custom event tracking: `window.Prodiax.track('event_name', properties)`
- User properties: `window.Prodiax.setUserProperties(properties)`
- Error tracking: `window.Prodiax.trackError(error, context)`

### How It Works:
1. The template sets `prodiaxSettings` in the global scope
2. When the Prodiax SDK loads, it automatically detects and uses these settings
3. The SDK initializes itself without requiring manual initialization calls
4. This approach is GTM-compatible and avoids sandbox restrictions
