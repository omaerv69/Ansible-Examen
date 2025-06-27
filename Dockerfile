FROM  ftutorials/ubuntu-ansible:1.0

# Installation de ansible-lint
RUN apt-get update && \
    apt-get install -y ansible-lint && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Définir un mot de passe pour root (à ne jamais faire en production)
RUN echo "root:Omar" | chpasswd

# Expose port SSH
EXPOSE 22
EXPOSE 80


# Lancer SSH en avant-plan pour maintenir le conteneur actif
CMD ["/usr/sbin/sshd", "-D"]