Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809FF24BF81
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgHTNjL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Aug 2020 09:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgHTJal (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Aug 2020 05:30:41 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD926207FB;
        Thu, 20 Aug 2020 09:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915839;
        bh=aMJupPBQ4LxbwYlKEK/6QB+6fhqLMcVfiMNCpsaL+xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f4sMLbF3Ul/oSOcXWDtf7iwQrI3+vQvCq5y7Yl3ym07AuGuA3UOAR7s39x12gHGk1
         bdOJyPHLfbdDmAyl1/S0WykPWX7i9HcBevqZzcszcsR/S/s/QWZrnc/71hV3B+fF8y
         IcfGhTLfd4jaho8ZwXiXIA1vEWA3QC+wAsjyhP+c=
Received: by mail-oi1-f171.google.com with SMTP id z22so1331795oid.1;
        Thu, 20 Aug 2020 02:30:38 -0700 (PDT)
X-Gm-Message-State: AOAM530RY4IMwYFWRqpHw7op23RTsLivnLutRFYlTm1Uz4U7Ip3WnfBC
        p1RcQx7Ozr82/YTz8SB2y97mUtf5D4JW6HxcJPk=
X-Google-Smtp-Source: ABdhPJxemHzFYiAaONEKxIjjxb830jZ1kTPr+TQsBCiFxqktaVfNOEcVPetmqS9UkEP59AbuX1DST0GcTwJkFK5yo5k=
X-Received: by 2002:a05:6808:b:: with SMTP id u11mr1168892oic.33.1597915838236;
 Thu, 20 Aug 2020 02:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200819092838.11290-1-jlee@suse.com>
In-Reply-To: <20200819092838.11290-1-jlee@suse.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Aug 2020 11:30:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGx=34tqSWqDUbfJ5WAB-3rWhBc1xsh2-kk2pQgcnfbRQ@mail.gmail.com>
Message-ID: <CAMj1kXGx=34tqSWqDUbfJ5WAB-3rWhBc1xsh2-kk2pQgcnfbRQ@mail.gmail.com>
Subject: Re: [PATCH] efi/efivars: create efivars mount point when get variable
 services are available
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Aug 2020 at 11:28, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
>
> The efivars filesystem depends on GetVariable or GetNextVariable EFI
> runtime services. So the /sys/firmware/efi/efivars does not need to be
> created when GetVariable and GetNextVariable are not available.
>
> It is useful for userland to determine the availability of efivars
> filesystem.
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>

Hello Joey,

This is not the right check to perform here: the efivarfs code could
be instantiated using a different efivars abstraction, so whether the
RT services are implemented is not entirely relevant.

Please look at commit f88814cc2578c121e6edef686365036db72af0ed
("efi/efivars: Expose RT service availability via efivars
abstraction") for an explanation of the underlying issue, and update
your patch accordingly.


> ---
>  drivers/firmware/efi/efi.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index fdd1db025dbf..929fbf4dfd5d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -404,11 +404,14 @@ static int __init efisubsys_init(void)
>         if (error)
>                 goto err_remove_group;
>
> -       /* and the standard mountpoint for efivarfs */
> -       error = sysfs_create_mount_point(efi_kobj, "efivars");
> -       if (error) {
> -               pr_err("efivars: Subsystem registration failed.\n");
> -               goto err_remove_group;
> +       if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
> +                                     EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
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
