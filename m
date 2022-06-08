Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161ED542D15
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jun 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiFHKU3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jun 2022 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiFHKUB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jun 2022 06:20:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B51371AB601
        for <linux-efi@vger.kernel.org>; Wed,  8 Jun 2022 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654682908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEHEjRGmX36MVX7I3CW3Ag7ueRgzzBbF2Okws9bZlv4=;
        b=YMebfZwSs5dEI9/vq/g2p/JKqBl6PVJ/UBy+Xe+R9FAb+orfColKRE8Aqu3S2bCCSFMkNT
        3U5/sHf4T/zyJWfp5layLREe29TA5x/YfosWMGIvGhoaLoILMftlvUAdEWhqQKFVSCKHtD
        CGFXYwm3icGoCI+0VF9X0ZS1bY9SOgY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Nh6qvH8PMDmGFrDUBbn4zw-1; Wed, 08 Jun 2022 06:08:27 -0400
X-MC-Unique: Nh6qvH8PMDmGFrDUBbn4zw-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so9740112wmj.0
        for <linux-efi@vger.kernel.org>; Wed, 08 Jun 2022 03:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=sEHEjRGmX36MVX7I3CW3Ag7ueRgzzBbF2Okws9bZlv4=;
        b=Xlkvxja8fq5a+QepU2zCOek8/qB3Bw3o4Zv6ga3vvi4QzBJjKPi9fWMwrfYbrg7+z4
         Dnooa03czR7lYbRsfp1PwCxrFOdVvidz2kZbPgaMpX2rHBN7NMgwxoyh9SLbWn8CfUMy
         kIEAbppyyOCshiucobPGeE4vHWdsHNbKps/jUJGbpBUimDw0mU6HF4ewr/gF+rV5PJwH
         8nA2nDSZtzDnYAqx5JSXSkgi0EghUVMatvirWp8NuIFCm54KuqnfgptaBj6zoDHDrWy7
         w4snhsI0+G8yKiK9y7dwEB+adv71ZV9oJ7R2f7LqtXK9XfSYAnVrauUI2ZS8xCFFKYRG
         ELVA==
X-Gm-Message-State: AOAM531FR5/DK+/IO2nLyDOSI/aaTd6sWsceuFkBdWrRZ3y+kqtwZTLI
        PFLTaCqoqbnXNuj/ALKSej+wlzQYpGOpx5IN02hN4/n/Nb7D6ZU5JWk8gTnvgwHeQnrAWh+lBPD
        FbtWvZ7w6F4TdpaPLMTTt
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr25736309wrc.38.1654682905239;
        Wed, 08 Jun 2022 03:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxxVImU4Va1WqxQD1UaKL+Dc2uPBVbwnA9UZNtwOl0kUiXQIUGj0uM330odftyyo1WuGntSg==
X-Received: by 2002:a05:6000:170a:b0:215:6799:782c with SMTP id n10-20020a056000170a00b002156799782cmr25736249wrc.38.1654682904562;
        Wed, 08 Jun 2022 03:08:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ad00:db2:4c6:8f3a:2ec4? (p200300cbc705ad000db204c68f3a2ec4.dip0.t-ipconnect.de. [2003:cb:c705:ad00:db2:4c6:8f3a:2ec4])
        by smtp.gmail.com with ESMTPSA id x4-20020adfffc4000000b0021018642ff8sm20678946wrs.76.2022.06.08.03.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 03:08:23 -0700 (PDT)
Message-ID: <cd0e727d-8ad6-2d74-55f5-498394aae297@redhat.com>
Date:   Wed, 8 Jun 2022 12:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 5/6] mm: Add mirror flag back on initrd memory
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, mawupeng <mawupeng1@huawei.com>
Cc:     ardb@kernel.org, corbet@lwn.net, will@kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, dvhart@infradead.org, andy@infradead.org,
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
 <99900b31-2605-2c85-a1b7-9ef2666b58da@redhat.com>
 <CAMj1kXGkzjq3koW_sgO4uzrdtwqSqzsJfT5ABYyvodf+ggXT2w@mail.gmail.com>
 <29900b05-ec44-76a2-645a-22a13399d7fd@huawei.com>
 <YqBzwgTgWEAx8J/C@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqBzwgTgWEAx8J/C@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 08.06.22 12:02, Mike Rapoport wrote:
> On Wed, Jun 08, 2022 at 03:27:09PM +0800, mawupeng wrote:
>>
>> 在 2022/6/7 22:49, Ard Biesheuvel 写道:
>>> On Tue, 7 Jun 2022 at 14:22, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 07.06.22 11:38, Wupeng Ma wrote:
>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>
>>>>> Initrd memory will be removed and then added in arm64_memblock_init() and this
>>>>> will cause it to lose all of its memblock flags. The lost of MEMBLOCK_MIRROR
>>>>> flag will lead to error log printed by find_zone_movable_pfns_for_nodes if
>>>>> the lower 4G range has some non-mirrored memory.
>>>>>
>>>>> In order to solve this problem, the lost MEMBLOCK_MIRROR flag will be
>>>>> reinstalled if the origin memblock has this flag.
>>>>>
>>>>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>>>>> ---
>>>>>   arch/arm64/mm/init.c     |  9 +++++++++
>>>>>   include/linux/memblock.h |  1 +
>>>>>   mm/memblock.c            | 20 ++++++++++++++++++++
>>>>>   3 files changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>>>> index 339ee84e5a61..11641f924d08 100644
>>>>> --- a/arch/arm64/mm/init.c
>>>>> +++ b/arch/arm64/mm/init.c
>>>>> @@ -350,9 +350,18 @@ void __init arm64_memblock_init(void)
>>>>>                        "initrd not fully accessible via the linear mapping -- please check your bootloader ...\n")) {
>>>>>                        phys_initrd_size = 0;
>>>>>                } else {
>>>>> +                     int flags, ret;
>>>>> +
>>>>> +                     ret = memblock_get_flags(base, &flags);
>>>>> +                     if (ret)
>>>>> +                             flags = 0;
>>>>> +
>>>>>                        memblock_remove(base, size); /* clear MEMBLOCK_ flags */
>>>>>                        memblock_add(base, size);
>>>>>                        memblock_reserve(base, size);
>>>>
>>>> Can you explain why we're removing+re-adding here exactly? Is it just to
>>>> clear flags as the comment indicates?
>>>>
>>>
>>> This should only happen if the placement of the initrd conflicts with
>>> a mem= command line parameter or it is not covered by memblock for
>>> some other reason.
>>>
>>> IOW, this should never happen, and if re-memblock_add'ing this memory
>>> unconditionally is causing problems, we should fix that instead of
>>> working around it.
>>
>> This will happen if we use initrdmem=3G,100M to reserve initrd memory below
>> the 4G limit to test this scenario(just for testing, I have trouble to boot
>> qemu with initrd enabled and memory below 4G are all mirror memory).
>>
>> Re-memblock_add'ing this memory unconditionally seems fine but clear all
>> flags(especially MEMBLOCK_MIRROR) may lead to some error log.
>>
>>>
>>>> If it's really just about clearing flags, I wonder if we rather want to
>>>> have an interface that does exactly that, and hides the way this is
>>>> actually implemented (obtain flags, remove, re-add ...), internally.
>>>>
>>>> But most probably there is more magic in the code and clearing flags
>>>> isn't all it ends up doing.
>>>>
>>>
>>> I don't remember exactly why we needed to clear the flags, but I think
>>> it had to do with some corner case we hit when the initrd was
>>> partially covered.
>> If "mem=" is set in command line, memblock_mem_limit_remove_map() will
>> remove all memory block without MEMBLOCK_NOMAP. Maybe this will bring the
>> memory back if this initrd mem has the MEMBLOCK_NOMAP flag?
>>
>> The rfc version [1] introduce and use memblock_clear_nomap() to clear the
>> MEMBLOCK_NOMAP of this initrd memblock.
>> So maybe the usage of memblock_remove() is just to avoid introducing new
>> function(memblock_clear_nomap)?
>>
>> Since commit 4c546b8a3469 ("memblock: add memblock_clear_nomap()") already
>> introduced memblock_clear_nomap(). Can we use this to remove flag MEMBLOCK_NOMAP
>> to solve this problem rather than bring flag MEMBLOCK_MIRROR back?
> 
> AFAICT, there are two corner cases that re-adding initrd memory covers:
> * initrd memory is not a part of the memory reported to memblock, either
> because of firmware weirdness or because it was cut out with mem=
> * initrd memory overlaps a NOMAP region
> 
> So to make sure initrd memory is mapped properly and retains
> MEMBLOCK_MIRROR I think the best we can do is
> 
> 	memblock_add();
> 	memblock_clear_nomap();
> 	memblock_reserve();

Would simply detect+rejecting to boot on such setups be an option? The
replies so far indicate to me that this is rather a corner case than a
reasonable use case.

-- 
Thanks,

David / dhildenb

