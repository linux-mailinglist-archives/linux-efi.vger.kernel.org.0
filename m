Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CE3CB9F1
	for <lists+linux-efi@lfdr.de>; Fri, 16 Jul 2021 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbhGPPiG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Jul 2021 11:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbhGPPiG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Jul 2021 11:38:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D801C061765
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 08:35:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so9069254pju.4
        for <linux-efi@vger.kernel.org>; Fri, 16 Jul 2021 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0cTnZy2I4CZKY1bHPxJLKssBACveTIPG9X+4FMx1/uQ=;
        b=afSs59INL/oaaVSpQPeRtiIcJrpZwqHHpaDKcKMQGA6aWrOaBsFQgpUgROlc1OHvsr
         R8+DUt0nxbzW92N5jyf1GQnF/hr52cuxKwcH10Pr8I7RED3k1ryiX7DXdXuaA7APN6m4
         XWPOS5SwXn7SL7HD5a2j5vD6dOKAEQY9m1vnGiABnDA5fHtdH2zr8Y5fdOgg0bb0iuku
         DojBvVx1otGchwtODy/S4//wZ2V3ziB+XpzqgAvJEq/hlGIebWzzQh0E5JJgub29thOP
         YmvVF0HsEbccSVc12R6sAKoXRNAtlV+kh3t3D5Xb8MzS29UsDlX4R1djNaCtt7Rgc/uW
         jh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0cTnZy2I4CZKY1bHPxJLKssBACveTIPG9X+4FMx1/uQ=;
        b=jnLSWVVRUEf4TY80ytorLobdBvLcOReTSNRM6IDeaVoYYF0jEQzgKM0pr4rsr6l2F6
         OEkrdVoq4QWXQaKn2JvXBB4EGiCBdGLjXmRaCq1kq7FanReIGmi3POqij6Bq1mkf4w0/
         tXAr+oDsZuy/Cyd7+aOmySfhn2xcLupswvH8r5ct649xzdz3BiY+KmMtJgPcP9BvslRn
         oe0Qg/hyipvxXonR0/MSbCWlTXE5ol2YXvF/xRCgWKgbB4FzA7SwTJ8TcvlQyGMeabzV
         p8+k4ILtYwqtYPZC4e9LXwajB5/WeCrGAauCC93WBiD9SKK6H3dKem1hsMOH2JPwAXJi
         HfJg==
X-Gm-Message-State: AOAM5314FzeFOde+lKCKnuKsl/yuPh8VENeJ3+QvSpss062ah2BfkVgQ
        R6gpC3TmnaJIzBfUGZP8MYpP6g==
X-Google-Smtp-Source: ABdhPJzO0czTiC4lrspMK8pptIQ8UcgEuTYWN2rX0ygskl7xaEBTKiH2YjQzLJUVfWfhZQnvHsTqCA==
X-Received: by 2002:a17:902:ed82:b029:ef:48c8:128e with SMTP id e2-20020a170902ed82b02900ef48c8128emr8350696plj.72.1626449710421;
        Fri, 16 Jul 2021 08:35:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j21sm8548916pjz.26.2021.07.16.08.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 08:35:09 -0700 (PDT)
Date:   Fri, 16 Jul 2021 15:35:05 +0000
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
Message-ID: <YPGnKfDvmgzHCwbI@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-16-brijesh.singh@amd.com>
 <YPDJQ0uumar8j22y@google.com>
 <dfa4ccb5-f85e-6294-6a80-9e4aa6d93c1e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa4ccb5-f85e-6294-6a80-9e4aa6d93c1e@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 16, 2021, Brijesh Singh wrote:
> 
> On 7/15/21 6:48 PM, Sean Christopherson wrote:
> > On Wed, Jul 07, 2021, Brijesh Singh wrote:
> >> @@ -1204,16 +1322,6 @@ void sev_pci_init(void)
> >>  	    sev_update_firmware(sev->dev) == 0)
> >>  		sev_get_api_version();
> >>  
> >> -	/* Obtain the TMR memory area for SEV-ES use */
> >> -	tmr_page = alloc_pages(GFP_KERNEL, get_order(SEV_ES_TMR_SIZE));
> >> -	if (tmr_page) {
> >> -		sev_es_tmr = page_address(tmr_page);
> >> -	} else {
> >> -		sev_es_tmr = NULL;
> >> -		dev_warn(sev->dev,
> >> -			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> >> -	}
> >> -
> >>  	/*
> >>  	 * If boot CPU supports the SNP, then first attempt to initialize
> >>  	 * the SNP firmware.
> >> @@ -1229,6 +1337,16 @@ void sev_pci_init(void)
> >>  		}
> >>  	}
> >>  
> >> +	/* Obtain the TMR memory area for SEV-ES use */
> >> +	tmr_page = __snp_alloc_firmware_pages(GFP_KERNEL, get_order(sev_es_tmr_size), false);
> >> +	if (tmr_page) {
> >> +		sev_es_tmr = page_address(tmr_page);
> >> +	} else {
> >> +		sev_es_tmr = NULL;
> >> +		dev_warn(sev->dev,
> >> +			 "SEV: TMR allocation failed, SEV-ES support unavailable\n");
> >> +	}
> > I think your patch ordering got a bit wonky.  AFAICT, the chunk that added
> > sev_snp_init() and friends in the previous patch 14 should have landed above
> > the TMR allocation, i.e. the code movement here should be unnecessary.
> 
> I was debating about it whether to include all the SNP supports in one
> patch or divide it up. If I had included all legacy support new
> requirement in the same patch which adds the SNP then it will be a big
> patch. I had feeling that others may ask me to split it.

It wasn't comment on the patch organization, rather that the code added in patch 14
appears to have landed in the wrong location within the code.  The above diff shows
that the TMR allocation is being moved around the SNP initialization code that was
added in patch 14 (the immediately prior patch).  Presumably the required order
doesn't magically change just because the TMR is now being allocated as a 2mb blob,
so either the code movement is unnecessary churn or the original location was wrong.
In either case, landing the SNP initialization code above the TMR allocation in
patch 14 would eliminate the above code movement.
