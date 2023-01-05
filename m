Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8765E29C
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 02:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjAEBoC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 20:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAEBnz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 20:43:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432803054D
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 17:43:54 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so544271pjj.2
        for <linux-efi@vger.kernel.org>; Wed, 04 Jan 2023 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qvbp9StBfREPm9I8aa88N5F9Rq5kJCaZobikFDCIkUs=;
        b=aGe2tFawcoyWZsfDcMGLCaXjZkLyoN9C1fE3zXrR6TwPkxwOpA0GBIkNJTpGi5CSMt
         6Afftkz7Pss9n5W3QSKnI0/aBJa9N4USaAvMHkW3UypczfmZiDys3mx0H/XTYlPQHe4j
         0rL4bapJ24GHgybCzjhI7JwK7vpcJ51fBYzYroPnZwxfoNPhYPs/qfKUq1dUU0vJPs5L
         E+bEauIOgYtbC2kpEbabKgYE1lHNyJNe/grIdHIHuoaV8qgsIgXZJfKJZJ9flp1r7P7u
         yWT/6yBlBRZHiwxEXD//rzbqdv0uyx+pQF5H9mk8Y/YgrvY37kdbi7pbLPFIl9ncnQFz
         uG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvbp9StBfREPm9I8aa88N5F9Rq5kJCaZobikFDCIkUs=;
        b=uhIPwYn2oH5c4OOFwa9A2aKmf+VrrlsvQzHLjlQBFuJWoViOxiqVbtakuKQadEG06h
         jDvRvYDH7ZS10Kodan1doHxY/l/EPgmbWU19VKftPYpxJZ+XP7r13orkYtHB6a6Sty/1
         2yF0G0YxdFCbqQS6UFCSG+jgGN8Jba8AYczh11Yw7Qn9yeB5x0ZgN/5cH9HcGJn7OCq2
         WMKz4ALB0lb4bD6I5gZEuzmrux5tm90+eIxjVhaJrEpksuVjhMfyVMBGfcWB0J4M+XGe
         k9G6LjiRCwhvXl2HN2L7CzczbNBqTvY5UlwACE1btRtlhbHg9fLzSQvnvu6gymAjeND4
         pRZQ==
X-Gm-Message-State: AFqh2kr/1oIwIgvbGYh419we6mJVQl0Rz/Oas6XIdJDJsDWisGDvQE3K
        6yBLKjhonGPbPa6F7BOPBmucsQ==
X-Google-Smtp-Source: AMrXdXuEZIYlNipB/1x/TwxCUNmQ8yIlGOKAJDrVShsUI6SI7yNkmlLkGEX66W+sSvYY8CQL8xSlsg==
X-Received: by 2002:a17:902:9b95:b0:189:6d32:afeb with SMTP id y21-20020a1709029b9500b001896d32afebmr59plp.1.1672883033545;
        Wed, 04 Jan 2023 17:43:53 -0800 (PST)
Received: from [2620:15c:29:203:fc97:724c:15bb:25c7] ([2620:15c:29:203:fc97:724c:15bb:25c7])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b0019290a36553sm11980965plk.63.2023.01.04.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 17:43:52 -0800 (PST)
Date:   Wed, 4 Jan 2023 17:43:51 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Aaron Thompson <dev@aaront.org>
cc:     linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Darren Hart <dvhart@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/1] Pages not released from memblock to the buddy
 allocator
In-Reply-To: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
Message-ID: <30478b4a-870b-bf48-76d0-a236a40e7674@google.com>
References: <010101857bbc3a41-173240b3-9064-42ef-93f3-482081126ec2-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Jan 2023, Aaron Thompson wrote:

> Hi all,
> 
> (I've CC'ed the KMSAN and x86 EFI maintainers as an FYI; the only code change
> I'm proposing is in memblock.)
> 
> I've run into a case where pages are not released from memblock to the buddy
> allocator. If deferred struct page init is enabled, and memblock_free_late() is
> called before page_alloc_init_late() has run, and the pages being freed are in
> the deferred init range, then the pages are never released. memblock_free_late()
> calls memblock_free_pages() which only releases the pages if they are not in the
> deferred range. That is correct for free pages because they will be initialized
> and released by page_alloc_init_late(), but memblock_free_late() is dealing with
> reserved pages. If memblock_free_late() doesn't release those pages, they will
> forever be reserved. All reserved pages were initialized by memblock_free_all(),
> so I believe the fix is to simply have memblock_free_late() call
> __free_pages_core() directly instead of memblock_free_pages().
> 
> In addition, there was a recent change (3c20650982609 "init: kmsan: call KMSAN
> initialization routines") that added a call to kmsan_memblock_free_pages() in
> memblock_free_pages(). It looks to me like it would also be incorrect to make
> that call in the memblock_free_late() case, because the KMSAN metadata was
> already initialized for all reserved pages by kmsan_init_shadow(), which runs
> before memblock_free_all(). Having memblock_free_late() call __free_pages_core()
> directly also fixes this issue.
> 
> I encountered this issue when I tried to switch some x86_64 VMs I was running
> from BIOS boot to EFI boot. The x86 EFI code reserves all EFI boot services
> ranges via memblock_reserve() (part of setup_arch()), and it frees them later
> via memblock_free_late() (part of efi_enter_virtual_mode()). The EFI
> implementation of the VM I was attempting this on, an Amazon EC2 t3.micro
> instance, maps north of 170 MB in boot services ranges that happen to fall in
> the deferred init range. I certainly noticed when that much memory went missing
> on a 1 GB VM.
> 
> I've tested the patch on EC2 instances, qemu/KVM VMs with OVMF, and some real
> x86_64 EFI systems, and they all look good to me. However, the physical systems
> that I have don't actually trigger this issue because they all have more than 4
> GB of RAM, so their deferred init range starts above 4 GB (it's always in the
> highest zone and ZONE_DMA32 ends at 4 GB) while their EFI boot services mappings
> are below 4 GB.
> 
> Deferred struct page init can't be enabled on x86_32 so those systems are
> unaffected. I haven't found any other code paths that would trigger this issue,
> though I can't promise that there aren't any. I did run with this patch on an
> arm64 VM as a sanity check, but memblock=debug didn't show any calls to
> memblock_free_late() so that system was unaffected as well.
> 
> I am guessing that this change should also go the stable kernels but it may not
> apply cleanly (__free_pages_core() was __free_pages_boot_core() and
> memblock_free_pages() was __free_pages_bootmem() when this issue was first
> introduced). I haven't gone through that process before so please let me know if
> I can help with that.
> 
> This is the end result on an EC2 t3.micro instance booting via EFI:
> 
> v6.2-rc2:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  178867
> 
> v6.2-rc2 + patch:
>   # grep -E 'Node|spanned|present|managed' /proc/zoneinfo
>   Node 0, zone      DMA
>           spanned  4095
>           present  3999
>           managed  3840
>   Node 0, zone    DMA32
>           spanned  246652
>           present  245868
>           managed  222816
> 

The above before + after seems useful information to include in the commit 
description of the change.
