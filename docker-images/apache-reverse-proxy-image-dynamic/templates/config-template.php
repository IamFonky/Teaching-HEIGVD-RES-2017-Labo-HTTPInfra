<?php
 $STATIC_APP = getenv('STATIC_APP');
 $DYNAMIC_APP = getenv('$DYNAMIC_APP');
 ?>
<VirtualHost *:80>
    ServerName demo.res.ch
    ProxyPass "/api/students/"' "http://<?php echo $DYNAMIC_APP ?>/"
    ProxyPassReverse "/api/students/" "http://<?php echo $DYNAMIC_APP ?>/"
    ProxyPass "/" "http://<?php echo $STATIC_APP ?>/"
    ProxyPassReverse "/" "http://<?php echo $STATIC_APP ?>/"
</VirtualHost>
