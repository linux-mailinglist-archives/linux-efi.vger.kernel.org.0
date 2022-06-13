Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635565489CC
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 18:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386048AbiFMOvQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385964AbiFMOuX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 10:50:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F124979;
        Mon, 13 Jun 2022 04:54:58 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LM91S5pwBz1K9RY;
        Mon, 13 Jun 2022 19:53:00 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 19:54:56 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 19:54:54 +0800
Message-ID: <fa1416be-f940-4c28-5c67-911e61ac024f@huawei.com>
Date:   Mon, 13 Jun 2022 19:54:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 6/6] memblock: Disable mirror feature if kernelcore is
 not specified
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC:     Wupeng Ma <mawupeng1@huawei.com>, <corbet@lwn.net>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <akpm@linux-foundation.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <paulmck@kernel.org>,
        <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <swboyd@chromium.org>, <wei.liu@kernel.org>,
        <robin.murphy@arm.com>, <david@redhat.com>,
        <anshuman.khandual@arm.com>, <thunder.leizhen@huawei.com>,
        <gpiccoli@igalia.com>, <chenhuacai@kernel.org>,
        <geert@linux-m68k.org>, <vijayb@linux.microsoft.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>
References: <20220613082147.183145-1-mawupeng1@huawei.com>
 <20220613082147.183145-7-mawupeng1@huawei.com> <YqcZ4O3pwceVtKYm@kernel.org>
 <CAMj1kXGwOczo1bgftMX9xTf8fRkrVYq8BjXJ6=XPj_yarbDYrA@mail.gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMj1kXGwOczo1bgftMX9xTf8fRkrVYq8BjXJ6=XPj_yarbDYrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 2022/6/13 19:25, Ard Biesheuvel wrote:
> On Mon, 13 Jun 2022 at 13:05, Mike Rapoport <rppt@kernel.org> wrote:
>> On Mon, Jun 13, 2022 at 04:21:47PM +0800, Wupeng Ma wrote:
>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>
>>> If system have some mirrored memory and mirrored feature is not specified
>>> in boot parameter, the basic mirrored feature will be enabled and this will
>>> lead to the following situations:
>>>
>>> - memblock memory allocation prefers mirrored region. This may have some
>>>    unexpected influence on numa affinity.
>>>
>>> - contiguous memory will be split into several parts if parts of them
>>>    is mirrored memory via memblock_mark_mirror().
...
> Also, on second thought, I don't think marking as mirror is what
> should be affected by the policy. Instead, choose_memblock_flags()
> should take this into account, in a way that we could refine later if
> needed.
> .

The choose_memblock_flags() only solve the issue of memblock allocation, but

the memblock could be splitted and fragmentized, the kernel won't treat the

mirror memory as special if no mirrored_kernelcore for now, so I think 
we'd better

to add the check into memblock_mark_mirror().

