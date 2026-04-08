### Backend

### Получил новый сертификат - обновить по гайду https://help.reg.ru/support/ssl-sertifikaty/3-etap-ustanovka-ssl-sertifikata/kak-nastroit-ssl-sertifikat-na-nginx#0

### 1. Передача .env на сервер - использовать (username обычно root):
scp C:\Projects\Statista\Statista\.env root@<ip_address>:~/Statista/Statista

### 2. Передача SSL сертификатов на сервер
scp -r C:\Projects\Statista\Statista\certs <username>@<host>:~/Statista/Statista/
