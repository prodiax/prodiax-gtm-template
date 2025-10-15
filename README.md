# Prodiax GTM Template

A Google Tag Manager template for integrating the Prodiax UX Analytics SDK. This template allows you to easily add comprehensive user behavior tracking, session recording, and analytics to your website through GTM.

## Features

- **Session Recording**: Capture user interactions and screen recordings
- **Heat Maps**: Visualize where users click and scroll
- **Error Tracking**: Monitor JavaScript errors and exceptions
- **Performance Monitoring**: Track page load metrics and Core Web Vitals
- **Form Analytics**: Track form interactions and completion rates
- **Rage Click Detection**: Identify problematic UI elements
- **Exit Intent Tracking**: Capture when users are about to leave
- **Scroll Analytics**: Monitor scroll depth and behavior patterns

## Quick Start

### 1. Install the Template

1. Download the `template.tpl` file from this repository
2. Open your Google Tag Manager container
3. Go to **Templates** → **New** → **Import**
4. Upload the `template.tpl` file
5. Save the template

### 2. Create a Prodiax Tag

1. Go to **Tags** → **New**
2. Select **Prodiax - UX Analytics SDK**
3. Configure your **Product ID** (required)
4. Set up appropriate triggers (e.g., All Pages)
5. Save and publish your container

### 3. Migration from Direct Script

If you're currently using the direct script approach, remove this from your HTML:

```html
<!-- Remove this -->
<script src="https://unpkg.com/prodiax-tracking-sdk@latest/dist/prodiax-sdk.min.js"></script>
<script>
  window.Prodiax.init({
    productId: 'your-product-id'
  });
</script>
```

GTM will handle the loading and initialization automatically.

## Configuration

### Required Settings
- **Product ID**: Your unique Prodiax product identifier

### Optional Settings
- **API Endpoint**: Custom backend URL (default: `https://api.prodiax.com/track`)
- **Environment**: Production, Staging, or Development
- **Debug Mode**: Enable detailed console logging
- **Feature Toggles**: Enable/disable specific tracking features
- **Privacy Settings**: Respect Do Not Track, anonymize IPs
- **Performance Settings**: Batch size and interval configuration

## Privacy & Compliance

- ✅ Respects browser Do Not Track settings
- ✅ IP address anonymization
- ✅ Configurable data collection
- ✅ GDPR compliant data handling
- ✅ No PII collection by default

## Browser Support

- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+

## Advanced Usage

You can create additional GTM tags to call Prodiax methods:

### Custom Event Tracking
```javascript
window.Prodiax.track('event_name', {
  property1: 'value1',
  property2: 'value2'
});
```

### User Properties
```javascript
window.Prodiax.setUserProperties({
  user_id: '12345',
  plan: 'premium',
  signup_date: '2024-01-01'
});
```

### Error Tracking
```javascript
window.Prodiax.trackError(error, {
  context: 'additional_info'
});
```

## How It Works

1. The template sets `prodiaxSettings` in the global scope
2. When the Prodiax SDK loads, it automatically detects and uses these settings
3. The SDK initializes itself without requiring manual initialization calls
4. This approach is GTM-compatible and avoids sandbox restrictions

## Troubleshooting

### Tag Not Firing
- Check trigger configuration
- Verify GTM container is published
- Ensure no JavaScript errors are blocking execution

### SDK Not Loading
- Check network tab for failed requests to unpkg.com
- Verify the CDN URL is accessible
- Check browser console for errors

### Debug Mode
Enable debug mode to see detailed information:
- SDK initialization status
- Event tracking details
- Session management info
- Error messages and warnings

## Support

- 📖 [Prodiax Documentation](https://docs.prodiax.com)
- 🐛 [Report Issues](https://github.com/prodiax/prodiax-gtm-template/issues)
- 💬 [Contact Support](mailto:support@prodiax.com)

## License

This template is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Changelog

### v1.0.0
- Initial release
- Full GTM template implementation
- Auto-initialization support
- Comprehensive configuration options
- Privacy compliance features
