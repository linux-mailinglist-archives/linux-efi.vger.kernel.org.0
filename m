Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B541D50B41C
	for <lists+linux-efi@lfdr.de>; Fri, 22 Apr 2022 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446130AbiDVJdT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Apr 2022 05:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446127AbiDVJdQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Apr 2022 05:33:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0C04EF6C;
        Fri, 22 Apr 2022 02:30:20 -0700 (PDT)
Received: from zn.tnic (p200300ea971b581b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:581b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5725E1EC0373;
        Fri, 22 Apr 2022 11:30:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650619815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fr/3xj84Vj/TEZf1cZMkrVY7DcRLFp6TzUknTxfDSpc=;
        b=EBQ+NlmK0S0dUCbjuzPRVhMIe8rt78EeQP9rPUu0CLQVFXjErOhx+pp+GAGMrf9X6yNmvb
        E8Cnw33VbETp64hh3oU1zlBRc2lcXVLoomXUnc1Vp+b/fTiXNhXc7MwTzwwaytoFWbPSrW
        eaMdjGlodeR8SBAKePnQafG0WaFO9M0=
Date:   Fri, 22 Apr 2022 11:30:11 +0200
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
Message-ID: <YmJ1o9UmPIW12Nu7@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
 <Yl3RmPhdZieSr8W2@zn.tnic>
 <20220418235015.mnujtlmmlyin7y6m@box.shutemov.name>
 <Yl5nSSC4HpSWqfY7@zn.tnic>
 <20220422002124.lwd7b56zko24gbll@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220422002124.lwd7b56zko24gbll@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 22, 2022 at 03:21:24AM +0300, Kirill A. Shutemov wrote:
> There's still #include <linux/efi.h> in misc.h. You removed one, but
> there's a second one for some reason.

I don't know which tree you're looking at but latest tip/master has:

$ git grep -E "efi\.h" arch/x86/boot/
arch/x86/boot/compressed/acpi.c:6:#include "efi.h"
arch/x86/boot/compressed/kaslr.c:25:#include "efi.h"
arch/x86/boot/compressed/misc.h:40:#include "efi.h"
arch/x86/boot/compressed/pgtable_64.c:7:#include "efi.h"

> Any plans for <linux/acpi.h>? It includes <linux/bitmap.h>:

So if misc.h is including linux/bitmap.h indirectly, you can simply
include misc.h right?

And then you'll slide under the closing door, as you say below. :)

> I also underesitmated what is required to be copied because of the
> indirect include. The list was only to compile bitmap.c. mem.c (former
> unaccepted_memory.c) would require more.

More like?

Maybe I can help out converting some of the stuff. You could push your
current state somewhere - even if it doesn't build - so that I can take
a look...

> BTW, do we have a white list of linux/ includes that allowed? minmax.h?
> math.h? What is the line.

Well, that's the thing. Even if those look innocuous now, if they get
new includes added to them, that has an influence on the decompressor.

So I'm thinking copying the required bits would be the proper way
forward.

> Maybe allow what is included directly or indirectly now? (Yes, it is my
> poor attempt to slide under closing door.)

That's basically saying, can I get this done so that I can mark my
checkbox that my task is done - you can deal with the crap later
yourself.

How about we take our time and solve this properly instead of hurrying
constantly?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
