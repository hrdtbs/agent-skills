---
name: playwright-scraper
description: Masterpiece skill to use Playwright to scrape content, take screenshots, and interact with webpages that require JavaScript to render. Use this skill when the user asks to get data from a URL, capture a screenshot of a website, or fetch dynamic content.
---

# playwright-scraper

This skill uses Python and Playwright to access web pages that might be heavily dependent on JavaScript for rendering. It provides a robust script that can:
1. Load a URL in a headless Chromium browser.
2. Extract the full HTML or just the text content.
3. Target a specific element using a CSS selector.
4. Take a screenshot of the page or a specific element.

## Dependencies

The skill uses `playwright`. When you first use this skill, ensure dependencies are installed:
```bash
pip install -r requirements.txt
playwright install chromium
```

## Scripts

### 1. `scripts/scrape.py`
A comprehensive Python script using `playwright.sync_api`.

**Usage:**
```bash
python scripts/scrape.py --url <URL> [--selector <CSS_SELECTOR>] [--output <FILE_PATH>] [--screenshot <SCREENSHOT_PATH>] [--text-only]
```

**Arguments:**
- `--url`: The target URL to scrape (required).
- `--selector`: A CSS selector to limit scraping to a specific element.
- `--output`: File path to save the scraped content (HTML or text). If not provided, outputs to stdout.
- `--screenshot`: File path to save a screenshot (PNG format).
- `--text-only`: If flagged, extracts inner text instead of HTML.

**Examples:**

1. **Extract all text from a page and save to a file:**
```bash
python scripts/scrape.py --url https://news.ycombinator.com --text-only --output hn.txt
```

2. **Capture a screenshot of a webpage:**
```bash
python scripts/scrape.py --url https://github.com --screenshot github.png
```

3. **Get the HTML of a specific element:**
```bash
python scripts/scrape.py --url https://en.wikipedia.org/wiki/Web_scraping --selector "#firstHeading"
```

## Tips for use
- If the output is expected to be very large, always use the `--output` argument to save to a file instead of flooding the context window.
- If you need visual context, pass the `--screenshot` argument and then use the image tools to view the generated image.
- Playwright handles waiting for the `networkidle` state, so it works perfectly for Single Page Applications (SPAs).
