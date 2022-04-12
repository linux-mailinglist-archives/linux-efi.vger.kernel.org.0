Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80F4FDC19
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 13:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiDLKO0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 06:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358186AbiDLJBY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 05:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA3041834A
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649751313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8HjmZzAIO50unb7pGZAQpRPqJO313RFErJC/+pOp/R0=;
        b=IkzNmt59JwO6895i4gRWAyjJEFTZrALQ8hNEZ2lfgWxKwr6MYvPmJOdUCGEFEX6gvMtZNP
        c9JU84/KA5L/asP6PBXmKhPMZB/1I/vYxg9u84i8dEzXzjKRS60p1v3pfcm01ePEqgJ0F/
        4nlJG2VJtY21qI05Lt6oK7FsIdyyB2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-85-URhQ71o_NZKy-7vLuXooMA-1; Tue, 12 Apr 2022 04:15:11 -0400
X-MC-Unique: URhQ71o_NZKy-7vLuXooMA-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so953470wmj.0
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 01:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=8HjmZzAIO50unb7pGZAQpRPqJO313RFErJC/+pOp/R0=;
        b=vgLLef7iFsYd39+QZi4iPKw3T/+EqjsILa0JsrrzDei8RsLozKcKl2RP+a6/97kGOY
         uclulkOJ1s7X9JB4I+j9JBDPmTmjCya1BZv6zMxYcm2sS2NUtS+16fLP6n4ulLRnTRId
         WhS7vHtMDBMMCvsi4JARlw+pcX7+vqn8IhOc/UpTEcDORON2S93YqHfYfhaWEQsUw8PI
         cVVMJSiX5NADSV/s2XkkUOy9e4OkUthkhxhb9UNjtTyrS73q56w8lk7FnUOmjkYiSwj4
         YP7SMRFO3FzEePAy44pjawr4G23DrJopjuAklzRPR/5vKeoCxYklVYMccDKG527XYoBX
         zUmg==
X-Gm-Message-State: AOAM530ONyOwZfNY8spVxycsSI2cZVf2pNKrTFtcA+B14/nJQGv85ZSS
        89l9DgTWwGveAohaKvzIsmhxbOHC4TORXrOJltQyfXXz/zbgPyw/eMO/TdkNrcld4znxO1De8t8
        NjraB3GGueA6sjxExs5nP
X-Received: by 2002:adf:ed8b:0:b0:206:1771:e373 with SMTP id c11-20020adfed8b000000b002061771e373mr28461580wro.84.1649751310602;
        Tue, 12 Apr 2022 01:15:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZYmHGzijmWq4j1QgvJKMtTI4uehpfCeAgJZFkKQ0wTIJR1ucWkaH70j+SivEpEn8AXTnKWA==
X-Received: by 2002:adf:ed8b:0:b0:206:1771:e373 with SMTP id c11-20020adfed8b000000b002061771e373mr28461563wro.84.1649751310358;
        Tue, 12 Apr 2022 01:15:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1800:7c14:16cc:5291:a9f3? (p200300cbc70718007c1416cc5291a9f3.dip0.t-ipconnect.de. [2003:cb:c707:1800:7c14:16cc:5291:a9f3])
        by smtp.gmail.com with ESMTPSA id b14-20020a7bc24e000000b003899c8053e1sm1814456wmj.41.2022.04.12.01.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:15:09 -0700 (PDT)
Message-ID: <ff9e0bad-be9a-97ac-ae88-d22bcfbe80d4@redhat.com>
Date:   Tue, 12 Apr 2022 10:15:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20220405234343.74045-1-kirill.shutemov@linux.intel.com>
 <20220405234343.74045-2-kirill.shutemov@linux.intel.com>
 <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCHv4 1/8] mm: Add support for unaccepted memory
In-Reply-To: <93a7cfdf-02e6-6880-c563-76b01c9f41f5@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 08.04.22 21:11, Dave Hansen wrote:
> On 4/5/22 16:43, Kirill A. Shutemov wrote:
>> Kernel only needs to accept memory once after boot, so during the boot
>> and warm up phase there will be a lot of memory acceptance. After things
>> are settled down the only price of the feature if couple of checks for
>> PageUnaccepted() in allocate and free paths. The check refers a hot
>> variable (that also encodes PageBuddy()), so it is cheap and not visible
>> on profiles.
> 
> Let's also not sugar-coat this.  Page acceptance is hideously slow.
> It's agonizingly slow.  To boot, it's done holding a global spinlock
> with interrupts disabled (see patch 6/8).  At the very, very least, each
> acceptance operation involves a couple of what are effectively ring
> transitions, a 2MB memset(), and a bunch of cache flushing.
> 
> The system is going to be downright unusable during this time, right?
> 
> Sure, it's *temporary* and only happens once at boot.  But, it's going
> to suck.
> 
> Am I over-stating this in any way?
> 
> The ACCEPT_MEMORY vmstat is good to have around.  Thanks for adding it.
>  But, I think we should also write down some guidance like:
> 
> 	If your TDX system seems as slow as snail after boot, look at
> 	the "accept_memory" counter in /proc/vmstat.  If it is
> 	incrementing, then TDX memory acceptance is likely to blame.
> 
> Do we need anything more discrete to tell users when acceptance is over?
>  For instance, maybe they run something and it goes really slow, they
> watch "accept_memory" until it stops.  They rejoice at their good
> fortune!  Then, memory allocation starts falling over to a new node and
> the agony beings anew.
> 
> I can think of dealing with this in two ways:
> 
> 	cat /sys/.../unaccepted_pages_left
> 
> which just walks the bitmap and counts the amount of pages remaining. or
> something like:
> 
> 	echo 1 > /sys/devices/system/node/node0/make_the_pain_stop
> 
> Which will, well, make the pain stop on node0.
> 

Either I'm missing something important or the random pain might just
take a really long time to stop?

I mean, we tend to reallocate the memory first that we freed last
(putting it to the head of the freelist when freeing and picking from
the head when allocating).

So unless your kernel goes crazy and allocates each and every page right
after boot, essentially accepting all memory, you might have random
unaccepted pages lurking at the tail of the freelists.

So if the VM is running for 355 days without significant memory
pressure, you can still run into unaccepted pages at day 356 that
results in a random delay due to acceptance of memory.


I think we most certainly want some way to make the random pain stop, or
to make the random pain go away after boot quickly. The
"unaccepted_pages_left" indicator would just be a "hey, there might be
random delays, but you cannot do anything about it". Magic toggles like
"make_the_pain_stop" are not so nice.

Can we simply automate this using a kthread or smth like that, which
just traverses the free page lists and accepts pages (similar, but
different to free page reporting)?

-- 
Thanks,

David / dhildenb

