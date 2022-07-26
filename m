Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E88581854
	for <lists+linux-efi@lfdr.de>; Tue, 26 Jul 2022 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiGZRZV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Jul 2022 13:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZRZU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Jul 2022 13:25:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6697B642C;
        Tue, 26 Jul 2022 10:25:19 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4ff2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4ff2:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E2BA1EC0373;
        Tue, 26 Jul 2022 19:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658856313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zc808cWbuiJ1LaEmAlRr5AvsxdqrezqcJtLhbo5Uy7g=;
        b=ql/OkaR/2POULdFAydeXv9SQYYLAW2Oguhc/zysyKU429tW8xTTiXOcCVj73rfKKSdqrp9
        S2n5W66hmjC11W1t+j5O+pllUu0utmqWbzKTSg7rCsEUxTCKefdk+G0CusKKEjYT9YMGhP
        1I2mP9ZoAv/WhylmeLh+Gcmv8J0BS9Q=
Date:   Tue, 26 Jul 2022 19:25:09 +0200
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
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Message-ID: <YuAjdYESLDIYFj8x@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 14, 2022 at 03:02:27PM +0300, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index 1df918b21469..bcd56fe82b9e 100644
> --- a/arch/x86/mm/unaccepted_memory.c
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -23,6 +23,38 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  	bitmap = __va(boot_params.unaccepted_memory);
>  	range_start = start / PMD_SIZE;
>  
> +	/*
> +	 * load_unaligned_zeropad() can lead to unwanted loads across page
> +	 * boundaries. The unwanted loads are typically harmless. But, they
> +	 * might be made to totally unrelated or even unmapped memory.
> +	 * load_unaligned_zeropad() relies on exception fixup (#PF, #GP and now
> +	 * #VE) to recover from these unwanted loads.
> +	 *
> +	 * But, this approach does not work for unaccepted memory. For TDX, a
> +	 * load from unaccepted memory will not lead to a recoverable exception
> +	 * within the guest. The guest will exit to the VMM where the only
> +	 * recourse is to terminate the guest.
> +	 *
> +	 * There are three parts to fix this issue and comprehensively avoid
> +	 * access to unaccepted memory. Together these ensure that an extra
> +	 * “guard” page is accepted in addition to the memory that needs to be
> +	 * used:
> +	 *
> +	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> +	 *    checks up to end+2M if ‘end’ is aligned on a 2M boundary.
> +	 *
> +	 * 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
> +	 *    aligned on a 2M boundary.

Why do we need those unicode quotes and backticks in there?

verify_diff: Warning: Unicode char [“] (0x8220 in line: +	 * “guard” page is accepted in addition to the memory that needs to be
verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    checks up to end+2M if ‘end’ is aligned on a 2M boundary.
verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 * 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    needs to be done to make ‘page’ usable. That work might include
verify_diff: Warning: Unicode char [‘] (0x8216 in line: +	 *    accepting pages in addition to ‘page’ itself.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
