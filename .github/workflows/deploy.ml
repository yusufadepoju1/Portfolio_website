name: Flask CI/CD Deploy

on:
  push:
    branches:
      - master

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Deploy to EC2
        uses: appleboy/ssh-action@v1.0.3
        with:
          host: ${{ secrets.EC2_HOST }}
          username: ${{ secrets.EC2_USER }}
          key: ${{ secrets.EC2_KEY }}
          script: |
            cd ~/Portfolio_website
            git pull origin master
            source venv/bin/activate
            pip install -r requirements.txt
            pkill -f app.py || true
            nohup python app.py > app.log 2>&1 &