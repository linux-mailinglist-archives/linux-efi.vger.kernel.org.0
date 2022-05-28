Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CA7536BE7
	for <lists+linux-efi@lfdr.de>; Sat, 28 May 2022 11:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiE1J0i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 May 2022 05:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiE1J0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 May 2022 05:26:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF7E6423
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 02:26:33 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30E843FBF9
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653729992;
        bh=51HZ/ZF/DBZUi+hYAZR96Rw1JBH9NEA5/WPL/bsRkcs=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IbWt7EywTX/wYiCw+Dao7QAouHWfhPgbX4fU7IRKpBXkk+jq2+4otGMpC1zHG/xO8
         R5WOQZ7NfkS5mlL1qUjYnV3Spc3yyALKhFSBkujAcZ+pOgoB4OWBP6w4FweqISPjba
         PhGlWbC3kj48J1Ed5fnI5TpjF0EUwts29ZZXhnuv4WCaPcw9wGVzBhzUa1oxQm1vmi
         8Lqdoq3ouqRT1AZIMQpv0/7WgAftJuKOR85muP+OdK7jqHbAUhIGZoIxYWjXduF7KC
         Wc4/Al8E+FGsly2RH4Z2ERCxCSz/eEZGdeLM2xqViSEi//jV6oF6cBDDQIOA8W93Iv
         Mq3PDJskqoZdQ==
Received: by mail-ed1-f69.google.com with SMTP id u19-20020a056402065300b0042d92237184so1155377edx.8
        for <linux-efi@vger.kernel.org>; Sat, 28 May 2022 02:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=51HZ/ZF/DBZUi+hYAZR96Rw1JBH9NEA5/WPL/bsRkcs=;
        b=wAJd2WPsxZNGJLlKq9yyI8NYC0FFez4iAwiUY+OzWTh/PANmmP3j+W91MSYUyicETU
         bfGNhBGemBr/iq56CR8iWRJqnvTNuV0DVW3X+MHj3GiY/1jwmqlWo/zUz6h1HMeu13S2
         gzL9+DdfczIjMbOKWazHOJHXMNWtGnfUIojc95K6gNxo5h3LDTQXuQpVjyaW3k+Jx1As
         TnAa3UoCDqA0QjTChGNehLaFZUz/L9xKRN42GZj3w2rieoP4y8E23XzLtCURQAN8kmRH
         cug93MNQIcCGawGpEEH6jhNGj9GsMloStxO1ol7cl0sIz48zvhIamMcmr40zqz/19Yx4
         VSfA==
X-Gm-Message-State: AOAM5339CN0gH/rtVM9a/lnx8GzuTyOD/khl/V3EQQ7zV67NZX0G0r4N
        DsbKeIsQO6cnl9g7kD5mW5IlWV9HzRorOEkSKWuV2J2JEanrZBHL4eaWeEZiT7bwGenlMMymJeV
        iBYWi+zkHW+XyadSdaUxoVRyyJlOEC8ocAx9XNA==
X-Received: by 2002:a17:907:6e12:b0:6fe:c2fd:89b7 with SMTP id sd18-20020a1709076e1200b006fec2fd89b7mr28883571ejc.581.1653729991235;
        Sat, 28 May 2022 02:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTIoHfWrOT9U2e85CFhK4imRJ1Ycox2VrkT/sTmCYMzAKvkrW+16CaVVHurj+g2SGaWKw6qQ==
X-Received: by 2002:a17:907:6e12:b0:6fe:c2fd:89b7 with SMTP id sd18-20020a1709076e1200b006fec2fd89b7mr28883553ejc.581.1653729990956;
        Sat, 28 May 2022 02:26:30 -0700 (PDT)
Received: from [192.168.123.94] (ip-062-143-094-109.um16.pools.vodafone-ip.de. [62.143.94.109])
        by smtp.gmail.com with ESMTPSA id w24-20020a50d798000000b0042db87b5ff4sm607240edi.88.2022.05.28.02.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 May 2022 02:26:30 -0700 (PDT)
Message-ID: <7b93efe6-fb54-d6f8-dd3b-3fb260652f15@canonical.com>
Date:   Sat, 28 May 2022 11:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] riscv: read-only pages should not be writable
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20220528014132.91052-1-heinrich.schuchardt@canonical.com>
 <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXGmwwD==yOnzfYgPg8Bpz1POK7aPBULcuMdgS-E1G2EAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 5/28/22 11:13, Ard Biesheuvel wrote:
> On Sat, 28 May 2022 at 03:41, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> If EFI pages are marked as read-only,
>> we should remove the _PAGE_WRITE flag.
>>
>> The current code overwrites an unused value.
>>
>> Fixes: b91540d52a08b ("RISC-V: Add EFI runtime services")
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/kernel/efi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
>> index 024159298231..1aa540350abd 100644
>> --- a/arch/riscv/kernel/efi.c
>> +++ b/arch/riscv/kernel/efi.c
>> @@ -65,7 +65,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
>>
>>          if (md->attribute & EFI_MEMORY_RO) {
>>                  val = pte_val(pte) & ~_PAGE_WRITE;
>> -               val = pte_val(pte) | _PAGE_READ;
>> +               val |= _PAGE_READ;
>>                  pte = __pte(val);
>>          }
>>          if (md->attribute & EFI_MEMORY_XP) {
>> --
>> 2.36.1
>>
> 
> Thanks Heinrich
> 
> Queued in efi/urgent.

I guess this should also be down-ported to 5.15 and 5.10.

Best regards

Heinrich
