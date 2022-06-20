Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285F85515CD
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jun 2022 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiFTK1C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jun 2022 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbiFTK1C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jun 2022 06:27:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4679413FAB;
        Mon, 20 Jun 2022 03:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 91C25CE1169;
        Mon, 20 Jun 2022 10:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B6FC3411B;
        Mon, 20 Jun 2022 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655720816;
        bh=prCd0hruC00HknZ99+NKnyfp0ohBvyccw/iGZdVf9I8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RUSIJCIeSvKsOxT2OJhAgHrXUmHpRgIXT7zDhrpTVEBo7F1WSwmTVma0IFiu9sMbX
         X9g8ekD/RRp+6LjjJ6vxPMq03lySLTBa4+8Z/LkR6o+1QV20HAuCHkd5tQo1OXwYDR
         arSy0TkKFTDNpz/2c1TRJLhNez7bILVYzComVjJk=
Date:   Mon, 20 Jun 2022 12:26:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-efi@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] media: atomisp_gmin_platform: stop abusing efivar API
Message-ID: <YrBLbb7jYNFautj7@kroah.com>
References: <20220620100819.1682995-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620100819.1682995-1-ardb@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jun 20, 2022 at 12:08:19PM +0200, Ard Biesheuvel wrote:
> As the code comment already suggests, using the efivar API in this way
> is not how it is intended, and so let's switch to the right one, which
> is simply to call efi.get_variable() directly after checking whether or
> not the GetVariable() runtime service is supported.
> 
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> 
> If I can please get an ack, I'd like to take this via the EFI tree for
> the next cycle.
> 
>  drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 27 +++++---------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> index 7e47db82de07..bf527b366ab3 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
> @@ -1284,7 +1284,7 @@ static int gmin_get_config_var(struct device *maindev,
>  	const struct dmi_system_id *id;
>  	struct device *dev = maindev;
>  	char var8[CFG_VAR_NAME_MAX];
> -	struct efivar_entry *ev;
> +	efi_status_t status;
>  	int i, ret;
>  
>  	/* For sensors, try first to use the _DSM table */
> @@ -1326,24 +1326,11 @@ static int gmin_get_config_var(struct device *maindev,
>  	for (i = 0; i < sizeof(var8) && var8[i]; i++)
>  		var16[i] = var8[i];
>  
> -	/* Not sure this API usage is kosher; efivar_entry_get()'s
> -	 * implementation simply uses VariableName and VendorGuid from
> -	 * the struct and ignores the rest, but it seems like there
> -	 * ought to be an "official" efivar_entry registered
> -	 * somewhere?
> -	 */
> -	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
> -	if (!ev)
> -		return -ENOMEM;
> -	memcpy(&ev->var.VariableName, var16, sizeof(var16));
> -	ev->var.VendorGuid = GMIN_CFG_VAR_EFI_GUID;
> -	ev->var.DataSize = *out_len;
> -
> -	ret = efivar_entry_get(ev, &ev->var.Attributes,
> -			       &ev->var.DataSize, ev->var.Data);
> -	if (ret == 0) {
> -		memcpy(out, ev->var.Data, ev->var.DataSize);
> -		*out_len = ev->var.DataSize;
> +	status = EFI_UNSUPPORTED;
> +	if (efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
> +		status = efi.get_variable(var16, &GMIN_CFG_VAR_EFI_GUID, NULL,
> +					  (unsigned long *)out_len, out);
> +	if (status == EFI_SUCCESS) {
>  		dev_info(maindev, "found EFI entry for '%s'\n", var8);
>  	} else if (is_gmin) {
>  		dev_info(maindev, "Failed to find EFI gmin variable %s\n", var8);
> @@ -1351,8 +1338,6 @@ static int gmin_get_config_var(struct device *maindev,
>  		dev_info(maindev, "Failed to find EFI variable %s\n", var8);
>  	}
>  
> -	kfree(ev);
> -
>  	return ret;
>  }
>  
> -- 
> 2.35.1
> 
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
