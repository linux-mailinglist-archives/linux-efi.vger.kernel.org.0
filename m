Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F552447FBF
	for <lists+linux-efi@lfdr.de>; Mon,  8 Nov 2021 13:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhKHMuw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 Nov 2021 07:50:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:27188 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhKHMuv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 Nov 2021 07:50:51 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HnrTJ6xMNz8vHJ;
        Mon,  8 Nov 2021 20:46:28 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Mon, 8 Nov 2021 20:48:03 +0800
Subject: Re: [PATCH -next,v2] efi/libstub: arm32: Use "align" for the size
 alignment
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
References: <20211102020545.145840-1-cuigaosheng1@huawei.com>
 <CAMj1kXFE1Gv41TowKZHqkwn+WVLsAOqJSFbi706KbMC0G_rqgw@mail.gmail.com>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <6bd8e85e-2ff8-f833-0b5b-2868b61f2f34@huawei.com>
Date:   Mon, 8 Nov 2021 20:48:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFE1Gv41TowKZHqkwn+WVLsAOqJSFbi706KbMC0G_rqgw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for your reply.

In my understanding address and size need to meet consistent alignment 
constraints,If I understand wrong, please reject this patch.

Best,

GaoSheng.

在 2021/11/4 17:26, Ard Biesheuvel 写道:
> On Tue, 2 Nov 2021 at 03:04, Gaosheng Cui <cuigaosheng1@huawei.com> wrote:
>> We are doing page-based allocations, and both the address
>> and size must meet alignment constraints, so using "align"
>> for the size alignment is a better choice.
>>
> Why is it a better choice? If I allocate a 2 MB aligned block of
> memory, why is it better to align the size to a multiple of 2 MB as
> well?
>
>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/firmware/efi/libstub/randomalloc.c | 2 +-
>>   drivers/firmware/efi/libstub/relocate.c    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
>> index 724155b9e10d..7b7159bb035d 100644
>> --- a/drivers/firmware/efi/libstub/randomalloc.c
>> +++ b/drivers/firmware/efi/libstub/randomalloc.c
>> @@ -76,7 +76,7 @@ efi_status_t efi_random_alloc(unsigned long size,
>>          if (align < EFI_ALLOC_ALIGN)
>>                  align = EFI_ALLOC_ALIGN;
>>
>> -       size = round_up(size, EFI_ALLOC_ALIGN);
>> +       size = round_up(size, align);
>>
>>          /* count the suitable slots in each memory map entry */
>>          for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
>> diff --git a/drivers/firmware/efi/libstub/relocate.c b/drivers/firmware/efi/libstub/relocate.c
>> index 8ee9eb2b9039..d6d27e8c23f8 100644
>> --- a/drivers/firmware/efi/libstub/relocate.c
>> +++ b/drivers/firmware/efi/libstub/relocate.c
>> @@ -50,7 +50,7 @@ efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
>>          if (align < EFI_ALLOC_ALIGN)
>>                  align = EFI_ALLOC_ALIGN;
>>
>> -       size = round_up(size, EFI_ALLOC_ALIGN);
>> +       size = round_up(size, align);
>>          nr_pages = size / EFI_PAGE_SIZE;
>>          for (i = 0; i < map_size / desc_size; i++) {
>>                  efi_memory_desc_t *desc;
>> --
>> 2.30.0
>>
> .
