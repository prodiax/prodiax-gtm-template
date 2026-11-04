# Prodiax for Google Tag Manager

A Google Tag Manager tag template that loads [Prodiax](https://prodiax.com) on a website: its A/B tests, its published fixes, and the visit data that measures them.

## Before you use it

The page itself is the better place for the Prodiax code. Pasted at the top of the page's `<head>`, it starts loading with the page, so a test is usually in place before anything shows. Google Tag Manager starts its tags after the page has shown, so a tested element near the top of the page can change while the visitor looks at it.

Use this template if you cannot edit your pages, or if you would rather keep your tools in Google Tag Manager. The Prodiax setup page shows the code for the page and the steps for a tag manager.

## Set up

1. Add the template to your container: Templates > Tag Templates > Search Gallery, search for Prodiax. Before it is in the gallery: Templates > Tag Templates > New > the menu at the top right > Import, and choose `template.tpl` from this repository.
2. Tags > New > Tag Configuration > Prodiax A/B Testing.
3. Site key: your site's key from the Prodiax setup page, the part after `/s/` in its code (for example `pk_live_AbC123AbC123AbC123AbC1` in `https://cdn.prodiax.app/s/pk_live_AbC123AbC123AbC123AbC1.js`).
4. Triggering: Initialization - All Pages.
5. Advanced Settings: Tag firing priority 100, Tag firing options Once per page.
6. Advanced Settings > Consent Settings: No additional consent required. Prodiax waits for the visitor's consent itself (below).
7. Save, then Submit and Publish the container.

The Prodiax setup page shows your site as live within seconds of the first visit.

## Consent

Prodiax sends nothing before the visitor consents. It reads Google Consent Mode (`analytics_storage`), Efilli and OneTrust by itself. With another cookie banner, call `prodiax('consent', true)` when the visitor accepts and `prodiax('consent', false)` when they refuse.

Leave the tag's consent setting at "No additional consent required": a tag that waits for consent in Google Tag Manager does not fire on the same page when the visitor accepts later, so their first page would be lost.

## Content-Security-Policy

If your site sends a Content-Security-Policy, allow:

```
script-src https://cdn.prodiax.app https://api.prodiax.com; connect-src https://api.prodiax.com
```

Google Tag Manager passes the page's nonce to the script this template adds.

## What the template does

It adds one script to the page, `https://cdn.prodiax.app/s/<site key>.js`, through Google Tag Manager's `injectScript`, and reports success or failure to Google Tag Manager. Its only permission is to inject scripts from `https://cdn.prodiax.app/s/`. It reads no cookies, no globals and no data layer values itself.

## License

[Apache License 2.0](LICENSE)
