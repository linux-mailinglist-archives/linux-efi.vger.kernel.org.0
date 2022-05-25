Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73253410F
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiEYQJM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiEYQJM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 12:09:12 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504ACAE27A
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 09:09:11 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AFBFA3FBC9
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653494949;
        bh=d8wzs0GJmElvjOENQNOKSUNkK9vo5WqYmuRjW9+dNXI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uzvbVzPg57zawLEoif9hNY8Cvh9w868svVFrpMiNCK/PSjubMfYKgtdRZqddogKoi
         4Vi+XjaUEd04hjrf5LpkpZBYHYTuGuDheXrx3oGiWcMrsg9cZ9mS4n0o8nj1ei7Ujp
         /nY9vMtzOQNT+pL8LadCNzJn65Tfjd9Z/t42HJnY7Ewb3iG+YdrfyP5AvFpaU80k9/
         LaWC/RTGeEDzSEyeKjZtLmezhfEv/Of2rKAZPYMR7F/o06LZcdxpz2D7nPHEbjQEVX
         y35idsoiFak2lIVbc3JESME5Z3CpPXMJZk1OntD/TGmxHvQGYJ0pr4imbSBzIWEgPo
         EyjamqBmJkuvw==
Received: by mail-ed1-f69.google.com with SMTP id u1-20020aa7d981000000b0042acd1f2253so15156916eds.4
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 09:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d8wzs0GJmElvjOENQNOKSUNkK9vo5WqYmuRjW9+dNXI=;
        b=Vw/vfpRMyWmBJnQVGFh0bUkG3rsm/kCb3PTqkbmcDWmZ7Bj9ngG6Eu4RmRzcpdOueT
         2QDcuK0YscKX5cOJXKVShyUvxISMrC0//IBTkHoKxf97unnt1CjNDAqT3PrpHhhX2VHD
         v42qrHGyZaMyJ88TvF2Ddui80cL7C9w9m+teyfCqpYQ2MZgicT+Ls+KITS5IWpTFMKMR
         +NdgHhigbO1UTNsVt0f3Igqoufqcf/Z25/32NDn3B0FponVaYrClnYSOXiqe5CE9+UTO
         Fo1+L7Zhf76DmsZvlvyPc9kncY3Mst20JdQBSL7Bx1G47YxSkFHl/r5Uzr3UndNYmF2I
         8ArQ==
X-Gm-Message-State: AOAM530RQwvMqp6vp4UU0XJKzbj8BfMSwIKQQ6MY9I0r8faTYNuPcfC4
        ZbobHGeor/2JTSenUC9GZxd3pRyH4T80ftWCkSas9ozPxgRAnYXtLuZAhX1ui1GG12ayxfuQK35
        vSrzpdLefaYq865gJORKJh3554lNgAuDxW4UuHw==
X-Received: by 2002:a05:6402:1914:b0:42b:73ae:e082 with SMTP id e20-20020a056402191400b0042b73aee082mr14382693edz.31.1653494948054;
        Wed, 25 May 2022 09:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpqXsCgcavHTP6/CfZQf4opU8VPdadSWqUfI+xqHjR9H80zRw2o39oJtqvERVspav9HAZUAA==
X-Received: by 2002:a05:6402:1914:b0:42b:73ae:e082 with SMTP id e20-20020a056402191400b0042b73aee082mr14382654edz.31.1653494947825;
        Wed, 25 May 2022 09:09:07 -0700 (PDT)
Received: from [192.168.123.67] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id vw13-20020a170907058d00b006feec47dae7sm2963066ejb.149.2022.05.25.09.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:09:06 -0700 (PDT)
Message-ID: <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
Date:   Wed, 25 May 2022 18:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com>
 <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/25/22 17:48, Ard Biesheuvel wrote:
> On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> wrote:
>>
>> The boot-hartid can be a 64bit value on RV64 platforms. Currently,
>> the "boot-hartid" in DT is assumed to be 32bit only. This patch
>> detects the size of the "boot-hartid" and uses 32bit or 64bit
>> FDT reads appropriately.
>>
>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>> ---
>>   drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
>> index 9e85e58d1f27..d748533f1329 100644
>> --- a/drivers/firmware/efi/libstub/riscv-stub.c
>> +++ b/drivers/firmware/efi/libstub/riscv-stub.c
>> @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
>>   {
>>          const void *fdt;
>>          int chosen_node, len;
>> -       const fdt32_t *prop;
>> +       const void *prop;
>>
>>          fdt = get_efi_config_table(DEVICE_TREE_GUID);
>>          if (!fdt)
>> @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
>>                  return -EINVAL;
>>
>>          prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
>> -       if (!prop || len != sizeof(u32))
>> +       if (!prop)
>> +               return -EINVAL;
>> +
>> +       if (len == sizeof(u32))
>> +               hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
>> +       else if (len == sizeof(u64))
>> +               hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
> 
> Does RISC-V care about alignment? A 64-bit quantity is not guaranteed
> to appear 64-bit aligned in the DT, and the cast violates C alignment
> rules, so this should probably used get_unaligned_be64() or something
> like that.

When running in S-mode the SBI handles unaligned access but this has a 
performance penalty.

We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.

Best regards

Heinrich

> 
> 
>> +       else
>>                  return -EINVAL;
>>
>> -       hartid = fdt32_to_cpu(*prop);
>>          return 0;
>>   }
>>
>> --
>> 2.25.1
>>

