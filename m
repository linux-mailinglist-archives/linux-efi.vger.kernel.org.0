Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49949475841
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 12:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbhLOL5t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 06:57:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242231AbhLOL5s (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 15 Dec 2021 06:57:48 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4F931EC0105;
        Wed, 15 Dec 2021 12:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639569462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ER+WXJjaSLqJ9tsy2K/I4s6XucuqFb6jbaTEpQwLM9Q=;
        b=oVALQHceuC97MU8vwp2RvKFbCv04i7xOl8k4Ca5KpVBA7ycnsCaBZCdYFJ3J8uh1Xjy2a1
        lMd8cgbY4wvmywNzJhcjUTf0J9qZmYqMhJ2Dw6VPF0npeJu9iaU2PyMc4yUcJBByqv7Rhe
        uOrBuqi3PsspW9FkGuBYKAgzSzr1k4g=
Date:   Wed, 15 Dec 2021 12:57:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Venu Busireddy <venu.busireddy@oracle.com>
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
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbnYNg/UXh/JGBBJ@zn.tnic>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbkzaiC31/DzO5Da@dt>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 14, 2021 at 06:14:34PM -0600, Venu Busireddy wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 2c5f12ae7d04..41b096f28d02 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -224,6 +224,43 @@ static inline void native_cpuid(unsigned int *eax, unsigned int *ebx,
>  	    : "memory");
>  }
>  
> +/*
> + * Returns the pagetable bit position in pt_bit_pos,
> + * iff the specified features are supported.
> + */
> +static inline int get_pagetable_bit_pos(unsigned long *pt_bit_pos,
> +					unsigned long features)

You can simply return pt_bit_pos:

static inline unsigned int get_pagetable_bit_pos(unsigned long features)

and return a negative value on error.

Also, the only duplication this is saving is visual - that function will
get inlined at the call sites.

Also, I'd love to separate the compressed kernel headers from the
kernel proper ones but I'm afraid that ship has sailed. But if I could,
that would have to be in a special header that gets included by both
stages...

So I don't mind this but I'd let Brijesh and Tom have a look at it too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
