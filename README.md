# sandbox-blue-minimal
Minimal CyberRangeCZ sandbox definition for a Blue Team lab (SIEM + 1 endpoint).
This repo is intentionally minimal and contains only necessary files to register
a topology definition in CyberRangeCZ using Git URL + revision.

## Innhold
- topology.yml              # Topology definition (required)
- variables.yml             # APG variables (valgfri)
- provisioning/
  - playbook.yml
  - provision_siem.yml
  - provision_endpoint.yml

## Før bruk — tilpass
1. Oppdater `topology.yml`:
   - Bytt `base_box.image` for hver host til et image-id/name som finnes i din CyberRangeCZ Image Pool.
   - Sett `mgmt_user` / `mgmt_protocol` hvis nødvendig (ssh/winrm).

2. (Valgfritt) Hvis du vil bruke Wazuh / Loki / Grafana:
   - Erstatt placeholder-debug-tasks i `provision_siem.yml` og `provision_endpoint.yml`
     med faktiske installasjons- og konfigurasjons-steps per deres anbefalte instruksjoner.
   - Sørg for at nettverksregler tillater agent → manager kommunikasjon.

## Hvordan registere i CyberRangeCZ (Git URL + Revision)
1. Push dette repo til GitHub (f.eks. `https://github.com/ORG/sandbox-blue-minimal.git`).
2. Åpne CyberRangeCZ web-UI som admin:
   - Gå til **Sandboxes → Sandbox Definition → Create Sandbox Definition**.
   - Angi `Git URL`: f.eks. `https://github.com/ORG/sandbox-blue-minimal.git`
   - Angi `Revision`: branch/tag/commit, feks `main` eller `v1.0`.
   - Klikk **Create**.
   - Platformen vil klone repoet og vise topology-definisjonen.

> Private repo: sørg for at plattformen har tilgang (følg dokumentasjonens avsnitt om Git auth).
> Hvis git-clone feiler, sjekk plattformens logs og autentiseringsmetode.

## Opprette en Topology Instance / Sandbox
1. I UI, finn din registrerte Topology Definition i listen.
2. Klikk **Create topology instance** (eller `New Sandbox` → velg topology).
3. Velg APG-variabler hvis ønskelig (fra `variables.yml`) og velg `auto-provision` hvis du vil at playbooks kjøres automatisk.
4. Start instansen. Overvåk Provisioning logs i UI for Ansible/output.
5. Når provisjonering er ferdig, bruk **Sandbox Access** for konsoll/SSH for å verifisere marker-filer:
   - SIEM-node: `/var/lab_logs/siem_provisioned.txt`
   - Endpoint: `/tmp/endpoint_provisioned.txt`

## Verifisering & feilsøk (kort)
- Provisioning feiler: se Provisioning logs (Ansible stdout/stderr) i UI.
- Git clone feiler: sjekk URL + revision og tilganger. For private repo, gi plattform tilgang.
- Agenter connect?: hvis du valgte å installere agenter senere, sjekk nettverk og manager-URL i playbooks.

## Notater
- Denne repoen er minimal og laget for å følge CyberRangeCZ-dokumentasjonen for sandbox-definition/topology-instance.
- For full produksjon/øvelse anbefales å legge til:
  - Wazuh manager & agents eller annen SIEM/aggregator
  - Loki + Grafana for logs + dashboards
  - Zeek/Malcolm for nettverks-innsikt
  - Flere endpoints og en angriper-node (red-team)

