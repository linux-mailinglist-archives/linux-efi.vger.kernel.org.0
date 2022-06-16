Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1D54E771
	for <lists+linux-efi@lfdr.de>; Thu, 16 Jun 2022 18:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiFPQlN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jun 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiFPQlM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jun 2022 12:41:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871872F656
        for <linux-efi@vger.kernel.org>; Thu, 16 Jun 2022 09:41:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso2325712pjg.1
        for <linux-efi@vger.kernel.org>; Thu, 16 Jun 2022 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MgmvFnUtjCO2ZoSD/nh5tvlUNfC+KyhUyQKzm2xuMbA=;
        b=rlwAFQlOm9itrfoCxgGh2ywywZl2bMeNhE/UA1PRYZB7i/vvH7BJx3aAMyfon2pdrX
         pGUCFTdy6Qt+qWQjwXYPfiIcqN2Zn1lVN7FZmUw4gBTqeBQzHay+jfk5j8v8udJ69z4c
         Ovi2fhLTQyq92Fboa5CW44YjCxausTVRZBemYXcSZxLbvYlej4x2lNJtiFZH0EC43HNm
         6zrK2x9JwIjc/UxsKb4jh0zY64YzOcypofW1QgsGJAYt8YH5SlvJ6ob0WVBnlosQCuB7
         C80yyHM3T2egJ6kEAfcwVphKIOZ24uXk1bcvLPuwLcvQgo3vqgtnZ2759mIzyjU2ethL
         94zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MgmvFnUtjCO2ZoSD/nh5tvlUNfC+KyhUyQKzm2xuMbA=;
        b=Vuk5cOWu6OOEk1eltPko+MTgu8/ZO93vmwkORHKt83BhRuGPUSx34oOj/oKu4CxKKp
         Owf6dMlkS7dX7Zruil5BiuiQlP+0b7YxGK3uxXzJ4Ruh9G0aJolz7SnA3OWSC3tWNCD+
         yMbX4vAmjjiahQoiDYrESmu0zTXxMHSLF/3tEns469AqnuYY+CA8OB6G6epLlNZ287ed
         t7niuPZuESeDcRfty9vz9jfpzJ0CjMSakHhMb5AVJs8tRFYOev/qgSgVLu5kM/v799iN
         3qPbCqlPVzJnqPcmO2TtMFEt3Edye+Aa2GqTnfWVYANtVFZm7FykWxDOUcl4JWu6xxF7
         rGdw==
X-Gm-Message-State: AJIora+NVqeasNAbSORpPwwA/yb/QdeKLINKkS3eEgGr4lbO4Q04K0NO
        9d9RyYEAOxZa+h1yWKQrGSEvbA==
X-Google-Smtp-Source: AGRyM1vlSK6hxncAIYtMkN18fpKkq/QvaVi/pEh5N9nHCclY7o89DXDIz4RXJ2yZPL1ZZAT6zOGVRg==
X-Received: by 2002:a17:903:41ca:b0:169:9b8:36bf with SMTP id u10-20020a17090341ca00b0016909b836bfmr2742734ple.161.1655397669715;
        Thu, 16 Jun 2022 09:41:09 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id j5-20020a17090adc8500b001e34b5ed5a7sm4031001pjv.35.2022.06.16.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:41:09 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:41:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>, x86@kernel.org,
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
        Borislav Petkov <bp@alien8.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 19/46] x86/kernel: Make the .bss..decrypted section
 shared in RMP table
Message-ID: <YqtdIf7OSivLxFL0@google.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-20-brijesh.singh@amd.com>
 <YqfabnTRxFSM+LoX@google.com>
 <YqistMvngNKEJu2o@google.com>
 <daaf7a84-4204-48ca-e40c-7ba296b4789c@amd.com>
 <YqizrTCk460kov/X@google.com>
 <6db51d45-e17a-38dd-131d-e43132c55dfb@amd.com>
 <Yqjm/b3deMlxxePh@google.com>
 <9abe9a71-242d-91d5-444a-b56c8b9b6d90@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9abe9a71-242d-91d5-444a-b56c8b9b6d90@amd.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 16, 2022, Tom Lendacky wrote:
> On 6/14/22 14:52, Sean Christopherson wrote:
> > On Tue, Jun 14, 2022, Tom Lendacky wrote:
> > > On 6/14/22 11:13, Sean Christopherson wrote:
> > > > > > > This breaks SME on Rome and Milan when compiling with clang-13.  I haven't been
> > > > > > > able to figure out exactly what goes wrong.  printk isn't functional at this point,
> > > > > > > and interactive debug during boot on our test systems is beyond me.  I can't even
> > > > > > > verify that the bug is specific to clang because the draconian build system for our
> > > > > > > test systems apparently is stuck pointing at gcc-4.9.
> > > > > > > 
> > > > > > > I suspect the issue is related to relocation and/or encrypting memory, as skipping
> > > > > > > the call to early_snp_set_memory_shared() if SNP isn't active masks the issue.
> > > > > > > I've dug through the assembly and haven't spotted a smoking gun, e.g. no obvious
> > > > > > > use of absolute addresses.
> > > > > > > 
> > > > > > > Forcing a VM through the same path doesn't fail.  I can't test an SEV guest at the
> > > > > > > moment because INIT_EX is also broken.
> > > > > > 
> 
> > 
> > > I'm not sure if there's a way to remove the jump table optimization for
> > > the arch/x86/coco/core.c file when retpolines aren't configured.
> > 
> > And for post-boot I don't think we'd want to disable any such optimizations.
> > 
> > A possibled "fix" would be to do what sme_encrypt_kernel() does and just query
> > sev_status directly.  But even that works, the fragility of the boot code is
> > terrifying :-(  I can't think of any clever solutions though.
> 
> I worry that another use of cc_platform_has() could creep in at some point
> and cause the same issue. Not sure how bad it would be, performance-wise, to
> remove the jump table optimization for arch/x86/coco/core.c.

One thought would be to initialize "vendor" to a bogus value, disallow calls to
cc_set_vendor() until after the kernel as gotten to a safe point, and then WARN
(or panic?) if cc_platform_has() is called before "vendor" is explicitly set.
New calls can still get in, but they'll be much easier to detect and less likely
to escape initial testing.

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index 49b44f881484..803220cd34a6 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -13,7 +13,11 @@
 #include <asm/coco.h>
 #include <asm/processor.h>

-static enum cc_vendor vendor __ro_after_init;
+/*
+ * Initialize the vendor to garbage to detect usage of cc_platform_has() before
+ * the vendor has been set.
+ */
+static enum cc_vendor vendor = CC_NR_VENDORS __ro_after_init;
 static u64 cc_mask __ro_after_init;

 static bool intel_cc_platform_has(enum cc_attr attr)
@@ -90,7 +94,10 @@ bool cc_platform_has(enum cc_attr attr)
                return intel_cc_platform_has(attr);
        case CC_VENDOR_HYPERV:
                return hyperv_cc_platform_has(attr);
+       case CC_VENDOR_NONE:
+               return false;
        default:
+               WARN_ONCE(1, "blah blah blah");
                return false;
        }
 }
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..adfd2fbce7ac 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -9,6 +9,7 @@ enum cc_vendor {
        CC_VENDOR_AMD,
        CC_VENDOR_HYPERV,
        CC_VENDOR_INTEL,
+       CC_NR_VENDORS,
 };

 void cc_set_vendor(enum cc_vendor v);

> I guess we can wait for Boris to get back and chime in.
> 
> > diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> > index bd4a34100ed0..5efab0d8e49d 100644
> > --- a/arch/x86/kernel/head64.c
> > +++ b/arch/x86/kernel/head64.c
> > @@ -127,7 +127,9 @@ static bool __head check_la57_support(unsigned long physaddr)
> >   }
> >   #endif
> > 
> > -static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
> > +static unsigned long __head sme_postprocess_startup(struct boot_params *bp,
> > +						    pmdval_t *pmd,
> > +						    unsigned long physaddr)
> 
> I noticed that you added the physaddr parameter but never use it...

Likely just garbage on my end, I was trying various ideas.
