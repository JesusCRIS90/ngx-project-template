import { environment } from './environment';

/**
 * Returns a correct path for assets, prepending the baseHref in production.
 * Example:
 *   getRightPath('/assets/data/file.json') =>
 *     '/assets/data/file.json' (dev)
 *     '/ngx-quiz-game/assets/data/file.json' (prod)
 */
export function getRightPath(path: string): string {
  // Ensure there's no double slashes when joining
  const cleanBase = environment.baseHref.replace(/\/+$/, '');
  const cleanPath = path.replace(/^\/+/, '');

  return `${cleanBase}/${cleanPath}`;
}
