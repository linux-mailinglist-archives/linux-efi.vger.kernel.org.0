Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1F4B2873
	for <lists+linux-efi@lfdr.de>; Fri, 11 Feb 2022 15:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351092AbiBKOza (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Feb 2022 09:55:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349983AbiBKOz3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Feb 2022 09:55:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721A131;
        Fri, 11 Feb 2022 06:55:28 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DF131EC03E3;
        Fri, 11 Feb 2022 15:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644591322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cDkjTWDqKQNWnc/zCRpQ/YG8Cct/yEFoBc7JQrQMptw=;
        b=JuSz00olsVVdWRlZ0j1y2KYv7/pjY9O+lx/jUcm2MLE2qjB8yQXePonn3SHNbDbdw+b92L
        q8/zE+9levcBrHllOIfG1/b/etAeXOIKwIAZRBCVMm3S1h+8pWO4OEjcSOBWWsX7cIz4NS
        tl3iyhz39QI5sYRgPGS35NyMFJC7+oI=
Date:   Fri, 11 Feb 2022 15:55:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v10 21/45] x86/mm: Add support to validate memory when
 changing C-bit
Message-ID: <YgZ427v95xcdOKSC@zn.tnic>
References: <20220209181039.1262882-1-brijesh.singh@amd.com>
 <20220209181039.1262882-22-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220209181039.1262882-22-brijesh.singh@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

+ Kirill.

On Wed, Feb 09, 2022 at 12:10:15PM -0600, Brijesh Singh wrote:
> @@ -2012,8 +2013,22 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>  	 */
>  	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>  
> +	/*
> +	 * To maintain the security guarantees of SEV-SNP guests, make sure
> +	 * to invalidate the memory before clearing the encryption attribute.
> +	 */
> +	if (!enc)
> +		snp_set_memory_shared(addr, numpages);
> +
>  	ret = __change_page_attr_set_clr(&cpa, 1);
>  
> +	/*
> +	 * Now that memory is mapped encrypted in the page table, validate it
> +	 * so that it is consistent with the above page state.
> +	 */
> +	if (!ret && enc)
> +		snp_set_memory_private(addr, numpages);
> +
>  	/*
>  	 * After changing the encryption attribute, we need to flush TLBs again
>  	 * in case any speculative TLB caching occurred (but no need to flush
> -- 

Right, as tglx rightfully points out here:

https://lore.kernel.org/r/875ypyvz07.ffs@tglx

this piece of code needs careful coordinated design so that it is clean
for both SEV and TDX.

First, as we've said here:

https://lore.kernel.org/r/1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com

we'd need generic functions which turn a pgprot into an encrypted or
decrypted pgprot on both SEV and TDX so we could do:

cc_pgprot_enc()
cc_pgprot_dec()

which does the required conversion on each guest type.

Also, I think adding required functions to x86_platform.guest. is a very
nice way to solve the ugly if (guest_type) querying all over the place.

Also, I was thinking of sme_me_mask and the corresponding
tdx_shared_mask I threw into the mix here:

https://lore.kernel.org/r/YgFIaJ8ijgQQ04Nv@zn.tnic

and we should simply add those without ifdeffery but unconditionally.

Simply have them always present. They will have !0 values on the
respective guest types and 0 otherwise. This should simplify a lot of
code and another unconditionally present u64 won't be the end of the
world.

Any other aspect I'm missing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
