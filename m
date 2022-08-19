Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B9F599BF6
	for <lists+linux-efi@lfdr.de>; Fri, 19 Aug 2022 14:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiHSM1K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Aug 2022 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiHSM1J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Aug 2022 08:27:09 -0400
X-Greylist: delayed 92039 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Aug 2022 05:27:05 PDT
Received: from iam.tj (yes.iam.tj [109.74.197.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C65D8B38
        for <linux-efi@vger.kernel.org>; Fri, 19 Aug 2022 05:27:05 -0700 (PDT)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id 67B99340AC;
        Fri, 19 Aug 2022 13:27:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
        t=1660912023; bh=wi6z0KYlpCOAnMGHQsHEt+hEPombuWqSjBffBTfJPQ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JD9Dr7Fr31i3Fwk4yIL6jJKi+erkfVjft1fTqM68Uppa/zkGjCvGSwpwJknJTa66E
         IExx+3/AOj5chA1MQHDXXL+i8Uj7jQ93b4Ave10XegUyBdhc2rCbK+m425H98lJgsv
         vaVMIH7W4jzQpJ+2vCy7NBXITfjjX1HBeqKFwbOd6jUhMXQXlZgPKmIai9dADnLXwL
         Q9dT8hi1MOyBid4tE20HKcEPaVLwvPYcJpbJWlr3Kzf4qadOnNpGkukWENOLUGKPUG
         ZPn+uiEm2en/Fx5ei0bZUGhzG3dZgTfcJ6C4haStO7p8J7oDzZv6n4U5BzcDpRMAR6
         SmCKIaRXTuF2A==
Message-ID: <c9eb866f-7615-c3a2-28e2-ffdf6d71ed88@iam.tj>
Date:   Fri, 19 Aug 2022 13:27:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: ExitBootServices() fails on Samsung W737 (Galaxy Book2)
Content-Language: en-GB
To:     Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     linux-efi@vger.kernel.org
References: <2e9741aa-562c-cd0d-7ee4-8281512bc2e0@iam.tj>
 <CAMj1kXH-uYwfxPrHv7YpKQ3iwS0aBEsj-OZ9aKpgr9SgyTdoWQ@mail.gmail.com>
From:   Tj <linux@iam.tj>
In-Reply-To: <CAMj1kXH-uYwfxPrHv7YpKQ3iwS0aBEsj-OZ9aKpgr9SgyTdoWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've opened a bug to report further investigations and had some success 
by implementing and calling EFI's GetNextMonotonicCount() via 
get_next_monotonic_count() **immediately after** calling 
exit_boot_services - which makes absolutely no sense but is now reliably 
starting Linux although that fails in other ways which I'm working through.

https://bugzilla.kernel.org/show_bug.cgi?id=216375

On 19/08/2022 08:22, Ard Biesheuvel wrote:
> (cc Steve - not sure who else still works on this stuff these days)
> 
> On Thu, 18 Aug 2022 at 13:00, Tj <linux@iam.tj> wrote:
>>
>> I've been diagnosing a failure to boot on a Samsung Galaxy Book2 (W737)
>> but have not been able to get the kernel to boot, and would welcome some
>> assistance:
>>
>> EFI stub: ERROR: Exit boot services failed
>>
>> The problem occurs in
>> drivers/firmware/efi/libstub/efi-stub-helper.c::efi_exit_boot_services().
>> EFI_INVALID_PARAMETER is returned by efi_bs_call(exit_boot_services...).
>>
>> Based on reading the EDK source I suspected either the key was changing
>> or memory alignment is wrong based on a reading of EDK's
>> CoreExitBootServices() and CoreTerminateMemoryMap() - making a large
>> assumption that Lenovo/Aptio (American Megatrends) firmware is based
>> around EDK.
>>
>> Since the addition of commit d4b341269efb3 "arm64: dts: qcom: Add
>> support for Samsung Galaxy Book2" I had inferred it is now possible to
>> boot this device into Linux, but so far it seems not.
>>
>> I added extensive efi_debug() logging to try to identify the problem and
>> have reported the patches I'm using and results extensively (too
>> extensively for including in this email) at "Issue #11: Samsung Galaxy
>> Book2 (SM-W737Y) snapdragon 850" of the aarch64-laptops project:
>>
>> https://github.com/aarch64-laptops/debian-cdimage/issues/11
>>
> 
> Looking at your adventures, it seems you are looking for something
> that the EFI stub in Linux is doing wrong, causing the
> ExitBootServices() call to fail.
> 
> One thing to be aware of is that vendors of such hardware don't care
> about EFI compliance, and rarely run the certification tests or turn
> up for plugfests, etc. They only care about the Windows Logo sticker,
> which is a lower bar in terms of EFI compatibility, and apparently,
> their buggy firmware manages to boot Windows fine.
> 
> One thing you could try is setting the TPL level to TPL_HIGH before
> calling exit_boot_services (or just disable interrupts). That way,
> your first call is more likely to succeed, as nothing that could
> change the memory map could run in the meantime.
> 
>> The latest results show:
>>
>> EFI stub: Booting Linux Kernel...
>> EFI stub: Using DTB from configuration table
>> EFI stub: DEBUG: Entering allocate_new_fdt_and_exit_boot()
>> EFI stub: Exiting boot services...
>> EFI stub: DEBUG: Calling efi_exit_boot_services() with map:
>> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
>> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>>    key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
>> EFI stub: DEBUG: Entered efi_exit_boot_services()
>> EFI stub: DEBUG: Memory map before calling priv_func():
>> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
>> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>>    key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
>> EFI stub: DEBUG: Memory map after calling priv_func():
>> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
>> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>>    key_ptr=0x000000009ffce868 *key_ptr=0x2b2c buff_size=0xc90 }
>> EFI stub: DEBUG: Calling efi_bs_call(exit_boot_services,
>> 0x00000000fcb87c98, 0x2b2c)
>> EFI stub: DEBUG: efi_bs_call() returned -9223372036854775806
>> (EFI_INVALID_PARAMETER)
>> EFI stub: DEBUG: Calling efi_bs_call() with get_memory_map
>> EFI stub: DEBUG: Memory map after calling get_memory_map() again:
>> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
>> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>>    key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
>> EFI stub: DEBUG: Calling priv_func() again
>> EFI stub: DEBUG: Memory map after calling priv_func() again:
>> EFI stub: DEBUG: efi_boot_memmap = {map=0x000000009ffce870
>> map_size=0xa20 desc_size=0x30 desc_ver=0x1
>>    key_ptr=0x000000009ffce868 *key_ptr=0x2b6e buff_size=0xc90 }
>> EFI stub: DEBUG: Calling (again!) efi_bs_call(exit_boot_services,
>> 0x00000000fcb87c98, 0x2b6e)
>> EFI stub: DEBUG: fail: efi_exit_boot_services() returns -9223372036854775806
>> EFI stub: DEBUG: Returned from efi_Exit_boot_services()
>> EFI stub: ERROR: Exit boot services failed.
>> EFI stub: DEBUG: fail_free_new_fdt: status= -9223372036854775806
>> EFI stub: DEBUG: fail: status= -9223372036854775806
>> EFI stub: DEBUG: Busy Wait so you can read the debug messages!
