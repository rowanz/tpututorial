# tpututorial
This is the associated code for Rowan's TPU tutorial. This is a limited version of a longer and more detailed set of tutorials, which you can find at [this website](https://cloud.google.com/tpu/docs/tutorials). Here are the steps to get set up:

1. [Download google cloud utilities.](https://cloud.google.com/sdk/install) There are links to an [interactive installer](https://cloud.google.com/sdk/docs/downloads-interactive) for osx/windows, and [apt-get instructions](https://cloud.google.com/sdk/docs/downloads-apt-get) for Ubuntu.
2. Open a terminal and run ```gcloud init``` (note that if you're following this tutorial on a server that doesn't have a display, you need to run `gcloud init --console-only`) You'll need to sign up with a project. If you're at UW, use the private lab-only account. Otherwise, use the project for your team at AI2.
3. We need to make sure the right zone/regions are set, so use
    ```
    gcloud config set compute/zone us-central1-b
    gcloud config set compute/region us-central1
    ```
4. Download the Cloud TPU tool. On OSX this is
    ```
    curl -O https://dl.google.com/cloud_tpu/ctpu/latest/darwin/ctpu && chmod a+x ctpu && mv ctpu ~/google-cloud-sdk/bin/
    ```
    On Linux this is
    ```
    wget https://dl.google.com/cloud_tpu/ctpu/latest/linux/ctpu && chmod a+x ctpu && sudo mv ctpu /usr/bin/
    ```
5. For some reason I often need to authenticate once more, so run
    ```
    gcloud auth application-default login
    ```
    (If you are on a remote server, use `gcloud auth application-default login --no-launch-browser`)
6. Visit [the cloud storage page](https://console.cloud.google.com/storage/browser) and make a cloud storage bucket in the `us-central1` region. I named mine `tpututorial`. We'll also need to fix the permissions on this storage bucket. Grab the project number from the main google cloud console (mine is `335436385550`) and edit the permissions (right hand side). Add 
    ```
    service-[PROJECT_NUMBER]@cloud-tpu.iam.gserviceaccount.com
    ```
    to both the `Storage Legacy Writer` and `Storage Legacy Reader` groups.
    
## Let's create our first TPU!
Finally done with setup! We're now ready to get started. The command that you want is:
```
ctpu up --name $(hostname) --tpu-size=v2-8 --preemptible --tf-version '1.12'
```
(replace `$(hostname)` with something better)
This will create a virtual machine, and an associated TPU. We're using one of the older (more stable) TPUs. There are also additional TPU options if we wanted more compute. The `--preemptible` flag means that your TPU might get suddenly killed by Google. These TPUs are much cheaper though!

At any time, you can look at the status of your VM and TPUs by going to the [VM instances](https://console.cloud.google.com/compute/instances) or [TPUs](https://console.cloud.google.com/compute/tpus) page.

There's one more thing you'll need to do. Look at the[VM instance](https://console.cloud.google.com/compute/instances) you created and add your SSH key into `SSH Keys` there. You can get your SSH key by running `cat ~/.ssh/id_rsa.pub`.

If you don't have an SSH key, use [this tutorial](https://confluence.atlassian.com/bitbucketserver/creating-ssh-keys-776639788.html). You will also need the External IP of your server, available on that page. Mine is `104.154.97.121`.

## Let's run BERT on our new TPU!

Let's upload this folder onto your new machine, and then SSH there. For me I'd run
```
scp -r ~/code/tpututorial rowanz@104.154.97.121:~
```
Usually I have PyCharm automatically upload stuff that's local to the cloud. So for me, I have:

* local (osx): `/Users/rowanz/code/tpututorial`
* remote (server): `/home/rowanz/tpututorial`

Now, `cd` into your remote directory `tpututorial`, and we'll install some dependencies by running `chmod +x setup.sh && ./setup.sh && source ~/.bashrc`

And that's it! We should be good to go. Let's train BERT on SWAG! Edit the file `train_and_val_swag.sh` with the name of your cloud storage bucket (since mine was `tpututorial`) and then run
```
chmod +x train_and_val_swag.sh && ./train_and_val_swag.sh
```
and you're done!!
