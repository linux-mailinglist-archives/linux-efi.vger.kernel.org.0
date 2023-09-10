Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43122799F23
	for <lists+linux-efi@lfdr.de>; Sun, 10 Sep 2023 19:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjIJRpz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 10 Sep 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIJRpz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 10 Sep 2023 13:45:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B67138
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 10:45:50 -0700 (PDT)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C457E3F63B
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694367948;
        bh=VdNNx1qIrx0LeNAoHBCXNUMxzfpMt/YU+ldcvE4loG8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=sELmJ1as285hScaSpgkyI8GdvpIcWEk0OjMjGLrQIgMa/AgfbgC9rJ0rtMDNkBLU6
         QQA8E74pTxFHBmLkX+qjJfNq+DPzkgIo0ACCiZ1U8q372Mhc0X1khs3chGCz4ZTNLa
         iO0xXAlVOqs23wIdYTcbmYxAOW+78D71Y0Ojmr3UYIanKFdGqhuoAZY4D8/w4fcnot
         TjPf5eipiY4k2X0XsY4StjleUu/yVqTQDxC5LxJwJc1pxrfEdm2BNADH71/Oiug3qN
         LN3BPrG+Eps5YZRypD0L9hSuK+RR9TdhRyOSbAFrHCGn4nir7EDiJtEKkxodowQufI
         u3IEnSW1MUqHQ==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315af0252c2so2654962f8f.0
        for <linux-efi@vger.kernel.org>; Sun, 10 Sep 2023 10:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694367948; x=1694972748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdNNx1qIrx0LeNAoHBCXNUMxzfpMt/YU+ldcvE4loG8=;
        b=woYWwhOyEE7U8AigkFvyYK5qZ+TTwW1NVr045A3xUgSOocK+yUe5BolKn2lq7sMOrb
         z2Bx95oidWpZxlnkEiiWrLbTj2RMAYRMpEvbQQqpVjyBvG0HUDDciiDxzK/hujbcCPJj
         wAkbs977k3/5h5sSVAxK/S5apmHSSfYUb9jHHgMnkAGlSTp0Qc2tb5Ij6GqCUSkzVLxn
         Nyt900EKp7YpSILWRuX74SLmif0yZWzgjbVLO/n8kU0lNGG5spYnV/yPSQdMxefApeOu
         I/jkbPIImde7VhEeo/luMZS3gJDEaLEG5JVfk2261te3cYI7/tYak58ZOe7Oa1YKQv+9
         J84A==
X-Gm-Message-State: AOJu0Yyh1TRRnNGOAwqt388skhVqFcMEn8I8go8s3Dg3Kx9fFEI3gQ0v
        jvIKEQKU2UHGKdMlU1Yjd6TBZgqpv6M+3jZLhWSLzAEB3ayMEHDNcGNw05ZAXYFZtWC1FPLdjXN
        Dwg1JEl4P7v6M8L7+nv9TiXg88+K9gg1e/S1I2eb3KHpjGw==
X-Received: by 2002:a5d:4cc1:0:b0:31f:4173:2ac8 with SMTP id c1-20020a5d4cc1000000b0031f41732ac8mr5593404wrt.18.1694367948355;
        Sun, 10 Sep 2023 10:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa6sDYKMH3HkVInUxt9XgBYP9GmkX0cGcnVkgJTzjnvB7r4ITayGVrUDdNQKphMA0TLPxCLg==
X-Received: by 2002:a5d:4cc1:0:b0:31f:4173:2ac8 with SMTP id c1-20020a5d4cc1000000b0031f41732ac8mr5593386wrt.18.1694367947918;
        Sun, 10 Sep 2023 10:45:47 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d4c82000000b0031aca6cc69csm7826289wrs.2.2023.09.10.10.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 10:45:47 -0700 (PDT)
Message-ID: <0feac60d-99ec-45fb-8c5b-b1918ffae680@canonical.com>
Date:   Sun, 10 Sep 2023 19:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <CAMj1kXEh3=vzJiCe1hy3r55akqSn0+t1AGZNEF8wqWCR3_rRcg@mail.gmail.com>
 <CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com>
Content-Language: en-US, de-DE
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 9/10/23 15:54, Ard Biesheuvel wrote:
> On Sun, 10 Sept 2023 at 15:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Sun, 10 Sept 2023 at 06:53, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>>>
>>> Some firmware (notably U-Boot) provides GetVariable() and
>>> GetNextVariableName() but not QueryVariableInfo().
>>>
>>> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
>>> statfs syscall was broken for such firmware.
>>>
>>> If QueryVariableInfo() does not exist or returns an error, just report the
>>> file-system size as 0 as statfs_simple() previously did.
>>>
>>> Fixes: d86ff3333cb1 ("efivarfs: expose used and total size")
>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>> ---
>>> v2:
>>>          initialize remaining_space to 0
>>
>> Thanks for the patch, and apologies for the oversight.
>>
>>> ---
>>>   fs/efivarfs/super.c | 20 ++++++++++++--------
>>>   1 file changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
>>> index e028fafa04f3..3893aae6a9be 100644
>>> --- a/fs/efivarfs/super.c
>>> +++ b/fs/efivarfs/super.c
>>> @@ -29,14 +29,9 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>          const u32 attr = EFI_VARIABLE_NON_VOLATILE |
>>>                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
>>>                           EFI_VARIABLE_RUNTIME_ACCESS;
>>> -       u64 storage_space, remaining_space, max_variable_size;
>>> +       u64 storage_space, remaining_space = 0, max_variable_size;
>>
>> Shouldn't storage_space be set to 0 too?
>>
>>>          efi_status_t status;
>>>
>>> -       status = efivar_query_variable_info(attr, &storage_space, &remaining_space,
>>> -                                           &max_variable_size);
>>> -       if (status != EFI_SUCCESS)
>>> -               return efi_status_to_err(status);
>>> -
>>>          /*
>>>           * This is not a normal filesystem, so no point in pretending it has a block
>>>           * size; we declare f_bsize to 1, so that we can then report the exact value
>>> @@ -44,10 +39,19 @@ static int efivarfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>>           */
>>>          buf->f_bsize    = 1;
>>>          buf->f_namelen  = NAME_MAX;
>>> -       buf->f_blocks   = storage_space;
>>> -       buf->f_bfree    = remaining_space;
>>>          buf->f_type     = dentry->d_sb->s_magic;
>>>
>>> +       /* Some UEFI firmware does not implement QueryVariable() */
>>> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
>>> +               status = efivar_query_variable_info(attr, &storage_space,
>>> +                                                   &remaining_space,
>>> +                                                   &max_variable_size);
>>> +               if (status == EFI_SUCCESS) {
>>> +                       buf->f_blocks   = storage_space;
>>> +                       buf->f_bfree    = remaining_space;
>>> +               }
>>> +       }
>>> +
>>
>> I'd prefer not to ignore the error completely here. How about we do
>>
>> --- a/fs/efivarfs/super.c
>> +++ b/fs/efivarfs/super.c
>> @@ -32,10 +32,15 @@ static int efivarfs_statfs(struct dentry *dentry,
>> struct kstatfs *buf)
>>          u64 storage_space, remaining_space, max_variable_size;
>>          efi_status_t status;
>>
>> -       status = efivar_query_variable_info(attr, &storage_space,
>> &remaining_space,
>> -                                           &max_variable_size);
>> -       if (status != EFI_SUCCESS)
>> -               return efi_status_to_err(status);
>> +       /* Some UEFI firmware does not implement QueryVariableInfo() */
>> +       storage_space = remaining_space = 0;
>> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
>> +               status = efivar_query_variable_info(attr, &storage_space,
>> +                                                   &remaining_space,
>> +                                                   &max_variable_size);
>> +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
>> +                       return efi_status_to_err(status);
>> +       }
>>
>>          /*
>>           * This is not a normal filesystem, so no point in pretending
>> it has a block
>>
>> (no need to resend if you agree)

Hello Ard,

thanks for reviewing.

Raising an error in such a rare circumstance would be ok for me.

> 
> Actually, perhaps it would be better to simply fall back to the old
> logic if QueryVariableInfo is not provided:
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index e028fafa04f3..50b05f1fa974 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -30,10 +30,15 @@ static int efivarfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
>                           EFI_VARIABLE_RUNTIME_ACCESS;
>          u64 storage_space, remaining_space, max_variable_size;
> -       efi_status_t status;
> +       efi_status_t status = EFI_UNSUPPORTED;
> +
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO))
> +               status = efivar_query_variable_info(attr, &storage_space,
> +                                                   &remaining_space,
> +                                                   &max_variable_size);
> +       if (status == EFI_UNSUPPORTED)
> +               return simple_statfs(dentry, buf);

I would not know why the block size (buf->f_bsize) should depend on the 
availability of QueryVariableInfo() (1 vs PAGE_SIZE).

Hence I would prefer your suggestion to just add the error handling 
suggested in your previous mail.

Best regards

Heinrich

> 
> -       status = efivar_query_variable_info(attr, &storage_space,
> &remaining_space,
> -                                           &max_variable_size);
>          if (status != EFI_SUCCESS)
>                  return efi_status_to_err(status);
