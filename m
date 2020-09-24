Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D7A276EFC
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIXKr7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 06:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXKr7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 06:47:59 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98F7A239A1;
        Thu, 24 Sep 2020 10:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600944478;
        bh=crA6jQgUS1FFfr6DRg0MQCRnOUDeb7w6bUzRsFm5xKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bKPDntr9XYycPElj3RXGS8Km6PrEOQQzu7sg5MsQWDi1Ki9DE9qD1W5I+MKQWdZJC
         /qm9XZyDoUOqK+LxF8HigXlZY7JxaqEEtvxixVdmq0UPYTwcoVVdY0o8aY4BBBXgb+
         T7Xv0tonCuc1WPT4hyhR2yKq9UnnO1dLSFTBKCXE=
Received: by mail-ot1-f42.google.com with SMTP id s66so2736743otb.2;
        Thu, 24 Sep 2020 03:47:58 -0700 (PDT)
X-Gm-Message-State: AOAM532cbIt0Fx7dMG7XFsewB7cp4h8Ig0X3waYMRy4jlGG9IJWJNkXu
        kudbLAr1bfjxKTGx5uMr93aCJnNTEMHFf66ZGYA=
X-Google-Smtp-Source: ABdhPJzlB3sNdM6Y8ZczMUhZi5xLlk1yPJfn5LQFHG2nfujWOJKSwSKRUGCMAg4Q7lc7uwfm4oYnzmNrRLyGXUnIVPo=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr2623454otk.108.1600944477888;
 Thu, 24 Sep 2020 03:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200924082833.12722-1-jlee@suse.com>
In-Reply-To: <20200924082833.12722-1-jlee@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Sep 2020 12:47:46 +0200
X-Gmail-Original-Message-ID: <CAMj1kXE64kMU7wnMQK+k=0tjaH9OMOrzN86yJPPRkx5Nq8XBqw@mail.gmail.com>
Message-ID: <CAMj1kXE64kMU7wnMQK+k=0tjaH9OMOrzN86yJPPRkx5Nq8XBqw@mail.gmail.com>
Subject: Re: [PATCH] efi/efivars: Create efivars mount point in the
 registration of efivars abstraction
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 24 Sep 2020 at 10:28, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This patch moved the logic of creating efivars mount point to the
> registration of efivars abstraction. It's useful for userland to
> determine the availability of efivars filesystem by checking the
> existence of mount point.
>
> The 'efivars' platform device be created on generic EFI runtime services
> platform, so it can be used to determine the availability of efivarfs.
> But this approach is not available for google gsmi efivars abstraction.
>
> This patch be tested on Here on qemu-OVMF and qemu-uboot.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Fabian Vogt <fvogt@suse.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arthur Heymans <arthur@aheymans.xyz>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> ---

I take it this is v3 of [0]? If so, please explain how it deviates
from v2. If it doesn't deviate from v2, it is better to continue the
discussion in the other thread.

For the sake of discussion, it helps to clarify the confusing nomenclature:

a) 'efivars abstraction' - an internal kernel API that exposes EFI
variables, and can potentially be backed by an implementation that is
not EFI based (i.e., Google gsmi)

b) efivars.ko module, built on top of the efivars abstraction, which
exposes EFI variables (real ones or gsmi ones) via the deprecated
sysfs interface

c) efivarfs filesystem, also built on top of the efivars abstraction,
which exposes EFI variables (real ones or gsmi ones) via a special
filesystem independently of sysfs.

Of course, the sysfs mount point we create for efivarfs is not called
'efivarfs' but 'efivars'. The sysfs subdirectory we create for
efivars.ko is called 'vars'. Sigh.


In this patch, you create the mount point for c) based on whether a)
gets registered (which occurs on systems with EFI Get/SetVariable
support or GSMI), right? So, to Greg's point, wouldn't it be easier to
simply check whether efivarfs is listed in /proc/filesystems?

It also helps if you could clarify what the actual use case is, rather
than saying that it is generally useful.





[0] https://lore.kernel.org/linux-efi/20200825160719.7188-1-jlee@suse.com/

>  drivers/firmware/efi/efi.c  |  7 -------
>  drivers/firmware/efi/vars.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3aa07c3b5136..23c11a2a3f4d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
>         if (error)
>                 goto err_remove_group;
>
> -       /* and the standard mountpoint for efivarfs */
> -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> -       if (error) {
> -               pr_err("efivars: Subsystem registration failed.\n");
> -               goto err_remove_group;
> -       }
> -
>         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
>                 efi_debugfs_init();
>
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 973eef234b36..6fa7f288d635 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
>                      const struct efivar_operations *ops,
>                      struct kobject *kobject)
>  {
> +       int error;
> +
>         if (down_interruptible(&efivars_lock))
>                 return -EINTR;
>
> @@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
>
>         up(&efivars_lock);
>
> +       /* and the standard mountpoint for efivarfs */
> +       if (efi_kobj) {
> +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> +               if (error) {
> +                       if (down_interruptible(&efivars_lock))
> +                               return -EINTR;
> +                       __efivars = NULL;
> +                       up(&efivars_lock);
> +                       pr_err("efivars: Subsystem registration failed.\n");
> +                       return error;
> +               }
> +       }
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(efivars_register);
> @@ -1222,6 +1237,8 @@ int efivars_unregister(struct efivars *efivars)
>
>         pr_info("Unregistered efivars operations\n");
>         __efivars = NULL;
> +       if (efi_kobj)
> +               sysfs_remove_mount_point(efi_kobj, "efivars");
>
>         rv = 0;
>  out:
> --
> 2.16.4
>
