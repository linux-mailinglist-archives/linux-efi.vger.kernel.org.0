Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B5119BF
	for <lists+linux-efi@lfdr.de>; Wed, 27 Apr 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbiD0OVl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Apr 2022 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiD0OUt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Apr 2022 10:20:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36635E742
        for <linux-efi@vger.kernel.org>; Wed, 27 Apr 2022 07:17:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y19so2834782ljd.4
        for <linux-efi@vger.kernel.org>; Wed, 27 Apr 2022 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x/04ExZsssyHqK3ybhx4YVkpwU+WO3WPNrqX7DTqXG4=;
        b=KcoQA4RUPwVoun+6cZl/pmYQbIgxcoqRYDMq1MFkIwR5zf/Z/nxThQRqsAXpO6fHl8
         KIomzfKhTflfdyS3w9NrdfMQKGTVAnQBz25Pe3HQItAotLqhUfYkS1qxfbzk3sUS9duR
         BFHXvCs1zMAiB27DkIhE0/vCtJMXpOFFAamo/+d1lmWh492Ftkv8Pm986gpCZzvuSn4y
         ERQB0kCCij3s2rkuRuKB+Bc3jQrBnKaKTc5O6mddoYlQo+M5eKoU2+gi1W9epBhTqajZ
         w6bW9WYrXOrScM6YsoZwQGiinAiJsHOebdQqSSZIfkdfg5JzYK5Qmpp4pvfSJhW+zZsP
         iZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x/04ExZsssyHqK3ybhx4YVkpwU+WO3WPNrqX7DTqXG4=;
        b=ksj7hobTKF44wzWZyG8yDyKUI3j0XDe7pItV5TSqEURP/nIZ0BIkj4eeR5IU/2heQI
         BUNQ+ZDqencdfIrIvpR9Mt3lXIE9/6zhEEHkwWebE+PVT25FWDcvfelJmUFLdHvwUEDe
         zOOhic0c9cUt5m8Dae6gYyQuy0p165ehAXuciYSXmjHMsMQQV4uIg4kNIVhXnhpJBbjo
         VGXLTdWlM3iOnzOWPvzhuyNywaaEqG2mxRhOWxlF4CSfnGkwzdUNochALWdHHnIoPuJg
         o7uigfN1/MdY81RCAruBx8lwB3B7OeZeVItZnDBGC56BoY+ASurmoQTr0fsvCUMnHy/l
         kN3A==
X-Gm-Message-State: AOAM530L+v/+2IF0fHsqnLtgacwrOcboh6i2gKnmA/JE6p8J7d2c439v
        ANl5zZg/SLhwmgBrBSFzyLcYtw==
X-Google-Smtp-Source: ABdhPJxVjTj0vQFFkI6C0mpp7oyTSf4B40Jzv5S29tPlaFcLkO/RSz/P1O/faKPD1SWNzxgEvPAecQ==
X-Received: by 2002:a05:651c:887:b0:247:f630:d069 with SMTP id d7-20020a05651c088700b00247f630d069mr18602831ljq.514.1651069053766;
        Wed, 27 Apr 2022 07:17:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t17-20020a192d51000000b0047212cead69sm633986lft.253.2022.04.27.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:17:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4FE48103716; Wed, 27 Apr 2022 17:19:14 +0300 (+03)
Date:   Wed, 27 Apr 2022 17:19:14 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michael Roth <michael.roth@amd.com>, Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 06/12] x86/boot/compressed: Handle unaccepted memory
Message-ID: <20220427141914.s7y7lhlaau473mu7@box.shutemov.name>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-7-kirill.shutemov@linux.intel.com>
 <20220427001756.xefhkwwc7uhxuusk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427001756.xefhkwwc7uhxuusk@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 26, 2022 at 07:17:56PM -0500, Michael Roth wrote:
> On Mon, Apr 25, 2022 at 06:39:28AM +0300, Kirill A. Shutemov wrote:
> > The firmware will pre-accept the memory used to run the stub. But, the
> > stub is responsible for accepting the memory into which it decompresses
> > the main kernel. Accept memory just before decompression starts.
> > 
> > The stub is also responsible for choosing a physical address in which to
> > place the decompressed kernel image. The KASLR mechanism will randomize
> > this physical address. Since the unaccepted memory region is relatively
> > small, KASLR would be quite ineffective if it only used the pre-accepted
> > area (EFI_CONVENTIONAL_MEMORY). Ensure that KASLR randomizes among the
> > entire physical address space by also including EFI_UNACCEPTED_MEMOR
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/boot/compressed/Makefile        |  2 +-
> >  arch/x86/boot/compressed/kaslr.c         | 14 ++++++++++++--
> >  arch/x86/boot/compressed/mem.c           | 21 +++++++++++++++++++++
> >  arch/x86/boot/compressed/misc.c          |  9 +++++++++
> >  arch/x86/include/asm/unaccepted_memory.h |  2 ++
> >  5 files changed, 45 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 7f672f7e2fea..b59007e57cbf 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -102,7 +102,7 @@ endif
> >  
> >  vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
> >  vmlinux-objs-$(CONFIG_INTEL_TDX_GUEST) += $(obj)/tdx.o $(obj)/tdcall.o
> > -vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/mem.o
> > +vmlinux-objs-$(CONFIG_UNACCEPTED_MEMORY) += $(obj)/bitmap.o $(obj)/find.o $(obj)/mem.o
> 
> Since it's possible to have CONFIG_UNACCEPTED_MEMORY=y while
> CONFIG_INTEL_TDX_GUEST=n (e.g. for SNP-only guest kernels), this can
> result in mem.o reporting linker errors due to tdx_accept_memory() not
> being defined. I think it needs a stub for !CONFIG_INTEL_TDX_GUEST, or
> something along that line.

Fair enough. This would do the trick:

diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 539fff27de49..4a49a2438180 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -19,6 +19,9 @@ static bool is_tdx_guest(void)
 	static bool once;
 	static bool is_tdx;

+	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
+	    return false;
+
 	if (!once) {
 		u32 eax, sig[3];

> >  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
> >  efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 411b268bc0a2..59db90626042 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -725,10 +725,20 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
> >  		 * but in practice there's firmware where using that memory leads
> >  		 * to crashes.
> >  		 *
> > -		 * Only EFI_CONVENTIONAL_MEMORY is guaranteed to be free.
> > +		 * Only EFI_CONVENTIONAL_MEMORY and EFI_UNACCEPTED_MEMORY (if
> > +		 * supported) are guaranteed to be free.
> >  		 */
> > -		if (md->type != EFI_CONVENTIONAL_MEMORY)
> > +
> > +		switch (md->type) {
> > +		case EFI_CONVENTIONAL_MEMORY:
> > +			break;
> > +		case EFI_UNACCEPTED_MEMORY:
> 
> Just FYI, but with latest tip boot/compressed now relies on a separate header
> in arch/x86/boot/compressed/efi.h where this need to be defined again.

Right.

Borislav, how do you want to handle this? Do you want me to rebase the
tree to a specific branch?

-- 
 Kirill A. Shutemov
