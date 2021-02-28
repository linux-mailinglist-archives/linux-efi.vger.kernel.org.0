Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D166932729A
	for <lists+linux-efi@lfdr.de>; Sun, 28 Feb 2021 15:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhB1ObW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Feb 2021 09:31:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhB1ObV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 28 Feb 2021 09:31:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9C0664E85;
        Sun, 28 Feb 2021 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614522640;
        bh=tRSKiWeT4uVY9+D1WloTwY3s57BRw3ISNaS62JRfeig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SslEeeX5tPrPCxcdFM9LBKg+MREdCUI7z92IdqZWkrEHt2coSQXiQpmLdDID1yPI6
         Yrbqeo5ixgkSoD0pFi8RwRHpt5rM96MxXmEDd4rqjN0J0TIGb4wEK8DLIxNxbsEjix
         J5DkH+0GhEp93afZw5WnIQN7VczymPQ6ZLhzhFg+iTVq596/xw0OzXAJ/mnh4f/3GT
         iau9+NOfJXdeC65oJO4SiAfeCu5jMzfILwiBIpHs598yRDGxqwSTb7haQekIx4GhNu
         rKDBxlrdd2tpRKlZeCThTdbKOijPshhz7qvj/nPHoYQhCeqlB2+2+y5EL/Gkyx8c6O
         NC22jf9QvI/Xw==
Received: by mail-ot1-f49.google.com with SMTP id b8so13924147oti.7;
        Sun, 28 Feb 2021 06:30:40 -0800 (PST)
X-Gm-Message-State: AOAM533PpP/KSadxU1DNsEWiTnDVdRJJRCbSbLssVgGv9OuNZtthNcX7
        E7ag365oeQIY92/TtZ/1zbzeKGfPuuWRuDFg/Kg=
X-Google-Smtp-Source: ABdhPJyX3wtEzaUw11Fe08B8vyJihfTl+dXKEIQsCIXpvAYlGWc0E043+x6fgr/ov/HJE7VqGFuaiDRxjIbeE/GmR18=
X-Received: by 2002:a9d:42c:: with SMTP id 41mr9520989otc.108.1614522640231;
 Sun, 28 Feb 2021 06:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20210227032949.31977-1-julianbraha@gmail.com>
In-Reply-To: <20210227032949.31977-1-julianbraha@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 28 Feb 2021 15:30:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGYUwttj4QYSaM-aqtThenXc3hds6VmfOTsQHApVKhjgQ@mail.gmail.com>
Message-ID: <CAMj1kXGYUwttj4QYSaM-aqtThenXc3hds6VmfOTsQHApVKhjgQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: efi: fix Kconfig dependency on CRYPTO
To:     Julian Braha <julianbraha@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 27 Feb 2021 at 04:29, Julian Braha <julianbraha@gmail.com> wrote:
>
> When EFI_EMBEDDED_FIRMWARE is enabled, and CRYPTO is not enabled,
> Kbuild gives the following warning:
>
> WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>   Depends on [n]: CRYPTO [=n]
>   Selected by [y]:
>   - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]
>
> This is because EFI_EMBEDDED_FIRMWARE selects CRYPTO_LIB_SHA256
> without selecting or depending on CRYPTO, despite CRYPTO_LIB_SHA256
> depending on CRYPTO.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Could you try the below instead? CRYPTO_LIB_SHA256 should not depend
on CRYPTO in the first place, we should fix that if we can

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a367fcfeb5d4..77e6bc6df0ee 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1936,9 +1936,10 @@ config CRYPTO_STATS
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
> index 2c3dac5ecb36..f914da9845ac 100644
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
> 2.27.0
>
