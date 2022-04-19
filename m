Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642C506617
	for <lists+linux-efi@lfdr.de>; Tue, 19 Apr 2022 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbiDSHnP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Apr 2022 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349532AbiDSHmp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Apr 2022 03:42:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4CBF48;
        Tue, 19 Apr 2022 00:40:02 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E3211EC0535;
        Tue, 19 Apr 2022 09:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650353997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rQXek4tqcEArLSkS/IUTo6V5mstAiO1dFqlCDSGiQXE=;
        b=hB2N9XJz7rFgUpYjr8iew/p5X3tqixuyQXbHsnUa7Ps/tIFU+cYFV9gIQwab/D4QwHZf/H
        8wt/r8C0yCABkfagI8tZ95iuLpwBKqQTAgt1CUoaRbu9O2ZuQTlPgCIT7BKHSVLbgNHjjm
        qi4O8T8hd6Z6VoLibUC771NQsvZrT2w=
Date:   Tue, 19 Apr 2022 09:39:53 +0200
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
Message-ID: <Yl5nSSC4HpSWqfY7@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 19, 2022 at 02:50:15AM +0300, Kirill A. Shutemov wrote:
> I find it strange that you go after <linux/bitmap.h> which has limited
> exposure while <linux/acpi.h> and <linux/efi.h> are there already.

Funny you should mention that:

https://lore.kernel.org/r/YlCKWhMJEMUgJmjF@zn.tnic

I *have* been working towards that but it's a losing whack-a-mole game
when you and others keep adding new stuff.

So no, we won't take a pile of changes and let the maintainer clean it
up afterwards.

> What do you want me to do here?

I think the stuff coming from the linux/ namespace you can simply copy
into a header in compressed/, like I've done with efi.h.

> // <asm/bitops.h>

The asm/ stuff can be put into a shared/ namespace header like the io
stuff you did.

> As 1 bit represents 2M, not all chunks can be represented in the bitmap
> and they have to be accepted. But the *goal* is to record unaccepted
> memory into bitmap. Some accepting is a side effect.
> 
> The early_accept_memory() name is just wrong.

Ok, how about process_unaccepted_memory(). It should be generic enough.

> Okay, I will do as you want, but I really hate it.

I find it really weird that you feel so strongly about it. If I would
have been asked to do it, I would've done it without even considering
it. But ok, since you feel so strongly about it, I've asked what the
other maintainers think.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
