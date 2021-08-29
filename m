Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F63FAC15
	for <lists+linux-efi@lfdr.de>; Sun, 29 Aug 2021 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhH2OA6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Aug 2021 10:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhH2OA6 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 29 Aug 2021 10:00:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31A9F60F39;
        Sun, 29 Aug 2021 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630245606;
        bh=mgK01xy87hSjH3l7m4l0m0nsFd/lEgiW70qMYmQvsC4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tDladQOdBbzp+rnr3Jn1DZWDEtzXbVETtHMN1aLHWtNdVHJqsSdq4GllYFeDOQWZ7
         nV8/7RrhGV/9VztZHjP9Qj+JFs3EUIkEKZoSzbyCS41ZaYicMmYWY+n0/c04tq+WlX
         fDT2oM4s1P5nLLS7DcZBVu6vSTcrWjo3Wt7NrfbyCYD2Qv2+b8SR86eSOVnGf224Mi
         O3+3y+hU6kbhK+N7Yf9zACDp/OrRBJMctyovUx2YRE6arqRd1ZC2CblExdYMCdn7W+
         WMDapqvZ8S8wYR7NR3uK6JxZbhNQqLV+8+YYkiDUVp6vKMRRdhHHiYHiP/GE3GxGsP
         COeVfmam52RKg==
Received: by mail-ot1-f43.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso14843007ots.5;
        Sun, 29 Aug 2021 07:00:06 -0700 (PDT)
X-Gm-Message-State: AOAM532CZpjJnERa20JpnpxSurhH7ciLyDV7iJmQ+NSxItvx+FteguuP
        WBLBSUzrN/BL6GbEzUIbJtvecbK/sfC2QhKRrvU=
X-Google-Smtp-Source: ABdhPJyG63/MhW0MEr9Re4yydZQ3gu720GRly9dwS+/n4vYzuPLmVHZ2cnirWP/vGcaXhXjbm/2Ja2vQC39UkiR6qkM=
X-Received: by 2002:a05:6830:444:: with SMTP id d4mr15709583otc.108.1630245605549;
 Sun, 29 Aug 2021 07:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210829132310.75687-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20210829132310.75687-1-heinrich.schuchardt@canonical.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 29 Aug 2021 15:59:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXESt+1mWLx1oQUCWcQUa6e2M4D44jD_LH8gDraAQy-=9Q@mail.gmail.com>
Message-ID: <CAMj1kXESt+1mWLx1oQUCWcQUa6e2M4D44jD_LH8gDraAQy-=9Q@mail.gmail.com>
Subject: Re: [PATCH v2: 1/1] efi/libstub: "Exiting bootservices" message
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Heinrich Schuchardt <xypron.gpk@gmx.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 29 Aug 2021 at 15:23, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The message
>
>     "Exiting boot services and installing virtual address map...\n"
>
> is even shown if we have efi=novamap on the command line or the firmware
> does not provide EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP.
>
> To avoid confusion just print
>
>     "Exiting boot services...\n"
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         reduce complexity, use same message irrespective of efi_novamap

Queued up now, thanks.

> ---
>  drivers/firmware/efi/libstub/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> index 365c3a43a198..fe567be0f118 100644
> --- a/drivers/firmware/efi/libstub/fdt.c
> +++ b/drivers/firmware/efi/libstub/fdt.c
> @@ -271,7 +271,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
>                 return status;
>         }
>
> -       efi_info("Exiting boot services and installing virtual address map...\n");
> +       efi_info("Exiting boot services...\n");
>
>         map.map = &memory_map;
>         status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
> --
> 2.30.2
>
