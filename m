Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9F20A2AA
	for <lists+linux-efi@lfdr.de>; Thu, 25 Jun 2020 18:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbgFYQLQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 12:11:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405929AbgFYQLP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Jun 2020 12:11:15 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2392720CC7;
        Thu, 25 Jun 2020 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593101475;
        bh=m6gUtE+LsGChKQcqMZfAQZ4md2ODPWeg5HpwIcqdIVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UHaVh79KG5y+i60f9823JmYoI2dUKjr7iYEo9d0OaJLhaDS3Lw1Xb0ilbPsy/kCH2
         AjFAJHDwsZ6SJUSmADpBoaQ4ayFZGbRTTzUP7hhLgLUwcJuO48AxJUe3PIzEfUzs6O
         3JHRa7DGeZYleUIGu8jJ5EKooHdrypa+Y0iydGcQ=
Received: by mail-ot1-f48.google.com with SMTP id u23so5746577otq.10;
        Thu, 25 Jun 2020 09:11:15 -0700 (PDT)
X-Gm-Message-State: AOAM530Jz9O1QPqzn1az5EywGQ8THwGQMzO123+VV//sGsfUvWxLjh7R
        fuTkd8A7BhQMool2NYBukWqHX+R2KnRNAedD2bA=
X-Google-Smtp-Source: ABdhPJzt+8GQLLE/RndnWOkKvFtWHzvNvUZ7LyQnx5yRgGBHgFAQHJtFg+C/0cwjMy41nytLHld+xvfrB+4m+9FOwnM=
X-Received: by 2002:a9d:5a12:: with SMTP id v18mr26495089oth.90.1593101474463;
 Thu, 25 Jun 2020 09:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200623150935.32181-1-geert+renesas@glider.be>
In-Reply-To: <20200623150935.32181-1-geert+renesas@glider.be>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 25 Jun 2020 18:11:03 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHY7b1nNoOU-LuXiriFPcTC4ZfMccivhJWJvAUGPhwMzQ@mail.gmail.com>
Message-ID: <CAMj1kXHY7b1nNoOU-LuXiriFPcTC4ZfMccivhJWJvAUGPhwMzQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
 should not default to yes
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 23 Jun 2020 at 17:09, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER is deprecated, so it should not
> be enabled by default.
>
> In light of commit 4da0b2b7e67524cc ("efi/libstub: Re-enable command
> line initrd loading for x86"), keep the default for X86.
>
> Fixes: cf6b83664895a5c7 ("efi/libstub: Make initrd file loader configurable")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Queued as a fix, thanks.

> ---
>  drivers/firmware/efi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index e6fc022bc87e03ab..56055c61904e49f4 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -127,7 +127,7 @@ config EFI_ARMSTUB_DTB_LOADER
>  config EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER
>         bool "Enable the command line initrd loader" if !X86
>         depends on EFI_STUB && (EFI_GENERIC_STUB || X86)
> -       default y
> +       default y if X86
>         help
>           Select this config option to add support for the initrd= command
>           line parameter, allowing an initrd that resides on the same volume
> --
> 2.17.1
>
