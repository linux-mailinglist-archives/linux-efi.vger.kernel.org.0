Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9BE519DAD
	for <lists+linux-efi@lfdr.de>; Wed,  4 May 2022 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiEDLPp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 May 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiEDLPo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 May 2022 07:15:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173A140CE;
        Wed,  4 May 2022 04:12:09 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBAD81EC03AD;
        Wed,  4 May 2022 13:12:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651662724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kUk21YBmxyczXtFGcC5AK2mHVk/xapqtm88uS9NvDyY=;
        b=p2B1tkQWwDlCdHp7NKG1T7/gTleL6yeWMd01DSIhaI10qDOd6aaT1LwQDM63Rjx0kSnRQ0
        a5faOD4YbYR6hkbqoDdUzlx9bPjZzpYjqLUECnyB7huVXTuRW2EgvXRJ0U/M+zjSHWgyNY
        9s8Fy4ymLhX99fwnLdC/F7cY2Y9CtMU=
Date:   Wed, 4 May 2022 13:12:06 +0200
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 08/12] x86/mm: Provide helpers for unaccepted memory
Message-ID: <YnJfhiiHn+48H2vb@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-9-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:30AM +0300, Kirill A. Shutemov wrote:
> +/* Protects unaccepted memory bitmap */
> +static DEFINE_SPINLOCK(unaccepted_memory_lock);
> +
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long *unaccepted_memory;

shorten that name.

> +	unsigned long flags;
> +	unsigned long range_start, range_end;

The tip-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +
> +	if (!boot_params.unaccepted_memory)
> +		return;
> +
> +	unaccepted_memory = __va(boot_params.unaccepted_memory);
> +	range_start = start / PMD_SIZE;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for_each_set_bitrange_from(range_start, range_end, unaccepted_memory,
> +				   DIV_ROUND_UP(end, PMD_SIZE)) {
> +		unsigned long len = range_end - range_start;
> +
> +		/* Platform-specific memory-acceptance call goes here */
> +		panic("Cannot accept memory");

Yeah, no, WARN_ON_ONCE() pls.

> +		bitmap_clear(unaccepted_memory, range_start, len);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}
> +
> +bool memory_is_unaccepted(phys_addr_t start, phys_addr_t end)
> +{
> +	unsigned long *unaccepted_memory = __va(boot_params.unaccepted_memory);

As above, shorten that one.

> +	unsigned long flags;
> +	bool ret = false;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	while (start < end) {
> +		if (test_bit(start / PMD_SIZE, unaccepted_memory)) {
> +			ret = true;

Wait, what?

That thing is lying: it'll return true for *some* PMD which is accepted
but not the whole range of [start, end].

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
