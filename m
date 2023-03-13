Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5C16B7015
	for <lists+linux-efi@lfdr.de>; Mon, 13 Mar 2023 08:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCMHZm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Mar 2023 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHZl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Mar 2023 03:25:41 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375A2312C
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:25:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l12so2009399wrm.10
        for <linux-efi@vger.kernel.org>; Mon, 13 Mar 2023 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678692339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCHID2rQx9HU+G56RqSfYvcOndtepLtlxvxu9BRx400=;
        b=TQ7Q3HRLE+zMXdLyTgME1YI29fLu8akcJjlQDD0PlzbU47h4p5EOxk5svhjfrtomzK
         rCyWRfnVl/Sis54acKW520tsBrVVWs5JvCCF9aGyotU2yJW1cTs6NysKdyUegPA519Qd
         fU9n1XtFL4Wvnma7sidW2U9l8KUkAMjt+TaehO+8RwgOrXo5+SvrS2rEBCc3JwumLL5I
         awmO71TqrVQ9W9NwPPQ3vmk2+TXt5JIDoFbsi1TcFSF/LEL78PAkrrkxHSnbYZedhusp
         +jBUp54FipPPlF3LRVLRLDYkUIMU0YQiCt+fIe2a3XG5sC5tcHE+rzjIa8E701JHDSXt
         8C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678692339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCHID2rQx9HU+G56RqSfYvcOndtepLtlxvxu9BRx400=;
        b=r+m7BR3HmgU5vqnYdlg4hnp1vgk55nt0x+MtL4wdlg7LtqB5jQ15ZnpRK1z6pKS820
         yKAvnv4liaSIsPEua6ySAx1ieNkegwlw3149zkApoE6kNcL2ICCmIhzBTNxN5OLYf6We
         1LBGRidJZ4a1L6dTkgHfGHof6A/l5tz/NSVrPzVUe7X5mfWFvJVAz+r+to5Llg7Zpc6R
         /i4fBZqR4pr5HN4RMkSJ9CpZLd0Dw66j0HzEgARfhrBfsE1P6rEitpc98BK/9InojM/C
         6DhDM/c+WhsisUQmx0ACGk+8ehGd0vQ9JDIVhiX+jQTvBCCXLzvJccbyZkyNdqz1oh7G
         i73Q==
X-Gm-Message-State: AO0yUKXi86W6OL5EzawwOM+8g/Emi43gw+mLlRpp3ZKGNQDltpCTqLhz
        oLioh0gay3vXvUcsn4p/yTZk3UcH95Zoy/5eO88=
X-Google-Smtp-Source: AK7set99AeZ+pDzT6pUBHo3uU4ohEjjG54Ey0jHypjD1W+6c3gIhmCikzkPK1kEf1VsJpEXr87u/SA==
X-Received: by 2002:adf:df81:0:b0:2ca:f680:cbf4 with SMTP id z1-20020adfdf81000000b002caf680cbf4mr23899875wrl.39.1678692338657;
        Mon, 13 Mar 2023 00:25:38 -0700 (PDT)
Received: from hera (ppp176092130041.access.hol.gr. [176.92.130.41])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d6042000000b002c71703876bsm7017833wrt.14.2023.03.13.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 00:25:38 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:25:36 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Michael Brown <mcb30@ipxe.org>
Subject: Re: [PATCH 1/2] efi: libstub: Pass loaded image EFI handle to
 efi_load_initrd()
Message-ID: <ZA7P8DdLaknIHQGR@hera>
References: <20230310084529.3229983-1-ardb@kernel.org>
 <20230310084529.3229983-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310084529.3229983-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Fri, Mar 10, 2023 at 09:45:28AM +0100, Ard Biesheuvel wrote:
> In preparation for allowing loaders to pass the initrd loadfile2
> protocol implementation via the loaded image handle instead of a global
> singleton device path, pass the loaded image EFI handle down to the code
> that loads the initrd.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 3 ++-
>  drivers/firmware/efi/libstub/efi-stub.c        | 4 ++--
>  drivers/firmware/efi/libstub/efistub.h         | 3 ++-
>  drivers/firmware/efi/libstub/x86-stub.c        | 4 ++--
>  4 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 1e0203d74691ffcc..d47aa855398b39a6 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -554,7 +554,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
>   *
>   * Return:	status code
>   */
> -efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> +efi_status_t efi_load_initrd(efi_handle_t handle,
> +			     efi_loaded_image_t *image,
>  			     unsigned long soft_limit,
>  			     unsigned long hard_limit,
>  			     const struct linux_efi_initrd **out)
> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> index 2955c1ac6a36ee00..a5eb773a574143cf 100644
> --- a/drivers/firmware/efi/libstub/efi-stub.c
> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> @@ -177,8 +177,8 @@ efi_status_t efi_stub_common(efi_handle_t handle,
>  	/* Ask the firmware to clear memory on unclean shutdown */
>  	efi_enable_reset_attack_mitigation();
>
> -	efi_load_initrd(image, ULONG_MAX, efi_get_max_initrd_addr(image_addr),
> -			NULL);
> +	efi_load_initrd(handle, image, ULONG_MAX,
> +			efi_get_max_initrd_addr(image_addr), NULL);
>
>  	efi_random_get_seed();
>
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 6bd3bb86d9679a1c..8a77aeae9e2215a5 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -1019,7 +1019,8 @@ static inline efi_status_t efi_load_dtb(efi_loaded_image_t *image,
>  				    ULONG_MAX, ULONG_MAX, load_addr, load_size);
>  }
>
> -efi_status_t efi_load_initrd(efi_loaded_image_t *image,
> +efi_status_t efi_load_initrd(efi_handle_t handle,
> +			     efi_loaded_image_t *image,
>  			     unsigned long soft_limit,
>  			     unsigned long hard_limit,
>  			     const struct linux_efi_initrd **out);
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index a0bfd31358ba97b1..e79f6977b41c15c2 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -867,8 +867,8 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
>  	 * arguments will be processed only if image is not NULL, which will be
>  	 * the case only if we were loaded via the PE entry point.
>  	 */
> -	status = efi_load_initrd(image, hdr->initrd_addr_max, ULONG_MAX,
> -				 &initrd);
> +	status = efi_load_initrd(handle, image, hdr->initrd_addr_max,
> +				 ULONG_MAX, &initrd);
>  	if (status != EFI_SUCCESS)
>  		goto fail;
>  	if (initrd && initrd->size > 0) {
> --
> 2.39.2
>

Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

