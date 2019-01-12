;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     ns.tuan.com. root.tuan.com. (
                              3         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
@       IN      NS      ns.tuan.com.
@       IN      MX      0 mail.tuan.com.
ns      IN      A       192.168.163.251
@       IN      A       172.16.163.251
www     IN      A       172.16.163.251
ftp     IN      A       172.16.163.251
mail    IN      A       172.16.163.252
proxy   IN      A       192.168.163.1
