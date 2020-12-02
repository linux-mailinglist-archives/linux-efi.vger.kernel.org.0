Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2265E2CBBBD
	for <lists+linux-efi@lfdr.de>; Wed,  2 Dec 2020 12:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgLBLkt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Dec 2020 06:40:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:57331 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgLBLkc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 2 Dec 2020 06:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606909132;
        bh=/DWCBgxz3DNOtmt0qRnumuqQFokOAAC7e033L3NtJL0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jdX4q3jhMnDpXFwruqkY3wDIskfoSj8SvcO0qXDymsYSfj7zAXYd2pgOj3cP0HgmK
         EQIdO/qmbHian4LV3wE8SaImxnHUrq5TAWgo04KjJWlHSlfHhGLMd0qIzb/3KIILEr
         Uxr3xEMwKIvb9icncmqxmU38psJ1ewcVZMZmCqdg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1k6qSK2MyW-014Bdc; Wed, 02
 Dec 2020 12:38:52 +0100
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     ivanhu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <1fbab8b3-3a37-f3f5-39b4-0c8123d27b29@canonical.com>
 <b1d8c534-8b47-5653-cf52-71ad5323ef14@gmx.de>
 <b230c85b-0015-d494-52ef-c6177f923e48@canonical.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <9feb54b4-447a-12f9-d781-e510623c2aef@gmx.de>
Date:   Wed, 2 Dec 2020 12:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <b230c85b-0015-d494-52ef-c6177f923e48@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zipw+WR4FIdfOAEiD7f/lMqo1/0y25PutrPjiLK38HEEGQ10dvt
 e1W+1+l4rVo0+TGPbNdQbSjmGiCGfRcFRSQaa2qW8893mvfHksZoRIGKCnN3+fIp9035GKV
 Cq7jFUkdz3wZ25oqWh/K9MAm+PAXC4ZTx5JrCrc4V0vHweLgzQy/sD/6Ql0k8HirtFyMjS9
 QuSK6mRbnaMX9EXBlml9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:75iRUOcjb/g=:h/PvGw3mp5osm4UxBhpOo8
 qU2qVB7ai/YTB2xs/BBwnDSATlER6Pve/jrHGuNFFGZZfecYtC8Rv1urmieRz2Yy2cTxlLzbW
 TyuZMxeHa+yfiy6gohVfKE9E2P8BdjyhdakVPwMSd9AN6rGdvvPuB58rrRAmHJU9RPO0AhLBs
 uMbjp+R/1MU/q0uyOcOAbnbmjUJ9Z+rZipoSB/baDja33npPPGl8j2jJThIMpVT1roBlfH1RH
 EQOJI1rC9ePes4FcFqCFNDzMBDD/CLE1KW5BorV/QW/v0G1ZJ9qPkTTcxs3kr634DrYGhLS8Y
 Dd5z/KW94OuZrGWfJyVjWIeYXbizOsXYU92wUNQ9ghDprYxPpqplnXau7lT7lUl74Zc4IxE93
 ww80qmyl0PDOsbsimrhh7TgbG/+sm5BrDyuYqbxXzHWttPo8yUv9fDxqj+TGgruAf3CnANwd/
 +ToS2NoRXSDR1eWu6j4bTZEBup6AL2ixiajcZvf0+yb8t7DvTISU0PkSmL2eb/4sxxwkCUkjy
 LTLJbPgARqPvnRzpVPQTBtqJJs/9dlIOUUthOlIywNBPv9Kq7E7sBLs2kkzYVHQvvLT1MQdhm
 rK9VKbhyyu/ts60PEyk4gVDcW4aW87/VHjLnMzD03eiwIB+JzCVzNar3tz2oMIm692vkmsIC7
 cFtBn9s1j2K8bpZ/j6x+wtrZGOCP4SwU5zuapC+/2al4o0VtdndRGGtzgoG9p3jUwsk7ZwUtk
 jHETVDaxqnDR/n+YUFU9vc1YCLMQdsFcwvDhv/UmtskfB8jEng0Z01vZciAi8nOwG3xut8Nqg
 oAlmXqEL51L9YDhPfa2I2sYbISmfKwS6zTliJp26SV99xJcsmV0gdaz4P6Egy6gXlISHqsqXe
 OZGJLI0/BRScKh9N/xVQ==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/30/20 11:38 AM, ivanhu wrote:
>
>
> On 11/30/20 5:17 PM, Heinrich Schuchardt wrote:
>> On 11/30/20 9:16 AM, ivanhu wrote:
>>> Hi Heinrich,
>>>
>>> Thanks for the patch.
>>> It looks good to me, but I noticed that the runtime_supported_mask was
>>> introduced after 5.7-rc1.
>>> Maybe we should add the kernel version checking for the old kernels.
>>
>> This is a kernel patch. Why should we check the kernel version in the
>> kernel code?
>>
>> As patches may be back-ported we should not make any assumptions in fwt=
s
>> based on the kernel version. If the ioctl() call fails with errno =3D
>> ENOTTY, we know that the kernel does not implement the ioctl call and w=
e
>> have to assume that all runtime services are available.
>
> Sounds good to me,
> Acked-by: Ivan Hu <ivan.hu@canonical.com>
>
> And I will replace the reading RuntimeServicesSupported efi variable by
> using efi_test in fwts RuntimeServicesSupported tests.
>
> FWTS will still test those Unsupported Runtime services to check if it
> returns EFI_UNSUPPORTED correctly.
> Is that could solve your problem?
> If I remember correctly, the problem from you is not to test those
> marked Unsupported Runtime services. But from the Spec. 8.1 Runtime
> Services Rules and Restrictions,

The problem I reported was that it is impossible to test UEFI runtime
services on U-Boot because FWTS tries to read the non-existent
RuntimeServicesSupported UEFI variable and mistakenly assumes that if
the variable does not exist none of the runtime services is implemented.

The correct thing to do in FWTS is:

* read RuntimeServicesSupported via the ioctl
* if the ioctl fails assume that all runtime services
   are implemented
* if the ioctl fails with errno !=3D ENOTTY write an error message
* for each runtime service marked as not supported
   check that it returns EFI_UNSUPPORTED
* for each service marked as supported
   check that it works correctly

Best regards

Heinrich

> "
> Note that this is merely a hint to the OS, which it is free to ignore,
> and so the platform is still required to provide callable
> implementations of unsupported runtime services that simply return
> EFI_UNSUPPORTED.
> "
>
> Cheers,
> Ivan
>>
>> Best regards
>>
>> Heinrich
>>
>>>
>>> Cheers,
>>> Ivan
>>>
>>> On 11/28/20 3:20 AM, Heinrich Schuchardt wrote:
>>>> Since the UEFI 2.8A specification the UEFI enabled firmware provides =
a
>>>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which
>>>> runtime
>>>> services are enabled. The EFI stub reads this table and saves the
>>>> value of
>>>> the field RuntimeServicesSupported internally.
>>>>
>>>> The Firmware Test Suite requires the value to determine if UEFI runti=
me
>>>> services are correctly implemented.
>>>>
>>>> With this patch an IOCTL call is provided to read the value of the fi=
eld
>>>> RuntimeServicesSupported, e.g.
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 #define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 _IOR('p', 0x0C, unsigned int)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 unsigned int mask;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open("/dev/efi_test", O_RDWR);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED=
_MASK, &mask);
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>> ---
>>>>  =C2=A0 drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
>>>>  =C2=A0 drivers/firmware/efi/test/efi_test.h |=C2=A0 3 +++
>>>>  =C2=A0 2 files changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/firmware/efi/test/efi_test.c
>>>> b/drivers/firmware/efi/test/efi_test.c
>>>> index ddf9eae396fe..47d67bb0a516 100644
>>>> --- a/drivers/firmware/efi/test/efi_test.c
>>>> +++ b/drivers/firmware/efi/test/efi_test.c
>>>> @@ -663,6 +663,19 @@ static long
>>>> efi_runtime_query_capsulecaps(unsigned long arg)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rv;
>>>>  =C2=A0 }
>>>>
>>>> +static long efi_runtime_get_supported_mask(unsigned long arg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 unsigned int __user *supported_mask;
>>>> +=C2=A0=C2=A0=C2=A0 int rv =3D 0;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 supported_mask =3D (unsigned int *)arg;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (put_user(efi.runtime_supported_mask, supporte=
d_mask))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D -EFAULT;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return rv;
>>>> +}
>>>> +
>>>>  =C2=A0 static long efi_test_ioctl(struct file *file, unsigned int cm=
d,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long arg)
>>>>  =C2=A0 {
>>>> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file,
>>>> unsigned int cmd,
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case EFI_RUNTIME_RESET_SYSTEM:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return efi_ru=
ntime_reset_system(arg);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 case EFI_RUNTIME_GET_SUPPORTED_MASK:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return efi_runtime_get_su=
pported_mask(arg);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTTY;
>>>> diff --git a/drivers/firmware/efi/test/efi_test.h
>>>> b/drivers/firmware/efi/test/efi_test.h
>>>> index f2446aa1c2e3..117349e57993 100644
>>>> --- a/drivers/firmware/efi/test/efi_test.h
>>>> +++ b/drivers/firmware/efi/test/efi_test.h
>>>> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>>>>  =C2=A0 #define EFI_RUNTIME_RESET_SYSTEM \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _IOW('p', 0x0B, struct efi_resetsyste=
m)
>>>>
>>>> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>>> +=C2=A0=C2=A0=C2=A0 _IOR('p', 0x0C, unsigned int)
>>>> +
>>>>  =C2=A0 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
>>>> --
>>>> 2.29.2
>>>>
>>

