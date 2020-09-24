Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC2C276DDB
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 11:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIXJvl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 05:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgIXJvl (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 24 Sep 2020 05:51:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8DE2396E;
        Thu, 24 Sep 2020 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600941100;
        bh=TgimIo4LtMHR70zUjNJMS20tf+W7300XmLWfy8v9sGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RaSEtGHdwDuOalyNKwB4D+91VvPEZc8LHgmr9sFNvoDdAPXoF3w0tfJMTegCsgM2H
         z3uJSjoFYs6jjZdCcVArtbadiz6gWj7UnEiZ2En6DgEAiUNfLliPgsN+TkKE+mblIy
         3l9o03DLJkf296TIgFeZFDWP64uGgBQJti7GKwZU=
Date:   Thu, 24 Sep 2020 11:51:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>, Ard Biesheuvel <ardb@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Fabian Vogt <fvogt@suse.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] efi/efivars: Create efivars mount point in the
 registration of efivars abstraction
Message-ID: <20200924095157.GA304421@kroah.com>
References: <20200924082833.12722-1-jlee@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924082833.12722-1-jlee@suse.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 24, 2020 at 04:28:33PM +0800, Lee, Chun-Yi wrote:
> This patch moved the logic of creating efivars mount point to the
> registration of efivars abstraction. It's useful for userland to
> determine the availability of efivars filesystem by checking the
> existence of mount point.

Why not do what all other tools do, and look in /proc/filesystems?

Why is efivars "special" in this way?  What tool isn't properly looking
for the filesystem in that way today?

> The 'efivars' platform device be created on generic EFI runtime services
> platform, so it can be used to determine the availability of efivarfs.
> But this approach is not available for google gsmi efivars abstraction.

I do not understand this last sentence, can you try to explain it
better?

> This patch be tested on Here on qemu-OVMF and qemu-uboot.

How about real hardware?  :)

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
>  drivers/firmware/efi/efi.c  |  7 -------
>  drivers/firmware/efi/vars.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 3aa07c3b5136..23c11a2a3f4d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -405,13 +405,6 @@ static int __init efisubsys_init(void)
>  	if (error)
>  		goto err_remove_group;
>  
> -	/* and the standard mountpoint for efivarfs */
> -	error = sysfs_create_mount_point(efi_kobj, "efivars");
> -	if (error) {
> -		pr_err("efivars: Subsystem registration failed.\n");
> -		goto err_remove_group;
> -	}
> -
>  	if (efi_enabled(EFI_DBG) && efi_enabled(EFI_PRESERVE_BS_REGIONS))
>  		efi_debugfs_init();
>  
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 973eef234b36..6fa7f288d635 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -1179,6 +1179,8 @@ int efivars_register(struct efivars *efivars,
>  		     const struct efivar_operations *ops,
>  		     struct kobject *kobject)
>  {
> +	int error;
> +
>  	if (down_interruptible(&efivars_lock))
>  		return -EINTR;
>  
> @@ -1191,6 +1193,19 @@ int efivars_register(struct efivars *efivars,
>  
>  	up(&efivars_lock);
>  
> +	/* and the standard mountpoint for efivarfs */
> +	if (efi_kobj) {

Why test for this?  Can it race?

thanks,

greg k-h
