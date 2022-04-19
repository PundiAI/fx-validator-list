# fxCore Validator List


## Instructions to update your validator's logo
1. fork the official Function X fx-validator-list repo
2. The forked repo should be under your account/username.
3. Clone the forked repo locally. 
if you are using terminal, git clone https://github.com/ your-github-username /fx-validator-list.git 
otherwise, simply use HTTPS method for any of your git clients : githubdesktop/sourcetree.
4. checkout a new branch and name the branch ‘update_[your FX validator address]_logo’
5.  you can find out your validator address <fxvaloper..> under your validator name through the link
 https://explorer.functionx.io/fxcore/validators update <your_validator's address> logo
 6. Run the following script 
    i) # mainnet
        ./run.sh mainnet
    ii) # testnet
        ./run.sh testnet
 8. add in the logo to your directory, the logo should have the following specifications:
    a. Ensure it is in a .png format
    b. Rename it to ‘logo.png’
    c. File size cannot be bigger than 2MB
    d. The recommended image size is 800*800
7. Once done, commit your changes and push to your forked repo.
8. Check in github for the changes, and then click create a pull request. 
9. If your logo update is not yet picked up,  kindly leave a message on functionx forum thread.

* update fxcore validator.json

```shell script
# mainnet
./run.sh mainnet
# testnet
./run.sh testnet
```

credits: FrenchXCore
https://forum.functionx.io/t/customized-validator-avatar-logo-update/3291/7
