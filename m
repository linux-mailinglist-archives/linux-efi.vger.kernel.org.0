Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B76D45CC
	for <lists+linux-efi@lfdr.de>; Mon,  3 Apr 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjDCN2m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 3 Apr 2023 09:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjDCN2k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 3 Apr 2023 09:28:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A080310C8;
        Mon,  3 Apr 2023 06:28:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52D1B1FF8F;
        Mon,  3 Apr 2023 13:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680528517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHqm72f+Z0I2AzfAbhnKdnJNlmuD9/GdE0RimqxF3Bk=;
        b=XkFA+dPaXYBCtXjZnIh4szDFpQyFAbgURFtWJRBp72ylru+ubP+sTKd0QLfYl8oVc+Ixfs
        rNSkSh9+aLOTgj2DaZY3hGjW8HHY0YR7nlDZ2/mRsfW0EDTbJnJQ3Zdnx/UNNDLhzOUctg
        hHAHydkFgXA0q7O3MJB1VHuIQGbrar0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680528517;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHqm72f+Z0I2AzfAbhnKdnJNlmuD9/GdE0RimqxF3Bk=;
        b=asU5R1Qcu5R93vWGXtOCEMuBatUblI6aSIhFT7IZYcZjU9yCRyubBsXf5VUCB/d+SB+pPS
        5x4XX0DH2gRwmIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C19CB1331A;
        Mon,  3 Apr 2023 13:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I7tWLoTUKmTwcAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Apr 2023 13:28:36 +0000
Message-ID: <48567ee3-b482-bafd-bd25-cbb8bf3403b2@suse.cz>
Date:   Mon, 3 Apr 2023 15:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv9 11/14] x86/mm: Avoid load_unaligned_zeropad() stepping
 into unaccepted memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        aarcange@redhat.com, peterx@redhat.com, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230330114956.20342-1-kirill.shutemov@linux.intel.com>
 <20230330114956.20342-12-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230330114956.20342-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 3/30/23 13:49, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> But, this approach does not work for unaccepted memory. For TDX, a load
> from unaccepted memory will not lead to a recoverable exception within
> the guest. The guest will exit to the VMM where the only recourse is to
> terminate the guest.
> 
> There are three parts to fix this issue and comprehensively avoid access
> to unaccepted memory. Together these ensure that an extra "guard" page
> is accepted in addition to the memory that needs to be used.
> 
> 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
>    checks up to end+2M if 'end' is aligned on a 2M boundary. It may
>    require checking 2M chunk beyond end of RAM. The bitmap allocation is
>    modified to accommodate this.
> 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
>    aligned on a 2M boundary.
> 3. Set PageUnaccepted() on both memory that itself needs to be accepted
>    *and* memory where the next page needs to be accepted. Essentially,
>    make PageUnaccepted(page) a marker for whether work needs to be done
>    to make 'page' usable. That work might include accepting pages in
>    addition to 'page' itself.
> 
> Side note: This leads to something strange. Pages which were accepted
> 	   at boot, marked by the firmware as accepted and will never
> 	   _need_ to be accepted might have PageUnaccepted() set on
> 	   them. PageUnaccepted(page) is a cue to ensure that the next
> 	   page is accepted before 'page' can be used.

At least the part about PageUnaccepted() is obsolete in v9, no?

> This is an actual, real-world problem which was discovered during TDX
> testing.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/mm/unaccepted_memory.c         | 39 +++++++++++++++++++++++++
>  drivers/firmware/efi/libstub/x86-stub.c |  7 +++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index 1df918b21469..a0a58486eb74 100644
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
> +	 * "guard" page is accepted in addition to the memory that needs to be
> +	 * used:
> +	 *
> +	 * 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
> +	 *    checks up to end+2M if 'end' is aligned on a 2M boundary.
> +	 *
> +	 * 2. Implicitly extend accept_memory(start, end) to end+2M if 'end' is
> +	 *    aligned on a 2M boundary. (immediately following this comment)
> +	 *
> +	 * 3. Set PageUnaccepted() on both memory that itself needs to be
> +	 *    accepted *and* memory where the next page needs to be accepted.
> +	 *    Essentially, make PageUnaccepted(page) a marker for whether work
> +	 *    needs to be done to make 'page' usable. That work might include
> +	 *    accepting pages in addition to 'page' itself.
> +	 */

And here.

> +	if (!(end % PMD_SIZE))
> +		end += PMD_SIZE;
> +
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
>  	for_each_set_bitrange_from(range_start, range_end, bitmap,
>  				   DIV_ROUND_UP(end, PMD_SIZE)) {
> @@ -46,6 +78,13 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
>  
>  	bitmap = __va(boot_params.unaccepted_memory);
>  
> +	/*
> +	 * Also consider the unaccepted state of the *next* page. See fix #1 in
> +	 * the comment on load_unaligned_zeropad() in accept_memory().
> +	 */
> +	if (!(end % PMD_SIZE))
> +		end += PMD_SIZE;
> +
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
>  	while (start < end) {
>  		if (test_bit(start / PMD_SIZE, bitmap)) {
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 1643ddbde249..1afe7b5b02e1 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -715,6 +715,13 @@ static efi_status_t allocate_unaccepted_bitmap(struct boot_params *params,
>  		return EFI_SUCCESS;
>  	}
>  
> +	/*
> +	 * range_contains_unaccepted_memory() may need to check one 2M chunk
> +	 * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
> +	 * sure that the bitmap is large enough handle it.
> +	 */
> +	max_addr += PMD_SIZE;
> +
>  	/*
>  	 * If unaccepted memory is present, allocate a bitmap to track what
>  	 * memory has to be accepted before access.

