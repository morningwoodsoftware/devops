include sshd

class server {
    user { 'captain':
        ensure => present,
        groups => ['admin'],
        home => '/home/captain',
        password => 'hoonfore',
        managehome => true,
    }

    ssh_authorized_key { 'konker',
        key => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArLzRa27Ui8ijP3ns35nNJwFHeiIZDCZAnQTd+VlgVZWYNv5S1oo1dbNOMneos+6OuZS7Ig09Ifw0efXzCJUqS2Br8VnCQhjdEInzCaBQSr4mG/V5ndlb1Z9ILTo9O2yZtwV3N4R69Z4GJNmEtJjIaUtDQUItsRt8MfhMuUVUD3luoFJz84JqfTPGHGbLu2a98o3mJeJM33uIRErSwhY5XprITJP3hh/qUweMo13fnRS8N/EpaPmW8oCDPiS1rQ/TB5H4ZRLRM3lZ0Au/6asrTGcxWfX3CGGG9Q9yNW0MZJsOqQN2Fmgqnobu0OSe8/wMJ/NgM2IQ/+XqQs46lZljKw== konker@morningwoodsoftware.com',
        user => User['captain'],
        require => Class['sshd'],
    }

    # create a rsa key pair, and the .ssh directory
    exec { 'ssh-keygen':
        command => '/usr/bin/ssh-keygen -q -f ~captain/.ssh/id_rsa -t rsa',
        creates => '~captain/.ssh/id_rsa',
        require => User['captain'],
    }
}

