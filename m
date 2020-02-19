Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99555164E3B
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgBSS7G (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 13:59:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:52401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgBSS7G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 13:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582138732;
        bh=UoLem9HJc6PMKNRZJYUxVAoavXucXX3qF11FAWErWUk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UupuxbDbB1QzsP/GMP0/vKBYrc2VqgroiKhw+2is7sJGLnfwDCtLSG6WP/7FtyXmw
         8gWtEdti9bspYSTanBDBPaCmuot9tZBq2AIU0J100E0AcQuHM3l8ia1nDDX/4GoPGh
         1rtjfT1n80lhzCuQj9ue8K1/odwR1eIRfWOTFa8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([84.119.33.160]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1jLTD81QQQ-00sfJI; Wed, 19
 Feb 2020 19:58:52 +0100
Subject: Re: [PATCH 0/9] efi: implement support for EFI RT properties table
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Leif Lindholm <leif@nuviainc.com>, Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>, x86@kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <20200219171907.11894-1-ardb@kernel.org>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <6613b89d-113a-5f18-35d0-fba46bd53677@gmx.de>
Date:   Wed, 19 Feb 2020 19:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200219171907.11894-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZxgRWMV8UTl+pGV/TliW9ZBGxpunOeFVrtvlrYXzOdXzzz4YkBI
 RefxQMxsItCT1Lx0FiW8o45NXx8e0XHgYtb0n9QklvPnVM3KFBoTjnOnOSYuEjvU4K0c669
 SXsU4lVjMSLpI9qj7tieJqulzF24LknooowgMMu9tPRbwS45XqSXZZxcMW8l2+9+mcBoZA+
 GHfSsjNmae4H3jZarze4w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GgiXngmfcyo=:2BQXfFHfb/mXa6stiNMNtS
 q86NjOYj2ZdDwJ4NAsZqaTVatfhced5H+KvyMmeQPtZLMr90ExJqi+h1mnDYAtyMmMAuwtIjL
 kpSLts0zxTW/Fk2YmWocWHPH+FrSeNI9i040zeiOTll2nZNw4HFtWDWg3vxqYhyYvawv/jgqL
 G8g4CA4/CT0QjsG8XsfinbeC+piKyZgypii7V79wazR+gl7tLdd9Si2jrJp5ZaW4r8KzVW1K1
 O+mocO2oc+BrXhplbxjYWqiD3em6zTqJHnzFr70lbkbUy7nObntQLscqLLtPUAcIAjDcc4wiW
 c7b7PLJbA5U0lgLkuadwo0JvMVKXDRiXXgqUq1etatw0floNKnMjnuooCpEMkwwxHePxRxZzW
 K8/VMbNfKAIrkSdIwPHNX7+lqXURepO161P0Q/mBS4nWhV7/ab8i52Yhwk/zibaFU9hXGTYnA
 VUL6QlQUCpqOeRFDiHpc/zcIWwtWFeQyFeNbUlHAI40JiAXBw5e8+zg4aPerqSGZ19sbCz5IL
 2x4M6jCpVr4qSit0X+YdY/x0ggHFTjhdR43LyY2EFt2cx86Ut1PBTYCWOfT1nPh2OJkW5tpZl
 fmMopGNa/Ie0c6/7tqXiI8gHRile4So612K8mL6SMiSt3DYXyhgesxZpCVMdoI80qsjxpPKJX
 I0YbyWUekognf4vnmx4X4Lcwq9/oa+wcGP7lZahJLB0t/ddBZXwNIMgyhlCTUDqGxypDS5d4U
 ALkQeZzGkAT0xHMemReydh7ZTJavwoiqsXDyaV2LFXfU/HLNdwqH4qZ0ujLpTDJtxSl4ZJNtG
 WD213nptNq9abp26+j4Swf0GEIlYX3MZo/QD6sQg9sC4FdKLTv8dkJFPZGYSVfylYXpqrXtpF
 1TFO7oJsXKWi+CzbN6gBD6h2EY6L18adce1gD0ev3MWACyumOvmvO9pnM29n4/PwDU4WDRSxG
 N4MNWwcpZIYHq+uqGWdqRZsL8d3jPPZh77zfspDfz2sS37FdrkUByHhv3AuhdBoYyuzDhz9la
 rK5E2NhAS7E0rEnmq+4ZcJBifEDijffRn2b5gNrw2ulIxiRmlkle49zit0jMCAyQJo+dS3Jtl
 pe0nXm9QzbObuJImoaxjUamKJLYj7C8Rfhw53B+AhvDTvRcPRpsC+pZsbHKgYzmi4BypkfoIn
 JmGdm6AEvw5UHizqp/B9uj0k0AjjnUmfH0DlGCUENbjk+qWf7S6HDGgZJyUlPXWW32ajAHD4J
 g0/QVIo/W9oUtph3H
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/19/20 6:18 PM, Ard Biesheuvel wrote:
> The UEFI spec version 2.8 errata A defines a configuration table called
> EFI_RT_PROPERTIES_TABLE that carries a mask describing which EFI runtime
> services are still functional at OS runtime.
This configuration table defined in UEFI spec 2.8A is replacing the
RuntimeServicesSupported variable introduced in UEFI spec 2.8 (which is
already implemented in U-Boot).

Replacing APIs as an "erratum" is unfortunate.

I am wondering whether in your implementation you will have to check for
both the variable if the firmware implements UEFI 2.8 and for the table
if the firmware implements UEFI 2.8A.

Best regards

Heinrich

>
> Even though any runtime services that cease to be functional when exitin=
g
> boot services are still required to return EFI_UNSUPPORTED when called b=
y
> the OS, having this mask is helpful, since we can use it to prevent modu=
les
> like efi-rtc or efivars from loading, instead of allowing them to probe =
and
> fail with an error.
>
> So let's wire this up: make some room in struct efi for the mask, read i=
t
> from the EFI_RT_PROPERTIES_TABLE if available, and replace various insta=
nces
> of 'if (efi_enabled(EFI_RUNTIME_SERVICES))' with checks for the runtime
> service in question that the code relies upon.
>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jeff Brasen <jbrasen@nvidia.com>
> Cc: Atish Patra <Atish.Patra@wdc.com>
> Cc: x86@kernel.org
>
> Ard Biesheuvel (9):
>    efi: store mask of supported runtime services in struct efi
>    efi: add support for EFI_RT_PROPERTIES table
>    efi: use more granular check for availability for variable services
>    efi: register EFI rtc platform device only when available
>    infiniband: hfi1: use EFI GetVariable only when available
>    scsi: iscsi: use EFI GetVariable only when available
>    efi: use EFI ResetSystem only when available
>    x86/ima: use EFI GetVariable only when available
>    integrity: check properly whether EFI GetVariable() is available
>
>   arch/x86/kernel/ima_arch.c                    |  2 +-
>   drivers/firmware/efi/efi-pstore.c             |  2 +-
>   drivers/firmware/efi/efi.c                    | 70 +++++++++++--------
>   drivers/firmware/efi/efivars.c                |  2 +-
>   drivers/firmware/efi/reboot.c                 |  4 +-
>   drivers/infiniband/hw/hfi1/efivar.c           |  2 +-
>   drivers/rtc/Makefile                          |  4 --
>   drivers/rtc/rtc-efi-platform.c                | 35 ----------
>   drivers/scsi/isci/init.c                      |  2 +-
>   fs/efivarfs/super.c                           |  2 +-
>   include/linux/efi.h                           | 40 +++++++++++
>   security/integrity/platform_certs/load_uefi.c |  2 +-
>   12 files changed, 89 insertions(+), 78 deletions(-)
>   delete mode 100644 drivers/rtc/rtc-efi-platform.c
>

