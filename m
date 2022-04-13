Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEF4FF450
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiDMKB5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 06:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiDMKBw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 06:01:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFBB25E1;
        Wed, 13 Apr 2022 02:59:26 -0700 (PDT)
Received: from zn.tnic (p200300ea971b584e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:584e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A3651EC0541;
        Wed, 13 Apr 2022 11:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649843961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Dzm9Q8xBuRXK4mGHHOX6fanOLpLEt+HqmgdG3ufabDI=;
        b=kH4m8hby7lSr/nMjW8zktpQlA5REnvZ5SauP0KqRlKsBQmvZycCStBD+i0x1w0MNO3FcVE
        heBC7WWUJoYOLsqKKZ9EHpGKiA/+a8NcKpj76cq7Rh59uWDhIM+8QBrghXme/2ZhybIA/O
        8j+GVlgmmD0cxpv7CmiaWxrlWyNuLic=
Date:   Wed, 13 Apr 2022 11:59:21 +0200
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
Subject: Re: [PATCHv4 2/8] efi/x86: Get full memory map in allocate_e820()
Message-ID: <Ylae+bejPzRMPrDw@zn.tnic>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220405234343.74045-3-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 06, 2022 at 02:43:37AM +0300, Kirill A. Shutemov wrote:
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 01ddd4502e28..d18cac8ab436 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -569,30 +569,28 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
>  }
>  
>  static efi_status_t allocate_e820(struct boot_params *params,
> +				  struct efi_boot_memmap *map,
>  				  struct setup_data **e820ext,
>  				  u32 *e820ext_size)
>  {
> -	unsigned long map_size, desc_size, map_key;
>  	efi_status_t status;
> -	__u32 nr_desc, desc_version;
> +	__u32 nr_desc;
>  
> -	/* Only need the size of the mem map and size of each mem descriptor */
> -	map_size = 0;
> -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> -			     &desc_size, &desc_version);
> -	if (status != EFI_BUFFER_TOO_SMALL)
> -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> -
> -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> +	status = efi_get_memory_map(map);
> +	if (status != EFI_SUCCESS)
> +		return status;
>  
> -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> +	nr_desc = *map->map_size / *map->desc_size;
> +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> +			EFI_MMAP_NR_SLACK_SLOTS;
>  
>  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
>  		if (status != EFI_SUCCESS)
> -			return status;
> +			goto out;

This looks weird. With the goto out of the way, this code turns into:

  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
		if (status != EFI_SUCCESS) {
			efi_bs_call(free_pool, *map->map);
			return EFI_SUCCESS;
		}

I think you want to return status as above after having called

	efi_bs_call(free_pool, *map->map);

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
