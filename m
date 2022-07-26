Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED8D5815B9
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiGZOvc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiGZOvc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 10:51:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C3B15802;
        Tue, 26 Jul 2022 07:51:30 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4ff2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4ff2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EC801EC0622;
        Tue, 26 Jul 2022 16:51:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658847084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NGpnmZ5jm4nrbHTpdSQDfmfUGgLHgWESSBLxxIVaizU=;
        b=dHkIi2g4b9g7z5bsQlPX2NowyqkPzJCGlMi4Ufh5hsv5Tfj5YHiwctLroQfN+dGTx85G+h
        Y92PR06Yd9CQXG5YcmHOCRurUVgl9eoGkpiaLVvTWuZzeuhHEeBgIFSgFWv/jh0Uw+Amz0
        0zRyMO9OBx+eb+9HGQ3kDZx/AIN1LPA=
Date:   Tue, 26 Jul 2022 16:51:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 14/14] x86/tdx: Add unaccepted memory support
Message-ID: <Yt//ZMrxtTwtKBqu@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614120231.48165-15-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 03:02:31PM +0300, Kirill A. Shutemov wrote:
> +static bool is_tdx_guest(void)
> +{
> +	static bool once;
> +	static bool is_tdx;
> +
> +	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
> +		return false;
> +
> +	if (!once) {
> +		u32 eax, sig[3];
> +
> +		cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax,
> +			    &sig[0], &sig[2],  &sig[1]);
> +		is_tdx = !memcmp(TDX_IDENT, sig, sizeof(sig));
> +		once = true;
> +	}
> +
> +	return is_tdx;
> +}

early_tdx_detect() already calls this CPUID function. It assigns
function pointers too.

So why can't you assign an accept_memory() function pointer there and
get rid of this sprinkled if (tdx) everywhere?

> diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
> index 918a7606f53c..8518a75e5dd5 100644
> --- a/arch/x86/boot/compressed/tdx.c
> +++ b/arch/x86/boot/compressed/tdx.c
> @@ -3,12 +3,15 @@
>  #include "../cpuflags.h"
>  #include "../string.h"
>  #include "../io.h"
> +#include "align.h"
>  #include "error.h"
> +#include "pgtable_types.h"
>  
>  #include <vdso/limits.h>
>  #include <uapi/asm/vmx.h>
>  
>  #include <asm/shared/tdx.h>
> +#include <asm/page_types.h>
>  
>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  void __tdx_hypercall_failed(void)
> @@ -75,3 +78,78 @@ void early_tdx_detect(void)
>  	pio_ops.f_outb = tdx_outb;
>  	pio_ops.f_outw = tdx_outw;
>  }
> +
> +static unsigned long try_accept_one(phys_addr_t start, unsigned long len,
> +				    enum pg_level level)

That's pretty much a copy of the same function in arch/x86/coco/tdx/tdx.c.

Yeah, you need a tdx-shared.c which you include in both places just like
it is done with sev-shared.c

...

> +void tdx_accept_memory(phys_addr_t start, phys_addr_t end)

That one too.

> +{
> +	/*
> +	 * Notify the VMM about page mapping conversion. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> +	 * section "TDG.VP.VMCALL<MapGPA>"
> +	 */
> +	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +		error("Accepting memory failed\n");
> +
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		unsigned long len = end - start;
> +		unsigned long accept_size;
> +
> +		/*
> +		 * Try larger accepts first. It gives chance to VMM to keep
> +		 * 1G/2M Secure EPT entries where possible and speeds up
> +		 * process by cutting number of hypercalls (if successful).
> +		 */
> +
> +		accept_size = try_accept_one(start, len, PG_LEVEL_1G);
> +		if (!accept_size)
> +			accept_size = try_accept_one(start, len, PG_LEVEL_2M);
> +		if (!accept_size)
> +			accept_size = try_accept_one(start, len, PG_LEVEL_4K);
> +		if (!accept_size)
> +			error("Accepting memory failed\n");
> +		start += accept_size;

This series of calls to try_accept_one() appear in at least three
places. Please carve them out into a separate function can put it in
tdx-shared.c.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
