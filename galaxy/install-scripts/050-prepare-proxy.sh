sudo mkdir /galaxy
sudo chown rosen:rosen /galaxy
cd /galaxy
git clone https://github.com/rosengrenen/a-galaxy-reborn
cd a-galaxy-reborn/galaxy
cp .env.example .env
