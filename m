Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99F17A1A5
	for <lists+linux-efi@lfdr.de>; Thu,  5 Mar 2020 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEIpu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Mar 2020 03:45:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgCEIpu (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 5 Mar 2020 03:45:50 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367D62166E
        for <linux-efi@vger.kernel.org>; Thu,  5 Mar 2020 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583397948;
        bh=fWS3WZ5Kortv8WPPLoSO915bYycttqhtNLWBFTUiEyk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JiYovA/qdm9/SWizxKOMRvJENTYZpYNV6OuvwMqZO4Jja/qXWhpAuiDDN8OHyMPp6
         nDsAo5ffUvcwy1P2EOz1oytoMWcMZVLCfc33YAcotxvTiQxc1ryQ1a1FP3u1X4CDZf
         qRvR4py3rRVhoP+nmgCWKpxeGbvCj50n+JmYIKsA=
Received: by mail-wr1-f52.google.com with SMTP id n15so575741wrw.13
        for <linux-efi@vger.kernel.org>; Thu, 05 Mar 2020 00:45:48 -0800 (PST)
X-Gm-Message-State: ANhLgQ076El7rWnvOPnFeK9hL76awqVUDQLnSCdjwDNgowiuj/hM1+fA
        8pYbEmbd0nlWrLxKFvXrea31J6F7No/qfP/tqzBYlQ==
X-Google-Smtp-Source: ADFU+vs9bN8Xq64X7JM21vY2L2wxsMUm+2oRJLz9+zoka/skOAbrtQ825bzO36uDKi/yK2nlHeq81MbJ5TeGbjiDLuQ=
X-Received: by 2002:a5d:6051:: with SMTP id j17mr8872658wrt.151.1583397946565;
 Thu, 05 Mar 2020 00:45:46 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu_3ZRRcoAcLTVVQe26q5x9KALmztaNQF=e=KqWaAwxtpA@mail.gmail.com>
 <20200305084041.24053-1-vdronov@redhat.com> <20200305084041.24053-2-vdronov@redhat.com>
In-Reply-To: <20200305084041.24053-2-vdronov@redhat.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 5 Mar 2020 09:45:35 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_n8MhgRFw-BUFgN1UUfTh1R6wsCNxKRA9QrQK74z6g7g@mail.gmail.com>
Message-ID: <CAKv+Gu_n8MhgRFw-BUFgN1UUfTh1R6wsCNxKRA9QrQK74z6g7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] efi: fix a race and a buffer overflow while
 reading efivars via sysfs
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>, joeyli <jlee@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 5 Mar 2020 at 09:41, Vladis Dronov <vdronov@redhat.com> wrote:
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
> does not get overwritten.
>
> Reported-by: Bob Sanders <bob.sanders@hpe.com> and the LTP testsuite
> Link: https://lore.kernel.org/linux-efi/20200303085528.27658-1-vdronov@redhat.com/T/#u

For the future, please don't add these links. This one points to the
old version of the patch, not to this one. It will be added by the
tooling once the patch gets picked up.

> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  drivers/firmware/efi/efivars.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 7576450c8254..69f13bc4b931 100644
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
> @@ -250,14 +259,16 @@ efivar_show_raw(struct efivar_entry *entry, char *buf)
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
> +       var->DataSize = datasize;
> +       if (ret)
>                 return -EIO;
>
>         if (in_compat_syscall()) {
> --
> 2.20.1
>
