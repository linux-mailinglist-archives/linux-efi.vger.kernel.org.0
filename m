Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079059948E
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 07:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244451AbiHSF3c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 01:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345200AbiHSF3c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 01:29:32 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F0ADAA30
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 22:29:30 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1B1D40AC0
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 05:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660886968;
        bh=xER6TRnTrBNwXD6+HBKnwmIzOz2ZnqY5jCAgXSVTrrU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kPeAxc/naK7Y67zCDUhtKhLqq81Yi/b8X8a+JaloA20An2faPDi864KXsTC/SX2gQ
         3V9/Zh2Nymho3tbwj7eAplh+OCwprzNMgkIK5Rryfv1Aq8OJIzAqlhOpB/bt8I69oU
         /7srkNCIQk6Xrp7DsMGvGkSzscpRx8+r/VtujJHz+PStrGZmOIUrHSx17Coiuiv1AX
         7Eb1xiQNbVw8WDEPeWMwICl9QUUQgxJB/iXBxuSC01xasNZGYfsZxHtWj1bfzdc3HS
         SuFM08UV6UoPd7y8IIE+E0Mj1sLZXA2SCTJRAvxGwvQ83Xt67cURUCTaUW8xY/8YFR
         48X9c5//XiGfQ==
Received: by mail-ed1-f71.google.com with SMTP id x20-20020a05640226d400b0043d50aadf3fso2239838edd.23
        for <linux-efi@vger.kernel.org>; Thu, 18 Aug 2022 22:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=xER6TRnTrBNwXD6+HBKnwmIzOz2ZnqY5jCAgXSVTrrU=;
        b=v7UdE971iDefO9Q6+BAmzZvessiFGsvZWJECZx6Bsks1aIw2jhkI0ox0IGhlUhqZjg
         e4i2Igf/aYLfDKYto+TsOqykfwM8sJg2fYNLniiYpJYglqA96PBmJKhf9urBg65ngtc0
         TVy7n8YNvpEIVeVAIZLvL7mD9WYlKJF1hW2wc1r+XKpGeNumNoE60xlP2e3sIdLeaReh
         EO4K2qWiGkmOCUqMlysMHBCDcnIXAcGBOzNbcGbkkvYzvsi7xKafXP8rpUAefgXrAVxr
         82fh3n+nTX6uP4iWQ7vRpO7eKrODK9+hfqsyZ4pWVKp2YbgyvTjARGFmdf+KGwQg0RBB
         Ny4g==
X-Gm-Message-State: ACgBeo1XpGjtlKN3nzbOAfm9pdXTEFq/Bw/bs+/rp1VJ0MzwauC2vkUi
        7DCtgWaSX9/TjUnni309/A2BUdqRlt6cpqEh1y81yQAEJMKl7Eq9oiGzrWpKylkdLcODQCgFQW5
        xIBa5CIVr/2k/qAmVKXRsXY8oypqSnI8RjjXyYQ==
X-Received: by 2002:a17:907:9484:b0:738:6f9f:6032 with SMTP id dm4-20020a170907948400b007386f9f6032mr3802929ejc.602.1660886967498;
        Thu, 18 Aug 2022 22:29:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7jINqlf+Q4vunXodQj13LIWEPCSdrbbF1YAngDNkYlPljntBkbjGnri2FgnTuLKp98dfzibw==
X-Received: by 2002:a17:907:9484:b0:738:6f9f:6032 with SMTP id dm4-20020a170907948400b007386f9f6032mr3802910ejc.602.1660886967190;
        Thu, 18 Aug 2022 22:29:27 -0700 (PDT)
Received: from [192.168.123.94] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402101700b00445b3cab975sm2391157edu.56.2022.08.18.22.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 22:29:26 -0700 (PDT)
Message-ID: <f0660f09-94e6-3268-dc95-cb81d9c6f58a@canonical.com>
Date:   Fri, 19 Aug 2022 07:29:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-efi@vger.kernel.org
References: <20220817110345.1771267-1-ardb@kernel.org>
 <20220817110345.1771267-5-ardb@kernel.org>
 <97c62ac5-46c5-c0cd-3226-07a28051a750@canonical.com>
 <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
Content-Language: en-US
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXHgnsGWscVFs_HQ_tLmoLAgcORC8k5Y0K_1m-XZWsxqMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 8/18/22 19:10, Ard Biesheuvel wrote:
> On Thu, 18 Aug 2022 at 18:42, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 8/17/22 13:03, Ard Biesheuvel wrote:
>>> Implement a minimal EFI app that decompresses the real kernel image and
>>> launches it using the firmware's LoadImage and StartImage boot services.
>>> This removes the need for any arch-specific hacks.
>>>
>>> Note that on systems that have UEFI secure boot policies enabled,
>>> LoadImage/StartImage require images to be signed, or their hashes known
>>> a priori, in order to be permitted to boot.
>>>
>>> There are various possible strategies to work around this requirement,
>>> but they all rely either on overriding internal PI/DXE protocols (which
>>> are not part of the EFI spec) or omitting the firmware provided
>>> LoadImage() and StartImage() boot services, which is also undesirable,
>>> given that they encapsulate platform specific policies related to secure
>>> boot and measured boot, but also related to memory permissions (whether
>>> or not and which types of heap allocations have both write and execute
>>> permissions.)
>>>
>>> The only generic and truly portable way around this is to simply sign
>>> both the inner and the outer image with the same key/cert pair, so this
>>> is what is implemented here.
>>>
>>> BZIP2 has been omitted from the set of supported compression algorithms,
>>> given that its performance is mediocre both in speed and size, and it
>>> uses a disproportionate amount of memory. For optimal compression, use
>>> LZMA. For the fastest boot speed, use LZO.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>    drivers/firmware/efi/Kconfig                |  31 ++++-
>>>    drivers/firmware/efi/libstub/Makefile       |   8 +-
>>>    drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
>>>    drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
>>>    drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
>>>    drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
>>>    6 files changed, 382 insertions(+), 5 deletions(-)
>>>
> ...
>>> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
>>> new file mode 100644
>>> index 000000000000..9cf968e90775
>>> --- /dev/null
>>> +++ b/drivers/firmware/efi/libstub/zboot.c
> ...
>>> +efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
>>> +                                   efi_system_table_t *systab)
>>> +{
>>> +     static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
>>> +     efi_loaded_image_t *parent, *child;
>>> +     unsigned long image_buffer;
>>> +     efi_handle_t child_handle;
>>> +     efi_status_t status;
>>> +     int ret;
>>> +
>>> +     WRITE_ONCE(efi_system_table, systab);
>>> +
>>> +     free_mem_ptr = (unsigned long)&zboot_heap;
>>> +     free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
>>> +
>>> +     status = efi_bs_call(handle_protocol, handle, &loaded_image,
>>> +                          (void **)&parent);
>>> +     if (status != EFI_SUCCESS) {
>>> +             log(L"Failed to locate parent's loaded image protocol\n");
>>> +             return status;
>>> +     }
>>> +
>>> +     status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
>>> +     if (status != EFI_SUCCESS) {
>>> +             log(L"Failed to allocate memory\n");
>>> +             return status;
>>> +     }
>>> +
>>> +     ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
>>> +                        NULL, (unsigned char *)image_buffer, 0, NULL,
>>> +                        error);
>>> +     if (ret < 0) {
>>> +             log(L"Decompression failed\n");
>>> +             return EFI_LOAD_ERROR;
>>> +     }
>>> +
>>> +     status = efi_bs_call(load_image, false, handle, NULL,
>>
>> I would prefer to pass the device path of the compressed image instead
>> of NULL. This way information is not lost.
>>
> 
> That way, we will have two loaded images with different handles
> claiming to be loaded from the same device path - I don't think that
> is appropriate tbh.

They both are the product of the same file on disk.

> 
> What we could do is define a vendor GUID for the decompressed kernel,
> and create a device path for it. That way, you can grab the
> loaded_image of the parent to obtain this information.
> 
> What did you have in mind as a use case?

The device-path could be used in the kernel log.

It can be used to find the device or folder with initrd where we use 
initrd= on the command line.

You could use the device path to access the original file, e.g. to read 
additional information.

For all use cases you would want to have the original device path.

Best regards

Heinrich

> 
>>> +                          (void *)image_buffer, uncompressed_size,
>>> +                          &child_handle);
>>> +     if (status != EFI_SUCCESS) {
>>> +             log(L"Failed to load image\n");
>>> +             return status;
>>> +     }
>>> +
>>> +     status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
>>> +                          (void **)&child);
>>> +     if (status != EFI_SUCCESS) {
>>> +             log(L"Failed to locate child's loaded image protocol\n");
>>> +             return status;
>>> +     }
>>> +
>>> +     // Copy the kernel command line
>>> +     child->load_options = parent->load_options;
>>> +     child->load_options_size = parent->load_options_size;
>>> +
>>> +     status = efi_bs_call(start_image, child_handle, NULL, NULL);
>>> +     if (status != EFI_SUCCESS) {
>>> +             log(L"StartImage() returned with error\n");
>>
>> Please, pass pointers for ExitDataSize and ExitData. If ExitDataSize !=
>> 0 a string is provided in ExitData. Return that data to the caller of
>> the compressed image. You may additionally print the string here.
>>
>> The caller then will then take care of freeing ExitData (via FreePool())
>> and optionally log the information.
>>
> 
> Good idea, I will add that.
> 
> Thanks,
> Ard.
