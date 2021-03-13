from setuptools import setup


def readme():
    with open('README') as f:
        return f.read()

setup(
    name='sshtc',
    version='0.1',
    description='Tiny SSH client in Linux terminal',
    long_description=readme(),
    url='https://github.com/smokehill/sshtc',
    author='Valera Padolochniy',
    author_email='valera.padolochniy@gmail.com',
    license='MIT',
    packages=['sshtc'],
    entry_points={
        'console_scripts': ['sshtc=sshtc.main:main'],
    },
    classifiers=[
        'Environment :: Console',
        'License :: OSI Approved :: MIT',
        'Programming Language :: Python :: 2.7',
    ],
)