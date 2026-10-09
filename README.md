# Bolan LLC website

Static site for bolansolutions.com, deployed by Cloudflare Workers (static assets from `site/`, see `wrangler.jsonc`).

- Edit `body.html` (home page) or `pages/*.html` (privacy, 404).
- Run `sh build.sh` to regenerate `site/`.
- Commit and push to `main`; Cloudflare deploys automatically.
- The workers.dev test link is bolan-ll-site.nolanwjones.workers.dev.
