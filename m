Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB1C53FEAD
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243658AbiFGMXW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jun 2022 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiFGMW0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jun 2022 08:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 376B2F6892
        for <linux-efi@vger.kernel.org>; Tue,  7 Jun 2022 05:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654604521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LFae0+Vw/Q7XKFtLqEkht1EHSrvkXyEHWVa21iC8kcQ=;
        b=XbmbQLZlWBmVHcefQvyIZ4eCwTHx1lZCuQw8Lw0uxrsqO9OW4axChiUxBJ8jBOVgLVyQvr
        ZyvrlHxeNIlR1pg9Br0ac8ESrhQxcsDXJmq/KwlVqDbZ0H53grOiZ9MtcRZJf19ijRqV/3
        BuufYoBNinJQ3FAVq/BeLLAlOJzfJV4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-YQdAqp5ZN6WGzKxZ4hWnXg-1; Tue, 07 Jun 2022 08:22:00 -0400
X-MC-Unique: YQdAqp5ZN6WGzKxZ4hWnXg-1
Received: by mail-wr1-f72.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so1707204wrb.20
        for <linux-efi@vger.kernel.org>; Tue, 07 Jun 2022 05:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=LFae0+Vw/Q7XKFtLqEkht1EHSrvkXyEHWVa21iC8kcQ=;
        b=2a3Rk5gVlEPko33q0zIGPjTNAo3dDb6Uj1zxgUa7MgYYcG+1imHV084p16M+3wwry3
         LtR0m4/QY4PqLIPz4PRq54MYn66ezmBHOfTJGNSSVafWkM0jEDAixOeQXyHaijiZYD7Y
         xVfkqUuBBxbKjWk1EtIglRI9A6gMYf20HKxm6dhEERoszJ3Y00al00uuoxafsRWH7+8f
         i0U8KKDNQ0O9kOKJaXWEoOtWkwl2qcST5BTEj+W+ZImjCVOTEwnmZexy4+I+qfHvuJJ0
         JVgMORPNYvR5Ky3b6egGJIDAZmoRA6Tcu3MZKiZ4EM0qq5OUpNw59WGx8uuOxhsjJOZ3
         NlDw==
X-Gm-Message-State: AOAM531anaWFtGdlTxA0fkyAlJ70dFDRhvO2oHDSdTRFciU4eynraFgH
        7THCI2cBhX+povd6HaARmdDDAdDW6GX9aTy8GkYNAhGd/PpdBsmLMk5L4TWJVcqoeTetXogtapp
        9umJOBxOCGwiZC/h0W43+
X-Received: by 2002:a5d:6f07:0:b0:20f:e7b6:60e9 with SMTP id ay7-20020a5d6f07000000b0020fe7b660e9mr26970314wrb.452.1654604518592;
        Tue, 07 Jun 2022 05:21:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6zVY8RJtypryJ4lRqoQ7sLYVvIPsHW+mIUVYuw6yWEgN87NIn1XVL3PPwxcCz6RZEMmu3Kw==
X-Received: by 2002:a5d:6f07:0:b0:20f:e7b6:60e9 with SMTP id ay7-20020a5d6f07000000b0020fe7b660e9mr26970280wrb.452.1654604518294;
        Tue, 07 Jun 2022 05:21:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:500:4c8d:4886:f874:7b6f? (p200300cbc70905004c8d4886f8747b6f.dip0.t-ipconnect.de. [2003:cb:c709:500:4c8d:4886:f874:7b6f])
        by smtp.gmail.com with ESMTPSA id eh2-20020a05600c61c200b0039c54f34948sm4284902wmb.5.2022.06.07.05.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 05:21:57 -0700 (PDT)
Message-ID: <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
Date:   Tue, 7 Jun 2022 14:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Wupeng Ma <mawupeng1@huawei.com>, corbet@lwn.net, will@kernel.org,
        ardb@kernel.org, catalin.marinas@arm.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        anshuman.khandual@arm.com, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, gpiccoli@igalia.com,
        chenhuacai@kernel.org, geert@linux-m68k.org, chenzhou10@huawei.com,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
References: <20220607093805.1354256-1-mawupeng1@huawei.com>
 <20220607093805.1354256-6-mawupeng1@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
In-Reply-To: <20220607093805.1354256-6-mawupeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07.06.22 11:38, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Initrd memory will be removed and then added in arm64_memblock_init() and this
> will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
> flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
> the lower 4G range has some non-mirrored memory.
> 
> In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
> reinstalled if the origin memblock has this flag.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  arch/arm64/mm/init.c     |  9 +++++++++
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 20 ++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61..11641f924d08 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
>  			"initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>  			phys_initrd_size = 0;
>  		} else {
> +			int flags, ret;
> +
> +			ret = memblock_get_flags(base, &flags);
> +			if (ret)
> +				flags = 0;
> +
>  			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>  			memblock_add(base, size);
>  			memblock_reserve(base, size);

Can you explain why we're removing+re-adding here exactly? Is it just to
clear flags as the comment indicates?


If it's really just about clearing flags, I wonder if we rather want to
have an interface that does exactly that, and hides the way this is
actually implemented (obtain flags, remove, re-add ...), internally.

But most probably there is more magic in the code and clearing flags
isn't all it ends up doing.

-- 
Thanks,

David / dhildenb

