import argparse
import sys
import os
from playwright.sync_api import sync_playwright, TimeoutError

def scrape(url, selector=None, output=None, screenshot=None, text_only=False):
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context()
        page = context.new_page()

        try:
            # Go to the requested URL and wait until the network is idle
            page.goto(url, wait_until="networkidle", timeout=30000)
        except TimeoutError:
            print(f"Error: Timeout while waiting for '{url}' to load.", file=sys.stderr)
            browser.close()
            sys.exit(1)
        except Exception as e:
            print(f"Error loading '{url}': {str(e)}", file=sys.stderr)
            browser.close()
            sys.exit(1)

        # Target the requested element or the whole page
        if selector:
            target = page.locator(selector)
            try:
                target.wait_for(state="attached", timeout=10000)
            except TimeoutError:
                print(f"Error: Element '{selector}' not found on the page.", file=sys.stderr)
                browser.close()
                sys.exit(1)
        else:
            target = page

        content = ""
        # Get content (text or HTML)
        if text_only:
            content = target.inner_text() if selector else page.evaluate("document.body.innerText")
        else:
            content = target.inner_html() if selector else page.content()

        # Output the content
        if output:
            try:
                os.makedirs(os.path.dirname(os.path.abspath(output)), exist_ok=True)
                with open(output, "w", encoding="utf-8") as f:
                    f.write(content)
                print(f"Successfully saved content to {output}")
            except IOError as e:
                print(f"Error saving content to '{output}': {str(e)}", file=sys.stderr)
        else:
            print(content)

        # Take a screenshot if requested
        if screenshot:
            try:
                os.makedirs(os.path.dirname(os.path.abspath(screenshot)), exist_ok=True)
                target.screenshot(path=screenshot)
                print(f"Successfully saved screenshot to {screenshot}")
            except Exception as e:
                print(f"Error saving screenshot to '{screenshot}': {str(e)}", file=sys.stderr)

        browser.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="A powerful web scraper using Playwright.")
    parser.add_argument("--url", required=True, help="The target URL to scrape.")
    parser.add_argument("--selector", help="A CSS selector to limit scraping to a specific element.")
    parser.add_argument("--output", help="File path to save the scraped content. Outputs to stdout if not provided.")
    parser.add_argument("--screenshot", help="File path to save a screenshot (PNG format).")
    parser.add_argument("--text-only", action="store_true", help="If set, extracts inner text instead of HTML.")

    args = parser.parse_args()

    scrape(
        url=args.url,
        selector=args.selector,
        output=args.output,
        screenshot=args.screenshot,
        text_only=args.text_only
    )
