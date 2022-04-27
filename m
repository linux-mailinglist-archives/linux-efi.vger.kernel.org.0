Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE395123DA
	for <lists+linux-efi@lfdr.de>; Wed, 27 Apr 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiD0U3k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 27 Apr 2022 16:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiD0U2i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 27 Apr 2022 16:28:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF82B18A1;
        Wed, 27 Apr 2022 13:25:20 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4EC91EC0494;
        Wed, 27 Apr 2022 22:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651091114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p7e7y4U72pX1k0JV9DJGLjX/ZB6VPKh+920c8wxQ69Y=;
        b=kGPTidYcAhLq7g882RDOr7ocQ1hwsPqncJq5vLderGzSWrvKThdIrUb73tjEv2tu7yTuAv
        kD6mRsioraWGmp45IBix5vUcuK9B9LWtzy8xmaJ/pLTBTFXuFuvhrLK/zEhKnS9xp9B5hV
        tDfvUs8zGpi5TWu4b+Q/fXgbtczXk2E=
Date:   Wed, 27 Apr 2022 22:25:11 +0200
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
Subject: Re: [PATCHv5 03/12] efi/x86: Get full memory map in allocate_e820()
Message-ID: <YmmmpxVDyc3R5K2t@zn.tnic>
References: <20220425033934.68551-1-kirill.shutemov@linux.intel.com>
 <20220425033934.68551-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425033934.68551-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 06:39:25AM +0300, Kirill A. Shutemov wrote:
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

Still silly, that label is useless then. Pasting the whole, simplified
function below.

It looks like it all boils down to propagating the retval up the chain...

static efi_status_t allocate_e820(struct boot_params *params,
                                  struct efi_boot_memmap *map,
                                  struct setup_data **e820ext,
                                  u32 *e820ext_size)
{
        efi_status_t status;
        __u32 nr_desc;

        status = efi_get_memory_map(map);
        if (status != EFI_SUCCESS)
                return status;

        nr_desc = *map->map_size / *map->desc_size;
        if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
                u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) + EFI_MMAP_NR_SLACK_SLOTS;

                status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
        }

        efi_bs_call(free_pool, *map->map);
        return status;
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
