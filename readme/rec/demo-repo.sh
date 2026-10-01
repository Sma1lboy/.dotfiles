#!/bin/bash
# Rebuild the neutral repo every take works in: a small TypeScript client
# with history and one uncommitted edit, so prompts show a branch and status.
set -eu
root=/tmp/dotfiles-demo/orbit-sdk
rm -rf "$root"
mkdir -p "$root/src" "$root/test"
cd "$root"

cat >package.json <<'EOF'
{
  "name": "orbit-sdk",
  "type": "module",
  "scripts": { "test": "bun test" }
}
EOF
cat >tsconfig.json <<'EOF'
{
  "compilerOptions": { "target": "ES2022", "module": "ESNext", "strict": true, "moduleResolution": "bundler", "allowImportingTsExtensions": true, "noEmit": true }
}
EOF
cat >src/session.ts <<'EOF'
export type Session = { token: string; expiresAt: number }

export async function getSession(now: number): Promise<Session> {
  // TODO: cache the session until it expires
  const res = await fetch("https://api.orbit.dev/session")
  const body = (await res.json()) as { token: string; ttl: number }
  return { token: body.token, expiresAt: now + body.ttl * 1000 }
}
EOF
cat >src/client.ts <<'EOF'
import { getSession } from "./session.ts"

export type ClientOptions = { baseUrl: string; maxAttempts?: number }
export type Client = { get: (path: string) => Promise<Response> }

export function createClient({ baseUrl, maxAttempts = 3 }: ClientOptions): Client {
  async function once(path: string): Promise<Response> {
    const session = await getSession(Date.now())
    return fetch(`${baseUrl}${path}`, {
      headers: { authorization: `Bearer ${session.token}` },
    })
  }

  return {
    async get(path) {
      let last: unknown
      for (let attempt = 0; attempt < maxAttempts; attempt++) {
        try {
          return await once(path)
        } catch (error) {
          // FIX: back off between attempts instead of retrying at once
          last = error
        }
      }
      throw last
    },
  }
}
EOF
cat >src/index.ts <<'EOF'
export { createClient } from "./client.ts"
export type { Client, ClientOptions } from "./client.ts"
EOF
cat >test/client.test.ts <<'EOF'
import { expect, test } from "bun:test"
import { createClient } from "../src/client.ts"

test("builds a client", () => {
  expect(createClient({ baseUrl: "https://api.orbit.dev" })).toBeDefined()
})
EOF
printf '# orbit-sdk\n\nA tiny client for the Orbit API.\n' >README.md

# Like any real TypeScript project, the repo carries its own `typescript`
# (typescript-tools runs that tsserver). Installed once into a cache outside
# the repo, then linked in; node_modules stays out of git.
cache=/tmp/dotfiles-demo/.typescript
if [ ! -d "$cache/node_modules/typescript" ]; then
  mkdir -p "$cache"
  (cd "$cache" && npm install --silent --no-audit --no-fund typescript@5 >/dev/null)
fi
mkdir -p node_modules
ln -s "$cache/node_modules/typescript" node_modules/typescript
printf 'node_modules\n' >.gitignore

export GIT_AUTHOR_NAME=Orbit GIT_AUTHOR_EMAIL=dev GIT_COMMITTER_NAME=Orbit GIT_COMMITTER_EMAIL=dev
git init -q -b main
git add .gitignore package.json tsconfig.json README.md && git commit -qm "chore: scaffold"
git add src test && git commit -qm "feat: client with retries"
printf '\n## Usage\n\n    const orbit = createClient({ baseUrl })\n' >>README.md
