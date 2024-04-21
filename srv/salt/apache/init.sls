# Apachen asennus
apache2:
  pkg.installed

# Asennetaan curl komentorivitestausta varten
curl:
  pkg.installed

# Apachen leosite-palvelin
/etc/apache2/sites-available/leosite.conf:
  file.managed:
    - source: "salt://apache/leosite.conf"
    - watch_in:
      - service: "apache2.service"

# Aktivoidaan leosite-palvelin
/etc/apache2/sites-enabled/leosite.conf:
  file.symlink:
    - target: "../sites-available/leosite.conf"
#    - watch_in:
#      - service: "apache2.service"

# Leosite-palvelimen juuri
/home/vagrant/publicsites/leo:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - makedirs: True

# Leosite-palvelimen pääsivu
/home/vagrant/publicsites/leo/index.html:
  file.managed:
    - user: vagrant
    - group: vagrant
    - source: "salt://apache/index.html"

# Poistetaan oletus palvelin.
/etc/apache2/sites-enabled/000-default.conf:
  file.absent
#    - watch_in:
#      - service: "apache2.service"

# Apachen palvelun seuranta
apache2.service:
  service.running
