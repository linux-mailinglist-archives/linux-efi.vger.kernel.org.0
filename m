Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8968258FB38
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiHKL0v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 07:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiHKL0u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 07:26:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845A11810;
        Thu, 11 Aug 2022 04:26:49 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9854329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9854:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 247F21EC056D;
        Thu, 11 Aug 2022 13:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660217204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UY0huCcMksTkB4oLQLF5MAgiiZEs9HuLdo2XFb9uvQw=;
        b=rmFZk2nFgA8PrMSlwDnyIhuf8Azrn/VmdGgQEjg3g7nzV/uXykxOaiNeOXhEuPPb5Y8Xna
        OomDtJMKKThisqRUyqWX9k0TBb4IO3OpJ68MEGE5BLGOuTXKJt46Pm+o7a6J8CqM8/Q/A5
        rNB4EJb0S/cMZ6BULpUInSoHeE/W8AI=
Date:   Thu, 11 Aug 2022 13:26:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <YvTncOa6KSr8EIuE@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
 <Yt/ANO5usdV+JSSW@zn.tnic>
 <80cc204b-a24f-684f-ec66-1361b69cae39@intel.com>
 <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <073c5a97-272c-c5a0-19f2-c3f14f916c72@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 03, 2022 at 07:02:31AM -0700, Dave Hansen wrote:
> One other thing I remembered as I re-read my write up on this.
> 
> In the "new" mode, guests never get #VE's for unaccepted memory.  They
> just exit to the host and can never be reentered.  They must be killed.

Yeah, this is the part which I think is really silly.

OSes, in their execution lifetime, can - erroneously or not - but it
happens pretty often in real life, touch some unrelated memory. And this
has never been a big deal - #PF, that's it.

But now they don't even get a chance to correct their mistake - VMEXIT,
die.

load_unaligned_zeropad() is just one case.

Imagine the user loads some buggy driver in the guest and that driver
starts doing stray memory accesses through a wild pointer into the
fields. Guest dies immediately.

Dunno bit it all feels a bit too harsh and unfriendly to me.

Sure, if that user is really unlucky, those stray accesses can kill
his OS on baremetal too. So maybe you could argue here that such stray
accesses are actually a good thing. :)

All I know is, there should be a more resilient way to handle those.

> In the "old" mode, I _believe_ that the guest always gets a #VE for
> non-EPT-present memory.  The #VE is basically the same no matter if the
> page is unaccepted or if the host goes out and makes a
> previously-accepted page non-present.
> 
> One really nasty implication of this "old" mode is that the host can
> remove *accepted* pages that are used in the syscall gap.  That means
> that the #VE handler would need to be of the paranoid variety which
> opens up all kinds of other fun.

Yeah, I believe this needs to be dealt with anyway, for SNP at least.
But on AMD it would simply cause an exception and it'll be handled in
the #VC thing. And there's some ugly code to deal with the gap too.

>  * "Old" - #VE's can happen in the syscall gap
>  * "New" - #VE's happen at better-defined times.  Unexpected ones are
>    fatal.
> 
> There's a third option which I proposed but doesn't yet exist.  The TDX
> module _could_ separate the behavior of unaccepted memory #VE's and
> host-induced #VEs.  This way, we could use load_unaligned_zeropad() with
> impunity and handle it in the #VE handler.  At the same time, the host
> would not be allowed to remove accepted memory and cause problems in the
> syscall gap.  Kinda the best of both worlds.

I like that. This should've been the default from the get-go. Oh well,
what's it called in English, hindsight is 20 20...?

> But, I'm not sure how valuable that would be now that we have the
> (admittedly squirrelly) code to avoid load_unaligned_zeropad() #VE's.

I think you should push for the bestest solution and one day we can kill
those ugly workarounds.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
