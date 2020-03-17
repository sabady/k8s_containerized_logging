FROM mysql:latest
RUN mkdir -p /mnt/logs
COPY gen-logs.sh /root/
RUN chmod +x /root/gen-logs.sh
ENTRYPOINT ["/root/gen-logs.sh"]
