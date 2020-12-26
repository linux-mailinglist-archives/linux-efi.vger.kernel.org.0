Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075AD2E2DEB
	for <lists+linux-efi@lfdr.de>; Sat, 26 Dec 2020 11:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgLZKSD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Dec 2020 05:18:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:57149 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgLZKSD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 26 Dec 2020 05:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608977787;
        bh=fhvQFjoACukp/k7zm5yGktg2tOKIdVIZ4JVo9h0FlL8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j5SKbuLubMQn3JhYz63LRJdX/z1znv2I/pMsOXp0D3/Amdd9I04WpsSmOiHuk7NcV
         e98p/LnDgPprI9IGjBk0JYtYF2noJ7MduvbCY5QmbflWBQ08/N15uNw5awEZc3eBrD
         VCyU1dJNY1JcMceuHGJ5eaiBLLARBhwxTQj6rYlk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([62.143.246.89]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1OXT-1jv7Mu1YxX-012rte; Sat, 26
 Dec 2020 11:16:27 +0100
Subject: Re: [PATCH 1/1] efi/efi_test: read RuntimeServicesSupported
To:     Ivan Hu <ivan.hu@canonical.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Colin King <colin.king@canonical.com>,
        fwts-devel@lists.ubuntu.com
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <bb31dcbe-cf19-64c5-daa0-5eb84f1a3583@gmx.de>
Date:   Sat, 26 Dec 2020 11:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201127192051.1430-1-xypron.glpk@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ondkgHtNnFxheAufqQnmJTMCZ/ygh7zw+sUiPnAl6dCdUTMd3ng
 7sl5fEHptNavep3eF8kNsjruzQmjbt5Qq8duT5OLJCUYLGaTj6ltIwLuQhb7dX4z1E5ZmSo
 tGUj3ZOC9RFEPCtIbgJexitSH2EbrJ6+SAoF9BJEoLPi7QCGAmZdW8pkRwNLgW072w2Iz0W
 c0jM+/MoxZFSSuNAkMUdA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MeBX2UpRlYE=:Ys23LkCHV0qS0LYfzDtqNM
 NDk3vozoYf0ztRhQ6Zn9Jl2lh/rXpVZATSf7EaQETucA/VC2N0ReEMHGMugsWnadzLOttzxPV
 YIrO1R5+/G+dULS6A4SAlr8DI0k4Ls4cGgLR1K+/LfscWyhtxgTCRCg+WqQzGxCD9D4jqgX9j
 4VtCD9PpXbJ8dY1YthhbEanWRkcSpHuhS1/bBLx3Bsvu86QRtiCPFmjXznfGcbrRxNoKa45RP
 ui1NM31ggcDvRcP8XqwnrqwRoLUWTc9R5Q9lQ7cG7422DLGX8rDKq2sRKqEi7tixcskVKvnRC
 v9cbVHHxEUjjpyKmgCJQkYiya3KVh14uUDIPZdR+EdhQ8cyWb+kc2uv/se2BM0zmwHetzBZ+X
 eMhMZhfpZJCWG0MzLtm8AORsKu0jMiQy+ur07hWVZTvYtbboacMDvy852rn6uvu0e8ZGSPKLa
 A+xIc110fd8XnbPm9yMPGZdfR3kzWvYOVHjy10dtLiLZvFwgK6tk0s1UU575oivvxPnETaGOW
 OO9XJ7HPn+EVXDWTFOyIxQWHmJuC8sqWEI1JkBpe8Rb9btpXzqmejPXgxiNGt/vaFSm8sSXDV
 3rLmcXN8i5cZGPJq5HKyvEkDo6itxL2wBSE3QfHpiHKf02l8X0BCc8akokTHAFBkYSOsD6Ae0
 2J8dzkEv08ySxqKvR24nyTQ5rSJGjA1AFFQRwyeRxeJllz69KjjdjmSEe612oZiHHPICYy7NQ
 KcSkKAUYBXtpOfHv/hqd/zuveXDd4LUkk4nvVXciqZljYweZCD9UfVoC07SXIR4TfmUX8MWXs
 Fs9GK+5SwwFrEjiiXxlh79Q3elQLWPOnq0Lx7hvn5orzkEGH29fccVYLgWuG6JIEzT6X+pVf9
 pQyCAGyTz8bYH8mIa5Pw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 11/27/20 8:20 PM, Heinrich Schuchardt wrote:
> Since the UEFI 2.8A specification the UEFI enabled firmware provides a
> configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtim=
e
> services are enabled. The EFI stub reads this table and saves the value =
of
> the field RuntimeServicesSupported internally.
>
> The Firmware Test Suite requires the value to determine if UEFI runtime
> services are correctly implemented.
>
> With this patch an IOCTL call is provided to read the value of the field
> RuntimeServicesSupported, e.g.
>
>      #define EFI_RUNTIME_GET_SUPPORTED_MASK \
>              _IOR('p', 0x0C, unsigned int)
>      unsigned int mask;
>      fd =3D open("/dev/efi_test", O_RDWR);
>      ret =3D ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Hello Ard,

the patch has now been admitted to Linus' branch.

Could we, please, have this patch applied to the 5.10 long term release,
too.

Best regards

Heinrich

> ---
>   drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
>   drivers/firmware/efi/test/efi_test.h |  3 +++
>   2 files changed, 19 insertions(+)
>
> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi=
/test/efi_test.c
> index ddf9eae396fe..47d67bb0a516 100644
> --- a/drivers/firmware/efi/test/efi_test.c
> +++ b/drivers/firmware/efi/test/efi_test.c
> @@ -663,6 +663,19 @@ static long efi_runtime_query_capsulecaps(unsigned =
long arg)
>   	return rv;
>   }
>
> +static long efi_runtime_get_supported_mask(unsigned long arg)
> +{
> +	unsigned int __user *supported_mask;
> +	int rv =3D 0;
> +
> +	supported_mask =3D (unsigned int *)arg;
> +
> +	if (put_user(efi.runtime_supported_mask, supported_mask))
> +		rv =3D -EFAULT;
> +
> +	return rv;
> +}
> +
>   static long efi_test_ioctl(struct file *file, unsigned int cmd,
>   							unsigned long arg)
>   {
> @@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsign=
ed int cmd,
>
>   	case EFI_RUNTIME_RESET_SYSTEM:
>   		return efi_runtime_reset_system(arg);
> +
> +	case EFI_RUNTIME_GET_SUPPORTED_MASK:
> +		return efi_runtime_get_supported_mask(arg);
>   	}
>
>   	return -ENOTTY;
> diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi=
/test/efi_test.h
> index f2446aa1c2e3..117349e57993 100644
> --- a/drivers/firmware/efi/test/efi_test.h
> +++ b/drivers/firmware/efi/test/efi_test.h
> @@ -118,4 +118,7 @@ struct efi_resetsystem {
>   #define EFI_RUNTIME_RESET_SYSTEM \
>   	_IOW('p', 0x0B, struct efi_resetsystem)
>
> +#define EFI_RUNTIME_GET_SUPPORTED_MASK \
> +	_IOR('p', 0x0C, unsigned int)
> +
>   #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
> --
> 2.29.2
>

