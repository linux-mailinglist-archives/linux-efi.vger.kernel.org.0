Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB8160FE9
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgBQK07 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 05:26:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729252AbgBQK06 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 05:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581935217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvztgHHdXJpn4KfypwkzWXcDhEJB7aBlhb6kVJm8K3M=;
        b=I2w1Ccsr2FlSih/GaPUnGT3aYC9YGazIuj4m4fSEObqVr6kcI0jQ7zCk+gzj5a96n+LBfw
        786KULRsgnkQkXkxytDf94BTo2TJekBmRBtaMuHDM1ynf8K6x4EMGAVx/kWWYO/vl50TPQ
        tnRmQ3C0RtlejqRDefMfcQgOR8bIlQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-jB-rg9oTM0ucKan7Xs5aiw-1; Mon, 17 Feb 2020 05:26:55 -0500
X-MC-Unique: jB-rg9oTM0ucKan7Xs5aiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB147DBBC;
        Mon, 17 Feb 2020 10:26:52 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-195.ams2.redhat.com [10.36.116.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 943D6867F9;
        Mon, 17 Feb 2020 10:26:49 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] efi/libstub: Add support for loading the initrd
 from a device path
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Lukas Wunner <lukas@wunner.de>
References: <20200216141104.21477-1-ardb@kernel.org>
 <20200216141104.21477-3-ardb@kernel.org>
 <4e427366-4141-e360-b1da-c5cb37f8092b@redhat.com>
 <CAKv+Gu8h17EdfEW_DDE9S_drLTJ3e3pVzJG29uij5DoGGMXpxA@mail.gmail.com>
 <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <b4eb9c01-b395-15de-cb4e-f1d4a539d9f7@redhat.com>
Date:   Mon, 17 Feb 2020 11:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8LEBFiXOXWv6nbKFpKvT8whaLr3-DkcHSNzW3BRTi8iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/17/20 11:22, Ard Biesheuvel wrote:
> On Mon, 17 Feb 2020 at 10:23, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> On Mon, 17 Feb 2020 at 10:15, Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>> On 02/16/20 15:11, Ard Biesheuvel wrote:
>>>> There are currently two ways to specify the initrd to be passed to the
>>>> Linux kernel when booting via the EFI stub:
>>>> - it can be passed as a initrd= command line option when doing a pure PE
>>>>   boot (as opposed to the EFI handover protocol that exists for x86)
>>>> - otherwise, the bootloader or firmware can load the initrd into memory,
>>>>   and pass the address and size via the bootparams struct (x86) or
>>>>   device tree (ARM)
>>>>
>>>> In the first case, we are limited to loading from the same file system
>>>> that the kernel was loaded from, and it is also problematic in a trusted
>>>> boot context, given that we cannot easily protect the command line from
>>>> tampering without either adding complicated white/blacklisting of boot
>>>> arguments or locking down the command line altogether.
>>>>
>>>> In the second case, we force the bootloader to duplicate knowledge about
>>>> the boot protocol which is already encoded in the stub, and which may be
>>>> subject to change over time, e.g., bootparams struct definitions, memory
>>>> allocation/alignment requirements for the placement of the initrd etc etc.
>>>> In the ARM case, it also requires the bootloader to modify the hardware
>>>> description provided by the firmware, as it is passed in the same file.
>>>> On systems where the initrd is measured after loading, it creates a time
>>>> window where the initrd contents might be manipulated in memory before
>>>> handing over to the kernel.
>>>>
>>>> Address these concerns by adding support for loading the initrd into
>>>> memory by invoking the EFI LoadFile2 protocol installed on a vendor
>>>> GUIDed device path that specifically designates a Linux initrd.
>>>> This addresses the above concerns, by putting the EFI stub in charge of
>>>> placement in memory and of passing the base and size to the kernel proper
>>>> (via whatever means it desires) while still leaving it up to the firmware
>>>> or bootloader to obtain the file contents, potentially from other file
>>>> systems than the one the kernel itself was loaded from. On platforms that
>>>> implement measured boot, it permits the firmware to take the measurement
>>>> right before the kernel actually consumes the contents.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>  drivers/firmware/efi/libstub/arm-stub.c        | 15 +++-
>>>>  drivers/firmware/efi/libstub/efi-stub-helper.c | 82 ++++++++++++++++++++
>>>>  drivers/firmware/efi/libstub/efistub.h         |  4 +
>>>>  drivers/firmware/efi/libstub/x86-stub.c        | 23 ++++++
>>>>  include/linux/efi.h                            |  1 +
>>>>  5 files changed, 122 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
>>>> index 2edc673ea06c..4bae620b95b9 100644
>>>> --- a/drivers/firmware/efi/libstub/arm-stub.c
>>>> +++ b/drivers/firmware/efi/libstub/arm-stub.c
>>>> @@ -160,6 +160,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>>>>       enum efi_secureboot_mode secure_boot;
>>>>       struct screen_info *si;
>>>>       efi_properties_table_t *prop_tbl;
>>>> +     unsigned long max_addr;
>>>>
>>>>       sys_table = sys_table_arg;
>>>>
>>>> @@ -258,10 +259,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>>>>       if (!fdt_addr)
>>>>               pr_efi("Generating empty DTB\n");
>>>>
>>>> -     status = efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
>>>> -                              efi_get_max_initrd_addr(dram_base, *image_addr));
>>>> +     max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
>>>> +     status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
>>>> +     if (status == EFI_SUCCESS) {
>>>> +             pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
>>>> +     } else if (status == EFI_NOT_FOUND) {
>>>> +             status = efi_load_initrd(image, &initrd_addr, &initrd_size,
>>>> +                                      ULONG_MAX, max_addr);
>>>> +             if (status == EFI_SUCCESS)
>>>> +                     pr_efi("Loaded initrd from command line option\n");
>>>> +     }
>>>>       if (status != EFI_SUCCESS)
>>>> -             pr_efi_err("Failed initrd from command line!\n");
>>>> +             pr_efi_err("Failed to load initrd!\n");
>>>>
>>>>       efi_random_get_seed();
>>>>
>>>> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> index 49008ac88b63..e37afe2c752e 100644
>>>> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
>>>> @@ -299,3 +299,85 @@ void efi_char16_printk(efi_char16_t *str)
>>>>       efi_call_proto(efi_table_attr(efi_system_table(), con_out),
>>>>                      output_string, str);
>>>>  }
>>>> +
>>>> +/*
>>>> + * The LINUX_EFI_INITRD_MEDIA_GUID vendor media device path below provides a way
>>>> + * for the firmware or bootloader to expose the initrd data directly to the stub
>>>> + * via the trivial LoadFile2 protocol, which is defined in the UEFI spec, and is
>>>> + * very easy to implement. It is a simple Linux initrd specific conduit between
>>>> + * kernel and firmware, allowing us to put the EFI stub (being part of the
>>>> + * kernel) in charge of where and when to load the initrd, while leaving it up
>>>> + * to the firmware to decide whether it needs to expose its filesystem hierarchy
>>>> + * via EFI protocols.
>>>> + */
>>>> +static const struct {
>>>> +     struct efi_vendor_dev_path      vendor;
>>>> +     struct efi_generic_dev_path     end;
>>>> +} __packed initrd_dev_path = {
>>>> +     {
>>>> +             EFI_DEV_MEDIA,
>>>> +             EFI_DEV_MEDIA_VENDOR,
>>>> +             sizeof(struct efi_vendor_dev_path),
>>>> +             LINUX_EFI_INITRD_MEDIA_GUID
>>>> +     }, {
>>>> +             EFI_DEV_END_PATH,
>>>> +             EFI_DEV_END_ENTIRE,
>>>> +             sizeof(struct efi_generic_dev_path)
>>>> +     }
>>>> +};
>>>> +
>>>> +/**
>>>> + * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
>>>> + * @load_addr:       pointer to store the address where the initrd was loaded
>>>> + * @load_size:       pointer to store the size of the loaded initrd
>>>> + * @max:     upper limit for the initrd memory allocation
>>>> + * @return:  %EFI_SUCCESS if the initrd was loaded successfully, in which case
>>>> + *           @load_addr and @load_size are assigned accordingly
>>>> + *           %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
>>>> + *           device path
>>>> + *           %EFI_LOAD_ERROR in all other cases
>>>
>>> [*]
>>>
>>>> + */
>>>> +efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
>>>> +                                   unsigned long *load_size,
>>>> +                                   unsigned long max)
>>>> +{
>>>> +     efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
>>>> +     efi_device_path_protocol_t *dp;
>>>> +     efi_load_file2_protocol_t *lf2;
>>>> +     unsigned long initrd_addr;
>>>> +     unsigned long initrd_size;
>>>> +     efi_handle_t handle;
>>>> +     efi_status_t status;
>>>> +
>>>> +     if (!load_addr || !load_size)
>>>> +             return EFI_INVALID_PARAMETER;
>>>
>>> Doesn't return EFI_LOAD_ERROR.
>>>
>>>> +
>>>> +     dp = (efi_device_path_protocol_t *)&initrd_dev_path;
>>>> +     status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
>>>> +     if (status != EFI_SUCCESS)
>>>> +             return status;
>>>
>>> Seems safe (the only plausible error could be EFI_NOT_FOUND).
>>>
>>>> +
>>>> +     status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
>>>> +                          (void **)&lf2);
>>>> +     if (status != EFI_SUCCESS)
>>>> +             return status;
>>>
>>> Interesting case; this should never fail... but note, if it does, it
>>> returns EFI_UNSUPPORTED, not EFI_NOT_FOUND (if the protocol is missing
>>> from the handle).
>>>
>>>> +
>>>> +     status = efi_call_proto(lf2, load_file, dp, false, &initrd_size, NULL);
>>>> +     if (status != EFI_BUFFER_TOO_SMALL)
>>>> +             return EFI_LOAD_ERROR;
>>>> +
>>>> +     status = efi_allocate_pages(initrd_size, &initrd_addr, max);
>>>> +     if (status != EFI_SUCCESS)
>>>> +             return status;
>>>
>>> Not sure about the efi_allocate_pages() wrapper (?); the UEFI service
>>> could return EFI_OUT_OF_RESOURCES.
>>>
>>
>> Hmm, guess I was a bit sloppy with the return codes. The important
>> thing is that EFI_NOT_FOUND is only returned in the one specifically
>> defined case.
>>
> 
> For the record [in case no respin+resend is needed for other reasons],
> I intend to update the comment block as below, and keep the code as
> is:
> 
> 
>   * @load_addr: pointer to store the address where the initrd was loaded
>   * @load_size: pointer to store the size of the loaded initrd
>   * @max:       upper limit for the initrd memory allocation
> - * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in
> which case
> - *             @load_addr and @load_size are assigned accordingly
> - *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> - *             device path
> + * @return:    %EFI_SUCCESS if the initrd was loaded successfully, in which
> + *             case @load_addr and @load_size are assigned accordingly
> + *             %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> + *             device path
> + *             %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
> + *             %EFI_OUT_OF_RESOURCES if memory allocation failed
>   *             %EFI_LOAD_ERROR in all other cases
> 

Right, I agree that updating the comments suffices for consistency; the
code is not wrong, only the comments and the code don't match.

So with that

Acked-by: Laszlo Ersek <lersek@redhat.com>


Thanks!
Laszlo

