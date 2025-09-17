# malcolm-minimal-sandbox
Minimal CyberRangeCZ sandbox definition to prepare a Malcolm VM.

## Hvordan bruke
1. Erstatt `topology.yml` base_box.image med et gyldig image-id fra din Image Pool.
2. Push repo til GitHub (https clone URL).
3. I CyberRangeCZ UI: Sandboxes → Sandbox Definition → Create Sandbox Definition
   - Git URL: https://github.com/ORG/malcolm-minimal-sandbox.git
   - Revision: main (eller valgt branch/tag)
4. Opprett en Topology Instance fra den registrerte definitionen.
   - Velg APG-variabler hvis du ønsker å endre `malcolm_repo_url` eller `malcolm_repo_revision`.
   - Velg `auto-provision` for automatisk å kjøre Ansible-playbook under provisjonering.
5. Etter at instansen er oppe, sjekk i UI:
   - Provisioning logs (for git clone + docker install)
   - Sandbox Access → SSH til malcolm-host
   - Verifiser marker: `/var/lab_logs/malcolm_provisioned.txt` og `/var/lab_logs/malcolm_next_steps.txt`
6. For å bygge/opprette Malcolm (manuelt på VM):
   - SSH inn som admin (eller bruk Sandbox Access konsoll)
   - `cd /opt/malcolm` og følg README i det klonede repoet. Vanlige kommandoer kan være `docker compose up -d` eller repo-spesifikke build-skript.
