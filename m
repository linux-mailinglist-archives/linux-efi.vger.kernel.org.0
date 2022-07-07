Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9856ACE2
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jul 2022 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiGGUns (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Jul 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiGGUnr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Jul 2022 16:43:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610EB2409B
        for <linux-efi@vger.kernel.org>; Thu,  7 Jul 2022 13:43:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id o12so8173413pfp.5
        for <linux-efi@vger.kernel.org>; Thu, 07 Jul 2022 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ll20ZcAb0w9z6zV6paEiNQvrdmi0bjy9wQYysAR+tA8=;
        b=URF1boc84AH8v3HsZBbgNOqHaD2PrXzBbYwtXSIfIVRywqeC1B6KsyAiYI58j7p8Ll
         w+BpTtRDUQDJMzOvCRjLMRlP/I4XvBlIw0fmlot8jvJ4iTPyGKKHpugbxZbP42XsyQPt
         0zpbeWv6tIlOzL0jPLkJCDZBGjh0PyOY0jp2S31IKnOXJ2gPxDiRBrVdra/sEZ7CqSxR
         jyEsVkeYWIAW55BczsdSKQ4cHzs7S1sruDMhUa9dcTtj6rR8RxyN7Rd6tWIgt6TA24zc
         6StG5dlQKRb9/JD+KpgqdRiSHCG6KbPQuHygtUPG1uZy1vtJqtdlxyRNnpCo9gnlodNf
         DwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ll20ZcAb0w9z6zV6paEiNQvrdmi0bjy9wQYysAR+tA8=;
        b=JrWh3+4J3cJGKJaQj/pGYUOHvDEXnFBs3XAP5JZnAGv7CPgI/9P5/i5UOO1XmJ/FuU
         +04BeywxeR6saRGZyEzWyHFElQFezFI6KiUeI3Z6Ej4L98rtWKNnMtCP0L/JCpSqMdJL
         NxtaE363C+1HuMjV8K4vLOF3HIUcSCUgeOphmZxyu9yrrphjR/nFq7ZGYwuqtpRiety+
         NfABIeDKLeT3oIvGXEp3DEeLk7ZI1DY/GnQd11GKotEoOFlmFzfy/ibmzwoGFKUlx7fe
         pnH+XHzf98z02+hoU7ieww7YPYkM1FDIy/yZWAeUt82lPl+7kDUP1wEw2UDLcolzrSE6
         aRFg==
X-Gm-Message-State: AJIora+KfMd7g3BhO1qI54HbHJKskCjfBiyx1/xD8pVPchsYkVkYPXDa
        6CGUnGmx7rYwycSVTykgrc0v4seUSK778g==
X-Google-Smtp-Source: AGRyM1snpqN5XIgDiCvMqPlmhkqtR4FIdb2NphBLO/yR046bU8RX+GmUkvAlMCeGkCa4G4i/R5k0NQ==
X-Received: by 2002:a05:6a00:a8e:b0:527:9d23:c613 with SMTP id b14-20020a056a000a8e00b005279d23c613mr55562111pfl.53.1657226624708;
        Thu, 07 Jul 2022 13:43:44 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id g16-20020a63e610000000b0041264dec901sm6517163pgh.21.2022.07.07.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:43:43 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:43:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <michael.roth@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <YsdFfL231NXvYOXu@google.com>
References: <20220307213356.2797205-20-brijesh.singh@amd.com>
 <YqfabnTRxFSM+LoX@google.com>
 <YqistMvngNKEJu2o@google.com>
 <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com>
 <YqizrTCk460kov/X@google.com>
 <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
 <Yqjm/b3deMlxxePh@google.com>
 <9abe9a71-242d-91d5-444a-b56c8b9b6d90@amd.com>
 <YqtdIf7OSivLxFL0@google.com>
 <Yr8mARnQT+VZK0iy@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr8mARnQT+VZK0iy@zn.tnic>
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

On Fri, Jul 01, 2022, Borislav Petkov wrote:
> On Thu, Jun 16, 2022 at 04:41:05PM +0000, Sean Christopherson wrote:
> > > I worry that another use of cc_platform_has() could creep in at some point
> > > and cause the same issue. Not sure how bad it would be, performance-wise, to
> > > remove the jump table optimization for arch/x86/coco/core.c.
> 
> Is there a gcc switch for that?

I believe -fno-jump-tables will do the trick.  That also reminds me exactly why
CONFIG_RETPOLINE=y isn't broken, jump tables are disabled when retpolines are enabled[*].

[*] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86952

> > One thought would be to initialize "vendor" to a bogus value, disallow calls to
> > cc_set_vendor() until after the kernel as gotten to a safe point, and then WARN
> > (or panic?) if cc_platform_has() is called before "vendor" is explicitly set.
> > New calls can still get in, but they'll be much easier to detect and less likely
> > to escape initial testing.
> 
> The invalid vendor thing makes sense but I don't think it'll help in
> this case.
> 
> We set vendor in sme_enable() which comes before the
> 
> __startup_64 -> sme_postprocess_startup
> 
> path you're hitting.

Right, but that's easily solved, no?  E.g.

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index e8f7953fda83..ed3118f5bf62 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -487,6 +487,8 @@ void __init sme_early_init(void)
        if (!sme_me_mask)
                return;

+       cc_set_vendor(CC_VENDOR_AMD);
+
        early_pmd_flags = __sme_set(early_pmd_flags);

        __supported_pte_mask = __sme_set(__supported_pte_mask);
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index f415498d3175..6b1c60032400 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -611,7 +611,6 @@ void __init sme_enable(struct boot_params *bp)
 out:
        if (sme_me_mask) {
                physical_mask &= ~sme_me_mask;
-               cc_set_vendor(CC_VENDOR_AMD);
                cc_set_mask(sme_me_mask);
        }
 }

And disallow cc_set_vendor() before x86_64_start_kernel(), then fix any fallout.

> We could do only the aspect of checking whether it hasn't been set yet
> and warn then, in order to make the usage more robust...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
