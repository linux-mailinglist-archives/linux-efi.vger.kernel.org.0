Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF184FF5FC
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiDMLqP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 07:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDMLqN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 07:46:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288415BD32
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 04:43:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so1848171ljf.4
        for <linux-efi@vger.kernel.org>; Wed, 13 Apr 2022 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEOvVQ8ODptnK3WwFBWfeYgjoqgGL18PHLUqQQVknZE=;
        b=IbDWQ6exmcYIF5xlYm/WQBVMxiI8gzxIlrURJHj4gun+Tfehojc623NglyuXPeXtem
         s3kj95CbN5IpEZiShOZ3p7KWR6T1IoH8Vve+GD9QG5gDR+5bRDwWfyK3ITy5zWsiBXXA
         OClXS6PkEVcFzkwMiMHnkuffDW2E3/DZN0BKFCw6B5FpphArioxoqdyai/uUZbJshTQY
         UxLKrifaPneqZ6/twcwWr+6+uR4Uw0E+Tmq9sBS9A0B1B5p1Ou835VDKJ3PdD3aX+Jza
         YPiSrtykL2uJOyQxThOQ0kd3qKwpkxfSZFANqbL7zFkBJBPclnW6dbKo1eZuEPcXqeUR
         451Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEOvVQ8ODptnK3WwFBWfeYgjoqgGL18PHLUqQQVknZE=;
        b=1dz2q4/+tOT0D7sNx4g649gULQfuaHABNP828gKOM2jnpGpvsSfLXPCxPi95T+hRy7
         zPHiY3E75in9u4b5uo0wlbVswaWOY8ivxU26wxKbRNvaHWbBI4LJMxPCFU4T9+qCGclv
         y+vG9QcEigVmay/nOax1V7j0HC2Ml63cjuYkTLdqAA0QiEzU+6DgEwAyrjHi+ZfhzyyE
         kOzxhQXceIjzqD7HWm5YvmG4jqF30GxcD7RMr91PBKFmHwNKTLQnb8sEVyFPo9KG+JSI
         0UsMp6qoaTlz/+ccLqk8Q0hX0XeuA7k6OyMu/ZBxvgqlAP+CAMB82PefzNK7re9Zt/V9
         pwwA==
X-Gm-Message-State: AOAM533Cmw0aB9aS45LJCk7ad4vzGYd7OuAoIxVHdN5z117tW321zDyY
        wH13AzoRTvdmDP0dvixjpqTZjA==
X-Google-Smtp-Source: ABdhPJxSc2DiuJ8ztlJC/7du5pH7HUiYvKu1fv1sdTG2x0jctLC+Bp5dpszyE0eMhivO+pDlpFDILQ==
X-Received: by 2002:a05:651c:1781:b0:247:daa7:4358 with SMTP id bn1-20020a05651c178100b00247daa74358mr25671523ljb.477.1649850230444;
        Wed, 13 Apr 2022 04:43:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j4-20020a05651231c400b0044ac20061ecsm4099397lfe.128.2022.04.13.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 04:43:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B7F8010369B; Wed, 13 Apr 2022 14:45:23 +0300 (+03)
Date:   Wed, 13 Apr 2022 14:45:23 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
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
Subject: Re: [PATCHv4 2/8] efi/x86: Get full memory map in allocate_e820()
Message-ID: <20220413114523.5si2ywl7zlgestz5@box.shutemov.name>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-3-kirill.shutemov@linux.intel.com>
 <Ylae+bejPzRMPrDw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylae+bejPzRMPrDw@zn.tnic>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Apr 13, 2022 at 11:59:21AM +0200, Borislav Petkov wrote:
> On Wed, Apr 06, 2022 at 02:43:37AM +0300, Kirill A. Shutemov wrote:
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index 01ddd4502e28..d18cac8ab436 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -569,30 +569,28 @@ static efi_status_t alloc_e820ext(u32 nr_desc, struct setup_data **e820ext,
> >  }
> >  
> >  static efi_status_t allocate_e820(struct boot_params *params,
> > +				  struct efi_boot_memmap *map,
> >  				  struct setup_data **e820ext,
> >  				  u32 *e820ext_size)
> >  {
> > -	unsigned long map_size, desc_size, map_key;
> >  	efi_status_t status;
> > -	__u32 nr_desc, desc_version;
> > +	__u32 nr_desc;
> >  
> > -	/* Only need the size of the mem map and size of each mem descriptor */
> > -	map_size = 0;
> > -	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
> > -			     &desc_size, &desc_version);
> > -	if (status != EFI_BUFFER_TOO_SMALL)
> > -		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
> > -
> > -	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
> > +	status = efi_get_memory_map(map);
> > +	if (status != EFI_SUCCESS)
> > +		return status;
> >  
> > -	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
> > -		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
> > +	nr_desc = *map->map_size / *map->desc_size;
> > +	if (nr_desc > ARRAY_SIZE(params->e820_table) - EFI_MMAP_NR_SLACK_SLOTS) {
> > +		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table) +
> > +			EFI_MMAP_NR_SLACK_SLOTS;
> >  
> >  		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> >  		if (status != EFI_SUCCESS)
> > -			return status;
> > +			goto out;
> 
> This looks weird. With the goto out of the way, this code turns into:
> 
>   		status = alloc_e820ext(nr_e820ext, e820ext, e820ext_size);
> 		if (status != EFI_SUCCESS) {
> 			efi_bs_call(free_pool, *map->map);
> 			return EFI_SUCCESS;
> 		}
> 
> I think you want to return status as above after having called
> 
> 	efi_bs_call(free_pool, *map->map);
> 
> ...

Ah. Right. I actually fix this in the next patch.

Will move it here.

-- 
 Kirill A. Shutemov
