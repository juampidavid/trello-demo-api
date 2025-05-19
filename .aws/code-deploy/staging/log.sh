log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [STAGING] - $1" >> /tmp/codedeploy.log
}