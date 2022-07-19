Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F257A966
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiGSVvP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 17:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbiGSVvI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 17:51:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E20B56B83;
        Tue, 19 Jul 2022 14:51:07 -0700 (PDT)
Received: from zn.tnic (p200300ea97297609329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7609:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B7301EC0645;
        Tue, 19 Jul 2022 23:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658267461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RiLRSeSrQbdMG2zQCqhnnPnmcRmrvC4CXHKDD5x+nVw=;
        b=hiCRIz2M+wi07p91BD9LK8bIexysFg9QoRVs5JmpL35MTXXCvCLiMLaulnJEKVj3fURGNF
        rHSHSsauaNe8BSd93KjcwtyB5cY3MkeqYoNU7bNOhpex7K0HvwpSXxDwpY6IzywYQSemv9
        nLaNM9g+XIpBA/eYS4hizIgojlpANOM=
Date:   Tue, 19 Jul 2022 23:50:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Gonda <pgonda@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
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
        Marcelo Cerri <marcelo.cerri@canonical.com>,
        tim.gardner@canonical.com,
        Khalid ElMously <khalid.elmously@canonical.com>,
        philip.cox@canonical.com,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-coco@lists.linux.dev, linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Yao, Jiewen" <jiewen.yao@intel.com>
Subject: Re: [PATCHv7 00/14] mm, x86/cc: Implement support for unaccepted
 memory
Message-ID: <YtcnQbiRgZPtR+rQ@zn.tnic>
References: <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
 <YtcgxxMyFTReuuRw@zn.tnic>
 <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb7479df-7871-9861-600d-c2fed783b659@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 19, 2022 at 02:35:45PM -0700, Dave Hansen wrote:
> They're trying to design something that can (forever) handle guests that
> might not be able to accept memory. 

Wait, what?

If you can't modify those guests to teach them to accept memory, how do
you add TDX or SNP guest support to them?

I.e., you need to modify the guests and then you can add memory
acceptance. Basically, your point below...

> It's based on the idea that *something* needs to assume control and
> EFI doesn't have enough information to assume control.
>
> I wish we didn't need all this complexity, though.
> 
> There are three entities that can influence how much memory is accepted:
> 
> 1. The host
> 2. The guest firmware
> 3. The guest kernel (or bootloader or something after the firmware)
> 
> This whole thread is about how #2 and #3 talk to each other and make
> sure *someone* does it.
> 
> I kinda think we should just take the guest firmware out of the picture.
>  There are only going to be a few versions of the kernel that can boot
> under TDX (or SEV-SNP) and *can't* handle unaccepted memory.  It seems a
> bit silly to design this whole interface for a few versions of the OS
> that TDX folks tell me can't be used anyway.
> 
> I think we should just say if you want to run an OS that doesn't have
> unaccepted memory support, you can either:
> 
> 1. Deal with that at the host level configuration
> 2. Boot some intermediate thing like a bootloader that does acceptance
>    before running the stupid^Wunenlightended OS
> 3. Live with the 4GB of pre-accepted memory you get with no OS work.
> 
> Yeah, this isn't convenient for some hosts.  But, really, this is
> preferable to doing an EFI/OS dance until the end of time.

Ack. Definitely.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
