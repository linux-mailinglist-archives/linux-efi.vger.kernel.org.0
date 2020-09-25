Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C478278113
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgIYHFO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbgIYHFM (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Sep 2020 03:05:12 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 854A422211;
        Fri, 25 Sep 2020 07:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601017511;
        bh=zuSbzzHJit1jTTi9zp2/OL6gmoxtDNrAYKnrZaniXPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=COwzg7EwHGXHnuZghZJvITz9sRCLyESwO0uVZazEayykQMqNOsPNMcxyNMlPaVqED
         43qnSWklRHTACK9OREuOd71236kx+18dr8xg22/1iZKAj6i0mNPrUHHwdn3GBqwt09
         9HI4fWKfLwiw/enilovPLUkhV0fSwKKnw9e6P3VU=
Received: by mail-oi1-f179.google.com with SMTP id a3so1794090oib.4;
        Fri, 25 Sep 2020 00:05:11 -0700 (PDT)
X-Gm-Message-State: AOAM531PpET5mBNp14nWTzZ5wqL6aePT59x0njTmTLH/w1KWw5+/anaZ
        1KFoy0PGShvedF5odMAmRltRjpTlu7bjVlY8z1U=
X-Google-Smtp-Source: ABdhPJyCWVBClIovJDS4Ckc7x38d5+rCdPwrUW7K2rukfHvM6mTo/4WFTOfKelVr79t/hYl6HScpW9/hbc3R0gbrApw=
X-Received: by 2002:aca:d845:: with SMTP id p66mr699567oig.47.1601017510722;
 Fri, 25 Sep 2020 00:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200918112459.918328-1-misch@google.com>
In-Reply-To: <20200918112459.918328-1-misch@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 09:04:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJ87J45D_tVZ-o9LJCQrDJig2Gscr=bHr1DMJ0wUOu-A@mail.gmail.com>
Message-ID: <CAMj1kXEJ87J45D_tVZ-o9LJCQrDJig2Gscr=bHr1DMJ0wUOu-A@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: Replace invalid slashes with exclamation marks
 in dentries.
To:     Michael Schaller <misch@google.com>
Cc:     michael@5challer.de, Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 18 Sep 2020 at 13:25, Michael Schaller <misch@google.com> wrote:
>
> Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> their name if the respective EFI variable has slashes in its name. This in
> turn causes EIO on getdents64, which prevents a complete directory listing
> of /sys/firmware/efi/efivars/.
>
> This patch replaces the invalid shlashes with exclamation marks like
> kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.

Thanks Michael

Can you resend this with a signed-off-by line please?

> ---
>  fs/efivarfs/super.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 28bb5689333a..15880a68faad 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -141,6 +141,9 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
>
>         name[len + EFI_VARIABLE_GUID_LEN+1] = '\0';
>
> +       /* replace invalid slashes like kobject_set_name_vargs does for /sys/firmware/efi/vars. */
> +       strreplace(name, '/', '!');
> +
>         inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644, 0,
>                                    is_removable);
>         if (!inode)
> --
> 2.28.0.681.g6f77f65b4e-goog
>
