Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6C2C72F9
	for <lists+linux-efi@lfdr.de>; Sat, 28 Nov 2020 23:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389737AbgK1VuF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Nov 2020 16:50:05 -0500
Received: from mout.gmx.net ([212.227.17.20]:52055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgK0TwR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 14:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606506732;
        bh=cP8Vc+LHa/V15QYxylljboEO3n80kHSSWmsdd8Xkrx0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FrTlncnYjBnjDG7aUOtDIXME1tt4bd4CLDK9rZPn5+5aozVLyw0+Q96MTXV54GwKF
         1/zzsNMchLsQUk59hN4WrHl5AFUa37MmcLrdNoaO468d0YArqNkO9vMdSsNB+1BqUa
         KRS+OxiWwZKSp6mXdEOgYjjsixqJhEKrK4VePdaY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.83] ([62.143.246.89]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1kyR270up1-00GGVj; Fri, 27
 Nov 2020 20:39:32 +0100
Subject: Re: ACK: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Ard Biesheuvel <ardb@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Ivan Hu <ivan.hu@canonical.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
 <98faddb2-5acc-c228-d002-71341d1c558e@canonical.com>
 <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <fac1a832-b5ce-8eea-d1aa-81a0f429d772@gmx.de>
Date:   Fri, 27 Nov 2020 20:39:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFNtCJEvbhZpO9p96UNGuo-r2dXQPm0TRjmQuF4TLBUcg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9iTXzInqIWUycq2dboX2F7id15cW9lvKXH5lsQyiTkZBS+YwusP
 A/mBGeK0pltUyFlrfcbNvIt24ZQTn/e8LyMzpp2WKlIYs4Wcg1MGuD4UWkV/R8qdgiM43/m
 ojBFjtcpFqg9GC4DZe82pE2PMgnCTf887V8I1xXOugkHnmHkmhTJQLTspKDEWJP0A7sDfrS
 ZoVaZPNeUK3GeAUJNB3Hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAiyjbBXifo=:QkIV6T6CbrA41ZBAtWfX4S
 C5rJAk1eCoU7LPUAkrcQ+YeZA3mf3TB8n7uhJo2ZT/myIIinmBTYhxm/r1i7tcC/Z41oxqoDk
 VK9Byo9gZmMIdrw76h0S7GD2pkUvCViCzqiVFmWx9NoDLmab0qlkvxOxpL9lzEBZ4w/MWyG9W
 UYi1pNTpifRIRK/OhYIcWjXx0WFeiX/XQCfzUMzDkeL2b2Tjg3DNaHy2Xo/6Tff5rYhcxpcjO
 TDvsPVOC2p5zFCDTpM6i9CVDjYC+UuHqdvgglut9tjY/KEUq/yl7hbDEUpeGh/tp2K/rRiAfv
 LW7rzHJgVhxuAVUt3+doeKYmcfQdnmr7EQy2yR+m8Xclb30Cz1SrbnSW33o8kKV4F5jForT4p
 9OuJdvd4J2Kh73uwUeST2UizHaqTsT9HZx0k71UqP36onlC46hHCkUswxPoyfGhMy0B1iw8Dj
 2zcOks0E/xSOxhlNephVq9W8Ah2clC4TvhcKPtVocCF7Lq9GLWIS8L5QmVri0077ajftflNRg
 Mi3MUAaw9KgLfvsvVzLuJpx0y6IyDogX8VxryGIl7tQz4E/7eUI/lXDUFpQBls1pCCEt/C7Ca
 flXiln7vjKfdfCBnJL5xjJEvzBILKznFEcr5OLtCtFwr16Shwwi+dTQo11lVMzmO4BwFw8omI
 CVdoxhRJr62O3yP8YQ4AfI8DCo8zaTWThtaXPKAdVzG257llGqXQ5eyuLdTSKzYEXj2Nnj60b
 tKLweflPss2h+BM5bOLLHsxcA2RrQURvpVM/AN/AMm0uC19StFW6NP7ADN2Uwfztg4p3HJ2K4
 tTQiXT5uuDB9CjsJCEFT1+bWg37tUV0mx/1p5KIY2B9fHyK1e/SvgbmC0FUU0ziHRluKO3xre
 QSHGCouNlEoUjKuw7+vg==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/27/20 8:29 PM, Ard Biesheuvel wrote:
> On Fri, 27 Nov 2020 at 20:28, Colin Ian King <colin.king@canonical.com> =
wrote:
>>
>> On 27/11/2020 19:20, Heinrich Schuchardt wrote:
>>> Since the UEFI 2.8A specification the UEFI enabled firmware provides a
>>> configuration table EFI_RT_PROPERTIES_TABLE which indicates which runt=
ime
>>> services are enabled. The EFI stub reads this table and saves the valu=
e of
>>> the field RuntimeServicesSupported internally.
>>>
>>> The Firmware Test Suite requires the value to determine if UEFI runtim=
e
>>> services are correctly implemented.
>>>
<snip />
>> Looks good to me. Thanks Heinrich.
>>
>> The EFI driver needs to be also updated in the linux kernel - has that
>> fix been submitted or do you require the fwts team to do that?
>>
>
> This /is/ the EFI driver.
>
> I'll take this as an acked-by but I'd like Ivan to chime in as well.
>

Hello Ard, hello Colin,

I have tested the patch with Linux 5.8.9.

Somehow Linux managed to break the kernel for my board between Linux
5.8.9 and 5.8.18. It does not boot form iSCSI with a newer kernel.

You probably want to run a user program against your latest kernel. This
is what I used:

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>

#define EFI_RUNTIME_GET_SUPPORTED_MASK \
         _IOR('p', 0x0C, unsigned int)

int main()
{
         unsigned int i, flag;
         int fd, ret;
         unsigned int mask;

         fd =3D open("/dev/efi_test", O_RDWR);
         if (fd =3D=3D -1) {
                 perror("open");
                 return 1;
         }

         ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
         if (ret =3D=3D -1) {
                 perror("ioctl");
                 return 1;
         }
         printf("mask 0x%08x\n", mask);

         flag =3D 1;
         for (i =3D 0x80000000; i; i >>=3D 1) {
                 if (i & mask) {
                         printf("%4s 0x%08x\n", flag ? "=3D" : "|", i);
                         flag =3D 0;
                 }
         }

         close(fd);

         return 0;
}

Best regards

Heinrich
