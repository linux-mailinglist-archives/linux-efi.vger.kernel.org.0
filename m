Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CF58AC57
	for <lists+linux-efi@lfdr.de>; Fri,  5 Aug 2022 16:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbiHEOWx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Aug 2022 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbiHEOWw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Aug 2022 10:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE1105A8A4
        for <linux-efi@vger.kernel.org>; Fri,  5 Aug 2022 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659709370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nKJNisKgyypX3Bk0DMUA5psdWAWJAJ4t4udQLs3H4mQ=;
        b=QsYf31/181Y+eI81utNUBXScd7zsxu2RU1iCW4kJn8+maKT1OBxlyoJIY/7ijrRyE+sCWN
        p+/PvKGTwNonWhO55M1o//UF1gUhZ1EfF4tPFKi2LpwpOYX6pcIbn6rDZLgP9WRAhvP5OO
        0RuvEK2nB0ohsPP20epLZFiux9giAWg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-Np9gkl9bNW-TqeqRFcsEXQ-1; Fri, 05 Aug 2022 10:22:49 -0400
X-MC-Unique: Np9gkl9bNW-TqeqRFcsEXQ-1
Received: by mail-wr1-f72.google.com with SMTP id t13-20020adfe10d000000b0021bae3def1eso535606wrz.3
        for <linux-efi@vger.kernel.org>; Fri, 05 Aug 2022 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=nKJNisKgyypX3Bk0DMUA5psdWAWJAJ4t4udQLs3H4mQ=;
        b=EB1CLaAuPlpaBtsbl17fmqkXim4FxmJKFNXnj+B0ySlc6uwypF83S1Fh8ZlWyTCfaP
         qlgRN3xmc4bzlXWiGGSYRga4cj4fx9YodjT5/Gv80boVVsZJfMTKm2Fhxwcjg/8O1qbg
         IhubTpxzeI2OX0Dq7hPFjXi3mxA0xH9WtWQRcHBNMOZ3tQIuWWYQ8OzkrrhGBgIUJoFG
         wPAlw6J+QGqed1uU4P3dTnqLHjlvLosaTNrCfA9fJh3d4K9vOoCGioH+249QuzTJ8CaU
         CWHJmYahpDgRfE607Mg8IqUCEFJnPhGHHQEdxZy2Mkr5CpY/1J98o+hkgAvVfmnOluCx
         8cTw==
X-Gm-Message-State: ACgBeo1oH1lb90FMvIx9H3J9DYiufw5cT9t0mOOTFKSrHa0eA+Hpxynb
        pUkxvLe+pxlcwXFMPaNgUEf10rXJxWmgjP3cG4OGP6PH1g6D0gZazF5mBzbSAS4ricNxSEfhtE+
        dgSsk4RNH1cWiv3qKt2nv
X-Received: by 2002:a05:6000:1684:b0:220:6e60:768d with SMTP id y4-20020a056000168400b002206e60768dmr4252352wrd.121.1659709367580;
        Fri, 05 Aug 2022 07:22:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6CYXT+ni9gsbRr8mZUNjpQ2tsstwjGkxFUtVPtwZkG8v0kEXmlA6Rh4FAkaG7a+zr3bUpxBw==
X-Received: by 2002:a05:6000:1684:b0:220:6e60:768d with SMTP id y4-20020a056000168400b002206e60768dmr4252330wrd.121.1659709367252;
        Fri, 05 Aug 2022 07:22:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b003a2c67aa6c0sm5760334wms.23.2022.08.05.07.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 07:22:46 -0700 (PDT)
Message-ID: <e828b48f-dcd8-6404-fc30-6e1dd682252f@redhat.com>
Date:   Fri, 5 Aug 2022 16:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv7 02/14] mm: Add support for unaccepted memory
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Mike Rapoport <rppt@kernel.org>, marcelo.cerri@canonical.com,
        tim.gardner@canonical.com, khalid.elmously@canonical.com,
        philip.cox@canonical.com, x86@kernel.org, linux-mm@kvack.org,
        linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-3-kirill.shutemov@linux.intel.com>
 <8cf143e7-2b62-1a1e-de84-e3dcc6c027a4@suse.cz>
 <cb9d3310-3bc0-8ecf-5e71-becce980235f@redhat.com>
 <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f936b024-43e1-5390-e33f-ad7d355a2802@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 05.08.22 15:38, Vlastimil Babka wrote:
> On 8/5/22 14:09, David Hildenbrand wrote:
>> On 05.08.22 13:49, Vlastimil Babka wrote:
>>> On 6/14/22 14:02, Kirill A. Shutemov wrote:
>>>> UEFI Specification version 2.9 introduces the concept of memory
>>>> acceptance. Some Virtual Machine platforms, such as Intel TDX or AMD
>>>> SEV-SNP, require memory to be accepted before it can be used by the
>>>> guest. Accepting happens via a protocol specific to the Virtual Machine
>>>> platform.
>>>>
>>>> There are several ways kernel can deal with unaccepted memory:
>>>>
>>>>  1. Accept all the memory during the boot. It is easy to implement and
>>>>     it doesn't have runtime cost once the system is booted. The downside
>>>>     is very long boot time.
>>>>
>>>>     Accept can be parallelized to multiple CPUs to keep it manageable
>>>>     (i.e. via DEFERRED_STRUCT_PAGE_INIT), but it tends to saturate
>>>>     memory bandwidth and does not scale beyond the point.
>>>>
>>>>  2. Accept a block of memory on the first use. It requires more
>>>>     infrastructure and changes in page allocator to make it work, but
>>>>     it provides good boot time.
>>>>
>>>>     On-demand memory accept means latency spikes every time kernel steps
>>>>     onto a new memory block. The spikes will go away once workload data
>>>>     set size gets stabilized or all memory gets accepted.
>>>>
>>>>  3. Accept all memory in background. Introduce a thread (or multiple)
>>>>     that gets memory accepted proactively. It will minimize time the
>>>>     system experience latency spikes on memory allocation while keeping
>>>>     low boot time.
>>>>
>>>>     This approach cannot function on its own. It is an extension of #2:
>>>>     background memory acceptance requires functional scheduler, but the
>>>>     page allocator may need to tap into unaccepted memory before that.
>>>>
>>>>     The downside of the approach is that these threads also steal CPU
>>>>     cycles and memory bandwidth from the user's workload and may hurt
>>>>     user experience.
>>>>
>>>> Implement #2 for now. It is a reasonable default. Some workloads may
>>>> want to use #1 or #3 and they can be implemented later based on user's
>>>> demands.
>>>>
>>>> Support of unaccepted memory requires a few changes in core-mm code:
>>>>
>>>>   - memblock has to accept memory on allocation;
>>>>
>>>>   - page allocator has to accept memory on the first allocation of the
>>>>     page;
>>>>
>>>> Memblock change is trivial.
>>>>
>>>> The page allocator is modified to accept pages on the first allocation.
>>>> The new page type (encoded in the _mapcount) -- PageUnaccepted() -- is
>>>> used to indicate that the page requires acceptance.
>>>>
>>>> Architecture has to provide two helpers if it wants to support
>>>> unaccepted memory:
>>>>
>>>>  - accept_memory() makes a range of physical addresses accepted.
>>>>
>>>>  - range_contains_unaccepted_memory() checks anything within the range
>>>>    of physical addresses requires acceptance.
>>>>
>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Acked-by: Mike Rapoport <rppt@linux.ibm.com>	# memblock
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>
>>> Hmm I realize it's not ideal to raise this at v7, and maybe it was discussed
>>> before, but it's really not great how this affects the core page allocator
>>> paths. Wouldn't it be possible to only release pages to page allocator when
>>> accepted, and otherwise use some new per-zone variables together with the
>>> bitmap to track how much exactly is where to accept? Then it could be hooked
>>> in get_page_from_freelist() similarly to CONFIG_DEFERRED_STRUCT_PAGE_INIT -
>>> if we fail zone_watermark_fast() and there are unaccepted pages in the zone,
>>> accept them and continue. With a static key to flip in case we eventually
>>> accept everything. Because this is really similar scenario to the deferred
>>> init and that one was solved in a way that adds minimal overhead.
>>
>> I kind of like just having the memory stats being correct (e.g., free
>> memory) and acceptance being an internal detail to be triggered when
>> allocating pages -- just like the arch_alloc_page() callback.
> 
> Hm, good point about the stats. Could be tweaked perhaps so it appears
> correct on the outside, but might be tricky.
> 
>> I'm sure we could optimize for the !unaccepted memory via static keys
>> also in this version with some checks at the right places if we find
>> this to hurt performance?
> 
> It would be great if we would at least somehow hit the necessary code only
> when dealing with a >=pageblock size block. The bitmap approach and
> accepting everything smaller uprofront actually seems rather compatible. Yet
> in the current patch we e.g. check PageUnaccepted(buddy) on every buddy size
> while merging.
> 
> A list that sits besides the existing free_area, contains only >=pageblock
> order sizes of unaccepted pages (no migratetype distinguished) and we tap
> into it approximately before __rmqueue_fallback()? There would be some
> trickery around releasing zone-lock for doing accept_memory(), but should be
> manageable.
> 

Just curious, do we have a microbenchmark that is able to reveal the
impact of such code changes before we start worrying?

-- 
Thanks,

David / dhildenb

