Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09644F216F
	for <lists+linux-efi@lfdr.de>; Tue,  5 Apr 2022 06:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiDECQU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Apr 2022 22:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiDECQS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Apr 2022 22:16:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C032739C368
        for <linux-efi@vger.kernel.org>; Mon,  4 Apr 2022 18:11:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bo5so10621741pfb.4
        for <linux-efi@vger.kernel.org>; Mon, 04 Apr 2022 18:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qk2vTGXRGqf3BpKwQtYdBLCMBP+WWND1mbOCTeq7Wd8=;
        b=M8Y3mkCyz4+DCsjQDgiHQLuP6ZxBkxl0uN10+U2ZHu9akhKgM8UGUz5wmW7tJAPQP3
         QTmFA2BUcbFUPrczakTRxGwXBdWfXzPfzDvgeaSSKTX2ETyxQaRXiOE8pcIv+QItZV1R
         YcAIj9+gpFvBzBQxhy4lAJ7VtG96ODgzuR27VBTeIi8VzSBA5K9IB4Wn2REubsm/4ZEj
         GWMbLa9EdZrL7Q04meUTwExAMH1Je0IY5Ff4RSMzfMEnJSIERJgUtGHNZW4s0xmMGGUW
         EACEBdpiTsmDRnB6GQOWobQzAd3yXuZYlxfQkd9pW77edOHHriaRDYcIP8UOoF+xZbtl
         sllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qk2vTGXRGqf3BpKwQtYdBLCMBP+WWND1mbOCTeq7Wd8=;
        b=LfxL3OpyNovWczwgaIs77mONr2uh8RhpkLm0z0i/OEi0+vp+p6v4siyShYW8/shRMA
         Su9BiiYIXA/BnYs+e0EqjbP1fDdosMvuqJIRA98B0LSt5o9ieIZd7C9wlAtyUenpo2Jo
         1viD5L+fzenkwParoILczm6z0oTryqAhuj5KYrtxuCHat/jL7IM1SveV/MurdSbx11xJ
         rncgh3FIaR99UkWHqPBfxiK/TdLCC+mKQ0j4tm/Ln25qAD0DDhF1G1LvJ013NZTu6tlK
         qNemw5Vxrx2ZPq00mmfHNRJy3E29qdxjb1jyyFVwSZPKKKNN/77suLWhXg+8pNcxpMXw
         JoNA==
X-Gm-Message-State: AOAM532p5+CH3h+eaUqEE7OFWLc2WHrv3e1lxREtpuaX2p5kL05DH4cY
        V7rDZO0sWXpwE52zhzh+qLKtQxpNP1/mHQ==
X-Google-Smtp-Source: ABdhPJyjA0jJqHDz/DH9qTaHPbID/6l5iy6vv0UwOj0FN0hUEVJXEqnuhpyz8BqJv3fl3Gsmm5CxSA==
X-Received: by 2002:a65:63d9:0:b0:374:6b38:c6b3 with SMTP id n25-20020a6563d9000000b003746b38c6b3mr636129pgv.195.1649118289900;
        Mon, 04 Apr 2022 17:24:49 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm261755pjn.34.2022.04.04.17.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 17:24:49 -0700 (PDT)
Date:   Tue, 5 Apr 2022 00:24:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 22/46] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Message-ID: <YkuMTdckSgSB9M6f@google.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-23-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307213356.2797205-23-brijesh.singh@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Mar 07, 2022, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> To provide a more secure way to start APs under SEV-SNP, use the SEV-SNP
> AP Creation NAE event. This allows for guest control over the AP register
> state rather than trusting the hypervisor with the SEV-ES Jump Table
> address.
> 
> During native_smp_prepare_cpus(), invoke an SEV-SNP function that, if
> SEV-SNP is active, will set/override apic->wakeup_secondary_cpu. This
> will allow the SEV-SNP AP Creation NAE event method to be used to boot
> the APs. As a result of installing the override when SEV-SNP is active,
> this method of starting the APs becomes the required method. The override
> function will fail to start the AP if the hypervisor does not have
> support for AP creation.

...

> @@ -823,6 +843,230 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages)
>  	pvalidate_pages(vaddr, npages, true);
>  }
>  
> +static int snp_set_vmsa(void *va, bool vmsa)
> +{
> +	u64 attrs;
> +
> +	/*
> +	 * Running at VMPL0 allows the kernel to change the VMSA bit for a page
> +	 * using the RMPADJUST instruction. However, for the instruction to
> +	 * succeed it must target the permissions of a lesser privileged
> +	 * VMPL level, so use VMPL1 (refer to the RMPADJUST instruction in the
> +	 * AMD64 APM Volume 3).
> +	 */
> +	attrs = 1;
> +	if (vmsa)
> +		attrs |= RMPADJUST_VMSA_PAGE_BIT;
> +
> +	return rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
> +}
> +
> +#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
> +#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
> +#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
> +
> +#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
> +#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
> +
> +static void *snp_alloc_vmsa_page(void)
> +{
> +	struct page *p;
> +
> +	/*
> +	 * Allocate VMSA page to work around the SNP erratum where the CPU will
> +	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
> +	 * collides with the RMP entry of VMSA page. The recommended workaround
> +	 * is to not use a large page.
> +	 */
> +
> +	/* Allocate an 8k page which is also 8k-aligned */
> +	p = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
> +	if (!p)
> +		return NULL;
> +
> +	split_page(p, 1);
> +
> +	/* Free the first 4k. This page may be 2M/1G aligned and cannot be used. */
> +	__free_page(p);
> +
> +	return page_address(p + 1);
> +}
> +
> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
> +{
> +	int err;
> +
> +	err = snp_set_vmsa(vmsa, false);

Uh, so what happens if a malicious guest does RMPADJUST to convert a VMSA page
back to a "normal" page while the host is trying to VMRUN that VMSA?  Does VMRUN
fault?

Can Linux refuse to support this madness and instead require the ACPI MP wakeup
protocol being proposed/implemented for TDX?  That would allow KVM to have at
least a chance of refusing to support AP "creation", which IMO is a CVE or three
waiting to happen.  From a KVM perspective, I don't ever want to be running a
guest-defined VMSA.

https://lore.kernel.org/all/YWnbfCet84Vup6q9@google.com

> +	if (err)
> +		pr_err("clear VMSA page failed (%u), leaking page\n", err);
> +	else
> +		free_page((unsigned long)vmsa);
