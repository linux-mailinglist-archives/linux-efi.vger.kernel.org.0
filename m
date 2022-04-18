Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B73505C82
	for <lists+linux-efi@lfdr.de>; Mon, 18 Apr 2022 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiDRQlm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Apr 2022 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiDRQlm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Apr 2022 12:41:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACA23206F;
        Mon, 18 Apr 2022 09:39:02 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1188D1EC032C;
        Mon, 18 Apr 2022 18:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650299937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oej/f1X9fcL38mCIYYKYA2X6taoESV0tpCWvTijPE1Y=;
        b=EjQpq8SbHnY7wyfCBF21dDs+DWQkHOJBxTzKXKwdF/fY44dG9E82HlJrL+9S38NL6uTat4
        iRCqom1TwEuFW+cVv6nwZQYGp/VEamF5P1S5lZ/r7PZwoA0N5LRrLhBdYV+lW5fBXiqChC
        MMfAynX1oFVxy0VW0wPKK+rmHxnVRSc=
Date:   Mon, 18 Apr 2022 18:38:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Subject: Re: [PATCHv4 3/8] efi/x86: Implement support for unaccepted memory
Message-ID: <Yl2UHOQ4iZJ29k0q@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418155545.a567xnxa6elglapl@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 18, 2022 at 06:55:45PM +0300, Kirill A. Shutemov wrote:
> I'm confused here. What is wrong with linux/ include namespace?

The problem is that you need all kinds of workarounds so that the
decompressor builds. Just look at the beginning of

arch/x86/boot/compressed/misc.h

Even you had to do them:

/* cpu_feature_enabled() cannot be used this early */
#define USE_EARLY_PGTABLE_L5

That thing sprinkled everywhere is not a clean solution.

> Yes, we had story with <asm/io.h> that actually caused issue in
> decompression code, but linux/ has a lot of perfectly portable
> library-like stuff.

Yes, those are fine except that not everything that leaks into the
decompressor code through includes is perfectly portable.

> Could you explain what rules are?

Library-like stuff like types.h, linkage.h, etc we could include for now
but including linux/kernel.h which pulls in everything but the kitchen
sink is bad.

So I'd like for the decompressor to be completely separate from kernel
proper because it is a whole different thing and I want for us to be
able to include headers in it without ugly workarounds just so that
kernel proper include changes do not influence the decompressor.

> Hm. accept_or_mark_unaccepted()?

What's wrong with early_accept_memory()?

> > Immediately? As opposed to delayed?
> 
> Yes. Otherwise accept is delayed until the first allocation of the memory.

Yes, put that in the comment pls.

> Memory encryption can be a reason to have unaccepted memory, but it is not
> 1:1 match. Unaccepted memory can be present without memory ecnryption if
> data secruty and integrity guaranteed by other means.

Really?

Please elaborate. I thought memory acceptance is a feature solely for
TDX and SNP guests to use.

> <asm/mem_encrypt.h> is very AMD SME/SEV centric.

So?

> I'm not sure it need to exist in the way it is now.

I'm not sure what your argument actually is for having yet another
separate header vs putting it in a header which already deals with that
stuff.

> Okay, I will move it into a separate function, but it has to be called
> from allocate_e820() because it allocates and free the map.

You mean, you want for allocate_e820() to call this new function because
both allocate and free?

Might have to explain what you mean here exactly.

> > And you're saying that that efi_allocate_pages() below can really give a
> > 256M contiguous chunk?
> 
> Yes, that's assumption. Is it too high ask to deal with 4PiB of PA?

From my experience, asking firmware to do stuff for ya is always a risky
thing. I guess such a huge allocation, when it fails, will be caught
early in platform verification so whatever...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
