Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D7505F16
	for <lists+linux-efi@lfdr.de>; Mon, 18 Apr 2022 23:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347857AbiDRVEE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 Apr 2022 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiDRVEE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 Apr 2022 17:04:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC929CAD;
        Mon, 18 Apr 2022 14:01:21 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91CC91EC02DD;
        Mon, 18 Apr 2022 23:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650315676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7HCvMEj24aZ0zd1t+d9k0U1kKozNBgur5S9H4AYHe2U=;
        b=PErpnXqqZQtQgL4AVRKd8/NrioNhTgva7ErctEwxIx5vM9xybZb2H6+Gjqp7SkSq8RbEdk
        f4cpHg4/T6DzsWWp9iUSG7nFSqmiwTia4j3db9Y5jzRwakr+LkKPnllCzkhxAddT2F+QkN
        4nErnaZw94C+E3d3rKS/yuXy7UB/I70=
Date:   Mon, 18 Apr 2022 23:01:12 +0200
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
Message-ID: <Yl3RmPhdZieSr8W2@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-4-kirill.shutemov@linux.intel.com>
 <Ylnwmvygp796+qcA@zn.tnic>
 <20220418155545.a567xnxa6elglapl@box.shutemov.name>
 <Yl2UHOQ4iZJ29k0q@zn.tnic>
 <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418202431.whvql4w57c7l5vpw@box.shutemov.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 18, 2022 at 11:24:31PM +0300, Kirill A. Shutemov wrote:
> <linux/bitmap> doesn't include <linux/kernel.h> or similar things.
> Is it okay for now?

No, it is not ok because those linux/ includes are moving targets. They
keep changing and then that indirectly influences the decompressor.

How much functionality from linux/bitmap.h do you actually need?

> But the goal of the function is not to accept the memory, but mark it
> as unaccepted in the bitmap.

Really?

+	 * Accept small regions that might not be able to be represented
+	 * in the bitmap:
+	 */
+	if (end - start < 2 * PMD_SIZE) {
+		__accept_memory(start, end);

That looks like it is accepting to me.

> Conceptionally, it is just memory that requires additional action before
> it can be accessed. Yes, at the moment TDX and SEV are the only users.
> It is implementation detail that TDX and SEV use memory encryption.

So there *might* be some potential future use. Nothing concrete at the
moment.

> Because I don't think it is a good fit. Frankly, even <asm/coco.h> fits
> better, although I'm no a fan either.
> 
> Do we have file shortage? I would rather keep it separate.

So I have not read a single argument for why the unaccepted memory gunk
should be separate.

We have perfectly fine mem_encrypt.[ch] files everywhere which already
contain code which deals with the kernel running as encrypted guest. The
unaccepted memory stuff is part of that - not something separate.

If it gets to get used for something different, sure, then it can be
carved out because it might need to be built separately, without the
rest of the encryption code. But as it is now, it doesn't have to. So
please put it in those files.

> Both allocate_e820() and handling unaccepted memory requires access to the
> efi memory map. We only need the size of memory map for e820, while
> unaccepted memory requires walking the map. We can serve both by
> requesting the map from the firmware once. It requires allocation and
> freeing memory for the map.
> 
> Makes sense?

Ok, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
