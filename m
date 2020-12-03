Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B932CCFD5
	for <lists+linux-efi@lfdr.de>; Thu,  3 Dec 2020 07:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgLCGul (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 3 Dec 2020 01:50:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:54571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbgLCGul (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 3 Dec 2020 01:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606978144;
        bh=FbTouvJFoFTi6OZTDP2GToir8Sio2bIbnJdc/EWnyEE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G5mCElKTbqWH6HbS/sc3aPl4bs+K41MvEJpvUymB8HZ7HciV9Plfk/Hv7KNH+zo7u
         W2UVKMZKvRclwuDn/prWwLTEdP8YXh2VJ61kWU+sDi8IVmhOM5DqZl6Z+KV/J8XORM
         OWgot9ZmDa/aBLFmKKi96zzWVUrHr56rMB+PZN68=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKHm-1jxAAN3MuC-00yhli; Thu, 03
 Dec 2020 07:49:03 +0100
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     ivanhu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <1fbab8b3-3a37-f3f5-39b4-0c8123d27b29@canonical.com>
 <b1d8c534-8b47-5653-cf52-71ad5323ef14@gmx.de>
 <b230c85b-0015-d494-52ef-c6177f923e48@canonical.com>
 <9feb54b4-447a-12f9-d781-e510623c2aef@gmx.de>
 <1315e36e-44f1-d753-935e-b6fbe71756e3@canonical.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <5c5ed9f7-616d-877c-6bc2-a2deef89b532@gmx.de>
Date:   Thu, 3 Dec 2020 07:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1315e36e-44f1-d753-935e-b6fbe71756e3@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tC1ZmgKamc6o6DLi91oWcFocLyHvVzs3PpIacxpNAM6TscPYTGX
 MlJ3PhV4g4L1P0hLjmARCYZ/5KhiJEvaPS3ZM/yxfeE/JH4kaiVvwPOB8NJjqxf8EUnkWH5
 NSIJGJWstW24QekrPV0yVxdCyUwu6vZ8sbNSjDc/P2EQJfMlVCe8DydI8OgLFEPxrBLw32I
 HTrTG40spCB/VE7Jy5gpg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RAMIgErC4TU=:xB48RqWjarQivmuu4pb2QU
 2MswZlUxD2AbkxFtbPLdpap2eLC65csV7TqV7/cuLZcMueJExbIpZjRuPQ+iF1boiQnxy41Wz
 NTI1Cv6kYGBPtWeCmUb4YXRI1TWFDUakAEC8Umf3b13j5uY+rjO2zO+n5qWFRmJRvo4ciPndV
 CUadTd9egD81AXHEQ+HsCE8pOKq5VYRnHtbqdoFpIxoDgDogp72Ycw2nR31DLuZ25dZVAOYeo
 zTHBwSdO+8TnwiEFplXulpG9lS+OzFyF4Qg76KH/dLujXnsash7fSATyBApg8pABMTQJpTPMW
 b1CErsE7oscZcnkojodd8+2kgOCDSuZe9yJtfRxUrDUOvfEw73l4koEf4+jWWDrRaQpzfeuM9
 +y+N3qzp5knry88v3QFTbu9iT1Qn+sFoq1H7s+HWYNwamMDfJGJgtvIbtThYWbOf5ka4PWv5i
 Gi1md+ViSWNdRsdaJshrpSh0QE55WTGe0o9dvZh6rQl/fRK8p9KYYZDzU+466AbDkzx5CiYW7
 V/IkqnpQKBdKHousvdTjqZ4N7yhf4Dkf118ymaCOOdBOOeNOdKiGrSyQyJVn9xJwsCHGbUm/d
 ictgbbZGJGvO3rF3e2ix+Zid02zi4SsNhAyTGC289zh4OuO3WeQ2tDCXs2fAiTaHSWqGxyQRU
 J9xuPdR7f2q7Pn1jsCtDWHhjX6/BMG4stAWii4/NvRXIUB4sTW6RrmLCmcsq0d35VBTcRjdRD
 6GEVlmgX4VB6sHJz6VGZtNyLzYc4zW98wI7JUVRLbaAOaOtHuUs657fsXXgCXBFgASx2EQ74N
 P9omvHwmwaK4Caj4WMgIftCZBn8u1i/FVLxQ4954cL/RGot2oi8Nyn/eZ2bS2EmEDvrTIyu/e
 QgGIvttIzqfvPRcGbtoA==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 12/3/20 2:20 AM, ivanhu wrote:
>
>
> On 12/2/20 7:38 PM, Heinrich Schuchardt wrote:
>> On 11/30/20 11:38 AM, ivanhu wrote:
>>>
>>>
>>> On 11/30/20 5:17 PM, Heinrich Schuchardt wrote:
>>>> On 11/30/20 9:16 AM, ivanhu wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> Thanks for the patch.
>>>>> It looks good to me, but I noticed that the runtime_supported_mask w=
as
>>>>> introduced after 5.7-rc1.
>>>>> Maybe we should add the kernel version checking for the old kernels.
>>>>
>>>> This is a kernel patch. Why should we check the kernel version in the
>>>> kernel code?
>>>>
>>>> As patches may be back-ported we should not make any assumptions in f=
wts
>>>> based on the kernel version. If the ioctl() call fails with errno =3D
>>>> ENOTTY, we know that the kernel does not implement the ioctl call and=
 we
>>>> have to assume that all runtime services are available.
>>>
>>> Sounds good to me,
>>> Acked-by: Ivan Hu <ivan.hu@canonical.com>
>>>
>>> And I will replace the reading RuntimeServicesSupported efi variable b=
y
>>> using efi_test in fwts RuntimeServicesSupported tests.
>>>
>>> FWTS will still test those Unsupported Runtime services to check if it
>>> returns EFI_UNSUPPORTED correctly.
>>> Is that could solve your problem?
>>> If I remember correctly, the problem from you is not to test those
>>> marked Unsupported Runtime services. But from the Spec. 8.1 Runtime
>>> Services Rules and Restrictions,
>>
>> The problem I reported was that it is impossible to test UEFI runtime
>> services on U-Boot because FWTS tries to read the non-existent
>> RuntimeServicesSupported UEFI variable and mistakenly assumes that if
>> the variable does not exist none of the runtime services is implemented=
.
>
> Could you provide the result log for me to check?

https://github.com/U-Boot-EFI/u-boot-fwts-results/blob/master/fwts_20_11_f=
ails.txt

is the results log from FWTS 20.11.

https://github.com/U-Boot-EFI/u-boot-fwts-results/blob/master/results-2020=
-10-31.txt

is the results log from a FWTS built from this branch:
https://github.com/xypron/fwts/commits/bugfixes

Best regards

Heinrich

>
> Ivan
>>
>> The correct thing to do in FWTS is:
>>
>> * read RuntimeServicesSupported via the ioctl
>> * if the ioctl fails assume that all runtime services
>>  =C2=A0 are implemented
>> * if the ioctl fails with errno !=3D ENOTTY write an error message
>> * for each runtime service marked as not supported
>>  =C2=A0 check that it returns EFI_UNSUPPORTED
>> * for each service marked as supported
>>  =C2=A0 check that it works correctly
>>
>> Best regards
>>
>> Heinrich
>>
>>> "
>>> Note that this is merely a hint to the OS, which it is free to ignore,
>>> and so the platform is still required to provide callable
>>> implementations of unsupported runtime services that simply return
>>> EFI_UNSUPPORTED.
>>> "
>>>
>>> Cheers,
>>> Ivan
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>>>
>>>>> Cheers,
>>>>> Ivan
>>>>>
>>>>> On 11/28/20 3:20 AM, Heinrich Schuchardt wrote:
>>>>>> Since the UEFI 2.8A specification the UEFI enabled firmware provide=
s a
>>>>>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which
>>>>>> runtime
>>>>>> services are enabled. The EFI stub reads this table and saves the
>>>>>> value of
>>>>>> the field RuntimeServicesSupported internally.
>>>>>>
>>>>>> The Firmware Test Suite requires the value to determine if UEFI
>>>>>> runtime
>>>>>> services are correctly implemented.
>>>>>>
>>>>>> With this patch an IOCTL call is provided to read the value of the
>>>>>> field
>>>>>> RuntimeServicesSupported, e.g.
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #define EFI_RUNTIME_GET_SUPPORTED_M=
ASK \
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 _IOR('p', 0x0C, unsigned int)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask;
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open("/dev/efi_test", O_RDWR=
);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, EFI_RUNTIME_GET_S=
UPPORTED_MASK, &mask);
>>>>>>
>>>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>> ---
>>>>>>  =C2=A0=C2=A0 drivers/firmware/efi/test/efi_test.c | 16 +++++++++++=
+++++
>>>>>>  =C2=A0=C2=A0 drivers/firmware/efi/test/efi_test.h |=C2=A0 3 +++
>>>>>>  =C2=A0=C2=A0 2 files changed, 19 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/firmware/efi/test/efi_test.c
>>>>>> b/drivers/firmware/efi/test/efi_test.c
>>>>>> index ddf9eae396fe..47d67bb0a516 100644
>>>>>> --- a/drivers/firmware/efi/test/efi_test.c
>>>>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>>>>> @@ -663,6 +663,19 @@ static long
>>>>>> efi_runtime_query_capsulecaps(unsigned long arg)
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rv;
>>>>>>  =C2=A0=C2=A0 }
>>>>>>
>>>>>> +static long efi_runtime_get_supported_mask(unsigned long arg)
>>>>>> +{
>>>>>> +=C2=A0=C2=A0=C2=A0 unsigned int __user *supported_mask;
>>>>>> +=C2=A0=C2=A0=C2=A0 int rv =3D 0;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 supported_mask =3D (unsigned int *)arg;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 if (put_user(efi.runtime_supported_mask, suppor=
ted_mask))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D -EFAULT;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 return rv;
>>>>>> +}
>>>>>> +
>>>>>>  =C2=A0=C2=A0 static long efi_test_ioctl(struct file *file, unsigne=
d int cmd,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long arg)
>>>>>>  =C2=A0=C2=A0 {
>>>>>> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file,
>>>>>> unsigned int cmd,
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case EFI_RUNTIME_RESET_SYSTEM=
:
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n efi_runtime_reset_system(arg);
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 case EFI_RUNTIME_GET_SUPPORTED_MASK:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return efi_runtime_get_=
supported_mask(arg);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTTY;
>>>>>> diff --git a/drivers/firmware/efi/test/efi_test.h
>>>>>> b/drivers/firmware/efi/test/efi_test.h
>>>>>> index f2446aa1c2e3..117349e57993 100644
>>>>>> --- a/drivers/firmware/efi/test/efi_test.h
>>>>>> +++ b/drivers/firmware/efi/test/efi_test.h
>>>>>> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>>>>>>  =C2=A0=C2=A0 #define EFI_RUNTIME_RESET_SYSTEM \
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _IOW('p', 0x0B, struct efi_re=
setsystem)
>>>>>>
>>>>>> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>>>>> +=C2=A0=C2=A0=C2=A0 _IOR('p', 0x0C, unsigned int)
>>>>>> +
>>>>>>  =C2=A0=C2=A0 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
>>>>>> --
>>>>>> 2.29.2
>>>>>>
>>>>
>>

