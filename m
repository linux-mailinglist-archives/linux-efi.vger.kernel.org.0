Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A151F88BE
	for <lists+linux-efi@lfdr.de>; Sun, 14 Jun 2020 14:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgFNMRc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 14 Jun 2020 08:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFNMRc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 14 Jun 2020 08:17:32 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E987D20747
        for <linux-efi@vger.kernel.org>; Sun, 14 Jun 2020 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592137052;
        bh=sMT8XEhGW2sO5PvBxbDB4VNMHLRFCs6JUU+119mvjRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mQyqlVde19i4X7ptWYHDqqBAHyJ98OjNdASJbGhBp4zYB72SNuLeUsGsnCsi/Mjvl
         GUbzjvaCEAd6N3q5q1mNKimh+EZVeeWqi1DlPalCNW993h8YUyA7xA63gcN3hZHoFZ
         lB8KI9sFxwD5hKqlM9u5H8BkYkWoTryR6907ABCA=
Received: by mail-ot1-f47.google.com with SMTP id s13so10945446otd.7
        for <linux-efi@vger.kernel.org>; Sun, 14 Jun 2020 05:17:31 -0700 (PDT)
X-Gm-Message-State: AOAM5317ZU+z/fi1RZAkbUoYatAdGNSjrUKkHat24yZ5m9ouDaGmpe66
        aVRTi7lE1oR0TQrqJApyJ79xuZpVHldmOvXLNSI=
X-Google-Smtp-Source: ABdhPJyHo+mRpBFV5ZF2Vmjz9NdM3kTRqCnLObB60HsJJA76yt+KEpW2QKMZzEX9ddi4Z8G5eteZ7n2HIRObkzVjlVY=
X-Received: by 2002:a9d:476:: with SMTP id 109mr18949930otc.77.1592137051316;
 Sun, 14 Jun 2020 05:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <1592135130-4013-1-git-send-email-lingshan.zhu@intel.com>
In-Reply-To: <1592135130-4013-1-git-send-email-lingshan.zhu@intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 14 Jun 2020 14:17:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGqgYm2SjRo3v1k8MBMNnZMBAMofNRgwKVnbrkX0Bd33g@mail.gmail.com>
Message-ID: <CAMj1kXGqgYm2SjRo3v1k8MBMNnZMBAMofNRgwKVnbrkX0Bd33g@mail.gmail.com>
Subject: Re: [PATCH] efi: fix errors in building: requires -maccumulate-outgoing-args
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 14 Jun 2020 at 13:49, Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> when build kernel with default config, efi/libstub won't build,
> complain: sorry, unimplemented: ms_abi attribute
> requires -maccumulate-outgoing-args or subtarget optimization
> implying it
>
> This commit intends to add -maccumulate-outgoing-args to Makefile
> cflags, make builder happy.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

Thank you Zhu. You are number #4 to report this to the linux-efi
mailing list, and a fix was already suggested.

https://lore.kernel.org/linux-efi/20200605150638.1011637-1-nivedita@alum.mit.edu/

Upgrading to something more recent than GCC 4.8 could be another
workaround, if that is an option for you. The fix should hopefully be
in by -rc2


> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 75daaf2..a4541b2 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -6,7 +6,7 @@
>  # enabled, even if doing so doesn't break the build.
>  #
>  cflags-$(CONFIG_X86_32)                := -march=i386
> -cflags-$(CONFIG_X86_64)                := -mcmodel=small
> +cflags-$(CONFIG_X86_64)                := -mcmodel=small -maccumulate-outgoing-args
>  cflags-$(CONFIG_X86)           += -m$(BITS) -D__KERNEL__ \
>                                    -fPIC -fno-strict-aliasing -mno-red-zone \
>                                    -mno-mmx -mno-sse -fshort-wchar \
> --
> 1.8.3.1
>
