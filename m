Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123C755863E
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jun 2022 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiFWSJw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jun 2022 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiFWSIg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 23 Jun 2022 14:08:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7872BC241;
        Thu, 23 Jun 2022 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656004792; x=1687540792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2yZfCAUS0MYfDCPoO0523LT8rgoWa8z9eTj07PaU7AU=;
  b=fvj2i8HHUPSz29/3GnfE5v8ftSUsieZLIAUfb41hqDI3V5EYHGYjpA4S
   4HtVIxu866sBu4oaIWkgV1dc4tPN0mDrTLqSU/TajVOdynwkjD+Cy3r/N
   LR/J74CGUCYDv5a5FFzur6Ca3hc4dOJoAXTrL06gURnuDiuOP0Jfy2nRK
   sAe5dkVGGZpYKBHYq3BZdbY61I1pPitW08SiETXZdbleZ+YXYWqkhSs2O
   Yl/RI0LTJ+Iq4BIPZwAmCF9Hh+cX3JTuckQmOgrcuN/71E3dyrbgUxLNu
   Vbe9YojRs7BoZnLc1r2epUa2LrwyFir8KZrrHUsaINRW9HDC3AnhrO5M7
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="263818203"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="263818203"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:19:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563530605"
Received: from ckeane-mobl1.amr.corp.intel.com (HELO [10.209.81.98]) ([10.209.81.98])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:19:41 -0700
Message-ID: <a2731ed4-72c1-4838-5049-3002e4bf8db9@intel.com>
Date:   Thu, 23 Jun 2022 10:19:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 10/14] x86/mm: Avoid load_unaligned_zeropad() stepping
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
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        x86@kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120231.48165-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 6/14/22 05:02, Kirill A. Shutemov wrote:
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
> to unaccepted memory. Together these ensure that an extra “guard” page
> is accepted in addition to the memory that needs to be used.
> 
> 1. Implicitly extend the range_contains_unaccepted_memory(start, end)
>    checks up to end+2M if ‘end’ is aligned on a 2M boundary.
> 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
>    aligned on a 2M boundary.
> 3. Set PageUnaccepted() on both memory that itself needs to be accepted
>    *and* memory where the next page needs to be accepted. Essentially,
>    make PageUnaccepted(page) a marker for whether work needs to be done
>    to make ‘page’ usable. That work might include accepting pages in
>    addition to ‘page’ itself.
...

That all looks pretty good.

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
> +	 *
> +	 * 3. Set PageUnaccepted() on both memory that itself needs to be
> +	 *    accepted *and* memory where the next page needs to be accepted.
> +	 *    Essentially, make PageUnaccepted(page) a marker for whether work
> +	 *    needs to be done to make ‘page’ usable. That work might include
> +	 *    accepting pages in addition to ‘page’ itself.
> +	 */

One nit with this: I'd much rather add one sentence to these to help tie
the code implementing it with this comment.  Maybe something like:

 * 2. Implicitly extend accept_memory(start, end) to end+2M if ‘end’ is
 *    aligned on a 2M boundary. (immediately following this comment)


> +	if (!(end % PMD_SIZE))
> +		end += PMD_SIZE;
> +
>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
>  	for_each_set_bitrange_from(range_start, range_end, bitmap,
>  				   DIV_ROUND_UP(end, PMD_SIZE)) {
> @@ -46,6 +78,10 @@ bool range_contains_unaccepted_memory(phys_addr_t start, phys_addr_t end)
>  
>  	bitmap = __va(boot_params.unaccepted_memory);
>  
> +	/* See comment on load_unaligned_zeropad() in accept_memory() */
> +	if (!(end % PMD_SIZE))
> +		end += PMD_SIZE;

It's a wee bit hard to follow this back to the comment that it
references, even with them sitting next to each other in this diff.  How
about adding:

	/*
	 * Also consider the unaccepted state of the *next* page.  See
	 * fix #1 in the comment on load_unaligned_zeropad() in
	 * accept_memory().
	 */

>  	spin_lock_irqsave(&unaccepted_memory_lock, flags);
>  	while (start < end) {
>  		if (test_bit(start / PMD_SIZE, bitmap)) {
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index b91c89100b2d..bc1110509de4 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -709,6 +709,13 @@ static efi_status_t allocate_unaccepted_memory(struct boot_params *params,
>  		return EFI_SUCCESS;
>  	}
>  
> +	/*
> +	 * range_contains_unaccepted_memory() may need to check one 2M chunk
> +	 * beyond the end of RAM to deal with load_unaligned_zeropad(). Make
> +	 * sure that the bitmap is large enough handle it.
> +	 */
> +	max_addr += PMD_SIZE;

I guess the alternative to this would have been to record 'max_addr',
then special case 'max_addr'+2M in the bitmap checks.  I agree this is
probably nicer.

Also, the changelog needs to at least *mention* this little tidbit.  It
was a bit of a surprise when I got here.

With those fixed:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
