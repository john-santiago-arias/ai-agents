# Read only for environment files

**Never read secrets.** Do not open, `Read`, `cat`, `grep`, print, or otherwise inspect credential/secret files — `.env*`, `.maestro/.env`, key/cert files, Firebase credentials, or any other credentials on the project. They are off-limits even "just to check". You may reference a variable by name (`${APP_ID}`, `${EMAIL}`) but never read its value.

Assume the variable exists and continue. Do not modify a `.env`, keep those values in memory, or share them.

## Notes

- If you cannot continue without looking for the env value, stop everything and ask.
