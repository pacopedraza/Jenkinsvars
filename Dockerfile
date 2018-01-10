FROM python:2.7

WORKDIR /app

RUN apt-get update && \
    apt-get install -y libxi-dev libgl1-mesa-dev libglu1-mesa-dev libsm-dev libgomp1 libfreetype6-dev libxrender-dev libfontconfig1-dev python python-dev python-distribute python-pip git && \
    pip install awscli laspy argparse

# set a maintainer
LABEL maintainer "pacopedraza87@gmail.com"

ADD input_to_secondjob.py /app/input_to_secondjob.py
EXPOSE 80
ENV OUTPUT_DIRECTORY=/output
CMD ["python", "input_to_secondjob.py"]
