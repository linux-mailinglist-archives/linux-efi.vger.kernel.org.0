Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E43599645
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347135AbiHSHlX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 03:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347105AbiHSHlV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 03:41:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B67CAC60
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:41:19 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02E6041FCD
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 07:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660894877;
        bh=Kz37seUbdlN/YJWW9C/vGCQuUNKhKzTQ6rInkuO+GQg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uw7BbWJxRhvkoTALhOrBcW7J4giWC/rHwNK2nwIXeTeThepSSDB1r1tPuwugEjehB
         kNc44S5xB7KydeEYTrBt2rJyABPG4kNgmzbodlm9v1jVbxBUPdEilboMfi5sem9CuY
         yGwFS0ylOnJxWwrObGaQIpPSYjmqMGXLtvAfXdAKBLtQYFo1yR8TVjSgZCn++Sz9ad
         NVxRiXXT2rTIi9O+asB7XE541GccocGhFrMcKv6+Sr88n9O+4I6BliAXV7MwOjvAhS
         k0U2EbFoa/2V5v0NiTJrHquik/90WS3pMqnBGdKvVmI5RIZCenRsbuR+yhk9Zyrw7Z
         JV0+njb+/pvow==
Received: by mail-wm1-f72.google.com with SMTP id j3-20020a05600c1c0300b003a5e72421c2so2209870wms.1
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 00:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Kz37seUbdlN/YJWW9C/vGCQuUNKhKzTQ6rInkuO+GQg=;
        b=4m/V1+XuzdvHOwa8L+ChcLdnnXXntbdZrAvtwqZ0TRrgQrVYHVAYRFqwIViOyRQ/u2
         d5n5uEX4UnVr0hn8EgZ3Jxo9kVQoAK/3mGK9NGZM1RjWxprAkUPcfKBsXBcvkO1ary6U
         YmJMWg5PX/pw7pXD0mac2lQTSCynh3RJf7TP8JQym0rnJ5jGEDRtGeLbLMk+G3wEHuEE
         kmxVWDvZjPc+2daLYusIJin1/9lqFqbi7B73PxZy2FVr647Pd5076eSC0rCUwZIZa3UE
         icOFPCTixfPLPvZfLRu9LipXNFAo/h/spRciCPx/zUTTFioOD8BvjdbtPXH6WkC334RW
         uMbA==
X-Gm-Message-State: ACgBeo2ts1GFGupX3ncURVAZCVn/GZLW6OiF+hBbfXm3vNOBpSfQgmhk
        42RZD969DjCldx5k6YUh/UtTxqeasHNRiz8E3b+UbuxspXgP5it3IgjLj1CsKz7OXncnpzft26z
        BLI35pdjjn6vZy9SiMxJQCy61URdIeC+u4+M10A==
X-Received: by 2002:a5d:6303:0:b0:225:2194:7181 with SMTP id i3-20020a5d6303000000b0022521947181mr3567494wru.614.1660894874848;
        Fri, 19 Aug 2022 00:41:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4dqewC65FRUPJ83ekHn6ZZwlJYhaMOIEPl/vpjakNt5ZGlZlbQFRFkfNc0GWZRsN93a8O3sQ==
X-Received: by 2002:a5d:6303:0:b0:225:2194:7181 with SMTP id i3-20020a5d6303000000b0022521947181mr3567468wru.614.1660894874479;
        Fri, 19 Aug 2022 00:41:14 -0700 (PDT)
Received: from [192.168.123.67] (ip-084-118-157-002.um23.pools.vodafone-ip.de. [84.118.157.2])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c4ecb00b003a4c6e67f01sm9205307wmq.6.2022.08.19.00.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 00:41:13 -0700 (PDT)
Message-ID: <2f741514-0791-6e82-d51c-f1a800f260f7@canonical.com>
Date:   Fri, 19 Aug 2022 09:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 4/6] efi/libstub: implement generic EFI zboot
Content-Language: en-US
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
 <f0660f09-94e6-3268-dc95-cb81d9c6f58a@canonical.com>
 <CAMj1kXFkDo7zHJ2csfRQpeXTWN2skw2yA_kso2Wu0tXQBKc=iA@mail.gmail.com>
 <607f3bb9-9d18-ba2a-3bea-88ae7be680c8@canonical.com>
 <CAMj1kXGchJNvsFPOW-_W1KgozSyyT_vE=PQiJmRH6NE3wbC7CA@mail.gmail.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMj1kXGchJNvsFPOW-_W1KgozSyyT_vE=PQiJmRH6NE3wbC7CA@mail.gmail.com>
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

On 8/19/22 09:07, Ard Biesheuvel wrote:
> On Fri, 19 Aug 2022 at 09:01, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 8/19/22 08:52, Ard Biesheuvel wrote:
>>> On Fri, 19 Aug 2022 at 07:29, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/18/22 19:10, Ard Biesheuvel wrote:
>>>>> On Thu, 18 Aug 2022 at 18:42, Heinrich Schuchardt
>>>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>>>
>>>>>> On 8/17/22 13:03, Ard Biesheuvel wrote:
>>>>>>> Implement a minimal EFI app that decompresses the real kernel image and
>>>>>>> launches it using the firmware's LoadImage and StartImage boot services.
>>>>>>> This removes the need for any arch-specific hacks.
>>>>>>>
>>>>>>> Note that on systems that have UEFI secure boot policies enabled,
>>>>>>> LoadImage/StartImage require images to be signed, or their hashes known
>>>>>>> a priori, in order to be permitted to boot.
>>>>>>>
>>>>>>> There are various possible strategies to work around this requirement,
>>>>>>> but they all rely either on overriding internal PI/DXE protocols (which
>>>>>>> are not part of the EFI spec) or omitting the firmware provided
>>>>>>> LoadImage() and StartImage() boot services, which is also undesirable,
>>>>>>> given that they encapsulate platform specific policies related to secure
>>>>>>> boot and measured boot, but also related to memory permissions (whether
>>>>>>> or not and which types of heap allocations have both write and execute
>>>>>>> permissions.)
>>>>>>>
>>>>>>> The only generic and truly portable way around this is to simply sign
>>>>>>> both the inner and the outer image with the same key/cert pair, so this
>>>>>>> is what is implemented here.
>>>>>>>
>>>>>>> BZIP2 has been omitted from the set of supported compression algorithms,
>>>>>>> given that its performance is mediocre both in speed and size, and it
>>>>>>> uses a disproportionate amount of memory. For optimal compression, use
>>>>>>> LZMA. For the fastest boot speed, use LZO.
>>>>>>>
>>>>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>>>>> ---
>>>>>>>      drivers/firmware/efi/Kconfig                |  31 ++++-
>>>>>>>      drivers/firmware/efi/libstub/Makefile       |   8 +-
>>>>>>>      drivers/firmware/efi/libstub/Makefile.zboot |  69 ++++++++++
>>>>>>>      drivers/firmware/efi/libstub/zboot-header.S | 139 ++++++++++++++++++++
>>>>>>>      drivers/firmware/efi/libstub/zboot.c        | 101 ++++++++++++++
>>>>>>>      drivers/firmware/efi/libstub/zboot.lds      |  39 ++++++
>>>>>>>      6 files changed, 382 insertions(+), 5 deletions(-)
>>>>>>>
>>>>> ...
>>>>>>> diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..9cf968e90775
>>>>>>> --- /dev/null
>>>>>>> +++ b/drivers/firmware/efi/libstub/zboot.c
>>>>> ...
>>>>>>> +efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
>>>>>>> +                                   efi_system_table_t *systab)
>>>>>>> +{
>>>>>>> +     static efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
>>>>>>> +     efi_loaded_image_t *parent, *child;
>>>>>>> +     unsigned long image_buffer;
>>>>>>> +     efi_handle_t child_handle;
>>>>>>> +     efi_status_t status;
>>>>>>> +     int ret;
>>>>>>> +
>>>>>>> +     WRITE_ONCE(efi_system_table, systab);
>>>>>>> +
>>>>>>> +     free_mem_ptr = (unsigned long)&zboot_heap;
>>>>>>> +     free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
>>>>>>> +
>>>>>>> +     status = efi_bs_call(handle_protocol, handle, &loaded_image,
>>>>>>> +                          (void **)&parent);
>>>>>>> +     if (status != EFI_SUCCESS) {
>>>>>>> +             log(L"Failed to locate parent's loaded image protocol\n");
>>>>>>> +             return status;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
>>>>>>> +     if (status != EFI_SUCCESS) {
>>>>>>> +             log(L"Failed to allocate memory\n");
>>>>>>> +             return status;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     ret = __decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
>>>>>>> +                        NULL, (unsigned char *)image_buffer, 0, NULL,
>>>>>>> +                        error);
>>>>>>> +     if (ret < 0) {
>>>>>>> +             log(L"Decompression failed\n");
>>>>>>> +             return EFI_LOAD_ERROR;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     status = efi_bs_call(load_image, false, handle, NULL,
>>>>>>
>>>>>> I would prefer to pass the device path of the compressed image instead
>>>>>> of NULL. This way information is not lost.
>>>>>>
>>>>>
>>>>> That way, we will have two loaded images with different handles
>>>>> claiming to be loaded from the same device path - I don't think that
>>>>> is appropriate tbh.
>>>>
>>>> They both are the product of the same file on disk.
>>>>
>>>
>>> But they are not the same. When re-loading the device path (as you
>>> suggest below) you will get a completely different file, and the only
>>> way to get at the payload is to execute it.
>>>
>>> So using the same device path is out of the question imo.
>>
>> How about appending a VenHW() node with a decompressor specific GUID at
>> the end of the DP?
>>
>> I think that is the most UEFIish way to express that the handle is
>> derived from the compressed file.
>>
>> You could even put additional information into the VenHW() node like the
>> compression type or the compressed size.
>>
> 
> Uhm, yes, that is what I am proposing further down in this email.
> 
> See below.
> 
>>>
>>>>>
>>>>> What we could do is define a vendor GUID for the decompressed kernel,
>>>>> and create a device path for it. That way, you can grab the
>>>>> loaded_image of the parent to obtain this information.
>>>>>
>>>>> What did you have in mind as a use case?
>>>>
>>>> The device-path could be used in the kernel log.
>>>>
>>>> It can be used to find the device or folder with initrd where we use
>>>> initrd= on the command line.
>>>>
>>>> You could use the device path to access the original file, e.g. to read
>>>> additional information.
>>>>
>>>> For all use cases you would want to have the original device path.
>>>>
>>>
>>> What we could do is:
>>>
>>> - define a device path in the decompressor, e.g.,
>>>
>>> <original device path>/Offset(<start>, <end>)/VendorMedia(xxx-xxx-xxx,
>>> <compression type>)
>>>
>>> where start, end and compression type describe the compressed payload
>>> inside the decompressor executable. (The compression type could be
>>> omitted, or could be a separate node.)
>>>
>>> - install the LoadFile2 protocol and the device path protocol onto a
>>> handle, and move the decompression logic into the LoadFile2
>>> implementation

Why would you create a LoadFile2 implementation if the decompressor is 
the only user? In this case I think an internal function call is more 
adequate.

A LoadFile2 protocol would make sense if the compressed image contains 
both a compressed kernel and the initrd and you wanted to provide the 
initrd via the LoadFile2 protocol.

For Iot use cases it would make sense to have a standalone process which 
you can use to:

* compress a kernel
* create a binary containing
* * a prepended decompressor binary
* * the compressed kernel
* * an optional initrd
* * an optional device-tree
* sign the complete file

At runtime the decompressor would:

* decompress the kernel
* create a LoadFile2 protocol for the initrd
* call the firmware to fix-up the device-tree
* install the fixed-up device-tree
* invoke the EFI stub of the kernel

This way we could have one binary where all relevant components are 
inside a single signed image.

Best regards

Heinrich

>>>
>>> - drop the SourceBuffer and SourceSize arguments to LoadImage(), and
>>> pass the device path instead, so that LoadFile2 will be invoked by
>>> LoadImage directly to perform the decompression.
>>>
>>> That way, we retain the information about the outer file, and each
>>> piece is described in detail in device path notation. As a bonus, we
>>> could easily expose the compressed part separately, if there is a need
>>> for that.
>>>
>>> This doesn't cover the initrd= issue you raised, but that is something
>>> we could address later in the stub if we wanted to (but I don't think
>>> initrd= is something we should care too much about)
>>

