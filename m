Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284861E8436
	for <lists+linux-efi@lfdr.de>; Fri, 29 May 2020 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgE2Q6z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 May 2020 12:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgE2Q6y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 29 May 2020 12:58:54 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6662077D;
        Fri, 29 May 2020 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771534;
        bh=6tlfi/KlQAH4pctyASY3wzp34+ZnDnmq+U8F75IPPNA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o1BepfCShtq/KsiMAGkedLZ/uPQFjJp0GSr5eUCWjKrkcXgJyr7qW6G4LRCpItAVO
         QcwMYsdtQcvPCBA9tfWHkMt4Zr8XEYAFRKHYxhiNMzj5zIbgbzjR+YQB1TZCT2WEh8
         CQ6il1G6NyM8YWfrtvU91cjWCc1Ggh4YWfq0Xxqk=
Received: by mail-il1-f181.google.com with SMTP id h3so3134587ilh.13;
        Fri, 29 May 2020 09:58:54 -0700 (PDT)
X-Gm-Message-State: AOAM5307j/bSSzwhlv9WYMvdSP6nxv1ZtYnM1sjVuP1Rs8boWl8RtSoG
        zwE4LAKOBMbpiTBG5gZXQDTjCIKp5od1Xl9Z+QY=
X-Google-Smtp-Source: ABdhPJyedPLm/zCa03ZuOKrd3n6uaiUDMxGu90j3hdCe11tG83kO5W8qNi/nBshOpQ47IJifSE0FgtUwEJf9AW5B9j4=
X-Received: by 2002:a92:5b0c:: with SMTP id p12mr8320222ilb.80.1590771533668;
 Fri, 29 May 2020 09:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200528185920.7314-1-wu000273@umn.edu>
In-Reply-To: <20200528185920.7314-1-wu000273@umn.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 29 May 2020 18:58:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEBgHYdpT2vxQM1k93NypBHRw-tjwnKhUxaSUuLVq9tKQ@mail.gmail.com>
Message-ID: <CAMj1kXEBgHYdpT2vxQM1k93NypBHRw-tjwnKhUxaSUuLVq9tKQ@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix reference count leak in efivar_create_sysfs_entry.
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 28 May 2020 at 20:59, <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> kobject_init_and_add() should be handled when it return an error,
> because kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem.
>
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

This one is already fixed in linux-next

> ---
>  drivers/firmware/efi/efivars.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 78ad1ba8c987..26528a46d99e 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -522,8 +522,10 @@ efivar_create_sysfs_entry(struct efivar_entry *new_var)
>         ret = kobject_init_and_add(&new_var->kobj, &efivar_ktype,
>                                    NULL, "%s", short_name);
>         kfree(short_name);
> -       if (ret)
> +       if (ret) {
> +               kobject_put(&new_var->kobj);
>                 return ret;
> +       }
>
>         kobject_uevent(&new_var->kobj, KOBJ_ADD);
>         if (efivar_entry_add(new_var, &efivar_sysfs_list)) {
> --
> 2.17.1
>
