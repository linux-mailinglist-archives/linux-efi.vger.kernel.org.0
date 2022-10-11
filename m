Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32815FB36D
	for <lists+linux-efi@lfdr.de>; Tue, 11 Oct 2022 15:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJKN2t (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Oct 2022 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJKN2r (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Oct 2022 09:28:47 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC9C50509
        for <linux-efi@vger.kernel.org>; Tue, 11 Oct 2022 06:28:45 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id h4so14223588vsr.11
        for <linux-efi@vger.kernel.org>; Tue, 11 Oct 2022 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raH7WVDSsvCPKQIhYgmZFVAAGSUF5nc09Zedq+rsMAU=;
        b=RIe4dBR0aMf5OdrqYm/Utd+N0OJj8M7yVRnxQt0SWrAE+Icqli8dm198FiWu1zyE4K
         ThFkWDgg/9Td5d2IRDtyLEfSPwokGQrcFSl+ZlD2K4af69I3g3EB9B1emQIrMWvScJHw
         r+I3aZYKyOKoXo9+c2guSFePs38N6mNAHs3VoFJnnpA5I08Jok+DXwlLOgxNK3KgfAUZ
         XdH4LxlWpNY4uzGhO4Af+xDw0bOM1Vadya5Rtbe4apuRaNOzWyL2aYvjt49BUK4JI6Dw
         lHsf8fQMu1jQgOb7cxH8q3pAtHNmlqi/rQWzUKfzGN0Ycw4ppIGnoOMf/vkNLy9aLTOC
         /peA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raH7WVDSsvCPKQIhYgmZFVAAGSUF5nc09Zedq+rsMAU=;
        b=xcGF5688TWU3aZzRCLzD8ogPJOWsx/gtXUv4ZKiIrp9C7XeSGYKipXLzg68FavAwxA
         bUrMMyAJ1GsItWl16HSyziXxXXaGY96yjsYWEcu8yZEeDWJF135JBGnw18L7Gi7AmjTH
         NCjl1Hew92YkvfVnRI0QSzBcK9WV8M84UvKOMxQ426l2iVYXthg6FQrX8BsPoqW8pTld
         1/JJdbdJnAW6g/N4zE9ux7co1PDxLdOeSn2mjGtfbLo2eNePr3IUwQ3IVw2OluK7tQJo
         84N1ChK63FP5yxO123ta5IHa0SsT3bO2nf37GhPfTFKjC6caIUSgaQ1KB1GHL3foot1+
         SVGQ==
X-Gm-Message-State: ACrzQf0l6+6Nmbf9pkIw38fsm5RCdpuQ1fnwptUI/Lua+tquOK2hhhYf
        xHMmsOiMTaklFMht1D5evmf143y16P9R5FGaRVvLWQ==
X-Google-Smtp-Source: AMsMyM4RCzDu9DE1SgMdp+TCHAnmXWjm2D/kY89a9RpcBY1OK3SAh2E+19si06YAqT4aoi2eeQCzNy8ngm5l9Ym0oU4=
X-Received: by 2002:a05:6102:301a:b0:3a7:8755:2b7e with SMTP id
 s26-20020a056102301a00b003a787552b7emr4741009vsa.32.1665494924704; Tue, 11
 Oct 2022 06:28:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:136f:0:b0:3d2:4916:f286 with HTTP; Tue, 11 Oct 2022
 06:28:44 -0700 (PDT)
In-Reply-To: <20221007155323.ue4cdthkilfy4lbd@box.shutemov.name>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-3-martin.fernandez@eclypsium.com> <20221007155323.ue4cdthkilfy4lbd@box.shutemov.name>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 11 Oct 2022 10:28:44 -0300
Message-ID: <CAKgze5bRKph0SPOerLDLZb5KckPX5+q0y649XCU4J5HehYVu0A@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] mm/mmzone: Tag pg_data_t with crypto capabilities
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/7/22, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> On Mon, Jul 04, 2022 at 10:58:26AM -0300, Martin Fernandez wrote:
>> Add a new member in the pg_data_t struct to tell whether the node
>> corresponding to that pg_data_t is able to do hardware memory
>> encryption.
>>
>> This will be read from sysfs.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  include/linux/mmzone.h | 3 +++
>>  mm/page_alloc.c        | 1 +
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index aab70355d64f..6fd4785f1d05 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -883,6 +883,9 @@ typedef struct pglist_data {
>>  	struct task_struct *kcompactd;
>>  	bool proactive_compact_trigger;
>>  #endif
>> +
>> +	bool crypto_capable;
>> +
>
> There's already pgdat->flags. Any reason we cannot encode it there?

Not really a reason, I'll considerate when I send then next version. I
tried to quickly find for references of what kind of flags does it
have, I didn't find any. Do you suggest it should work?

>>  	/*
>>  	 * This is a per-node reserve of pages that are not available
>>  	 * to userspace allocations.
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e008a3df0485..147437329ac7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -7729,6 +7729,7 @@ static void __init free_area_init_node(int nid)
>>  	pgdat->node_id = nid;
>>  	pgdat->node_start_pfn = start_pfn;
>>  	pgdat->per_cpu_nodestats = NULL;
>> +	pgdat->crypto_capable = memblock_node_is_crypto_capable(nid);
>>
>>  	if (start_pfn != end_pfn) {
>>  		pr_info("Initmem setup node %d [mem %#018Lx-%#018Lx]\n", nid,
>> --
>> 2.30.2
>>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov
>
