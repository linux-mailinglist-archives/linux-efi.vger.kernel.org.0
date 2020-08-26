Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC9252E00
	for <lists+linux-efi@lfdr.de>; Wed, 26 Aug 2020 14:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgHZMIf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Aug 2020 08:08:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgHZMIa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 26 Aug 2020 08:08:30 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6970E2087D;
        Wed, 26 Aug 2020 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443709;
        bh=LtLkAShyIGY4PhKwW6il8v3zv5EU8NYcrikGnC+ntT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EKwiHOBEcwfHi77g0MzNXWtK1Ubhlp/WdnhtS9QSltgfUUVtCqPX+wWO7UTLIcPcF
         iwrC9pggBzskvCXX0z7cnUC33cQExDdltwfXMKKx+VHp/xP88/JiG+qLhrNinKTR1L
         0Kev3G/OZaHrJhJALb3DZAPUCuh3SLHyULX+LNNc=
Received: by mail-oi1-f170.google.com with SMTP id v13so1258592oiv.13;
        Wed, 26 Aug 2020 05:08:29 -0700 (PDT)
X-Gm-Message-State: AOAM531ieJPET8RF0oRAA9Wni6w2msMK1zSbsNdVjKqqW1DNW06IqeZe
        50R0CZux2jBQyuVGj+5oGu1ehGSILgndM28EG3o=
X-Google-Smtp-Source: ABdhPJzzPq7S2H5rVGigyuue4pj1WV/eBXdUGRHi6dgNXRlZ8nZgWnELoCz7uNsTVW4mTpQmfHxfC71nLK9ZQYuGbc8=
X-Received: by 2002:aca:d8c5:: with SMTP id p188mr3452457oig.47.1598443708834;
 Wed, 26 Aug 2020 05:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200826004607.7483-1-jlee@suse.com>
In-Reply-To: <20200826004607.7483-1-jlee@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 26 Aug 2020 14:08:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHAmUVPs=P5ptb3J95+4epP5fQXkBZ_+vLP8xfxri8VBw@mail.gmail.com>
Message-ID: <CAMj1kXHAmUVPs=P5ptb3J95+4epP5fQXkBZ_+vLP8xfxri8VBw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efivars: Create efivars mount point via efivars abstraction
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 26 Aug 2020 at 02:46, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> This patch creates efivars mount point when active efivars abstraction
> be set. It is useful for userland to determine the availability of efivars
> filesystem.
>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Fabian Vogt <fvogt@suse.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Apologies for not bringing this up before: while the patch seems fine,
I wonder if we really need this if the purpose is to decide whether
efivars is available or not. We already have the 'efivars' platform
device for this, and so userland can simply check for the existence of

/sys/devices/platform/efivars.0

and so we don't need to make any changes for this.



> ---
>
> v2:
> Using efivars_kobject() helper instead of checking GetVariable or
> GetNextVariable EFI runtime services. Because the efivarfs code could be
> instantiated using a different efivars abstraction.
>
>  drivers/firmware/efi/efi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3aa07c3b5136..db483fc68501 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -405,11 +405,13 @@ static int __init efisubsys_init(void)
>         if (error)
>                 goto err_remove_group;
>
> -       /* and the standard mountpoint for efivarfs */
> -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> -       if (error) {
> -               pr_err("efivars: Subsystem registration failed.\n");
> -               goto err_remove_group;
> +       if (efivars_kobject()) {
> +               /* and the standard mountpoint for efivarfs */
> +               error = sysfs_create_mount_point(efi_kobj, "efivars");
> +               if (error) {
> +                       pr_err("efivars: Subsystem registration failed.\n");
> +                       goto err_remove_group;
> +               }
>         }
>
>         if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
> --
> 2.16.4
>
