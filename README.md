# Website for Burlington Property LLC

Live at https://burlingtonpropertyllc.com

This is based on https://github.com/gautamkrishnar/github-pages-gallery/blob/master/README.md

## Local Development

### Prerequisites

- Docker Desktop (required)
  - Download from https://www.docker.com/products/docker-desktop/
  - Or install via Homebrew: `brew install --cask docker`
  - Make sure Docker Desktop is running before building

### Build and Preview Locally

```bash
# Build the gallery from your local photos
docker run -v "$(pwd):/work" ghcr.io/thumbsup/thumbsup /bin/sh -c "cd /work/ && thumbsup --config config.json"

# Customize the HTML
bash customize_html.sh

# Serve locally
cd build_output && python3 -m http.server 8000
```

Then open http://localhost:8000 in your browser.