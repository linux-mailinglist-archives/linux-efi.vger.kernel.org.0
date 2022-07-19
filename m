Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF957A8E6
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jul 2022 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiGSVXl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jul 2022 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiGSVXj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Jul 2022 17:23:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF396170C;
        Tue, 19 Jul 2022 14:23:34 -0700 (PDT)
Received: from zn.tnic (p200300ea97297609329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:7609:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E629F1EC0644;
        Tue, 19 Jul 2022 23:23:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658265808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9enq0fgxD5G4aG3v4Ve8uLcTEh3C8HVLu42xXwSENQs=;
        b=Nepl+HfvfnIeaiJV3nAMnxEVX+rd09745zFNBMV7IvHW/EAVv0blS62razb3b9KTO9qOoA
        S28eL2neJFYrwuoZl4vDQ+2PrCE5Ie0OcYUc+Ru6rBXZFKh1iPj+qp5/MuPLDQJf/1U2Me
        Lr2aHQ7qIx0xQpAbilMYQxlmcvQYAPk=
Date:   Tue, 19 Jul 2022 23:23:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
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
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <YtcgxxMyFTReuuRw@zn.tnic>
References: <CAMkAt6oJJaRM_dy=y2BP99VziPriVuA4jAmMc=G7njwJYKFgyg@mail.gmail.com>
 <CAMj1kXHpS2B9Q7AaQ1euGidZUEyR6gfi=e+t1J_Cr8bmK_9mTw@mail.gmail.com>
 <20220627223808.ihgy3epdx6ofll43@black.fi.intel.com>
 <CAMj1kXEdS9SzFZZ4WGH6sR0WDCOgYDZ3Geg6X2sqSnQ-CXXpZA@mail.gmail.com>
 <20220718172159.4vwjzrfthelovcty@black.fi.intel.com>
 <CAAH4kHYR+VkSJ5J8eWmeaEvstuRz_EuqVQqPfwmp5dhNGRyJwQ@mail.gmail.com>
 <CAAH4kHaHJo4NUb72tHeica4a34hq5u_QP6d6Vuzngf6EqTJ8Aw@mail.gmail.com>
 <CAAH4kHaB2tL+sAn0NAciu5DQeX5hpNkDees=n=f83S=Ph9Y6tw@mail.gmail.com>
 <YtcCWfCQuEsVhH6W@zn.tnic>
 <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEKtcieycyyFMyuLKJK61FgaDwtLieC0N47W1Sa5LaBsA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jul 19, 2022 at 10:45:06PM +0200, Ard Biesheuvel wrote:
> So let's define a way for the EFI stub to signal to the firmware
> (before EBS()) that it will take control of accepting memory. The
> 'bootloader that calls EBS()' case can invent something along the
> lines of what has been proposed in this thread to infer the
> capabilities of the kernel (and decide what to signal to the
> firmware). But we have no need for this additional complexity on
> Linux.

To tell you the truth, I've been perusing this thread from the sidelines
and am wondering why does this need this special dance at all?

If EFI takes control of accepting memory, then when the guest kernel
boots, it'll find all memory accepted and not do anything.

If EFI doesn't accept memory, then the guest kernel will boot and do the
accepting itself.

So either I'm missing something or we're overengineering this for no
good reason...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
