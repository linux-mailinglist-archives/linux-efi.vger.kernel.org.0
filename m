Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27450169A3B
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBWVYy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 16:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbgBWVYy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 16:24:54 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAC6120836
        for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2020 21:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582493094;
        bh=7kdTqjLLh+0ILrJfwsTMqqhOicjScRZHRMjtRZPrGlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WOmCEcHYjNNQEnUqQfnoxQgKHZtQFjBYRpNg7ihv+RX950zEuUi3spkvDpTbHjgij
         3PxQX7UXTcyNhBzp2StdSFBQI4H6U31IqCTeN//oApATR9vG+dXpP9127C7fDQmp9H
         sGeaoTWKm6wGQKjYN9CRsudSK467orAfPn39RxH8=
Received: by mail-wr1-f53.google.com with SMTP id g4so1706727wro.13
        for <linux-efi@vger.kernel.org>; Sun, 23 Feb 2020 13:24:53 -0800 (PST)
X-Gm-Message-State: APjAAAV4+N+b7QRnghwl5YWIdzC//pUySn0kmzQFT3zU0nqtd75dGse7
        519f+WcvEb9jKoDenZy42q1MF26lImlrX0B+eeAf1w==
X-Google-Smtp-Source: APXvYqxh3oHIItYXU8XQw7YE668jXu11SRHBVFjA3SbZxX42nwOS2Sp8qklA9AHF4U6ZX52q/I4kEOon082VpOtZgXY=
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr62928962wrr.208.1582493092208;
 Sun, 23 Feb 2020 13:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20200223204557.114634-1-xypron.glpk@gmx.de>
In-Reply-To: <20200223204557.114634-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Feb 2020 22:24:41 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-D5Oo0k=j33ZyfnFBBRUBfGcpJB63UZgsUyo7So6QirA@mail.gmail.com>
Message-ID: <CAKv+Gu-D5Oo0k=j33ZyfnFBBRUBfGcpJB63UZgsUyo7So6QirA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/esrt: unused variable in __init efi_esrt_init
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, 23 Feb 2020 at 21:46, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Remove an unused variable in __init efi_esrt_init().
> Simplify a logical constraint.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued in efi/next, thanks

> ---
>  drivers/firmware/efi/esrt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
> index 2762e0662bf4..e3d692696583 100644
> --- a/drivers/firmware/efi/esrt.c
> +++ b/drivers/firmware/efi/esrt.c
> @@ -240,7 +240,6 @@ void __init efi_esrt_init(void)
>  {
>         void *va;
>         struct efi_system_resource_table tmpesrt;
> -       struct efi_system_resource_entry_v1 *v1_entries;
>         size_t size, max, entry_size, entries_size;
>         efi_memory_desc_t md;
>         int rc;
> @@ -288,14 +287,13 @@ void __init efi_esrt_init(void)
>         memcpy(&tmpesrt, va, sizeof(tmpesrt));
>         early_memunmap(va, size);
>
> -       if (tmpesrt.fw_resource_version == 1) {
> -               entry_size = sizeof (*v1_entries);
> -       } else {
> +       if (tmpesrt.fw_resource_version != 1) {
>                 pr_err("Unsupported ESRT version %lld.\n",
>                        tmpesrt.fw_resource_version);
>                 return;
>         }
>
> +       entry_size = sizeof(struct efi_system_resource_entry_v1);
>         if (tmpesrt.fw_resource_count > 0 && max - size < entry_size) {
>                 pr_err("ESRT memory map entry can only hold the header. (max: %zu size: %zu)\n",
>                        max - size, entry_size);
> --
> 2.25.0
>
