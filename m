Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E842C8257
	for <lists+linux-efi@lfdr.de>; Mon, 30 Nov 2020 11:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgK3KjX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Nov 2020 05:39:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41605 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgK3KjX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Nov 2020 05:39:23 -0500
Received: from [106.104.74.151] (helo=[192.168.31.192])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ivan.hu@canonical.com>)
        id 1kjgZs-0000Am-90; Mon, 30 Nov 2020 10:38:40 +0000
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <1fbab8b3-3a37-f3f5-39b4-0c8123d27b29@canonical.com>
 <b1d8c534-8b47-5653-cf52-71ad5323ef14@gmx.de>
From:   ivanhu <ivan.hu@canonical.com>
Message-ID: <b230c85b-0015-d494-52ef-c6177f923e48@canonical.com>
Date:   Mon, 30 Nov 2020 18:38:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b1d8c534-8b47-5653-cf52-71ad5323ef14@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 11/30/20 5:17 PM, Heinrich Schuchardt wrote:
> On 11/30/20 9:16 AM, ivanhu wrote:
>> Hi Heinrich,
>>
>> Thanks for the patch.
>> It looks good to me, but I noticed that the runtime_supported_mask was
>> introduced after 5.7-rc1.
>> Maybe we should add the kernel version checking for the old kernels.
> 
> This is a kernel patch. Why should we check the kernel version in the
> kernel code?
> 
> As patches may be back-ported we should not make any assumptions in fwts
> based on the kernel version. If the ioctl() call fails with errno =
> ENOTTY, we know that the kernel does not implement the ioctl call and we
> have to assume that all runtime services are available.

Sounds good to me,
Acked-by: Ivan Hu <ivan.hu@canonical.com>

And I will replace the reading RuntimeServicesSupported efi variable by
using efi_test in fwts RuntimeServicesSupported tests.

FWTS will still test those Unsupported Runtime services to check if it
returns EFI_UNSUPPORTED correctly.
Is that could solve your problem?
If I remember correctly, the problem from you is not to test those
marked Unsupported Runtime services. But from the Spec. 8.1 Runtime
Services Rules and Restrictions,
"
Note that this is merely a hint to the OS, which it is free to ignore,
and so the platform is still required to provide callable
implementations of unsupported runtime services that simply return
EFI_UNSUPPORTED.
"

Cheers,
Ivan
> 
> Best regards
> 
> Heinrich
> 
>>
>> Cheers,
>> Ivan
>>
>> On 11/28/20 3:20 AM, Heinrich Schuchardt wrote:
>>> Since the UEFI 2.8A specification the UEFI enabled firmware provides a
>>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which
>>> runtime
>>> services are enabled. The EFI stub reads this table and saves the
>>> value of
>>> the field RuntimeServicesSupported internally.
>>>
>>> The Firmware Test Suite requires the value to determine if UEFI runtime
>>> services are correctly implemented.
>>>
>>> With this patch an IOCTL call is provided to read the value of the field
>>> RuntimeServicesSupported, e.g.
>>>
>>>      #define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>>              _IOR('p', 0x0C, unsigned int)
>>>      unsigned int mask;
>>>      fd = open("/dev/efi_test", O_RDWR);
>>>      ret = ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
>>>
>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>   drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
>>>   drivers/firmware/efi/test/efi_test.h |  3 +++
>>>   2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/firmware/efi/test/efi_test.c
>>> b/drivers/firmware/efi/test/efi_test.c
>>> index ddf9eae396fe..47d67bb0a516 100644
>>> --- a/drivers/firmware/efi/test/efi_test.c
>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>> @@ -663,6 +663,19 @@ static long
>>> efi_runtime_query_capsulecaps(unsigned long arg)
>>>       return rv;
>>>   }
>>>
>>> +static long efi_runtime_get_supported_mask(unsigned long arg)
>>> +{
>>> +    unsigned int __user *supported_mask;
>>> +    int rv = 0;
>>> +
>>> +    supported_mask = (unsigned int *)arg;
>>> +
>>> +    if (put_user(efi.runtime_supported_mask, supported_mask))
>>> +        rv = -EFAULT;
>>> +
>>> +    return rv;
>>> +}
>>> +
>>>   static long efi_test_ioctl(struct file *file, unsigned int cmd,
>>>                               unsigned long arg)
>>>   {
>>> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file,
>>> unsigned int cmd,
>>>
>>>       case EFI_RUNTIME_RESET_SYSTEM:
>>>           return efi_runtime_reset_system(arg);
>>> +
>>> +    case EFI_RUNTIME_GET_SUPPORTED_MASK:
>>> +        return efi_runtime_get_supported_mask(arg);
>>>       }
>>>
>>>       return -ENOTTY;
>>> diff --git a/drivers/firmware/efi/test/efi_test.h
>>> b/drivers/firmware/efi/test/efi_test.h
>>> index f2446aa1c2e3..117349e57993 100644
>>> --- a/drivers/firmware/efi/test/efi_test.h
>>> +++ b/drivers/firmware/efi/test/efi_test.h
>>> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>>>   #define EFI_RUNTIME_RESET_SYSTEM \
>>>       _IOW('p', 0x0B, struct efi_resetsystem)
>>>
>>> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>> +    _IOR('p', 0x0C, unsigned int)
>>> +
>>>   #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
>>> -- 
>>> 2.29.2
>>>
> 
