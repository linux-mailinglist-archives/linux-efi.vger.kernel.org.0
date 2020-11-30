Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB662C80CB
	for <lists+linux-efi@lfdr.de>; Mon, 30 Nov 2020 10:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgK3JSs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Nov 2020 04:18:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:48605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727319AbgK3JSs (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Nov 2020 04:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606727829;
        bh=DtDnlcM/YJInWCVv1/iD8rWXd3ITq/89IV83lM5DXBI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pd/287AABxBMa8aV3Hr6gOdKo4QtVX2BPIACPu/tKjkuWhs+Q+bsin4TtzDmg6jYa
         6cpDD6bRtdqjsT5rxtHinlK6X1XtPvTSBdR3iKIFwFepdItJL5lC8DjclvTlNsfDdg
         R6WZsZVxY4OUmcFa1JpsSOf8+gf1h+/7TCdmeGyk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1knmR02mcp-006Pik; Mon, 30
 Nov 2020 10:17:09 +0100
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     ivanhu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <1fbab8b3-3a37-f3f5-39b4-0c8123d27b29@canonical.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <b1d8c534-8b47-5653-cf52-71ad5323ef14@gmx.de>
Date:   Mon, 30 Nov 2020 10:17:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1fbab8b3-3a37-f3f5-39b4-0c8123d27b29@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oYTpBiNRhka7/jp5ZKPrGhfDfEY4Q63iKCW/J9TCMkSArvyFZoo
 +8GtGYwQpP6KisVxGdpFl30xctXezDu+Y7kQIIUWad3btWtxcbMegKpc18Xc0xyALN2Uj5i
 E358rEA0nak3/lgQK5tyagW2VAvWOs5z2EeFVGwvt7qSnuLMdQgkAIvaADLNOrWfijFB/tW
 Pza697GFxu02Bo1wgUq5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TEkzRpG/EME=:zm4fWIdeXe2OODTpi5uYoE
 Fo09EhlL8MXiABoxMwnAYA+oUfvpbgZmRMl5gnwzd6W+eGQ9Xh8jYSBW7UgKvSC6Fg+fEXRrc
 aO6l2pUXdeabwsD0CzvGFBCprq2u2A3wJDBQx4ZZ2AUR83LeDdeoE71Eu+bZIjZ3FNm22QEER
 TPkjisNhkD2Fo2WtuIDCfw7owvbwZh9rSYQKz+zpcwc7qIk1cpwOw5693jbweJIlseuGP+tfD
 7MW7UZWJO7FVqJcE35noFcn6IeN+5Jz+t39upK25WhekcVhw6F1SV6hZiIdzrSMljtVnP8msd
 QeFf2N+m+JU3eefufEt7UEJlbPVHKsYzf/h+MIdfS1ueiPXMDcjW6eYiLfOPYz08PNQzClgti
 Nz7EIawjeCTWkoGCaSo4yk/Td/kovOhpzFG5Mh0QBo8UIEyGKwJ3ocbEa1Yc7MKUUMncVSXRw
 fAIR8xDDTBMavNpU9X5Jy3pMY2+Q1JLEJKl+bqcClTrEVnK/k9Tbu+PDVh4JrxEpVaZW75WZb
 /LUDXaSbwUleSAEYkaPAOQLYxWD9nC/EvG9yFKeHYgjWdw+62I2zfNrN7cQ56mfRoFnXVH3R1
 KE3Pazdr78Drm7zLPayk+QU4R52LR9hJkNsopdfkdnn7jZwq2SkaocHHxWdOM/cykp0Mv1alG
 GAGDQy6fdc+aw30ZtWh5uwOvle04bIarVCuIdPghtiBWA/5oo/KAOuWnoLRIs/yEzWVxnYveb
 Xo83IRhMYxai62CgB6SQYGw1p4j2I0SA8gf48XUZdkKGIQuPq91ZsjyX8UlM3ozxPqiZ1RcH+
 oAzCOHYX9VQGpSmo0ufAZXXQxh50iBnFx+si3akhk2Zt93Ri2YYobYOAGfLsHHByHHwhM0CjS
 yCaXD2Nr8bx8KrHwm+Lw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/30/20 9:16 AM, ivanhu wrote:
> Hi Heinrich,
>
> Thanks for the patch.
> It looks good to me, but I noticed that the runtime_supported_mask was
> introduced after 5.7-rc1.
> Maybe we should add the kernel version checking for the old kernels.

This is a kernel patch. Why should we check the kernel version in the
kernel code?

As patches may be back-ported we should not make any assumptions in fwts
based on the kernel version. If the ioctl() call fails with errno =3D
ENOTTY, we know that the kernel does not implement the ioctl call and we
have to assume that all runtime services are available.

Best regards

Heinrich

>
> Cheers,
> Ivan
>
> On 11/28/20 3:20 AM, Heinrich Schuchardt wrote:
>> Since the UEFI 2.8A specification the UEFI enabled firmware provides a
>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which runti=
me
>> services are enabled. The EFI stub reads this table and saves the value=
 of
>> the field RuntimeServicesSupported internally.
>>
>> The Firmware Test Suite requires the value to determine if UEFI runtime
>> services are correctly implemented.
>>
>> With this patch an IOCTL call is provided to read the value of the fiel=
d
>> RuntimeServicesSupported, e.g.
>>
>>      #define EFI_RUNTIME_GET_SUPPORTED_MASK \
>>              _IOR('p', 0x0C, unsigned int)
>>      unsigned int mask;
>>      fd =3D open("/dev/efi_test", O_RDWR);
>>      ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
>>
>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>   drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
>>   drivers/firmware/efi/test/efi_test.h |  3 +++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/ef=
i/test/efi_test.c
>> index ddf9eae396fe..47d67bb0a516 100644
>> --- a/drivers/firmware/efi/test/efi_test.c
>> +++ b/drivers/firmware/efi/test/efi_test.c
>> @@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned=
 long arg)
>>   	return rv;
>>   }
>>
>> +static long efi_runtime_get_supported_mask(unsigned long arg)
>> +{
>> +	unsigned int __user *supported_mask;
>> +	int rv =3D 0;
>> +
>> +	supported_mask =3D (unsigned int *)arg;
>> +
>> +	if (put_user(efi.runtime_supported_mask, supported_mask))
>> +		rv =3D -EFAULT;
>> +
>> +	return rv;
>> +}
>> +
>>   static long efi_test_ioctl(struct file *file, unsigned int cmd,
>>   							unsigned long arg)
>>   {
>> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsig=
ned int cmd,
>>
>>   	case EFI_RUNTIME_RESET_SYSTEM:
>>   		return efi_runtime_reset_system(arg);
>> +
>> +	case EFI_RUNTIME_GET_SUPPORTED_MASK:
>> +		return efi_runtime_get_supported_mask(arg);
>>   	}
>>
>>   	return -ENOTTY;
>> diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/ef=
i/test/efi_test.h
>> index f2446aa1c2e3..117349e57993 100644
>> --- a/drivers/firmware/efi/test/efi_test.h
>> +++ b/drivers/firmware/efi/test/efi_test.h
>> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>>   #define EFI_RUNTIME_RESET_SYSTEM \
>>   	_IOW('p', 0x0B, struct efi_resetsystem)
>>
>> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
>> +	_IOR('p', 0x0C, unsigned int)
>> +
>>   #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
>> --
>> 2.29.2
>>

