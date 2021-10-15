Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0042F475
	for <lists+linux-efi@lfdr.de>; Fri, 15 Oct 2021 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhJON5T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Oct 2021 09:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240085AbhJON5T (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 15 Oct 2021 09:57:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F62611C3;
        Fri, 15 Oct 2021 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634306112;
        bh=W9JUX50y1R3dPEz3lpKtAb3gbC3sCZbENO1ZX8uqAUM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NguL+SI/UwIzAHOCJu+NF7mY1gND43pY5ijUx6UWsbqpPHgA+yfNmqTeEaGiJSv3W
         As88CYHX4mi/f1GQC5lQjfJNAEwX/J9NErt/IjoLCztUibFmZBeul1EzQEPi1bG9bp
         +LMRtzwrM1Ynxq/thG1SdH7i/ni0xrw7NhDbBJxG6Hq5HhI4iyGLTG9mNSG9bOcLIN
         xSkc+WC2I+ysEqd1rdcxFvqe7eMq3QD+PLcK3TS0I5gysN7pL9TN/htOL5L/OGSyk/
         p4B+wR4fYdtINK1cXkkfOLw//fburNpYif1hr2bRI8lR5IMNBMCkVS9txJ8YaDKPvD
         4tviN3JNRMogg==
Received: by mail-ot1-f48.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso11201355otl.4;
        Fri, 15 Oct 2021 06:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM532zFwzp3QaReLn6BxltWsHpIH7WMKtZwDmyRhMpGNHM019iVuI2
        V0hAwjowwnD1FFq2Bk+dOKs7FNlD0q+QbV9Se3g=
X-Google-Smtp-Source: ABdhPJxNc1ioot2KPEKn+aojQmoB8Z3BfnRwEYCDdn+fLuipY+j5ce8XCfW1HLI87mSC773Vb8R6OaqlLXOmC6QvqG0=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8265172oto.112.1634306112213;
 Fri, 15 Oct 2021 06:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211015131946.13374-1-vegard.nossum@oracle.com>
In-Reply-To: <20211015131946.13374-1-vegard.nossum@oracle.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 15 Oct 2021 15:55:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH5U7Ztv_vn=ej8GJh9hWoVetQz3RxihoYL8WxdLJZMQQ@mail.gmail.com>
Message-ID: <CAMj1kXH5U7Ztv_vn=ej8GJh9hWoVetQz3RxihoYL8WxdLJZMQQ@mail.gmail.com>
Subject: Re: [PATCH] efi: select CRYPTO for EFI_EMBEDDED_FIRMWARE
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ crypto folks)

On Fri, 15 Oct 2021 at 15:24, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Fix the following build warning:
>
>   WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>     Depends on [n]: CRYPTO [=n]
>     Selected by [y]:
>     - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]
>
> Fixes: f0df68d5bae88 ("efi: Add embedded peripheral firmware support")
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>

Hello Vegard,

I don't think this is the right fix, to be honest. The crypto library
functions have no dependencies at all on the crypto API, so I think it
would be better to do something like the below:

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 536df4b6b825..b79de4820ce9 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1919,9 +1919,10 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
        bool

-source "lib/crypto/Kconfig"
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"

 endif  # if CRYPTO
+
+source "lib/crypto/Kconfig"


> ---
>  drivers/firmware/efi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 2c3dac5ecb36d..f914da9845acc 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -248,6 +248,7 @@ endmenu
>  config EFI_EMBEDDED_FIRMWARE
>         bool
>         depends on EFI
> +       select CRYPTO
>         select CRYPTO_LIB_SHA256
>
>  config UEFI_CPER
> --
> 2.23.0.718.g5ad94255a8
>
