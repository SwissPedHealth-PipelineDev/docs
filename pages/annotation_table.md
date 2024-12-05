---
layout: default
title: Annotation table
nav_order: 5
---

<!-- 2023-05-31 00:00:01 -->

<head>
<!-- function to resize table iframe to make height 100% to prevent nested scolling. --> <script>
  function resizeIframe(obj) {
    obj.style.height = obj.contentWindow.document.documentElement.scrollHeight + 'px';
  }
</script>
</head>

Last update: 20230531

<h1>Annotation table</h1>

The majority of these databases are included in dbNSFP which is thus the simplest joint source [^Liu2011dbNSFP], [^Liu2020dbNSFP].

1. Liu X, Jian X, and Boerwinkle E. 2011. dbNSFP: a lightweight database of human non-synonymous SNPs and their functional predictions. Human Mutation. 32:894-899.

2. Liu X, Li C, Mou C, Dong Y, and Tu Y. 2020. dbNSFP v4: a comprehensive database of transcript-specific functional predictions and annotations for human nonsynonymous and splice-site SNVs. Genome Medicine. 12:103.

[^Liu2011dbNSFP]: Liu X, Jian X, and Boerwinkle E. 2011. dbNSFP: a lightweight database of human non-synonymous SNPs and their functional predictions. Human Mutation. 32:894-899.

[^Liu2020dbNSFP]: Liu X, Li C, Mou C, Dong Y, and Tu Y. 2020. dbNSFP v4: a comprehensive database of transcript-specific functional predictions and annotations for human nonsynonymous and splice-site SNVs. Genome Medicine. 12:103.

<img 
src="{{ "data/annotation_datasets/output/annotation_datasets_category.png" | relative_url }}"
width="100%">


<iframe 
src="{{ "data/annotation_datasets/output/annotation_datasets_table.html" | relative_url }}"
width="100%"
frameborder="0" scrolling="no" onload="resizeIframe(this)" />


<!-- Without the script above, some of these methods may be useful: -->
<!-- <iframe --> 
<!-- src="{{ site.baseurl }}{% link data/annotation_datasets/output/annotation_datasets_table.html %}" -->
<!-- width="100%" -->
<!-- onload="this.height=screen.height;" -->
<!-- ></iframe> --> 
<!-- id="igraph" --> 
<!-- height="5000" -->
<!-- seamless="seamless" -->
<!-- style="border:none;" --> 
<!-- scrolling="no" -->
<!-- onload="this.width=screen.width;" -->
<!-- onload="this.width=screen.width;this.height=screen.height;" -->

