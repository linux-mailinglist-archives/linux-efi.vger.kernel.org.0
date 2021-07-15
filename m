Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686B83CAFC3
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 01:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhGOXvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 15 Jul 2021 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhGOXvS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 15 Jul 2021 19:51:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F13BC061762
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 16:48:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id y17so8169042pgf.12
        for <linux-efi@vger.kernel.org>; Thu, 15 Jul 2021 16:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5OQMDn6Hx/yHVRBDOLcOoarZgTpJ6ou0lJ0Voq0OG4M=;
        b=Xerp+3Ma+7CKr4/78JI541G8uYD8//jwvClMOF/fOO7QmiQm8HAEUnu6NpDbBLMH1q
         bZGV9qTn+NrOGGYaOzCjTB7B/aPpvd5It43hKuUVskOmztUVNBp7D+395FsS2sQvlrxq
         xVAo8FpFCDhowTVg4hGaiMCdbGyqn6qUNM0miSvgPCaSI49UBGL5vj48ibmF6+Rb17X0
         w7C8AuBB8wkZlc1aeNQ5K9KigBlX9jYvbv1ccsercnerPpuW03IdweX4DvdjBnQR82bX
         e0jajjskDBGjMsxL7Fj/B+zCTGGj135zbVxs9kViMAV8ZYC/Kcwbxlf9wsPPlckGHHm4
         ds+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5OQMDn6Hx/yHVRBDOLcOoarZgTpJ6ou0lJ0Voq0OG4M=;
        b=d0rx3zSC5Tu0Sdvx5/56P1SJvylcC9r4TX4o3pecodS28IrknCEwph/oLQV7zC2yw0
         Mm5wt8i8EmfdBnrfbyXwo2CRnUe5RQhIb79rNcExIcfr2d6K+c9NpdJ/V/pqAlfBhwBi
         mmixdzYZDsNqNsBdrW+8DHcMpkAml2osDNBbvuWvHMASWgJOJ1bhct0CBqWUq7VSSP7K
         4IBUSVlHoQETNl4UMPrDWX6r2hAeLyTunR3tAWFMzuztxcZtDon0NBkZHFWwkZq6qCZe
         Bm3Mtq7OBfNNLR1LgPR2N8uI5kZT5UFELIRJwcx8RChaGaOJzFmNt4YwvC92IqUY7+29
         4/ZA==
X-Gm-Message-State: AOAM530Z8aMyKEzoyEfwdM21d6hsX5iApvNY/o8AcJLbq9Zazz+Wa4qd
        eFRRdb/gYorN2n63KVXRwgJCoQ==
X-Google-Smtp-Source: ABdhPJzB/aLwcMzRnzgFsmskaKhCj/u4SogoqFPq9x0TyUcwapKqqebbwl1vM0o7pXaHZ6NJDfrs4g==
X-Received: by 2002:a63:4e5d:: with SMTP id o29mr275121pgl.379.1626392903572;
        Thu, 15 Jul 2021 16:48:23 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o184sm8719553pga.18.2021.07.15.16.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 16:48:22 -0700 (PDT)
Date:   Thu, 15 Jul 2021 23:48:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 15/40] crypto: ccp: Handle the legacy TMR
 allocation when SNP is enabled
Message-ID: <YPDJQ0uumar8j22y@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-16-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-16-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> The behavior and requirement for the SEV-legacy command is altered when
> the SNP firmware is in the INIT state. See SEV-SNP firmware specification
> for more details.
> 
> When SNP is INIT state, all the SEV-legacy commands that cause the
> firmware to write memory must be in the firmware state. The TMR memory

It'd be helpful to spell out Trusted Memory Region, I hadn't seen that
term before and for some reason my brain immediately thought "xAPIC register!".

> is allocated by the host but updated by the firmware, so, it must be
> in the firmware state.  Additionally, the TMR memory must be a 2MB aligned
> instead of the 1MB, and the TMR length need to be 2MB instead of 1MB.
> The helper __snp_{alloc,free}_firmware_pages() can be used for allocating
> and freeing the memory used by the firmware.

None of this actually states what the patch does, e.g. it's not clear whether
all allocations are being converted to 2mb or just the SNP.  Looks like it's
just SNP.  Something like this?

  Allocate the Trusted Memory Region (TMR) as a 2mb sized/aligned region when
  SNP is enabled to satisfy new requirements for SNP.  Continue allocating a
  1mb region for !SNP configuration.

> While at it, provide API that can be used by others to allocate a page
> that can be used by the firmware. The immediate user for this API will
> be the KVM driver. The KVM driver to need to allocate a firmware context
> page during the guest creation. The context page need to be updated
> by the firmware. See the SEV-SNP specification for further details.

...

> @@ -1153,8 +1269,10 @@ static void sev_firmware_shutdown(struct sev_device *sev)
>  		/* The TMR area was encrypted, flush it from the cache */
>  		wbinvd_on_all_cpus();
>  
> -		free_pages((unsigned long)sev_es_tmr,
> -			   get_order(SEV_ES_TMR_SIZE));
> +
> +		__snp_free_firmware_pages(virt_to_page(sev_es_tmr),
> +					  get_order(sev_es_tmr_size),
> +					  false);
>  		sev_es_tmr = NULL;
>  	}
>  
> @@ -1204,16 +1322,6 @@ void sev_pci_init(void)
>  	    sev_update_firmware(sev->dev) == 0)
>  		sev_get_api_version();
>  
> -	/* Obtain the TMR memory area for SEV-ES use */
> -	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
> -	if (tmr_page) {
> -		sev_es_tmr = page_address(tmr_page);
> -	} else {
> -		sev_es_tmr = NULL;
> -		dev_warn(sev->dev,
> -			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> -	}
> -
>  	/*
>  	 * If boot CPU supports the SNP, then first attempt to initialize
>  	 * the SNP firmware.
> @@ -1229,6 +1337,16 @@ void sev_pci_init(void)
>  		}
>  	}
>  
> +	/* Obtain the TMR memory area for SEV-ES use */
> +	tmr_page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(sev_es_tmr_size), false);
> +	if (tmr_page) {
> +		sev_es_tmr = page_address(tmr_page);
> +	} else {
> +		sev_es_tmr = NULL;
> +		dev_warn(sev->dev,
> +			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> +	}

I think your patch ordering got a bit wonky.  AFAICT, the chunk that added
sev_snp_init() and friends in the previous patch 14 should have landed above
the TMR allocation, i.e. the code movement here should be unnecessary.

>  	/* Initialize the platform */
>  	rc = sev_platform_init(&error);
>  	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {

...

> @@ -961,6 +965,13 @@ static inline int snp_guest_dbg_decrypt(struct sev_data_snp_dbg *data, int *erro
>  	return -ENODEV;
>  }
>  
> +static inline void *snp_alloc_firmware_page(gfp_t mask)
> +{
> +	return NULL;
> +}
> +
> +static inline void snp_free_firmware_page(void *addr) { }

Hmm, I think we should probably bite the bullet and #ifdef and/or stub out large
swaths of svm/sev.c before adding SNP support.  sev.c is getting quite massive,
and we're accumulating more and more stubs outside of KVM because its SEV code
is compiled unconditionally.
