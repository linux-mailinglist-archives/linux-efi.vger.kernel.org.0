Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8414D4AC808
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiBGR6N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 12:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344640AbiBGRwj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 12:52:39 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8CDC0401D9;
        Mon,  7 Feb 2022 09:52:38 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E7441EC01B7;
        Mon,  7 Feb 2022 18:52:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644256353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lj3M3QiQvXsBo94U4HlpV/D8C0ht7/jERvq5KAmCCTE=;
        b=RBq8vE9Qzf2e+zlbZGA9DQP1MUr9EquOtpBPB/LIb0VrV3MWGw859eIXsOAguuxr3oh7RX
        U+x/86JIZYerfBFoHjXGrzDqFJkJjKFYyQNGp9K5+LbWwdAqD0zvAhQGdLHiWxNfs5V7of
        2pBZkpWHSDm+IkFL22w6dVHUxpVgwnk=
Date:   Mon, 7 Feb 2022 18:52:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com
Subject: Re: [PATCH v9 31/43] x86/compressed/64: Add support for SEV-SNP
 CPUID table in #VC handlers
Message-ID: <YgFcXMEvWs9xGTPF@zn.tnic>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-32-brijesh.singh@amd.com>
 <Yf5XScto3mDXnl9u@zn.tnic>
 <20220205162249.4dkttihw6my7iha3@amd.com>
 <Yf/PN8rBy3m5seU9@zn.tnic>
 <20220207153739.p63sa5tcaxtdx2wn@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220207153739.p63sa5tcaxtdx2wn@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 07, 2022 at 09:37:39AM -0600, Michael Roth wrote:
> Absolutely, I know a thorough review is grueling work, and would never
> want to give the impression that I don't appreciate it. Was just hoping
> to revisit these in the context of v9 since there were some concerning
> things in flight WRT the spec handling and I was sort of focused on
> getting ahead of those in case they involved firmware/spec changes. But
> I realize that's resulted in a waste of your time and I should have at
> least provided some indication of where I was with these before your
> review. Won't happen again.

Thanks, that's appreciated.

And in case you're wondering, the kernel is the most flexible thing from
all parties involved so even if you have to change the spec/fw, fixing
the kernel is a lot easier than any of the other things. So make sure
you do a good job with the spec/fw - the kernel will be fine. :-)

> Ok, will work this in for v10. My plan is to introduce this struct:
> 
>   struct cpuid_leaf {
>       u32 fn;
>       u32 subfn;
>       u32 eax;
>       u32 ebx;
>       u32 ecx;
>       u32 edx;
>   }

Ok.

> as part of the patch which introduces sev_cpuid_hv():
> 
>   x86/sev: Move MSR-based VMGEXITs for CPUID to helper
> 
> and then utilize that for the function parameters there, here, and any
> other patches in the SNP code involved with fetching/manipulating cpuid
> values before returning them to the #VC handler.

Sounds good.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
