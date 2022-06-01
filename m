Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3653A00A
	for <lists+linux-efi@lfdr.de>; Wed,  1 Jun 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbiFAJG5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Jun 2022 05:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351093AbiFAJFs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Jun 2022 05:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B488FD4B
        for <linux-efi@vger.kernel.org>; Wed,  1 Jun 2022 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654074346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJrHD/fk/T3aZT3PXrEdxCfOFI/2TTZWKV2+KGqpvvM=;
        b=aNGf2iRmXCzzIGp2B58fd7be9Ft6UN+m4e6D6Ibopcat1uCbWk3Z5SFCd8k1VTHYuhbaOE
        BeUmeedvj9w8hvg+DTT2+5d2GACPjP1wmNszpNPpuvukixkdAc8PY4RyT5mF+kCPyjW+1R
        BL3flYIjH/F5qDsVHSE+l6VFmSQ+X60=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-IjlqKfr9Pju3BThrFJFHaw-1; Wed, 01 Jun 2022 05:05:45 -0400
X-MC-Unique: IjlqKfr9Pju3BThrFJFHaw-1
Received: by mail-wr1-f72.google.com with SMTP id i10-20020a5d55ca000000b002103d76ffcaso151535wrw.17
        for <linux-efi@vger.kernel.org>; Wed, 01 Jun 2022 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=LJrHD/fk/T3aZT3PXrEdxCfOFI/2TTZWKV2+KGqpvvM=;
        b=wjQmylZYVAAPfdnRrsKfNh6BtTKe5jnMsAc9Dnh0nSt/ylTdYGu/VmEuoUC+3a/Ojh
         2oVjdlwX9QY4QJ3HVqMCtrduDhmnV1cZQAF5v9Uirs2jGR8bh9XYpV+XLG7XRCnra38J
         q6ZL07iRsmqQlC6GZFMStbKTeCflE68pzzJIysaLCZGrC24OJbydY3KfPLMpjYim2J8v
         xdVIDNL3MZggcN+pVW4IDof1ya12ADiHbUkyHV5FB0t/k5R6NkPVXbCgsX9Zjgez3sP6
         8Tk7plnCVYKhn4zbgzg8eOVGTVibkSKbPXLmpkK53NE9RY2h1yBkbtb5ObO3sG7DK+HK
         WqRw==
X-Gm-Message-State: AOAM533fgnQgz6GKbxgrxQo6uc1X+Y/EIxLWV1wKuGRvKgGgfgBH1XJ3
        8aO2F9064YX8ipmptVvaElPxbfy+4s4R6km/7PrmuicXhCP0kU9MLsQoAPHeZ+Q+qgZERR3Ym+4
        jdTttuv0d4mWvyRH9ij7h
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr52818602wrr.142.1654074343766;
        Wed, 01 Jun 2022 02:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxI/IEgL1kUl8RIGZMf6kss0Qr5WfcXWB8YjnOXt3Enet6ufD7u1NcX/gWzDd47wFHqRyvYg==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr52818592wrr.142.1654074343514;
        Wed, 01 Jun 2022 02:05:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b00397342e3830sm7173656wms.0.2022.06.01.02.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:05:42 -0700 (PDT)
Message-ID: <76adccb2-2925-e102-db6f-529492d885c7@redhat.com>
Date:   Wed, 1 Jun 2022 11:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv6 15/15] mm/vmstat: Add counter for memory accepting
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
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220517153444.11195-1-kirill.shutemov@linux.intel.com>
 <20220517153444.11195-16-kirill.shutemov@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220517153444.11195-16-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 17.05.22 17:34, Kirill A. Shutemov wrote:
> The counter increased every time kernel accepts a memory region.
> 
> The counter allows to see if memory acceptation is still ongoing and
> contributes to memory allocation latency.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/mm/unaccepted_memory.c | 1 +
>  include/linux/vm_event_item.h   | 3 +++
>  mm/vmstat.c                     | 3 +++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/arch/x86/mm/unaccepted_memory.c b/arch/x86/mm/unaccepted_memory.c
> index 6ecd79101922..fe1dabfae326 100644
> --- a/arch/x86/mm/unaccepted_memory.c
> +++ b/arch/x86/mm/unaccepted_memory.c
> @@ -74,6 +74,7 @@ void accept_memory(phys_addr_t start, phys_addr_t end)
>  		}
>  
>  		bitmap_clear(bitmap, range_start, len);
> +		count_vm_events(ACCEPT_MEMORY, len * PMD_SIZE / PAGE_SIZE);
>  

It's a bit weird that this is accounted from arch code. Also, I'm a bit
confused about the granularity here (PMD_SIZE).

>  		/* In early boot nr_unaccepted is not yet initialized */
>  		if (nr_unaccepted) {
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 16a0a4fd000b..6a468164a2f9 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -136,6 +136,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_X86
>  		DIRECT_MAP_LEVEL2_SPLIT,
>  		DIRECT_MAP_LEVEL3_SPLIT,
> +#endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +		ACCEPT_MEMORY,
>  #endif
>  		NR_VM_EVENT_ITEMS
>  };
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b75b1a64b54c..4c9197f32406 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1397,6 +1397,9 @@ const char * const vmstat_text[] = {
>  	"direct_map_level2_splits",
>  	"direct_map_level3_splits",
>  #endif
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +	"accept_memory",
> +#endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */

How exactly would I be able to figure out if "memory acceptation is
still ongoing" if there is one last remaining page stuck at the tail of
the freelist?

Wouldn't it make more sense to actually count the number of unaccepted
pages in the buddy? Once that number drops to 0, one knows that there is
no unaccepted memory left in the buddy.

-- 
Thanks,

David / dhildenb

