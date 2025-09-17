# malcolm-minimal-topology

Minimal CyberRangeCZ sandbox for Malcolm-lab (Malcolm VM + Attacker + Victim).
Base image: `debian-12-x86_64`.

Denne repoen inneholder:
- `topology.yml` (registrert i CyberRangeCZ og fungerer med din backend)
- `variables.yml` (APG - valgfrie)
- `provisioning/`
  - `provision_malcolm.yml` (installerer Docker + kloner Malcolm-repo)
  - `provision_attacker.yml` (installerer tcpreplay, kopierer pcap, legger til run script)
  - `provision_victim.yml` (minimal marker)
- `attacker_files/`
  - `run_attack.sh` (kjørbar)
  - `sample_attack.pcap` (valgfritt — generer eller last opp)

---

## Før du starter
1. Sørg for at `topology.yml` bruker riktig `image:` (`debian-12-x86_64`) og gyldige `flavor:`-navn for din plattform (du fikk sandbox opp med `large`/`small` — behold disse eller endre etter tilgjengelige flavors).
2. Push repo til GitHub (HTTPS clone URL).

---

## Register Sandbox Definition i CyberRangeCZ
1. Logg inn som admin i CyberRangeCZ UI.  
2. Gå til `Sandboxes → Sandbox Definition → Create Sandbox Definition`.  
   - Git URL: `https://github.com/ORG/your-repo.git`  
   - Revision: `main` (eller branch/tag du brukte)  
3. Klikk **Create** — plattformen vil klone repo og registrere topology.

---

## Opprett en Topology Instance (sandbox)
1. I UI velg din Topology Definition og klikk **Create topology instance**.  
2. Velg `auto-provision` hvis du vil at Ansible-playbooks kjøres automatisk.  
3. Start instansen.

---

## Verifisering etter provisjonering
Når provisjoneringen er fullført, sjekk via UI → Sandbox Access eller SSH:

- Malcom-host: `/var/lab_logs/malcolm_provisioned.txt` (skal inneholde repo + timestamp)  
- Attacker: `/var/lab_logs/attacker_provisioned.txt`  
- Victim: `/var/lab_logs/victim_provisioned.txt`  

Sjekk også at:
- `docker --version` finnes på malcolm-host.
- `/opt/malcolm` finnes (repo klonet).
- `/opt/pcaps/sample_attack.pcap` finnes på attacker (hvis du la den i repo).

---

## Kjøre angrep (manuelt)
SSH til attacker (eller bruk Sandbox Access konsoll):
```bash
# hvis sample_attack.pcap mangler, generer eller kopier den til /opt/pcaps/
sudo /usr/local/bin/run_attack.sh
