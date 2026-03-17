#!/usr/bin/env bun

import { $ } from "bun";
$.throws(false);

const c = (code: string) => (s: string) => `\x1b[${code}m${s}\x1b[0m`;
const boldCyan = c("1;36");
const yellow = c("0;33");
const green = c("0;32");
const gray = c("0;90");
const white = c("0;37");

type StatusData = {
  cwd?: string;
  model?: { display_name?: string };
  context_window?: { used_percentage?: number; remaining_percentage?: number };
  session_id?: string;
};

function shortenHome(path: string): string {
  const home = Bun.env.HOME;
  return home ? path.replace(home, "~") : path;
}

function truncatePath(path: string, maxDepth = 3): string {
  const parts = path.split("/");
  if (parts.length <= maxDepth) return path;
  return `…/${parts.slice(-maxDepth).join("/")}`;
}

async function getCurrentBranch(cwd: string): Promise<string> {
  if (!cwd) return "";
  return (await $`git -C ${cwd} branch --show-current`.text()).trim();
}

function progressBar(percent: number, width = 25): string {
  const filled = Math.floor((percent * width) / 100);
  return `${green("█".repeat(filled))}${gray("░".repeat(width - filled))}`;
}

function headerLine(model: string, cwd: string, branch: string): string {
  const parts: string[] = [];
  if (model) parts.push(boldCyan(model));
  if (cwd) parts.push(yellow(cwd));
  if (branch) parts.push(green(` ${branch}`));
  return parts.join(" ");
}

const data: StatusData = await Bun.stdin.json();
const rawCwd = data.cwd ?? "";
const model = data.model?.display_name ?? "";
const used = data.context_window?.used_percentage ?? 0;
const remaining = data.context_window?.remaining_percentage ?? 100;
const sessionId = data.session_id ?? "";

const cwd = truncatePath(shortenHome(rawCwd));
const branch = await getCurrentBranch(rawCwd);

console.log(headerLine(model, cwd, branch));
console.log(`${progressBar(used)} ${white(`${used}% used (${remaining}% remaining)`)}`);
if (sessionId) console.log(gray(`Session: ${sessionId}`));
