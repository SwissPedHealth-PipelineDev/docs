---
layout: home
title: Home
nav_order: 1
---

<h1
style="display:center;">
    <img
    style="float: left; padding-top: 1px"
    src="{{ "assets/images/logos/SwissPedHealth_Pipeline_Devs.png" | relative_url }}"
    alt="Pipe dev logo image"
    width="70"
    />
PipeDev docs
</h1>

---

{: .no_toc }
<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
- TOC
{:toc}
</details>
---

<!-- width="100% -->


## Welcome


This is the documentation index for bioinformatic pipeline development.
You can visit the project home page at
<https://www.swisspedhealth.ch>.

## Quick start

Most likely, you are looking for one of our design documents. 
Check the **side bar** or go here: [Index page for design documents](pages/design_doc/design_doc.html).
These pages describe the processes for our pipelines, start to finish, with links to supporting information.

## Full site navigation

<div class="nav-columns specific-grid">
  <ul>
  {% assign pages = site.html_pages  %}
  {% for page in pages %}
    {% if page.title %}
      <li><a href="{{ page.url | relative_url }}">{{ page.title }}</a></li>
    {% endif %}
  {% endfor %}
  </ul>
</div>

## About

### General


Please contact us if you find any documentation that requires updates. 
We aim to include information about tools, reference datasets, databases, and any other component used in our pipelines besides sensitive and protected personal information. 
We will not include README information about pipeline source code here - this information should be found in the individual project repositories.
However, should any stable pipelines become routinely implemented, we are likely add a user guide here. 

### Content

This documentation is made to track the public progress of pipeline development.
It includes information about the pipeline branches, for example DNA single variant detection, DNA CNV detection, RNA quantitative expression, etc.
Many features are common to different branches (e.g. reference databases, reference datasets) are therefore listed separately form branch-specific content. 

We rely on accurate reference data sources and therefore each component is tracked with identification information such as source location (URL, citation, etc), date, checksum, file size, contributor ID, etc. 
We maintain a database to ensure accurate tracking to reduce duplication or mislabelling.
This database is to be used for automated variable generation, reporting, and cross-project consistency.
We aim to maintain this database in our public git repository to promote data integrity and open science.

### Data protection

No research data or personal information will be included in public documentation.
Sensitive variables will only be stored within private offline project repositories.
We use a public development repository to ensure a clear separation of infrastructure development and private patient data.

## Contributors
1. The SwissPedHealth-PipelineDev organisation on GitHub:
[github.com/SwissPedHealth-PipelineDev](https://github.com/SwissPedHealth-PipelineDev). 
2. This documentation repository is hosted on our GitHub organisation under `docs`:
[github.com/SwissPedHealth-PipelineDev/docs](https://github.com/SwissPedHealth-PipelineDev/docs).

* You can request to become a member of the organisation via GitHub. 
* You can make pull requests to the `docs` repository.
* Alternatively, you can email us with comments directly.

## Documentation style

This site is built using the *bare-minimum* template from the 
"Just the Docs" theme. 
It uses Jekyll to build the static site which is then hosted on GitHub pages (or hosted from any other server).

If Jekyll is installed on your computer, you can also build and preview the created site *locally*. This lets you test changes before committing them, and avoids waiting for GitHub Pages.[^1] And you will be able to deploy your local build to a different platform than GitHub Pages.

We currently allow GitHub pages to rebuild the site using Jekyll.
We have also tested the method to push the pre-built `_site`, should additional custom plugins be required. However, we aim to rely on minimum complexity. 

More specifically, the created site:

- uses a gem-based approach, i.e. uses a `Gemfile` and loads the `just-the-docs` gem
- uses the [GitHub Pages / Actions workflow] to build and publish the site on GitHub Pages

[Browse the theme documentation][Just the Docs] to learn more about how to use this theme.

You can read about how to maintain docs in the `docs` directory of an existing project repo, see [Hosting your docs from an existing project repo](https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md#hosting-your-docs-from-an-existing-project-repo) in the template README.
However, this `docs` repo is a standalone repository within the SwissPedHealth-PipelineDev github orgnaisation.

{: .note }
We can use the special styles for `{: .note }` and `{: .warning }` by adding this code before a paragraph.


## Documentation growth
We intermittently track the [documentation log count](pages/file_count.html).

![img]({{ "assets/images/file_count_plot-1.png" | relative_url }})


![img]({{ "assets/images/logos/SwissPedHealth_Pipeline_Devs_wide_2.png" | relative_url }})


----

[^1]: [It can take up to 10 minutes for changes to your site to publish after you push the changes to GitHub](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll#creating-your-site).

[Just the Docs]: https://just-the-docs.github.io/just-the-docs/
[GitHub Pages]: https://docs.github.com/en/pages
[README]: https://github.com/just-the-docs/just-the-docs-template/blob/main/README.md
[Jekyll]: https://jekyllrb.com
[GitHub Pages / Actions workflow]: https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/
[use this template]: https://github.com/just-the-docs/just-the-docs-template/generate
