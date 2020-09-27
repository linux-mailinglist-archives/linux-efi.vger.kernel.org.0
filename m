Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E7B279F90
	for <lists+linux-efi@lfdr.de>; Sun, 27 Sep 2020 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgI0IXb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Sep 2020 04:23:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:32915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgI0IXb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 27 Sep 2020 04:23:31 -0400
X-Greylist: delayed 311 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 04:23:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601195009;
        bh=bxVaC1eSnEjiqdfmIA+whRypVD//3tbYE+HJ+x3tia4=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=K+ZdDHR2qAGD3mFvKLEk1OBcj1Oe1TlbBOXh/y45T7GWbR3gJsfyCJTVT7YRkig++
         HO3hCb87sG2DZtBCPovqyrXE0LzzyUKF3fK4bsYkiKU6fDZCco0q60ecE7bKddTkvU
         n7RtJ7hS+7qZFXOuq6L5szuprNEH0cd6PMP5bjy8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.123.51] ([178.202.41.107]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1kA7nV0PFj-00E688; Sun, 27
 Sep 2020 10:18:02 +0200
Subject: Re: [PATCH] efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL
 failure
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
References: <20200926085850.16342-1-ardb@kernel.org>
Cc:     Scott K Logan <logans@cottsay.net>
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
Autocrypt: addr=xypron.glpk@gmx.de; prefer-encrypt=mutual; keydata=
 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 Eg==
Message-ID: <2bad5e33-9b04-5ea3-da29-3eb914ef5436@gmx.de>
Date:   Sun, 27 Sep 2020 10:17:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200926085850.16342-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+1dM4gGm4PWM9OjAIa8A1KYfiz2LJEILI3EN+7DvTJfwAjmxAz
 FZc9rTgh6qAoNuCCNfL8B9T62hvgA3Q5uv4KUxFJp+ubA03ZkA+JYIbLrAT5S/Z7nR8yz/E
 z7tpIuV1Yf8QB7iydFRpE/Gp9YR74+dlRgsgHE8WRpHji+VnOeMBlZ2Wd0Qb19SMkuOtCRQ
 czgR5/MzViLg8BiO7eDUA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5mSs+DpJ6Q=:+wdDtAHDUz8pf8aYEjOdtw
 8xTHcIHZo4Rpn6xE8Y3h3MyiGRbiIUw78m1mSiuyTOuv0dNmwG1ORcPV2pQ5tXWS5aUvMD+HL
 Ln98ItLGNunmWJrKq7HEuXhDIGyHGSq5jRXB8fKrhm9+gHppIhgXJpyitZqZE4MpQB9eTCsEa
 R7gqGy4GgPnZ5vNftr5RGBvc5vv+3yGE8E0vBFz8iom20RwMrBTDrdk4yaDzMXbeBQd3JTwKt
 /C+cf828ns9BVyfkCqI+difGIYTKC2HxbFPRGWbNeDS/NK5xwzwlzaEJOZEv2TIByPXfmBwht
 ryDsrPDqmPkskZguzgSArVbd83OXd5GtZ/bRaJL3S8JpgKvs1tqeLZqrQEx0Vx6epSkQQeqUi
 ZXvGvG/P3ofxTtgk0G6ZW0kLSASnSirk4IQCkh4WdQmfuI6fYTstfM6ZI31LK7bEXaWIP8sew
 w7+aZ+u5sHiRmr0PB5JSlHkWIz/OalCoj0Fb9Ji+mMwtrHwe7VVh26715tjZKB/xPSZj6zbbM
 V1hXZWIPe/+vnsbcySCSzTMtj8WKCPV+E15XVrrAhLzMyrggnGPvaxqKmtRNFiQpJLW/Hipnr
 H35A3fi81HTBWW1yauoC+//cMTL/R1BQDnkmFTZ1S2o0ngrmk9inoNYexfi4czjr3m5l6gpGN
 i0TdxGdq3onU0J0Ern9ssOF02V5z1Anxd/Lv+SefhVAY4BbDCxyD8iQf5Akm3rCE65CvFk0xi
 KSo34ZGwnFl7GmVJ8/5JSMYzCivZvwQ6Ez5tQvtHJC5vd3+X2alVqoYX7Ddt1mXO4eiuqHLKS
 mqPVCGSDVRm5rxIwJ8QU1Ujh3xk4Cq5h6VVkfgfC6Rt0aCoZgfLy8WgZew/6kJ1JJ6d1rqN4e
 XXms4inH/HzLgmegdoZDNpjp/7No0PDGFH7pXpH17iRJPSCkX5OG5JVWWsZ1LGfUbLT40iT1g
 dDI48HpiZDAW7NG62j1RjJx5kfFhL9nbN4oVLttid8PiEPEe9iOQU4fHvmUTTxVUmJsNPviY7
 crdGAFzVPZdZMIl1QEfRSgItFkF8qPmehX6XFUzngeJqkfpchhluWmaO/QfAkHdigTfgKfAX6
 fa+tdXwXMGUCLYkUqV+Ji1GtsgLoVQCZoQdlDfyVO3t+ZSrxCAv6IuzueDimIo4A/qe6lAXRm
 pmQyajrYy8wy12zfb7Y/Jjh9cRJNve2JXsKXq92meIkEJJLrySTrw05PSH031x0wtHff1/7GG
 8ytSeD8HWLSakKmeb6SowwUhjLkoskZ4MV7bWWw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/26/20 10:58 AM, Ard Biesheuvel wrote:
> Currently, on arm64, we abort on any failure from efi_get_random_bytes()
> other than EFI_NOT_FOUND when it comes to setting the physical seed for
> KASLR, but ignore such failures when obtaining the seed for virtual
> KASLR or for early seeding of the kernel's entropy pool via the config
> table. This is inconsistent, and may lead to unexpected boot failures.
>
> So let's permit any failure for the physical seed, and simply report
> the error code if it does not equal EFI_NOT_FOUND.
>
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Hello Ard,

thank you for providing the patch. Unfortunately this seems not to be
enough for booting with an EFI_RNG_PROTOCOL.GetRng() returning
EFI_UNSUPPORTED.

This is the output I received on v5.9-rc6, defconfig with your patch
applied. I can retry with a branch from
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/ if you
indicate which one to use.

EFI stub: Booting Linux Kernel...
EFI stub: ERROR: efi_get_random_bytes() failed (0x8000000000000003),
KASLR will be disabled
EFI stub: Using DTB from configuration table

EFI stub: Exiting boot services and installing virtual address map...

EFI stub: ERROR: Unable to construct new device tree.
EFI stub: ERROR: Failed to update FDT and exit boot services

This matches the problem originally reported by Scott.

Best regards

Heinrich

> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmwar=
e/efi/libstub/arm64-stub.c
> index e5bfac79e5ac..21692a986beb 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -62,10 +62,10 @@ efi_status_t handle_kernel_image(unsigned long *imag=
e_addr,
>  			status =3D efi_get_random_bytes(sizeof(phys_seed),
>  						      (u8 *)&phys_seed);
>  			if (status =3D=3D EFI_NOT_FOUND) {
> -				efi_info("EFI_RNG_PROTOCOL unavailable, no randomness supplied\n");
> +				efi_info("EFI_RNG_PROTOCOL unavailable, KASLR will be disabled\n");
>  			} else if (status !=3D EFI_SUCCESS) {
> -				efi_err("efi_get_random_bytes() failed\n");
> -				return status;
> +				efi_err("efi_get_random_bytes() failed (0x%lx), KASLR will be disab=
led\n",
> +					status);
>  			}
>  		} else {
>  			efi_info("KASLR disabled on kernel command line\n");
>

