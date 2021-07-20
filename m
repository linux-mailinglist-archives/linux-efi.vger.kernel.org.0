Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4156D3CFE11
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGTPFF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 11:05:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:58267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239665AbhGTOUL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 20 Jul 2021 10:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626793223;
        bh=7JdJAmzmrGsuzFEq70IzT5ECb4hmPKilGvqx9UcNLYo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bAhOVEhG7GKzvSNt5PDL8oJBFKJfDQd9g4CJn7FAFGSvFgMW+WtlVpVF4rYvDwsfo
         UlmqdMkTFygT/gO44r5Mg385cAc6fenQqxfKUgYBCxijX5meXFVk55dYSbIKq3tykC
         shOV9MKQrVex/8a0ElxMTnnWoMShPMySl16Czr9U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.189] ([88.152.144.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6llE-1m22132BbC-008Gby; Tue, 20
 Jul 2021 17:00:23 +0200
Subject: Re: [PATCH 1/1] RISC-V: load initrd wherever it fits into memory
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <20210629134018.62859-1-xypron.glpk@gmx.de>
 <877di3mfbe.fsf@igel.home>
 <CAOnJCUJhYZbAL9dMReJt0=y9V33Ed1DaBCXGCdwxH8iUU3bcRg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <42271be6-9586-d387-0419-22e2fcc0d8a3@gmx.de>
Date:   Tue, 20 Jul 2021 17:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUJhYZbAL9dMReJt0=y9V33Ed1DaBCXGCdwxH8iUU3bcRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PTG1MiKwTZILCTDhV5MyL3ndWlpPj7Z5tndcB4DWFM92M+/DX1/
 2c4zaVsku/vu5nmN3zCIFC+GnmtR6+aFPf/QQBznbJ0f5qtEJgv8YPnucRjzP9ZR6uvlwj7
 es4CgIN6LYh1MUIpFw++QRb/Z8lQ574PyHCyQ8oZaMLXyPcgLVmNAzV8VbwAb/cInySmTn3
 sfX0AhdmuDJ75894uh3nA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3tg4y7hCivo=:DCeEs/VENqXKNCQNfmAAJy
 nyGUjn2rcQ07VJlz7UA7n8iTKj1cmGWG6uHFA+KE+kikCFkE6N6udjhRs+wzmmbfDH90cBKvj
 +fdEdveFsmvij344/q08yDXS9UMcJXprSgrBwzFuhA38bZw0lt3/TY2GMiL+96ObxM+sVl7Ie
 /gT5QYSUSSuQOzkv3PDovRxBRPhCcFCiQarRA9I6w7z0++NVNBqaQxH5n98kOhi1i/F3DR/PD
 lCxLSIMJWZINJ0t6eKh2YaQ1Kc4QeBp7sz6bCxq3pDWmXqT7hzbjRTXF3bLFRqOf3dV94ePtK
 oaY8g1b3Y2pWI3sVixo8rY0unSflY/7T5/XUmTQrNpeF10QTDOfiPa35ypNESV8C2RYifu/dx
 pJIkSSAMtc7KaKPUXHwKyxmfyfE9G6Y5on/zui2zpIp/VuyV8ubgkp9GiUGFFw1c/EU4KWrUU
 U0uqOOdU6pWcT4sLeB95HMXu8iJTmLh91WPRyeXq9ou5bPNvMbkw9sXQHh2ggVahwJl6af7HF
 ufCiTZfoq0om42tJNClBbXUF0OCpEpnAPg0nbiesmxYZa5K2Wt2L6LPzC5wj4heiDYMv2NPUN
 dv2nkAqKAusXgwyHmmLoD3InntmIPJ1hXUU3O9WihHocXTsITC63h8GSBikf8sOimvuxOM4pJ
 R2bYnk1t4SrQREKX/ZBpCTlAO48yzGIZgNJUoK0FtiiO9LH910uz7ZRVm1gBuvxinKrgYz3NN
 NwVnucnHZ+9kec8u939KZfg0DFO4M1jg0v5sWGGh4EQPojsm9pMbfBDUYrJaAG96hkOKTYB84
 Mm4Jnf7NBi02YoKgNJnirCX0D8Upk7+BuATBs9WIXV6S7iKRMn/ONHaiYoeZw6r63AOSDlOAF
 RbijP1aFYlH2NdH4abgzhfrfLa7oFIz7tJLFWXZ4v0mwEJjBbxm9xaiHLruNFc2IsElE3AqpZ
 DYqeRlUCC+0w3GXIKmWpElcVzY0TBM2qjrhjJAWtBNkwNUfDd1hkXJBLa0AdU7M4H3wNTbYB3
 1gtVAMmF6+3CuZ0rA2RyWItro3SFKXa04HJqus5eDsvW129g+4IX5Y/9x/qSXKdERyfKefxvr
 ANRbJE2qEebdZ2UYd+ldBzzywCcNjR0gipc
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 7/9/21 7:14 PM, Atish Patra wrote:
> On Tue, Jul 6, 2021 at 12:07 PM Andreas Schwab <schwab@linux-m68k.org> w=
rote:
>>
>> On Jun 29 2021, Heinrich Schuchardt wrote:
>>
>>> Requiring that initrd is loaded below RAM start + 256 MiB led to failu=
re
>>> to boot SUSE Linux with GRUB on QEMU, cf.
>>> https://lists.gnu.org/archive/html/grub-devel/2021-06/msg00037.html
>>>
>>> Remove the constraint.
>>>
>>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>
>> With that patch the image in
>> http://download.opensuse.org/ports/riscv/tumbleweed/iso/ work again.
>>
>
> Thanks.
> @palmer: Can you take this one in this cycle ?

@Palmer, Paul, Albert
Ard suggested to move this patch through linux-riscv. Could you please
review the patch available at

https://lore.kernel.org/linux-riscv/20210629134018.62859-1-xypron.glpk@gmx=
.de/

The patch is necessary to boot on QEMU with GRUB with large initrd.

Best regards

Heinrich

>
>> Andreas.
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA A=
EC1
>> "And now for something completely different."
>
>
>
