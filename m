Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A5D27A15A
	for <lists+linux-efi@lfdr.de>; Sun, 27 Sep 2020 16:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgI0OIb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Sep 2020 10:08:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:52001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgI0OIb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 27 Sep 2020 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601215693;
        bh=gUlPCpCEKwq/O4FHTzY0GrnFjvpJ98jIQKKgmB7igVY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a3nGCc4akBEjC99cteN2PDKn+xIr+OatDOF9xpFQn+ZdXI9fCpto0B75gD09LZYum
         E0s2N9xmZDkoFsZ5g0CIi+Ql49kTYLxW1a5XY59qAgluMnIKICofsRVyF/HTRzlPAv
         vqRMEqag/MWpn221NosBafkdfyZhOv7dFsGzQCH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([178.202.41.107]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1ju13710Mi-00X6kL; Sun, 27
 Sep 2020 16:08:13 +0200
Subject: Re: [PATCH] efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL
 failure
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Scott K Logan <logans@cottsay.net>
References: <20200926085850.16342-1-ardb@kernel.org>
 <2bad5e33-9b04-5ea3-da29-3eb914ef5436@gmx.de>
 <CAMj1kXF1gpTh5yFopkPmgdiHyC-+qKFrzgJSTynkujWUbwh9bg@mail.gmail.com>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <612f4c25-45a8-5912-6661-77f02ef798bb@gmx.de>
Date:   Sun, 27 Sep 2020 16:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXF1gpTh5yFopkPmgdiHyC-+qKFrzgJSTynkujWUbwh9bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1wHUbpv4uBh0wtEd/kJk76UbUyCgmpgVvl2WL5zN7AwRrJ/VH6w
 R/GzWOwu439Ioo9TQ2OgZzpkS4cbebFU4mrcHg0H6DNLMM65TgI+v/2QBFbQLtvs1ooka2c
 A97nU7EwQaF5KbN7nsV2ozEwgAfzwk/vL2aEljWh7E6LXZgsiwqUjbTPjItY/y0rz6SpSfw
 u8eW1T3PxwJAFBi8X7ZIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ClOHnAEafhA=:0ya1wVklKAdrT/kVSzXkr9
 B/Op61VQ30mKfx0ylTJkQKEtqJ5mg7WdGCAZOelsZ+8pbQpHzLBh84XSa+TZSwAQNt5TKdFSC
 NThg8nI+cM5ESFy3Pgrob3HHpwjYXGz+wUMgAQ/Hdu+X/jDvt16dz6N5l/pYHXZstYEgQOBeM
 qsM2pZuJhhY3DN/Uw6Leb+r6WUsJXXOHROl3MbWd7mu1q6FATSzSVlR1QrKN1y9POVJH0ZccA
 4nemmemPrR3IOwlLTLoYvRrnYrQy7P5jq5xr2yemihcjz3HE6hjKil8McTFrAB6RYH7p3mFvA
 nQUXGkejv5w09zoPzXoCKfPegGi4j5Ox5Yl02Rr4DK6fVXvS4hoctGGZsiw5eNFWBF9GFnbe1
 fTAZpP702emhq3mkdQWW27Qfxr7RHNkF6o2t0uIMv1pWYCJmk0AvCGM15U6fGjRmhubGAh8nu
 s88orPBjtY5Y/NBeNRYFGwPBMB1ODBp0Woc2sCnVgzxM4kMo92QrUYqMX+xireAsivfnkxPMC
 xrepRdnaXgM4esBkeQUH3gvK0VkT/6I7guYx7raP5ay1or6Ti8lhFSd4hMeUKc0I+Yenkp5Yx
 Dh6CZhP0iCWdZyeDjo0CgAPkRdo/4cYiHDAzQFLuaZnBD2i0bwRMWvQZCWKWy6CO+jbMhqaKD
 H2hQaoYzM3BO93DgbFg3Quc4d+/lzpXM4WUvkMxxyAnH4fo2Z0BKZbZlhXZ0zqGOCgfLWKOi+
 wreOyzQqIC9zsZ0GXXZr+x1WVVmTaxu0PqeXKKgplcy4b+ktokLi8vI/2UUu1bCdnvuZ143zs
 xqPRQ0Iu447MrD74xoD/ECgRNVtVYxWPOkbZGeSeglhDAGiwg2yRygLL/EU5lcUZzC3F0zhK4
 SOrRniW4VApM4lkClKjeO1uVzqgmqOjqfCfJpjkNHbMMlr2j/shixbfk+lJy0Fd+Qpo6bUGGm
 NjthP+wkIBUWTgXUlrZUsDVIYxonAsVNwLP1Qh4XODh6aMFhG8YX1OnNYYc6zBtpQbR+8UucG
 0X4zfUaDNuZVQHX0oGhnSXiH1J2jnVO9J8221BixY0EL+gEZkQOsEraDiaYgOmkd0uzv1CUn9
 N78nhMvLLwKnUs/dOsHYV6bP0o1551YQcXU5yHaPYLJU3uarebVQ3u/IsJ1/ebm/M5q4SUhPe
 rmT/3HlFC5Rdq8js2i/xl8osWqUKX2qh7Uplujh2t48h2BBc3DMLrow8G+EBPl1F096ACMQph
 /wSUus74ACopC1S5j9+Pz/o5mcE3PaFZjXlFibA==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/27/20 11:13 AM, Ard Biesheuvel wrote:
> On Sun, 27 Sep 2020 at 10:18, Heinrich Schuchardt <xypron.glpk@gmx.de> w=
rote:
>>
>> On 9/26/20 10:58 AM, Ard Biesheuvel wrote:
>>> Currently, on arm64, we abort on any failure from efi_get_random_bytes=
()
>>> other than EFI_NOT_FOUND when it comes to setting the physical seed fo=
r
>>> KASLR, but ignore such failures when obtaining the seed for virtual
>>> KASLR or for early seeding of the kernel's entropy pool via the config
>>> table. This is inconsistent, and may lead to unexpected boot failures.
>>>
>>> So let's permit any failure for the physical seed, and simply report
>>> the error code if it does not equal EFI_NOT_FOUND.
>>>
>>> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> Hello Ard,
>>
>> thank you for providing the patch. Unfortunately this seems not to be
>> enough for booting with an EFI_RNG_PROTOCOL.GetRng() returning
>> EFI_UNSUPPORTED.
>>
>> This is the output I received on v5.9-rc6, defconfig with your patch
>> applied. I can retry with a branch from
>> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/ if you
>> indicate which one to use.
>>
>> EFI stub: Booting Linux Kernel...
>> EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000003),
>> KASLR will be disabled
>> EFI stub: Using DTB from configuration table
>>
>> EFI stub: Exiting boot services and installing virtual address map...
>>
>> EFI stub: ERROR: Unable to construct new device tree.
>> EFI stub: ERROR: Failed to update FDT and exit boot services
>>
>> This matches the problem originally reported by Scott.
>>
>
> OK, so we need something like the below as well:
>
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -145,8 +145,6 @@ static efi_status_t update_fdt(void *orig_fdt,
> unsigned long orig_fdt_size,
>                         status =3D fdt_setprop_var(fdt, node,
> "kaslr-seed", fdt_val64);
>                         if (status)
>                                 goto fdt_set_fail;
> -               } else if (efi_status !=3D EFI_NOT_FOUND) {
> -                       return efi_status;
>                 }
>         }
>
>
> Could you please check whether that fixes the issue?
>

The new change allows booting.

I could not observe the new message from the patch on my ARM64 system.
The only related messages I found are:

[  +0.000000] efi: EFI v2.80 by Das U-Boot
[  +0.000000] efi: RTPROP=3D0x7aef9040 SMBIOS=3D0x7aef5000 MEMRESERVE=3D0x=
566df040
[  +0.000000] random: get_random_bytes called from
start_kernel+0x314/0x4e8 with crng_init=3D0
[  +0.003506] KASLR disabled due to lack of seed

Best regards

Heinrich
