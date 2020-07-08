Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100BC218D8D
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jul 2020 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgGHQvy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jul 2020 12:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgGHQvy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jul 2020 12:51:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1199CC061A0B
        for <linux-efi@vger.kernel.org>; Wed,  8 Jul 2020 09:51:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so3948001wml.3
        for <linux-efi@vger.kernel.org>; Wed, 08 Jul 2020 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xxNvnfTgLA4Td8NaWjHGsW53rCS5DmDa5Nl1mNiVX5o=;
        b=jg3lEoUWvlOc3r55+uZJ4vmEksMGXnjUJrUwJohfemBJfNJvmYfmtK6CqhYjp/uqy5
         3DqYc6sC6GrJdGok/qZq/G+vDEtFfLzco0nJXEgZZJDa9SSl4ziZiKgZkn7G3r6zk7ef
         uwvAEl0J4a396SvDrrz/aqo5EfsTZmjPdGJQ+t5Go4aP5KrFIvHiVr5GwZweMKGPqhgq
         61B2JWYZdXHY+o5E0ifG+LFSLBD9TlBSPmYvaWLqfERwPfGZmmF4MpvjD3QJM/UvK9Ko
         uozdvcXkiWfaCvSvP6u1GFfWh/uZK4DH2v0V6+V4XW6JL71Eak03Er+xKGPKsKJQtItz
         z+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxNvnfTgLA4Td8NaWjHGsW53rCS5DmDa5Nl1mNiVX5o=;
        b=R9DelQDJzazSGe1H6C/3jWWeC9FQEoKwPo8aHP73ztqmQsfPmBpqB2B3fFXOENQU2g
         WS966W31fsQP60quxGIBt4CkIejtqGRunvKcfbnV/mSxAAbhLengK+X71HDyJMDy0hiC
         wNPc/uZ4SBGVI2QInUFPlut/s6fbE5c8PJt9hLpr3n5jRpkli1lhmxphbgovtiivhET8
         TXZksUGt6meSrClBeDQ4UAJ2MdJZLS4H/2kAOAAjQHe+7+xEzWvyQQykNd58G69cT/qb
         M0S5bCYk4fnRzAGEt2ZPS218R2oqK3WWmNXza5AwVsX01JMSWUE7NQefaEmEdwACyio9
         FYHw==
X-Gm-Message-State: AOAM530lhvoJ5g2ZCLq/rLZ3wionkYgXviE0CeG170u7HUHsEoS2vQ34
        NztPJaX9zjFytnw16Pvb/LPyiu55HH0=
X-Google-Smtp-Source: ABdhPJwmSPwQpl4nSloRellR4zlRQGaAiKVP+a5NwxwpKdTwx5cF/H0Zt65Sc/+BUhzArPRObqVTWA==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr10186731wmc.188.1594227112581;
        Wed, 08 Jul 2020 09:51:52 -0700 (PDT)
Received: from apalos.home (athedsl-4423884.home.otenet.gr. [79.130.240.188])
        by smtp.gmail.com with ESMTPSA id j6sm854327wro.25.2020.07.08.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:51:52 -0700 (PDT)
Date:   Wed, 8 Jul 2020 19:51:49 +0300
From:   ilias.apalodimas@linaro.org
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, xypron.glpk@gmx.de
Subject: Re: [PATCH v3] efi/efivars: Expose RT service availability via
 efivars abstraction
Message-ID: <20200708165149.GA322853@apalos.home>
References: <20200708135135.11163-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708135135.11163-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 08, 2020 at 04:51:35PM +0300, Ard Biesheuvel wrote:
> Commit
> 
>   bf67fad19e493b ("efi: Use more granular check for availability for variable services")
> 
> introduced a check into the efivarfs, efi-pstore and other drivers that
> aborts loading of the module if not all three variable runtime services
> (GetVariable, SetVariable and GetNextVariable) are supported. However, this
> results in efivarfs being unavailable entirely if only SetVariable support
> is missing, which is only needed if you want to make any modifications.
> Also, efi-pstore and the sysfs EFI variable interface could be backed by
> another implementation of the 'efivars' abstraction, in which case it is
> completely irrelevant which services are supported by the EFI firmware.
> 
> So make the generic 'efivars' abstraction dependent on the availibility of
> the GetVariable and GetNextVariable EFI runtime services, and add a helper
> to find out whether the current 'efivars' abstraction supports writes (and
> wire it up to the availability of SetVariable for the generic one)
> 
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Fixes: bf67fad19e493b ("efi: Use more granular check for availability for variable services")
> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v3 of [0], which fixed things at the wrong layer - efivarfs does not care
> about EFI firmware, it only talks to the lower 'efivars' layer, which can be
> implemented in various different ways.
> 
> [0] https://lore.kernel.org/linux-efi/20200708111938.20948-1-ardb@kernel.org/
> 
>  drivers/firmware/efi/efi-pstore.c |  5 +----
>  drivers/firmware/efi/efi.c        | 12 ++++++++----
>  drivers/firmware/efi/efivars.c    |  5 +----
>  drivers/firmware/efi/vars.c       |  6 ++++++
>  fs/efivarfs/super.c               |  6 +++---
>  include/linux/efi.h               |  1 +
>  6 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
> index c2f1d4e6630b..feb7fe6f2da7 100644
> --- a/drivers/firmware/efi/efi-pstore.c
> +++ b/drivers/firmware/efi/efi-pstore.c
> @@ -356,10 +356,7 @@ static struct pstore_info efi_pstore_info = {
>  
>  static __init int efivars_pstore_init(void)
>  {
> -	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
> -		return 0;
> -
> -	if (!efivars_kobject())
> +	if (!efivars_kobject() || !efivar_supports_writes())
>  		return 0;
>  
>  	if (efivars_pstore_disable)
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 5114cae4ec97..fdd1db025dbf 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -176,11 +176,13 @@ static struct efivar_operations generic_ops;
>  static int generic_ops_register(void)
>  {
>  	generic_ops.get_variable = efi.get_variable;
> -	generic_ops.set_variable = efi.set_variable;
> -	generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
>  	generic_ops.get_next_variable = efi.get_next_variable;
>  	generic_ops.query_variable_store = efi_query_variable_store;
>  
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
> +		generic_ops.set_variable = efi.set_variable;
> +		generic_ops.set_variable_nonblocking = efi.set_variable_nonblocking;
> +	}
>  	return efivars_register(&generic_efivars, &generic_ops, efi_kobj);
>  }
>  
> @@ -382,7 +384,8 @@ static int __init efisubsys_init(void)
>  		return -ENOMEM;
>  	}
>  
> -	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES)) {
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
> +				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME)) {
>  		efivar_ssdt_load();
>  		error = generic_ops_register();
>  		if (error)
> @@ -416,7 +419,8 @@ static int __init efisubsys_init(void)
>  err_remove_group:
>  	sysfs_remove_group(efi_kobj, &efi_subsys_attr_group);
>  err_unregister:
> -	if (efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE |
> +				      EFI_RT_SUPPORTED_GET_NEXT_VARIABLE_NAME))
>  		generic_ops_unregister();
>  err_put:
>  	kobject_put(efi_kobj);
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 26528a46d99e..dcea137142b3 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -680,11 +680,8 @@ int efivars_sysfs_init(void)
>  	struct kobject *parent_kobj = efivars_kobject();
>  	int error = 0;
>  
> -	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
> -		return -ENODEV;
> -
>  	/* No efivars has been registered yet */
> -	if (!parent_kobj)
> +	if (!parent_kobj || !efivar_supports_writes())
>  		return 0;
>  
>  	printk(KERN_INFO "EFI Variables Facility v%s %s\n", EFIVARS_VERSION,
> diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
> index 5f2a4d162795..973eef234b36 100644
> --- a/drivers/firmware/efi/vars.c
> +++ b/drivers/firmware/efi/vars.c
> @@ -1229,3 +1229,9 @@ int efivars_unregister(struct efivars *efivars)
>  	return rv;
>  }
>  EXPORT_SYMBOL_GPL(efivars_unregister);
> +
> +int efivar_supports_writes(void)
> +{
> +	return __efivars && __efivars->ops->set_variable;
> +}
> +EXPORT_SYMBOL_GPL(efivar_supports_writes);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 12c66f5d92dd..28bb5689333a 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -201,6 +201,9 @@ static int efivarfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_d_op		= &efivarfs_d_ops;
>  	sb->s_time_gran         = 1;
>  
> +	if (!efivar_supports_writes())
> +		sb->s_flags |= SB_RDONLY;
> +
>  	inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
>  	if (!inode)
>  		return -ENOMEM;
> @@ -252,9 +255,6 @@ static struct file_system_type efivarfs_type = {
>  
>  static __init int efivarfs_init(void)
>  {
> -	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_VARIABLE_SERVICES))
> -		return -ENODEV;
> -
>  	if (!efivars_kobject())
>  		return -ENODEV;
>  
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index bb35f3305e55..05c47f857383 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -994,6 +994,7 @@ int efivars_register(struct efivars *efivars,
>  int efivars_unregister(struct efivars *efivars);
>  struct kobject *efivars_kobject(void);
>  
> +int efivar_supports_writes(void);
>  int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *),
>  		void *data, bool duplicates, struct list_head *head);
>  
> -- 
> 2.17.1
> 

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

