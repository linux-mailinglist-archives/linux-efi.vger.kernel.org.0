Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D5296FAB
	for <lists+linux-efi@lfdr.de>; Fri, 23 Oct 2020 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464040AbgJWMrQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Oct 2020 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464023AbgJWMrP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Oct 2020 08:47:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA93C0613CE
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:47:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so1690536wrn.0
        for <linux-efi@vger.kernel.org>; Fri, 23 Oct 2020 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=teGfWDMc4tg7gJOc+NSlRBxm4270R4Ay0Auhg+Y3mzw=;
        b=E8S0rwEEKUkP2HNzt3RXe0oKSRVKMF3HTz3pn2TnQe61AJyteKi8U80dJJ9wakCSSS
         U2vO2jP7FSEKw5FOnNR3bNe33Mh7bTCkDLizYPn/wa3+dPo/gKEEmi4PZ9u2yTwAZuVJ
         4cq1662XFrKB4Iw/yRyGubkSW5wyZGqusrI5lUwt+1jdF4HhZg1tvoOZ88dpB6NZmsNK
         8N1NZ7XSQg3m12xZLZjHbX9/eI2ivyyAMPY2d9SnU/M4RcrProoE6EvPnbZwnQEnm7HI
         I4W9SnpHEltZN3vUElKPpZtYmM+/V1+dkbcOz0fyeM3iVxmf9qIOovCsM3MCnpVVnMgk
         0J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=teGfWDMc4tg7gJOc+NSlRBxm4270R4Ay0Auhg+Y3mzw=;
        b=tksYnhwqxgMbYxWzncwbQA/6nNxRJv13TGMrjSsO2CuvS3gMM/eYTHqigXx/D55clm
         x9iuMZi3mXpwPDqwcnTvQOUIILNPHHJJH5qa16VIyQ9ga/xZ88NSzBGA55G5pC0NF3rC
         BdRs/x1RNHM7uUj70pEz6ih8CioqCLRbBH0ZQm+fmVS7yxJnWNvADPLQ5i0h88hzccMk
         1cBQpoVTXfrReAD+fk4ppxura3H97G+QLVoAuSH6W4QlzGR1I2T8gwY3vBw0MOJv4vG+
         JBUk44tlBBHVqAEWL+Ku6ll3O19xCA4F+/wQVgqaiXWUcELZeHSOX0g3q9XKVJBByYj2
         ug9Q==
X-Gm-Message-State: AOAM5338TaXJkN4ctJk6nVDhQcVzOHhAuprWZsmcUAaRGX6hbtTDIzPq
        aHOhWeSHjZRpcyidaz/yY+Ah0A==
X-Google-Smtp-Source: ABdhPJwuBzIbPqKO25sGmGQnl8kjVxQGYVYB+7Kno95ik/SbbKHOylDjwCxmisOyTeIzd4H700QQgQ==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr2454658wrr.300.1603457232984;
        Fri, 23 Oct 2020 05:47:12 -0700 (PDT)
Received: from vanye (cpc92880-cmbg19-2-0-cust79.5-4.cable.virginm.net. [82.27.104.80])
        by smtp.gmail.com with ESMTPSA id i33sm3189489wri.79.2020.10.23.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 05:47:12 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:47:10 +0100
From:   Leif Lindholm <leif@nuviainc.com>
To:     Ard Biesheuvel <ard.biesheuvel@arm.com>
Cc:     linux-efi@vger.kernel.org, grub-devel@gnu.org,
        daniel.kiper@oracle.com
Subject: Re: [PATCH 4/4] linux: ignore FDT unless we need to modify it
Message-ID: <20201023124710.GD1664@vanye>
References: <20201023120825.30466-1-ard.biesheuvel@arm.com>
 <20201023120825.30466-5-ard.biesheuvel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023120825.30466-5-ard.biesheuvel@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Oct 23, 2020 at 14:08:25 +0200, Ard Biesheuvel wrote:
> Now that we implemented supported for the LoadFile2 protocol for initrd
> loading, there is no longer a need to pass the initrd parameters via
> the device tree. This means there is no longer a reason to update the
> device tree in the first place, and so we can ignore it entirely.

There is a change in behaviour here which I don't think matters, but
I'll call it out anyway:
If there was ever a kernel out there with an EFI stub that depended on
a chosen node existing in the DT, and the one provide by firmware did
not contain one, that setup would break from this *if* it didn't use
an initrd.

/
    Leif

> The only remaining reason to deal with the devicetree is if we are
> using the 'devicetree' command to load one from disk, so tweak the
> logic in grub_fdt_install() to take that into account.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> ---
>  grub-core/loader/arm64/linux.c | 22 ++++++++++----------
>  grub-core/loader/efi/fdt.c     |  7 +++++--
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/grub-core/loader/arm64/linux.c b/grub-core/loader/arm64/linux.c
> index 285422c7bd43..9e282b6660fe 100644
> --- a/grub-core/loader/arm64/linux.c
> +++ b/grub-core/loader/arm64/linux.c
> @@ -93,21 +93,21 @@ finalize_params_linux (void)
>  
>    void *fdt;
>  
> -  fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
> +  /* Set initrd info */
> +  if (initrd_start && initrd_end > initrd_start)
> +    {
> +      fdt = grub_fdt_load (GRUB_EFI_LINUX_FDT_EXTRA_SPACE);
>  
> -  if (!fdt)
> -    goto failure;
> +      if (!fdt)
> +	goto failure;
>  
> -  node = grub_fdt_find_subnode (fdt, 0, "chosen");
> -  if (node < 0)
> -    node = grub_fdt_add_subnode (fdt, 0, "chosen");
> +      node = grub_fdt_find_subnode (fdt, 0, "chosen");
> +      if (node < 0)
> +	node = grub_fdt_add_subnode (fdt, 0, "chosen");
>  
> -  if (node < 1)
> -    goto failure;
> +      if (node < 1)
> +	goto failure;
>  
> -  /* Set initrd info */
> -  if (initrd_start && initrd_end > initrd_start)
> -    {
>        grub_dprintf ("linux", "Initrd @ %p-%p\n",
>  		    (void *) initrd_start, (void *) initrd_end);
>  
> diff --git a/grub-core/loader/efi/fdt.c b/grub-core/loader/efi/fdt.c
> index ee9c5592c700..ab900b27d927 100644
> --- a/grub-core/loader/efi/fdt.c
> +++ b/grub-core/loader/efi/fdt.c
> @@ -85,13 +85,16 @@ grub_fdt_install (void)
>    grub_efi_guid_t fdt_guid = GRUB_EFI_DEVICE_TREE_GUID;
>    grub_efi_status_t status;
>  
> +  if (!fdt && !loaded_fdt)
> +    return GRUB_ERR_NONE;
> +
>    b = grub_efi_system_table->boot_services;
> -  status = b->install_configuration_table (&fdt_guid, fdt);
> +  status = b->install_configuration_table (&fdt_guid, fdt ?: loaded_fdt);
>    if (status != GRUB_EFI_SUCCESS)
>      return grub_error (GRUB_ERR_IO, "failed to install FDT");
>  
>    grub_dprintf ("fdt", "Installed/updated FDT configuration table @ %p\n",
> -		fdt);
> +		fdt ?: loaded_fdt);
>    return GRUB_ERR_NONE;
>  }
>  
> -- 
> 2.17.1
> 
