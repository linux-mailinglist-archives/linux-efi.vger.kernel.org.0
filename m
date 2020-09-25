Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3A2781F0
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgIYHtJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYHtJ (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 25 Sep 2020 03:49:09 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7830208B6;
        Fri, 25 Sep 2020 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601020148;
        bh=0YaWO5ZKqM34f+iCaQRuK4WZ+QdaTdR/4VJClcjFB4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qGyEsfAmVUtlrh0hv7RRpbANMOtZbG8hdjuBcylToA6+ceLvFlX8bYILjDrivTRbN
         3vs/vuaABk6ElXaGJNpTeQ1QtgF2kSs5TAy61FfVQ0gSJLD7rtF1tlUydzgSuNIZ7R
         oEpzUsPnwFDqjELUY8/rJUkjX3XB/xX4V8pJYyIk=
Received: by mail-oi1-f182.google.com with SMTP id u126so1839255oif.13;
        Fri, 25 Sep 2020 00:49:08 -0700 (PDT)
X-Gm-Message-State: AOAM5310221G68ZrzS8TuYHei5yDI3aBNSsIQE1fnlizaRhwIFAQdlW8
        aR3xhOvF7BRtzjZLKImN+lCAC2Pa565Si1Udl1Y=
X-Google-Smtp-Source: ABdhPJyJ7wLcpN8hDRC8yWbIWEFVFfuwz++cbypMBk6skJfpMeM5wvx6rKGlXDsvixT+Uaa66IO4GDwGEWh8C6NzqA0=
X-Received: by 2002:aca:d845:: with SMTP id p66mr767207oig.47.1601020147940;
 Fri, 25 Sep 2020 00:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200925074502.150448-1-misch@google.com>
In-Reply-To: <20200925074502.150448-1-misch@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 25 Sep 2020 09:48:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
Message-ID: <CAMj1kXH9B0TevUEN=CGn9TCYCgr37zX+kSfmqxeALPmUG4GWCA@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Replace invalid slashes with exclamation
 marks in dentries.
To:     Michael Schaller <misch@google.com>
Cc:     michael@5challer.de, Matthew Garrett <matthew.garrett@nebula.com>,
        Jeremy Kerr <jk@ozlabs.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 25 Sep 2020 at 09:45, Michael Schaller <misch@google.com> wrote:
>
> Without this patch efivarfs_alloc_dentry creates dentries with slashes in
> their name if the respective EFI variable has slashes in its name. This in
> turn causes EIO on getdents64, which prevents a complete directory listing
> of /sys/firmware/efi/efivars/.
>
> This patch replaces the invalid shlashes with exclamation marks like
> kobject_set_name_vargs does for /sys/firmware/efi/vars/ to have consistently
> named dentries under /sys/firmware/efi/vars/ and /sys/firmware/efi/efivars/.
>
> Signed-off-by: Michael Schaller <misch@google.com>

Thanks

> Tested-by: Michael Schaller <misch@google.com>

I will drop this - in general, it is assumed that you test your own
patches before sending them to the list, so this is implicit. Also,
tested-by's given on the list tend to carry more weight than ones that
are givenin private and added to the patch by the authors themselves.


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
