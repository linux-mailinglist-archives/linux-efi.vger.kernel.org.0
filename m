Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5472722BB8
	for <lists+linux-efi@lfdr.de>; Mon,  5 Jun 2023 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFEPpx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Jun 2023 11:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjFEPpF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Jun 2023 11:45:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E1E58;
        Mon,  5 Jun 2023 08:44:46 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9FE381EC0103;
        Mon,  5 Jun 2023 17:43:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685979818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VXFJI2jhPS1vK8LdTu13gIhdU4o5Lt+D6h7V+L8AsL4=;
        b=h+bi6/zJ861dFjCf7S6mRtP53hEuyO0LnJGFpZ+YBPzyhlfvMXubo48LQk+Y8D61euoz/r
        6Z5Dwd/akE0e4JsvnLKg5+a0/5Z4DSASRlaKYCbC6T1JXst5xQp1moZpIyJ9siuiVuB4kX
        DYLnhefxCYqtjojEIfVuROirktuBt1c=
Date:   Mon, 5 Jun 2023 17:43:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Dario Faggioli <dfaggioli@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv13 5/9] efi: Add unaccepted memory support
Message-ID: <20230605154333.GLZH4CpV3eXCCWCGxi@fat_crate.local>
References: <20230601182543.19036-1-kirill.shutemov@linux.intel.com>
 <20230601182543.19036-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601182543.19036-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 01, 2023 at 09:25:39PM +0300, Kirill A. Shutemov wrote:
> +void accept_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	struct efi_unaccepted_memory *unaccepted;
> +	unsigned long range_start, range_end;
> +	unsigned long flags;
> +	u64 unit_size;
> +
> +	if (efi.unaccepted == EFI_INVALID_TABLE_ADDR)
> +		return;

efi_get_unaccepted_table() already does this test.

> +	unaccepted = efi_get_unaccepted_table();
> +	if (!unaccepted)
> +		return;

So this looks weird: callers can call accept_memory() and that function
can fail. But they can't know whether it failed or not because it
returns void.

> +	unit_size = unaccepted->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted->phys_base)
> +		start = unaccepted->phys_base;

So this silently trims start...

> +	if (end < unaccepted->phys_base)
> +		return;

But fails only when end is outside of range.

I'd warn here at least. And return an error so that the callers know.

> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted->phys_base;
> +	end -= unaccepted->phys_base;
> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted->size * unit_size * BITS_PER_BYTE;

How is all that trimming not important to the caller?

It would assume that its memory got accepted but not really.

> +	range_start = start / unit_size;
> +
> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	for_each_set_bitrange_from(range_start, range_end, unaccepted->bitmap,
> +				   DIV_ROUND_UP(end, unit_size)) {
> +		unsigned long phys_start, phys_end;
> +		unsigned long len = range_end - range_start;
> +
> +		phys_start = range_start * unit_size + unaccepted->phys_base;
> +		phys_end = range_end * unit_size + unaccepted->phys_base;
> +
> +		arch_accept_memory(phys_start, phys_end);
> +		bitmap_clear(unaccepted->bitmap, range_start, len);
> +	}
> +	spin_unlock_irqrestore(&unaccepted_memory_lock, flags);
> +}
> +
> +bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
> +{
> +	struct efi_unaccepted_memory *unaccepted;
> +	unsigned long flags;
> +	bool ret = false;
> +	u64 unit_size;
> +
> +	unaccepted = efi_get_unaccepted_table();
> +	if (!unaccepted)
> +		return false;
> +
> +	unit_size = unaccepted->unit_size;
> +
> +	/*
> +	 * Only care for the part of the range that is represented
> +	 * in the bitmap.
> +	 */
> +	if (start < unaccepted->phys_base)
> +		start = unaccepted->phys_base;

Same comment as above. Trimming start is fine?

> +	if (end < unaccepted->phys_base)
> +		return false;
> +
> +	/* Translate to offsets from the beginning of the bitmap */
> +	start -= unaccepted->phys_base;
> +	end -= unaccepted->phys_base;

Ditto as above.

> +
> +	/* Make sure not to overrun the bitmap */
> +	if (end > unaccepted->size * unit_size * BITS_PER_BYTE)
> +		end = unaccepted->size * unit_size * BITS_PER_BYTE;

Ditto.

> +	spin_lock_irqsave(&unaccepted_memory_lock, flags);
> +	while (start < end) {
> +		if (test_bit(start / unit_size, unaccepted->bitmap)) {
> +			ret = true;
> +			break;

I have a faint memory we've had this before but you need to check
*every* bit in the unaccepted bitmap before returning true. Doh.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
