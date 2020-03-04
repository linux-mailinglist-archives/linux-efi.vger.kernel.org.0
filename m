Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D2179427
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCDP5d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 10:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbgCDP5b (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 10:57:31 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 600B421739
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583337450;
        bh=ILnFl8RmIMsml+ikE7ngdhxT/GrRssw7KpYC8Sdzi8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHgNltKLgLHu9Ig8V+Tymy7PM5UmFZLeJFrCSpeBxRS8h2S5WWK8NrOToq7JPIh1v
         DRJQq6l36pq5/fnzzAgbXvIS/wD+wQXt0iNff51CA4syuSvvN/2QTmKEaZr6fUlP7r
         ZsYiljIwdyxcrWvuvk7EmasRmOEXeg+XZV2CozOA=
Received: by mail-wm1-f51.google.com with SMTP id 7so8625wmj.1
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 07:57:30 -0800 (PST)
X-Gm-Message-State: ANhLgQ3b4PgwpJveKoc9iinmxE/DZGFDanaNFiT31fx1e4IwzAKbwlDy
        DbJFTSoAn4UO+r6LuGuiNUwcKh8TrKpIukkE00LLqw==
X-Google-Smtp-Source: ADFU+vunZfY6ZlJCw/RmmWZMdrFRr6f0dI+h9rJagUF2Ca4ke1LTHNYGhV0DKsbWvr8aqreTP2SjzUMyvHX7MYZUv3s=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr4576821wmt.68.1583337448738;
 Wed, 04 Mar 2020 07:57:28 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200304154936.24206-1-vdronov@redhat.com>
In-Reply-To: <20200304154936.24206-1-vdronov@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 16:57:16 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_WFL24dGPakcPgGW3MayYx1qND9HxL87vods7h4LyZJw@mail.gmail.com>
Message-ID: <CAKv+Gu_WFL24dGPakcPgGW3MayYx1qND9HxL87vods7h4LyZJw@mail.gmail.com>
Subject: Re: [PATCH v2] efi: fix a race and a buffer overflow while reading
 efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, joeyli <jlee@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 16:50, Vladis Dronov <vdronov@redhat.com> wrote:
>
> There is a race and a buffer overflow corrupting a kernel memory while
> reading an efi variable with a size more than 1024 bytes via the older
> sysfs method. This happens because accessing struct efi_variable in
> efivar_{attr,size,data}_read() and friends is not protected from
> a concurrent access leading to a kernel memory corruption and, at best,
> to a crash. The race scenario is the following:
>
> CPU0:                                CPU1:
> efivar_attr_read()
>   var->DataSize = 1024;
>   efivar_entry_get(... &var->DataSize)
>     down_interruptible(&efivars_lock)
>                                      efivar_attr_read() // same efi var
>                                        var->DataSize = 1024;
>                                        efivar_entry_get(... &var->DataSize)
>                                          down_interruptible(&efivars_lock)
>     virt_efi_get_variable()
>     // returns EFI_BUFFER_TOO_SMALL but
>     // var->DataSize is set to a real
>     // var size more than 1024 bytes
>     up(&efivars_lock)
>                                          virt_efi_get_variable()
>                                          // called with var->DataSize set
>                                          // to a real var size, returns
>                                          // successfully and overwrites
>                                          // a 1024-bytes kernel buffer
>                                          up(&efivars_lock)
>
> This can be reproduced by concurrent reading of an efi variable which size
> is more than 1024 bytes:
>
> ts# for cpu in $(seq 0 $(nproc --ignore=1)); do ( taskset -c $cpu \
> cat /sys/firmware/efi/vars/KEKDefault*/size & ) ; done
>
> Fix this by using a local variable for a var's data buffer size so it
> does not get overwritten. Also add a sanity check to efivar_store_raw().
>
> Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  drivers/firmware/efi/efi-pstore.c |  2 +-
>  drivers/firmware/efi/efivars.c    | 32 ++++++++++++++++++++++---------
>  drivers/firmware/efi/vars.c       |  2 +-
>  3 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index 9ea13e8d12ec..e4767a7ce973 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -161,7 +161,7 @@ static int efi_pstore_scan_sysfs_exit(struct efivar_entry *pos,
>   *
>   * @record: pstore record to pass to callback
>   *
> - * You MUST call efivar_enter_iter_begin() before this function, and
> + * You MUST call efivar_entry_iter_begin() before this function, and
>   * efivar_entry_iter_end() afterwards.
>   *
>   */

This hunk can be dropped now, I guess

> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 7576450c8254..16a617f9c5cf 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -83,13 +83,16 @@ static ssize_t
>  efivar_attr_read(struct efivar_entry *entry, char *buf)
>  {
>         struct efi_variable *var = &entry->var;
> +       unsigned long size = sizeof(var->Data);
>         char *str = buf;
> +       int ret;
>
>         if (!entry || !buf)
>                 return -EINVAL;
>
> -       var->DataSize = 1024;
> -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> +       var->DataSize = size;

For my understanding, could you explain why we do the assignment here?
Does var->DataSize matter in this case? Can it deviate from 1024?

> +       if (ret)
>                 return -EIO;
>
>         if (var->Attributes & EFI_VARIABLE_NON_VOLATILE)
> @@ -116,13 +119,16 @@ static ssize_t
>  efivar_size_read(struct efivar_entry *entry, char *buf)
>  {
>         struct efi_variable *var = &entry->var;
> +       unsigned long size = sizeof(var->Data);
>         char *str = buf;
> +       int ret;
>
>         if (!entry || !buf)
>                 return -EINVAL;
>
> -       var->DataSize = 1024;
> -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> +       var->DataSize = size;
> +       if (ret)
>                 return -EIO;
>
>         str += sprintf(str, "0x%lx\n", var->DataSize);
> @@ -133,12 +139,15 @@ static ssize_t
>  efivar_data_read(struct efivar_entry *entry, char *buf)
>  {
>         struct efi_variable *var = &entry->var;
> +       unsigned long size = sizeof(var->Data);
> +       int ret;
>
>         if (!entry || !buf)
>                 return -EINVAL;
>
> -       var->DataSize = 1024;
> -       if (efivar_entry_get(entry, &var->Attributes, &var->DataSize, var->Data))
> +       ret = efivar_entry_get(entry, &var->Attributes, &size, var->Data);
> +       var->DataSize = size;
> +       if (ret)
>                 return -EIO;
>
>         memcpy(buf, var->Data, var->DataSize);
> @@ -199,6 +208,9 @@ efivar_store_raw(struct efivar_entry *entry, const char *buf, size_t count)
>         u8 *data;
>         int err;
>
> +       if (!entry || !buf)
> +               return -EINVAL;
> +

So what are we sanity checking here? When might this occur? Does it
need to be in the same patch?

>         if (in_compat_syscall()) {
>                 struct compat_efi_variable *compat;
>
> @@ -250,14 +262,16 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
>  {
>         struct efi_variable *var = &entry->var;
>         struct compat_efi_variable *compat;
> +       unsigned long datasize = sizeof(var->Data);
>         size_t size;
> +       int ret;
>
>         if (!entry || !buf)
>                 return 0;
>
> -       var->DataSize = 1024;
> -       if (efivar_entry_get(entry, &entry->var.Attributes,
> -                            &entry->var.DataSize, entry->var.Data))
> +       ret = efivar_entry_get(entry, &var->Attributes, &datasize, var->Data);
> +       var->DataSize = size;
> +       if (ret)
>                 return -EIO;
>
>         if (in_compat_syscall()) {
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 436d1776bc7b..5f2a4d162795 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -1071,7 +1071,7 @@ EXPORT_SYMBOL_GPL(efivar_entry_iter_end);
>   * entry on the list. It is safe for @func to remove entries in the
>   * list via efivar_entry_delete().
>   *
> - * You MUST call efivar_enter_iter_begin() before this function, and
> + * You MUST call efivar_entry_iter_begin() before this function, and
>   * efivar_entry_iter_end() afterwards.
>   *
>   * It is possible to begin iteration from an arbitrary entry within

We can drop this.

> --
> 2.20.1
>
