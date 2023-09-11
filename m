Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8379A4EF
	for <lists+linux-efi@lfdr.de>; Mon, 11 Sep 2023 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjIKHs1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Sep 2023 03:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjIKHs0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Sep 2023 03:48:26 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04895CE3
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 00:47:51 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC4843F5DC
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 07:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694418400;
        bh=IPxNhe9yzpK5O52TUCbZ/EbR8ChkH7a/aRDhzHHm/WA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=hXuOxx41YUyxeZ1IgozM8eFQwQxKcERSO722M8NO490ZJ/8vsEOktlNOhtPHdCbCc
         gbIAfGkrBXewcTV2rzorpX00cOrJ1Nb0FCGFN+wS8A6yMs7Znz/62yYr5qE1Y1eXTj
         ePZJELjlz7UkCH2ID8eyzIRgbO4kmgKS4yX5A86RPWwRkMLYLt7QzERb1vazb73/yU
         Vb8gGYx9Hr6zk1kjLS7b/NE3SwMfgXRYk0h+osy1ztJLAQtEVnq2V1Z9M0KVGd2MLU
         hx+IJ4K7E/Xom6kzd9TkWVrjBEitcDXSoBoRjj7KF7Z+y24YA87jjQnmlfrPh/FW6m
         B78aJi6s+hIiQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fd0fa4d08cso30980675e9.1
        for <linux-efi@vger.kernel.org>; Mon, 11 Sep 2023 00:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694418400; x=1695023200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPxNhe9yzpK5O52TUCbZ/EbR8ChkH7a/aRDhzHHm/WA=;
        b=CNWVMFK6IA8XOQZHUhtmcTkR7rL1z083uV+ot8UkaT4X9uBQ5PzEMsNlCulB47nVtv
         RRkK56ZRI6XRIwSvc9ky1fKcBHzBtxW/CMG9tttL6/qX2zjN9o1gBP7gUTiMkfdnWHh2
         3sNnI7DbqGO7gzqhlTLiwypU8s7GtTGUatlt4PwWwp1hhpAuzT7jfnyEBb61q0+EiiT6
         GLfaF2Byxxv3GWQUfW0wANelRn0VG0MeWlMrT0zFkos9HemaCP7iXmjXhXew8FH4jwLu
         K+WPcSx0s+f6Gg5QObGmMgj5MsW+EO4fOu/Q7ub+Ic9kHn/kTA08biFyA5lttbmkrNaq
         ui4g==
X-Gm-Message-State: AOJu0Yz7ksySJKLK8iNwOljqYswY7mHpLq98gYkBdmZHtRmEkUuhHgn/
        ArkHdqnpa2oDNV/sSvihku8kJeThsLXpXpEXyg/23girvrqX8Kp1J6QSTvjHXtt7LBLygTpJGfy
        Ux4Gd+9Vp30pGHpItCC8rUMeq5Fs9bsFuNoXr3C94syKXjQ==
X-Received: by 2002:a7b:cc8f:0:b0:401:d5bb:9b40 with SMTP id p15-20020a7bcc8f000000b00401d5bb9b40mr7864218wma.15.1694418400607;
        Mon, 11 Sep 2023 00:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBR25riedYFwjDgILjYdbNzDPPyrpVfLqCp+IsQt6sVUU1sRcksZotaCsCxa4fVAQSzFajBw==
X-Received: by 2002:a7b:cc8f:0:b0:401:d5bb:9b40 with SMTP id p15-20020a7bcc8f000000b00401d5bb9b40mr7864208wma.15.1694418400176;
        Mon, 11 Sep 2023 00:46:40 -0700 (PDT)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b00402c0a8a084sm12409865wmj.17.2023.09.11.00.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 00:46:39 -0700 (PDT)
Message-ID: <27e76823-5464-4fd7-844d-7ed273a8a902@canonical.com>
Date:   Mon, 11 Sep 2023 09:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efivarfs: fix statfs() on efivarfs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Anisse Astier <anisse@astier.eu>, Jeremy Kerr <jk@ozlabs.org>,
        Anisse Astier <an.astier@criteo.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20230910045445.41632-1-heinrich.schuchardt@canonical.com>
 <ZP4QEvhzO5cOt6lT@gpdmax>
 <1bc137b6-6006-42cd-9f6d-c523fc753d63@canonical.com>
 <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXGChp5TOk5h1EC9R7TBn=QDVo_FU5VhHjp8nSz2GJ6wtA@mail.gmail.com>
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

On 9/11/23 08:45, Ard Biesheuvel wrote:
> On Sun, 10 Sept 2023 at 22:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 9/10/23 20:53, Anisse Astier wrote:
>>> Hi Heinrich,
>>>
>>> On Sun, Sep 10, 2023 at 06:54:45AM +0200, Heinrich Schuchardt wrote:
>>>> Some firmware (notably U-Boot) provides GetVariable() and
>>>> GetNextVariableName() but not QueryVariableInfo().
>>>
>>>   From a quick search, it seems u-boot, does support QueryVariableInfo, is
>>> it on a given version ?
>>>
>>> https://elixir.bootlin.com/u-boot/v2023.07.02/source/lib/efi_loader/efi_variable.c#L391
>>
>> QueryVariableInfo() and SetVariable() are available before
>> ExitBootServices(), i.e. in Linux' EFI stub.
>>
>> ExitBootServices() results in calling efi_variables_boot_exit_notify()
>> which disables these services during the UEFI runtime.
>>
>>>
>>>>
>>>> With commit d86ff3333cb1 ("efivarfs: expose used and total size") the
>>>> statfs syscall was broken for such firmware.
>>>
>>> Could you be more specific ? What breaks, and what regressed ? I imagine
>>> it could be some scripts running df, but maybe you had something else in
>>> mind ?
>>
>> Some more details can be found in
>> https://bugs.launchpad.net/ubuntu/+source/linux-meta-riscv/+bug/2034705.
>>
>> Though EFI variables are exposed via GetVariable() and
>> GetNextVariableName() the efivar command refuses to display variables
>> when statfs() reports an error.
>>
>>>
>>>>
>>>> If QueryVariableInfo() does not exist or returns an error, just report the
>>>> file-system size as 0 as statfs_simple() previously did.
>>>
>>> I considered doing this [2] , but we settled on returning an error
>>> instead for clarity:
>>> https://lore.kernel.org/linux-efi/20230515-vorgaben-portrait-bb1b4255d31a@brauner/
>>>
>>> I still think it would be a good idea if necessary.
>>
>> We should never break user APIs.
>>
> 
> Indeed.
> 
>>>
>>> On the approach, I prefer what Ard proposed, to fall back to the old
>>> approach. I think the difference in block size could also be a good
>>> marker that something wrong is happening:
>>> https://lore.kernel.org/linux-efi/CAMj1kXEkNSoqG4zWfCZ8Ytte5b2SzwXggZp21Xt17Pszd-q0dg@mail.gmail.com/
>>
>> This will allow user code making assumptions based on block size:
>> If block size > 1, assume setting variables is possible.
>>
>> We should really avoid this.
>>
> 
> I agree that having different block sizes depending on which code path
> is taken is not great. But that is the situation we are already in,
> given that older kernels will always report PAGE_SIZE. And actually,
> PAGE_SIZE does not make sense either - PAGE_SIZE could be larger than
> 4k on ARM for instance, so the efivarfs block size will be dependent
> on the page size of the kernel you happened to boot.
> 
> So I think we should go with the below:
> 
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -32,10 +32,16 @@ static int efivarfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>          u64 storage_space, remaining_space, max_variable_size;
>          efi_status_t status;
> 
> -       status = efivar_query_variable_info(attr, &storage_space,
> &remaining_space,
> -                                           &max_variable_size);
> -       if (status != EFI_SUCCESS)
> -               return efi_status_to_err(status);
> +       /* Some UEFI firmware does not implement QueryVariableInfo() */
> +       storage_space = remaining_space = 0;
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_QUERY_VARIABLE_INFO)) {
> +               status = efivar_query_variable_info(attr, &storage_space,
> +                                                   &remaining_space,
> +                                                   &max_variable_size);
> +               if (status != EFI_SUCCESS && status != EFI_UNSUPPORTED)
> +                       pr_warn_ratelimited("query_variable_info()
> failed: 0x%lx\n",
> +                                           status);

Adding a warning here is helpful. The else branch would be:

+		} else {
+			buf->f_blocks	= storage_space;
+			buf->f_bfree	= remaining_space;
+		}

Best regards

Heinrich

> +       }
> 
>          /*
>           * This is not a normal filesystem, so no point in pretending
> it has a block

