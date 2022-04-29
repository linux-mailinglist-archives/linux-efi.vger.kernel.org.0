Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A01A5147AB
	for <lists+linux-efi@lfdr.de>; Fri, 29 Apr 2022 12:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357879AbiD2LBr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Apr 2022 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357873AbiD2LBr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Apr 2022 07:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EB34B6443
        for <linux-efi@vger.kernel.org>; Fri, 29 Apr 2022 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651229908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hd8jixMX/+sl7pAeiP0+TvqgeE8m0z/UExwqrgT495g=;
        b=LGQ/rj0W9eUgy1j/+4Adv9vBImgCGHtkCzMlFJMksLbgS3YzEzQhK8bnAW5iyN6J/edDFX
        DaVC3luTup5Ja4h1LXRsHY+0eyuB0pty/mA0bMCQ0ZDfg45y9DMay/nHR/Q08CejKSiVP/
        xpQqr0qjsJ4xb1iYKOBJixkIPw0TX0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-DkyOpML2MXGOm-WSt3_m7A-1; Fri, 29 Apr 2022 06:58:22 -0400
X-MC-Unique: DkyOpML2MXGOm-WSt3_m7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50142811E84;
        Fri, 29 Apr 2022 10:58:21 +0000 (UTC)
Received: from fedora (unknown [10.22.16.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1469C27EAB;
        Fri, 29 Apr 2022 10:58:15 +0000 (UTC)
Date:   Fri, 29 Apr 2022 07:58:14 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [PATCHv5 04/12] x86/boot: Add infrastructure required for
 unaccepted memory support
Message-ID: <YmvExncBpvDdfTjd@fedora>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-5-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-5-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:26AM +0300, Kirill A. Shutemov wrote:

[snip]

>  
> +static __always_inline void __set_bit(long nr, volatile unsigned long *addr)

Can't we update the existing set_bit function?

> +{
> +	asm volatile(__ASM_SIZE(bts) " %1,%0" : : "m" (*(volatile long *) addr),

Why do we need the cast here?

> +		     "Ir" (nr) : "memory");

Shouldn't we add "cc" to the clobber list?

> +}
> +
> +static __always_inline void __clear_bit(long nr, volatile unsigned long *addr)
> +{
> +	asm volatile(__ASM_SIZE(btr) " %1,%0" : : "m" (*(volatile long *) addr),
> +		     "Ir" (nr) : "memory");
> +}

Same comments of __set_bit apply here (except there is no clear_bit function)

[snip]

> +
> +static __always_inline unsigned long swab(const unsigned long y)
> +{
> +#if __BITS_PER_LONG == 64
> +	return __builtin_bswap32(y);
> +#else /* __BITS_PER_LONG == 32 */
> +	return __builtin_bswap64(y);

Suppose y = 0x11223344UL, then, the compiler to cast it to a 64 bits
value yielding 0x0000000011223344ULL, __builtin_bswap64 will then
return 0x4433221100000000, and the return value will be casted back
to 32 bits, so swapb will always return 0, won't it?

> +#endif
> +}
> +
> +unsigned long _find_next_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long nbits,

The addr2 name seems a bit misleading, it seems to act as some kind of mask,
is that right?

> +		unsigned long start, unsigned long invert, unsigned long le)
> +{
> +	unsigned long tmp, mask;
> +
> +	if (unlikely(start >= nbits))
> +		return nbits;
> +
> +	tmp = addr1[start / BITS_PER_LONG];
> +	if (addr2)
> +		tmp &= addr2[start / BITS_PER_LONG];
> +	tmp ^= invert;
> +
> +	/* Handle 1st word. */
> +	mask = BITMAP_FIRST_WORD_MASK(start);
> +	if (le)
> +		mask = swab(mask);
> +
> +	tmp &= mask;
> +
> +	start = round_down(start, BITS_PER_LONG);
> +
> +	while (!tmp) {
> +		start += BITS_PER_LONG;
> +		if (start >= nbits)
> +			return nbits;
> +
> +		tmp = addr1[start / BITS_PER_LONG];
> +		if (addr2)
> +			tmp &= addr2[start / BITS_PER_LONG];
> +		tmp ^= invert;
> +	}

Isn't better to divide start by BITS_PER_LONG in the beginning of the fuction,
and then multiply it by BITS_PER_LONG when necessary, saving the division operations
in the while loop?

[snip]

