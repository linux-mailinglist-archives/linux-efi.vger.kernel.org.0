Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99509596CAC
	for <lists+linux-efi@lfdr.de>; Wed, 17 Aug 2022 12:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiHQKRN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Aug 2022 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHQKRM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Aug 2022 06:17:12 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2083658DCE
        for <linux-efi@vger.kernel.org>; Wed, 17 Aug 2022 03:17:10 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmsawPxi+zUDAA--.3662S3;
        Wed, 17 Aug 2022 18:16:58 +0800 (CST)
Message-ID: <62f83c65-7e8c-cbe4-0ec1-a8dc8ce0d6b6@loongson.cn>
Date:   Wed, 17 Aug 2022 18:16:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: EFI zboot on LoongArch [was: LoongArch: Add efistub booting
 support]
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220617145754.582056-1-chenhuacai@loongson.cn>
 <CAMj1kXERN209b7dbVs_hy4BeUwrmk2p9_vF+Wq2W8PUeHOQTkg@mail.gmail.com>
 <CAAhV-H60CJDRY4c+Eu+L=rNgHsXQqx=HK9nNSqg69WVV+Bm3SQ@mail.gmail.com>
 <CAMj1kXE1MijqonkPeH+Ydg8ti4_4YFXxBKK6Wztb=HtSY5EAgQ@mail.gmail.com>
 <CAAhV-H503hgyUZND2MmZ2h3qVb3SRt79HcQy7HrFmfGBci-QMA@mail.gmail.com>
 <CAMj1kXEzzAXYP3nXo8-Ny+iwuDorrO-JqoKjg3R+4kmhV_v_KQ@mail.gmail.com>
 <CAAhV-H60mSKx3k1CwBCdubswosgqe+NuVaMtKA=hpjBhq5w5wA@mail.gmail.com>
 <CAMj1kXFi0o3dOmpW9qarJPH2L2EWKCPKE--3z=jsGjaYh1JrTQ@mail.gmail.com>
 <CAAhV-H5CXeG9mNxqJLouvSGLqno4DSwbpPOO5xG2D6ptF2dSTQ@mail.gmail.com>
 <CAMj1kXEuQMy4+uMxg3A0W=F=PnRHUNLfrN=BPpR3pi_kbWaVpQ@mail.gmail.com>
 <137f829f227602593327461b6349abeaf4bb1f26.camel@xry111.site>
 <CAMj1kXF=kosmBuF7fd_+gkcxxF0MnB8OdvJ+k3k0uL+Oh3haXg@mail.gmail.com>
 <CAAhV-H6e9WH5GxYiK9CFnUnJC=NzG=bsmNwuR7Waiz7LadV5xg@mail.gmail.com>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <CAAhV-H6e9WH5GxYiK9CFnUnJC=NzG=bsmNwuR7Waiz7LadV5xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnmsawPxi+zUDAA--.3662S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWrZFyDWFW5WF17WF4Uurg_yoW8AFW3pa
        yxAFyqyFs5tF48tr1vvw1DX342ywsFyryvqw15XryIkFn0qr1UJr1UtFykWrZrJFWrJwn0
        va4Sqas7Cr4qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
        ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        IzuJUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



在 2022/8/17 17:09, Huacai Chen 写道:
> Hi, Ard,
> 
> On Wed, Aug 17, 2022 at 4:36 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Wed, 17 Aug 2022 at 09:59, Xi Ruoyao <xry111@xry111.site> wrote:
>>>
>>> On Wed, 2022-08-17 at 09:49 +0200, Ard Biesheuvel wrote:
>>>
>>>>>>>>
>>>> I am trying to port the generic EFI zboot support to LoongArch, but I
>>>> am running into a problem:
>>>>
>>>> The zboot EFI image consists of
>>>>
>>>> zImage.o, created with objcopy -O binary
>>>> zboot-header.o, created using the assembler
>>>> libstub.a, created as usual
>>>>
>>>> This results in errors such as
>>>> arch/loongarch/boot/zboot-header.o: can't link different ABI object.
>>>> failed to merge target specific data of file
>>>> arch/loongarch/boot/zboot-header.o
>>>>
>>>> which I think is caused by the fact that objcopy does not set the LP64
>>>> soft float flags on the ELF object it creates.
>>>>
>>>> Do you see any way around this limitation?
>>>
>>> Update to Binutils-2.39
>>> (https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=83c5f3a)
>>>
>>
>> Thanks, that worked. I can now build the LoongArch EFI stub and the
>> zboot decompressor.
>>
>> Unfortunately, while the normal EFI stub kernel boots ok in QEMU/edk2,
>> the zboot one crashes with
>>
>> CRMD   0xB0
>> PRMD   0x4
>> ECFG  0x800
>> ESTAT   0x40000
>> ERA    0x17B87719C
>> BADV    0x17C634000
>> BADI 0x381031A5
>> PC 0x00017B87719C
>>
>> or
>>
>> CRMD   0xB0
>> PRMD   0x4
>> ECFG  0x800
>> ESTAT   0x40000
>> ERA    0x17B138D10
>> BADV    0x17C3CC000
>> BADI 0x294000F7
>> PC 0x00017B138D10

From the ESTAT 0x40000, it seems that it is writing unallocated
memory in efi stage with address 0x17C3CC000 or 0x17C634000.

regards
bibo,mao

> 
> Bibo is a key developer of QEMU/EDK2, maybe he can give some help.
> 
> Huacai

