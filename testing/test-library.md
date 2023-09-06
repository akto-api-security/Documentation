# Test library

Akto provides functionality to add your own tests in the form of nuclei template files. You can run your own tests, along with Automated tests built by Akto against your api collections very conveniently.

## Brief Overview

* In the left navbar, click on Tests Library section.
* You will see lots of pre-existing tests(Automated tests built by Akto, as well as nuclei templates), which cover major OWASP categories.
* You can also check out source code of any nuclei template test. For ex - Go to "path\_traversal" subCategory inside BOLA category, you will see "Contribute in Github" option below each of the tests. You are more than welcome to contribute to these templates :)

<figure><img src="../.gitbook/assets/Frame 24 (1).png" alt=""><figcaption></figcaption></figure>

## Adding your own Test

* You would see an "Add test" button in the Tests library section.
* On clicking the button, you would have to fill out few details -
  * **Raw Url of nuclei template** - For the template you intend on adding, you can very easily get it's raw url from github, by clicking on Raw option in it's source code. A sample raw url might look like - https://raw.githubusercontent.com/akto-api-security/tests-library/master/BOLA/path\_traversal/path\_traversal\_full.yaml.
  * **Category** - Please select the appropriate category from the range of categories in drop down menu. In case of any confusion in selecting the category, you can check out pre existing nuclei tests.
  * **Subcategory** - Please select the appropriate subCategory from the range of categories in drop down menu. In case of any confusion in selecting the category, you can check out pre existing nuclei tests.
  * **Severity** - You can also assign severity for your newly added template. By default it's preselected as HIGH. But you can lower it down to MEDIUM/LOW, depending on your use case.
* Click on Add button at the bottom right.

{% hint style="info" %}
We will soon be launching a feature where you might be able to upload template via a file as well, so watch out for that :)
{% endhint %}

Here you go! You have now successfully added a test of your own, which you can run against your dataset. While running tests, you can find your newly added template inside the category you chose earlier.

## Contributing to our Open Source Testing Module -

We would be very happy to make tests as robust and useful to the community. If you find this helpful, and are willing to contribute and you feel your templates might be really useful for the other developers out there, you can check out our open source repo - https://github.com/akto-api-security/tests-library. All suggestions to existing templates, and new templates are welcome. Create a PR, which will be reviewed by us. Also, we will soon be publishing a robust Contribution Guidilines.
