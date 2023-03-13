Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741D86B70E2
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 09:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCMILl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCMILj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 04:11:39 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D6F3C22
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 01:11:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso10281731wmb.0
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678695097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEe2i5Niyz15TyqK5zefORFwtaI/pvogFz7meC3LSjE=;
        b=GVGvN99LRVt4uSalmlbY4pMSQ0mQrybphOHbuc4VRh1Vyl7pf3PfZQhe1hlxghyt9a
         n2rRBfPLhnTzOy4DXrD7Sd+XCyQQOiX34Sba8kLKQ7Qr/RiYxyoTbGGDCOX1ObMYJeT/
         /pc607W7cKDs5L46UIjBG+V8IYVzujQ/aF/1qMNXgqv6PLyRAPWK0vvrBMc0jGCHDloh
         r+E0DihBijKAtw1AQnODK4RJHovd8aD67VhqlwLH1lCSLBQrbE6nPExLeWGUmhtlfx5W
         WhQ+zcYbkE4lzKuRI0Vy9mdMuImjWb6ox2y0F4RviJCma+5MaP7DQJ8yAPUnA52SKxYi
         sV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678695097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEe2i5Niyz15TyqK5zefORFwtaI/pvogFz7meC3LSjE=;
        b=wkO0nVn49E+AuoBrBITzABSA/q7m51ZCxLAZFXQjElg/b6l/HLwpKYU8AFlxc31/Jt
         hhc6WaY4wvrxkimEDnZPpZaAxczai8Czxwndp7y63n9RzJCcUKMTlAfmUZDczqCcJe/9
         cAWH2Mmdo2OT17713e0YnzgXfzYKmyuLR5m8HE220MFmK4dBseiIqenAfsbU8Qmlg693
         j9yyEo9b9T7QaRlxawGfcyKgNLE/EWQ/51r4jcUV+ZsWMCjuQOGsN5KK7V0hM625pIuN
         kRfJUU1nggxE53IgoOn9bR2QlVGE5dLVVhTPF1Xa9jv6NQdqa2w47IfdBDfyHs3LJROs
         3t1Q==
X-Gm-Message-State: AO0yUKUuApJeTyyeRlpwpaaFRhpLjqpVjluC/gngbYvVQ/qh/CmGqF7x
        EBxfA2OmflQU99s6rHTmdJkjdT0YzGdJiTZOIxM=
X-Google-Smtp-Source: AK7set/rZU9sqIJeSVl4RiH5gS0Wn4z64q2vu6AfKRf4Gpqq5YLOfGOksN61dyGhx4Z+dKmoqn0xlQ==
X-Received: by 2002:a05:600c:19d1:b0:3e2:dba:7155 with SMTP id u17-20020a05600c19d100b003e20dba7155mr9701826wmq.20.1678695096686;
        Mon, 13 Mar 2023 01:11:36 -0700 (PDT)
Received: from hera (ppp176092130041.access.hol.gr. [176.92.130.41])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c315300b003e7c89b3514sm8829349wmo.23.2023.03.13.01.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 01:11:36 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:11:34 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Michael Brown <mcb30@ipxe.org>
Subject: Re: [PATCH 2/2] efi: libstub: Look for initrd LoadFile2 protocol on
 image handle
Message-ID: <ZA7atjWz16jQYr0H@hera>
References: <20230310084529.3229983-1-ardb@kernel.org>
 <20230310084529.3229983-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310084529.3229983-3-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Mar 10, 2023 at 09:45:29AM +0100, Ard Biesheuvel wrote:
> The use of a global singleton device path for describing the initrd to
> be loaded by the kernel implies that only a single handle can exist that
> carries the initrd LoadFile2 protocol implementation.
>
> This avoids the need on the part of the EFI stub to reason about which
> initrd is the preferred one when several are being provided - we already
> have initrd loading via the setup header on x86 and via DT on other
> architectures, in addition to the initrd= command line option, and so
> having a single loader provided initrd that supersedes all of them was
> deemed preferable over having multiple sources.
>
> However, this means that intermediate loader stages cannot simply
> install the LoadFile2 initrd device path, and will need to check for
> failures and deal with them. It also means that such stages will have to
> reason about whether or not the subsequent stage being loaded is the
> final one, or whether it may attempt to install the initrd device path
> itself.
>
> We can solve this by associating the initrd LoadFile2 protocol with the
> loaded image instead of with a global singleton device path. That way,
> each stage can associate any initrd it provides with the image that it
> is loading.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 42 ++++++++++++--------
>  include/linux/efi.h                            |  2 +-
>  include/linux/pe.h                             |  2 +-
>  3 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index d47aa855398b39a6..a97c95a1d99e0b9d 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -482,10 +482,11 @@ static const struct {
>  };
>
>  /**
> - * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
> - * @initrd:	pointer of struct to store the address where the initrd was loaded
> - *		and the size of the loaded initrd
> - * @max:	upper limit for the initrd memory allocation
> + * efi_load_initrd_lf2() - load the initrd from the Linux initrd device path
> + * @image_handle: EFI handle of the loaded image
> + * @initrd:	  pointer of struct to store the address where the initrd was
> + *                loaded and the size of the loaded initrd
> + * @max:	  upper limit for the initrd memory allocation
>   *
>   * Return:
>   * * %EFI_SUCCESS if the initrd was loaded successfully, in which
> @@ -495,24 +496,33 @@ static const struct {
>   * * %EFI_LOAD_ERROR in all other cases
>   */
>  static
> -efi_status_t efi_load_initrd_dev_path(struct linux_efi_initrd *initrd,
> -				      unsigned long max)
> +efi_status_t efi_load_initrd_lf2(efi_handle_t image_handle,
> +				 struct linux_efi_initrd *initrd,
> +				 unsigned long max)
>  {
>  	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
> +	efi_guid_t initrd_lf2_proto_guid = LINUX_EFI_INITRD_LF2_PROTOCOL_GUID;
>  	efi_device_path_protocol_t *dp;
>  	efi_load_file2_protocol_t *lf2;
>  	efi_handle_t handle;
>  	efi_status_t status;
>
> -	dp = (efi_device_path_protocol_t *)&initrd_dev_path;
> -	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> -	if (status != EFI_SUCCESS)
> -		return status;
> -
> -	status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> +	/* first look for a initrd loading protocol specific to this image */
> +	status = efi_bs_call(handle_protocol, image_handle, &initrd_lf2_proto_guid,
>  			     (void **)&lf2);
> -	if (status != EFI_SUCCESS)
> -		return status;
> +	if (status != EFI_SUCCESS) {
> +		/* look for the global singleton initrd loading protocol */
> +		dp = (efi_device_path_protocol_t *)&initrd_dev_path;
> +		status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp,
> +				     &handle);
> +		if (status != EFI_SUCCESS)
> +			return status;
> +
> +		status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> +				     (void **)&lf2);
> +		if (status != EFI_SUCCESS)
> +			return status;
> +	}
>
>  	initrd->size = 0;
>  	status = efi_call_proto(lf2, load_file, dp, false, &initrd->size, NULL);
> @@ -567,9 +577,9 @@ efi_status_t efi_load_initrd(efi_handle_t handle,
>  	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || efi_noinitrd)
>  		return EFI_SUCCESS;
>
> -	status = efi_load_initrd_dev_path(&initrd, hard_limit);
> +	status = efi_load_initrd_lf2(handle, &initrd, hard_limit);
>  	if (status == EFI_SUCCESS) {
> -		efi_info("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> +		efi_info("Loaded initrd using LoadFile2 protocol\n");
>  		if (initrd.size > 0 &&
>  		    efi_measure_tagged_event(initrd.base, initrd.size,
>  					     EFISTUB_EVT_INITRD) == EFI_SUCCESS)
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 04a733f0ba956211..83643d6aee755d85 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -417,7 +417,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
>  #define LINUX_EFI_COCO_SECRET_AREA_GUID		EFI_GUID(0xadf956ad, 0xe98c, 0x484c,  0xae, 0x11, 0xb5, 0x1c, 0x7d, 0x33, 0x64, 0x47)
>  #define LINUX_EFI_BOOT_MEMMAP_GUID		EFI_GUID(0x800f683f, 0xd08b, 0x423a,  0xa2, 0x93, 0x96, 0x5c, 0x3c, 0x6f, 0xe2, 0xb4)
> -
> +#define LINUX_EFI_INITRD_LF2_PROTOCOL_GUID	EFI_GUID(0xf9e3378e, 0xb3b1, 0x423a,  0xbd, 0x9a, 0x2d, 0x08, 0x60, 0x28, 0x7f, 0x72)
>  #define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
>
>  /*
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 6ffabf1e6d039e67..934e3a15ea7ddc07 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -29,7 +29,7 @@
>   * handover_offset and xloadflags fields in the bootparams structure.
>   */
>  #define LINUX_EFISTUB_MAJOR_VERSION		0x1
> -#define LINUX_EFISTUB_MINOR_VERSION		0x1
> +#define LINUX_EFISTUB_MINOR_VERSION		0x2
>
>  /*
>   * LINUX_PE_MAGIC appears at offset 0x38 into the MS-DOS header of EFI bootable
> --
> 2.39.2
>

Tested (with a slightly hacked version of u-boot) both paths.

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
