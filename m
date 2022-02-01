Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E84A5ABC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 11:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiBAK5Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 05:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237001AbiBAK5X (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Feb 2022 05:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643713043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvlNVXABWeHw4gpYnmoaoySXybSLgHqyGniZWPgVn1s=;
        b=YG9gJ+7ZAVMj4Dc/zqcInq0S1JwMZGzqj4B3RboEJkVGx0NaCDRePdusaNkmzTIajfVGI/
        TmEZeHNatIcuv8bk3+6IqU0nF/Qa4+Iqn2/VKkhqSF2xr3zDqMlJ4BugxurI16Goi2O8xJ
        JdVby/38wHtvy3/BEECd5TkWsEifOiM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-0C2M-EaZP2eRyjtyJaeEhg-1; Tue, 01 Feb 2022 05:57:22 -0500
X-MC-Unique: 0C2M-EaZP2eRyjtyJaeEhg-1
Received: by mail-ej1-f70.google.com with SMTP id mp5-20020a1709071b0500b0069f2ba47b20so6298915ejc.19
        for <linux-efi@vger.kernel.org>; Tue, 01 Feb 2022 02:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=AvlNVXABWeHw4gpYnmoaoySXybSLgHqyGniZWPgVn1s=;
        b=4V06ePwplDR3KTPi+Y47LyKdK6GKFIs1u/EKQL5ZoJ9Dx06zVuACMxZ6+7+1Fb54GN
         G4R/y+i7dJdosafnDKcnZseUAWVL9EVh6/T+c73XTI23Cpe1m3PzV3DJ20qMdkxUTFUM
         HA7WJKumC8I7mwYFBc5zLPBZ83gRLJ719Pkjqql4IW8LZGy2VHFblqjaLZS3KDI+XuOh
         4YIzJgXqHpGfDFz+wajQ1x5nCqrr2OYFbdWdtgrvcqU1Y1QmcPolTWmB1yT/VbPsXUrI
         HFdY2AyR4NaODmiYARFUYBaHPSlm35yoyikATgjQjJ8H8KyC9x0L4YJR4WJnkEWmPDoj
         K5IA==
X-Gm-Message-State: AOAM5328Att+VaxhNfS8FWwFVtXJwM0EOlOpB6u8SxoKE7TMGv0Gs81M
        nktZUqvONNCzSivJTosNzUAl4WqznthF0/Y8JbXADpjPcqNaXaFbTxSgdXBHXbQo8xM7bHEc8xt
        GmaovlCTdaDgu23mcLqQX
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr24834164eds.81.1643713040797;
        Tue, 01 Feb 2022 02:57:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUrP62z4YI3xIllj+ZnBGCvXCO+D81q7RQ5ccoK4hgtp0NvEFZbCTfVey66a0Izz8vG22M8g==
X-Received: by 2002:aa7:da8c:: with SMTP id q12mr24834131eds.81.1643713040486;
        Tue, 01 Feb 2022 02:57:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c711:ba00:67b6:a3ab:b0a8:9517? (p200300cbc711ba0067b6a3abb0a89517.dip0.t-ipconnect.de. [2003:cb:c711:ba00:67b6:a3ab:b0a8:9517])
        by smtp.gmail.com with ESMTPSA id f18sm14390425ejh.97.2022.02.01.02.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 02:57:19 -0800 (PST)
Message-ID: <9c979e5a-91ae-413d-f2a9-168c9c37e5ab@redhat.com>
Date:   Tue, 1 Feb 2022 11:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        rppt@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, brijesh.singh@amd.com,
        dave.hansen@intel.com, dfaggioli@suse.com, jroedel@suse.de,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rientjes@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        varad.gautam@suse.com, vbabka@suse.cz, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <YfZJQedck2YxZcWA@kernel.org>
 <20220130164548.40417-1-kirill.shutemov@linux.intel.com>
 <acc12d73-a7d1-014c-9c07-33251d7d07ee@redhat.com>
 <20220131193041.xuagyispia77ak2g@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv3.1 1/7] mm: Add support for unaccepted memory
In-Reply-To: <20220131193041.xuagyispia77ak2g@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 31.01.22 20:30, Kirill A. Shutemov wrote:
> On Mon, Jan 31, 2022 at 01:13:49PM +0100, David Hildenbrand wrote:
>> On 30.01.22 17:45, Kirill A. Shutemov wrote:
>>> UEFI Specification version 2.9 introduces the concept of memory
>>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>>> SEV-SNP, requiring memory to be accepted before it can be used by the
>>> guest. Accepting happens via a protocol specific for the Virtual Machine
>>> platform.
>>>
>>> Accepting memory is costly and it makes VMM allocate memory for the
>>> accepted guest physical address range. It's better to postpone memory
>>> acceptance until memory is needed. It lowers boot time and reduces
>>> memory overhead.
>>>
>>> Support of such memory requires a few changes in core-mm code:
>>>
>>>   - memblock has to accept memory on allocation;
>>>
>>>   - page allocator has to accept memory on the first allocation of the
>>>     page;
>>>
>>> Memblock change is trivial.
>>>
>>> The page allocator is modified to accept pages on the first allocation.
>>> PageBuddyUnaccepted() is used to indicate that the page requires acceptance.
>>>
>>> Kernel only need to accept memory once after boot, so during the boot
>>> and warm up phase there will be a lot of memory acceptance. After things
>>> are settled down the only price of the feature if couple of checks for
>>> PageBuddyUnaccepted() in alloc and free paths. The check refers a hot
>>> variable (that also encodes PageBuddy()), so it is cheap and not visible
>>> on profiles.
>>>
>>> Architecture has to provide three helpers if it wants to support
>>> unaccepted memory:
>>>
>>>  - accept_memory() makes a range of physical addresses accepted.
>>>
>>>  - maybe_mark_page_unaccepted() marks a page PageBuddyUnaccepted() if it
>>>    requires acceptance. Used during boot to put pages on free lists.
>>>
>>>  - accept_page() makes a page accepted and clears PageBuddyUnaccepted().
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>>
>>
>> You should somehow document+check+enforce that page poisoning cannot be
>> enabled concurrently, because it cannot possibly work IIUC.
> 
> Looking at code again, I now think that sharing the bit with PageOffline()
> is wrong. Previously I convinced myself that there's no conflict on the
> bit. In the initial version of the patchset, the page acceptance happened
> inside del_page_from_free_list() so any removal from the free list lead to
> clearing the bit. It is not the case now when acceptance moved to
> post_alloc_hook(). __isolate_free_page() and __offline_isolated_pages()
> look problematic now.

Both grab the zone lock. So as long as you'd perform the update of both
bits (PageOffline+PageBuddy) in one go under the zone lock, you could
handle it accordingly. But IIRC we don't want to accept memory while
holding the zone lock ...

Of course, you could clear the flag under the zone lock and forward the
requirement to prep_new_page(). For example, using alloc_flags.

We could have a new ALLOC_UNACCEPTED that will result in
prep_new_page()->post_alloc_hook() calling accept_page().

Relevant functions (e.g., rmqueue()) would consume *alloc_flags instead
of alloc_flags and simply clear+set the bit while updating *alloc_flags.

* __alloc_pages_bulk()->__rmqueue_pcplist() shouldn't need care because
  unaccepted pages shouldn't be on a pcp list (iow, previously
  allocated)
* Not sure if we'd have to touch try_to_compact_pages(), because we can
  only stumble over unnaccepted pages if these pages were never
  allocated, would require some thought.

So maybe it would boil down to rmqueue() only.

> 
> I will use brand new bit for the flag and rename BuddyUnaccepted to just
> Unaccepted, since it can be set with Buddy cleared.
> 
> Sounds okay?

Fine with me, having something restricted to PageBuddy() might be
conceptually nicer, though.

[...]

>>
>> You'll be setting the page as unaccepted even before it's actually
>> PageBuddy(). While that works, I wonder why we call
>> maybe_mark_page_unaccepted() at these points.
>>
>> Why are we not moving that deeper into the buddy? __free_pages_core() is
>> used for any fresh pages that enter the buddy, used outside of
>> page_alloc.c only for memory hot(un)plug, so I'd suggest moving it at
>> least into there.
>>
>> But maybe we'd even move it further down, to the place where we actually
>> establish PageBuddy().
>>
>> One idea would be adding a new FPI_UNACCEPTED flag, passing it from
>> __free_pages_core() only, and calling maybe_mark_page_unaccepted() from
>> __free_one_page() after set_buddy_order().
>>
>> If in-lining would do its job properly, we'd be left with the
>> FPI_UNACCEPTED checks only when called via __free_pages_core(), and we'd
>> have that call at a single place right where we mess with PageBuddy().
> 
> Okay, this approach looks neat. See fixup below.
> 
> But there's down side: maybe_mark_page_unaccepted() cannot be __init
> anymore, since it is called from __free_one_page().

Good point, do we care?

> 
> Any comments?

LGTM

-- 
Thanks,

David / dhildenb

