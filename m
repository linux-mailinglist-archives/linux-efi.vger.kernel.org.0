Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47B62C7358
	for <lists+linux-efi@lfdr.de>; Sat, 28 Nov 2020 23:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbgK1VuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57244 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgK0Tps (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Nov 2020 14:45:48 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kijZN-0004ws-Tl; Fri, 27 Nov 2020 19:38:13 +0000
Subject: Re: ACK: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <98faddb2-5acc-c228-d002-71341d1c558e@canonical.com>
 <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <8d4133d9-3d4b-ee3c-7bb0-927c14d37961@canonical.com>
Date:   Fri, 27 Nov 2020 19:38:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 27/11/2020 19:29, Ard Biesheuvel wrote:
> On Fri, 27 Nov 2020 at 20:28, Colin Ian King <colin.king@canonical.com> wrote:
>>
>> On 27/11/2020 19:20, Heinrich Schuchardt wrote:
>>> Since the UEFI 2.8A specification the UEFI enabled firmware provides a
>>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
>>> services are enabled. The EFI stub reads this table and saves the value of
>>> the field RuntimeServicesSupported internally.
>>>
>>> The Firmware Test Suite requires the value to determine if UEFI runtime
>>> services are correctly implemented.
>>>
>>> With this patch an IOCTL call is provided to read the value of the field
>>> RuntimeServicesSupported, e.g.
>>>
>>>     #define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>>             _IOR('p', 0x0C, unsigned int)
>>>     unsigned int mask;
>>>     fd = open("/dev/efi_test", O_RDWR);
>>>     ret = ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
>>>
>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>  drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
>>>  drivers/firmware/efi/test/efi_test.h |  3 +++
>>>  2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
>>> index ddf9eae396fe..47d67bb0a516 100644
>>> --- a/drivers/firmware/efi/test/efi_test.c
>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>> @@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned long arg)
>>>       return rv;
>>>  }
>>>
>>> +static long efi_runtime_get_supported_mask(unsigned long arg)
>>> +{
>>> +     unsigned int __user *supported_mask;
>>> +     int rv = 0;
>>> +
>>> +     supported_mask = (unsigned int *)arg;
>>> +
>>> +     if (put_user(efi.runtime_supported_mask, supported_mask))
>>> +             rv = -EFAULT;
>>> +
>>> +     return rv;
>>> +}
>>> +
>>>  static long efi_test_ioctl(struct file *file, unsigned int cmd,
>>>                                                       unsigned long arg)
>>>  {
>>> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
>>>
>>>       case EFI_RUNTIME_RESET_SYSTEM:
>>>               return efi_runtime_reset_system(arg);
>>> +
>>> +     case EFI_RUNTIME_GET_SUPPORTED_MASK:
>>> +             return efi_runtime_get_supported_mask(arg);
>>>       }
>>>
>>>       return -ENOTTY;
>>> diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/test/efi_test.h
>>> index f2446aa1c2e3..117349e57993 100644
>>> --- a/drivers/firmware/efi/test/efi_test.h
>>> +++ b/drivers/firmware/efi/test/efi_test.h
>>> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>>>  #define EFI_RUNTIME_RESET_SYSTEM \
>>>       _IOW('p', 0x0B, struct efi_resetsystem)
>>>
>>> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>> +     _IOR('p', 0x0C, unsigned int)
>>> +
>>>  #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
>>> --
>>> 2.29.2
>>>
>>
>> Looks good to me. Thanks Heinrich.
>>
>> The EFI driver needs to be also updated in the linux kernel - has that
>> fix been submitted or do you require the fwts team to do that?

Oops. It's been a lot week :-(

>>
> 
> This /is/ the EFI driver.
> 
> I'll take this as an acked-by but I'd like Ivan to chime in as well.
> 
+1


