Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC414FAAD4
	for <lists+linux-efi@lfdr.de>; Sat,  9 Apr 2022 22:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiDIUn4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 9 Apr 2022 16:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiDIUn4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 9 Apr 2022 16:43:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4456434
        for <linux-efi@vger.kernel.org>; Sat,  9 Apr 2022 13:41:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bq30so7621027lfb.3
        for <linux-efi@vger.kernel.org>; Sat, 09 Apr 2022 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BMIBppXLbzT5rl5nFL/hepo4NioK75rx70EFlK3wfVg=;
        b=lepNhCrBGbo6Pi4UwZtZjxnNpNKam79xcZ2yE+nshnF/7pOQtNz9cBGiFOCq8+iZ/R
         KyZem4RegVD60Jb0ugfQemqeSmesE9JDsGMIZyvTi1j61gwQC5Jl54+oPpv1qEr5nHz1
         7pbES4ljfdOKsj90GujVIm4sYuJ/wmXEmGBdLv63FYxObZn8XoAfiGZLMbYDwddbpfjF
         6E5mheUXex+HyhhDtq6MxEkTneL7i36JnCpqYAYjJwFb6KqLn+nTxFwqRY+kirGxhOFv
         xiCU9rWeYkH1OyQKscsMhac7t+82pKYSu9J6azjMg27rshE87VvuFnpRR4V9VjazQvmo
         GNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BMIBppXLbzT5rl5nFL/hepo4NioK75rx70EFlK3wfVg=;
        b=VYNWjxT7v++ZzEDdtKX+oG6LtTWVcaHl9sdP2cftWa5IOVURBSk25SaCtISTfrpWWN
         X+8UEsrfbQoIOH7WxrSnavcZhPf1Kxg0k/cDEYf1xpepDCAs+IGWIA+OceVvs0O+8VNe
         zazurTE4aXueybe9AmbnxYzpdCbLo8X5bNj332uhSkoCpELmUU62IO98Rkd6SH4kg5wp
         oOhz7xPBCwV5SpmOU/DKlFswS07piv3E3ZvZcBGH+Q8t7vAAY+8JS6w3nMZyCJyXba2D
         YlCqIjbPbl+P8jjZr0FQFDrOCl5tykUNP5mCb4CJBH0GdVVmnuZzJOpg0iANbb+PQAzF
         0aYw==
X-Gm-Message-State: AOAM530rLqvehkoP0BgGs4Wus5S5UVcyDHZHc5HWtSlEBxhcw54Gpvds
        I6Y8ipJtj3eVDxKc3zGuFQ8Yrg==
X-Google-Smtp-Source: ABdhPJyuPYXGvF6wigXiMfnDCnvVB1xi6mYWsajnzN2iZF06d9C3dwPBU4jPaliEjax/9NqHH4gBnQ==
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id y19-20020a0565123f1300b00464f55f7806mr9339683lfa.598.1649536905956;
        Sat, 09 Apr 2022 13:41:45 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s12-20020a19770c000000b0046b87800f71sm517340lfc.49.2022.04.09.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 13:41:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B09B71039DB; Sat,  9 Apr 2022 23:43:16 +0300 (+03)
Date:   Sat, 9 Apr 2022 23:43:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCHv4 5/8] x86/mm: Reserve unaccepted memory bitmap
Message-ID: <20220409204316.bv5qmuqtstml6knx@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-6-kirill.shutemov@linux.intel.com>
 <1ac804b3-eaaf-e87d-2fb5-30125c81ae28@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac804b3-eaaf-e87d-2fb5-30125c81ae28@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 08, 2022 at 11:08:48AM -0700, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
> > A given page of memory can only be accepted once.  The kernel has a need
> > to accept memory both in the early decompression stage and during normal
> > runtime.
> > 
> > A bitmap used to communicate the acceptance state of each page between the
> > decompression stage and normal runtime.  This eliminates the possibility of
> > attempting to double-accept a page.
> 
> ... which is fatal, right?  Could you include that an also the rationale
> for why it is fatal?

Actually, no. For TDX, TDX_ACCEPT_PAGE would just return an error. It is
not fatal, but it indicates that there is security hole. VMM can clear the
range of the memory if it can trick the guest to re-accept the memory
blindly:

1. VMM removes the memory range from the guest. VMM can do it at any
   point.
2. VMM re-adds memory for the same range of the guest physical addresses.
3. VMM tricks guest into re-accepting this memory blindly. It makes the
   range of guest physical memory filled with 0.
4. ???
5. PROFIT!

TDX relies on guest to be careful with accepting memory and only do this
for memory that is not in use. 

This patchet is designed to keep unaccepted
memory accounted and prevent such double accpept.


> > The bitmap is allocated in EFI stub, decompression stage updates the state
> > of pages used for the kernel and initrd and hands the bitmap over to the
> > main kernel image via boot_params.
> 
> This is really good info.  Could we maybe expand it a bit?
> 
> There are several steps in the bitmap's lifecycle:
> 1. Bitmap is allocated in the EFI stub

Allocated and populated.

> 2. The kernel decompression code locates it, accepts some pages before
>    decompression and marks them in the bitmap.
> 3. Decompression code points to the bitmap via a boot_param

Actually EFI stub makes boot_param point to the bitmap. Decompression code
and main kernel consume it from there.

> 4. Main kernel locates bitmap via the boot_param and uses it to guide
>    runtime acceptance decisions.
> 
> > In the runtime kernel, reserve the bitmap's memory to ensure nothing
> > overwrites it.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/x86/kernel/e820.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> > index f267205f2d5a..22d1fe48dcba 100644
> > --- a/arch/x86/kernel/e820.c
> > +++ b/arch/x86/kernel/e820.c
> > @@ -1316,6 +1316,16 @@ void __init e820__memblock_setup(void)
> >  	int i;
> >  	u64 end;
> >  
> > +	/* Mark unaccepted memory bitmap reserved */
> > +	if (boot_params.unaccepted_memory) {
> > +		unsigned long size;
> > +
> > +		/* One bit per 2MB */
> > +		size = DIV_ROUND_UP(e820__end_of_ram_pfn() * PAGE_SIZE,
> > +				    PMD_SIZE * BITS_PER_BYTE);
> > +		memblock_reserve(boot_params.unaccepted_memory, size);
> > +	}
> 
> One oddity here: The size is implied by the e820's contents.  Did you
> mention somewhere that unaccepted memory is considered E820_TYPE_RAM?
> It *has* to be in order for e820__end_of_ram_pfn() to work, right?

"e820_type = E820_TYPE_RAM;" for "case EFI_UNACCEPTED_MEMORY:" in patch
3/8 does this.

I didn't wrote down it explitictly. I will.

-- 
 Kirill A. Shutemov
