Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3A2A57C8
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 22:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbgKCVpz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 16:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbgKCVpy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 16:45:54 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C5DC0613D1
        for <linux-efi@vger.kernel.org>; Tue,  3 Nov 2020 13:45:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 38D80128095D;
        Tue,  3 Nov 2020 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604439954;
        bh=RbE9NNXWBkXoM5N8yuWmVkQIALuK4inWa29n3wJx+20=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=bfJiZ0bef75J7b8t+wr27z9GRAnWCuEyCWIi2cmi73uHI9F3qWz7ODt4lwweiCJRy
         gfLS3sAVy54ZFCkuYQu0ptbx07X3jqjCJt+F5s2qmA25FZxGRnzNrgainqmUoRAeJW
         41FuWUJwUEaQGe7+x+YAxKmnrp/662LTcxhW/Ygw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4DjvuF4wAxqQ; Tue,  3 Nov 2020 13:45:54 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9BCC912808E6;
        Tue,  3 Nov 2020 13:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604439954;
        bh=RbE9NNXWBkXoM5N8yuWmVkQIALuK4inWa29n3wJx+20=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=bfJiZ0bef75J7b8t+wr27z9GRAnWCuEyCWIi2cmi73uHI9F3qWz7ODt4lwweiCJRy
         gfLS3sAVy54ZFCkuYQu0ptbx07X3jqjCJt+F5s2qmA25FZxGRnzNrgainqmUoRAeJW
         41FuWUJwUEaQGe7+x+YAxKmnrp/662LTcxhW/Ygw=
Message-ID: <0bbde2ad79c3389c8663401a67edc502d5d86bc1.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH 7/7] efi/libstub: measure loaded initrd info into
 the TPM
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>, Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Tue, 03 Nov 2020 13:45:52 -0800
In-Reply-To: <20201102170634.20575-8-ardb@kernel.org>
References: <20201102170634.20575-1-ardb@kernel.org>
         <20201102170634.20575-8-ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-11-02 at 18:06 +0100, Ard Biesheuvel wrote:
> Modify the initrd loading sequence so that the contents of the initrd
> loaded by the EFI stub are measured into the TPM. Note that this also
> includes the measurement of a zero sized input if the stub's initrd
> loader fails for any reason, or simply succeeds with no result, which
> it does for legacy reasons when using the initrd= command line
> option.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 53 +++++++++++++++-
> ----
>  1 file changed, 40 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c
> b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 72a7e7c4d403..d8cf1911171a 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -625,6 +625,22 @@ efi_status_t
> efi_load_initrd_cmdline(efi_loaded_image_t *image,
>  				    load_addr, load_size);
>  }
>  
> +static const struct {
> +	efi_tcg2_event_t	event_data;
> +	u8			description[];
> +} initrd_tcg2_event = {
> +	{
> +		sizeof(initrd_tcg2_event),
> +		{
> +			sizeof(initrd_tcg2_event.event_data.event_heade
> r),
> +			EFI_TCG2_EVENT_HEADER_VERSION,
> +			0,
> +			0
> +		},
> +	},
> +	"Linux initrd"
> +};
> +
>  /**
>   * efi_load_initrd() - Load initial RAM disk
>   * @image:	EFI loaded image protocol
> @@ -641,25 +657,36 @@ efi_status_t efi_load_initrd(efi_loaded_image_t
> *image,
>  			     unsigned long soft_limit,
>  			     unsigned long hard_limit)
>  {
> +	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
> +	efi_tcg2_protocol_t *tcg2 = NULL;
>  	efi_status_t status;
>  
>  	if (efi_noinitrd) {
>  		*load_addr = *load_size = 0;
> -		return EFI_SUCCESS;
> +		status = EFI_SUCCESS;
> +	} else {
> +		status = efi_load_initrd_dev_path(load_addr, load_size,
> hard_limit);
> +		if (status == EFI_SUCCESS) {
> +			efi_info("Loaded initrd from
> LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> +		} else if (status == EFI_NOT_FOUND) {
> +			status = efi_load_initrd_cmdline(image,
> load_addr, load_size,
> +							 soft_limit,
> hard_limit);
> +			if (status == EFI_SUCCESS && *load_size > 0)
> +				efi_info("Loaded initrd from command
> line option\n");
> +		}
> +		if (status != EFI_SUCCESS) {
> +			efi_err("Failed to load initrd: 0x%lx\n",
> status);
> +			*load_addr = *load_size = 0;
> +		}
>  	}
>  
> -	status = efi_load_initrd_dev_path(load_addr, load_size,
> hard_limit);
> -	if (status == EFI_SUCCESS) {
> -		efi_info("Loaded initrd from
> LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> -	} else if (status == EFI_NOT_FOUND) {
> -		status = efi_load_initrd_cmdline(image, load_addr,
> load_size,
> -						 soft_limit,
> hard_limit);
> -		if (status == EFI_SUCCESS && *load_size > 0)
> -			efi_info("Loaded initrd from command line
> option\n");
> -	}
> -	if (status != EFI_SUCCESS) {
> -		efi_err("Failed to load initrd: 0x%lx\n", status);
> -		*load_addr = *load_size = 0;
> +	efi_bs_call(locate_protocol, &tcg2_guid, NULL, (void **)&tcg2);
> +	if (tcg2) {
> +		efi_status_t s = efi_call_proto(tcg2,
> hash_log_extend_event,
> +						0, *load_addr,
> *load_size,
> +						&initrd_tcg2_event.even
> t_data);
> +		if (s != EFI_SUCCESS)
> +			efi_warn("Failed to measure initrd data into
> PCR #xx: 0x%lx\n", s);

Both shim and grub currently work for both TPMs 1.2 and 2.0.  I get
that TPM 1.2 should be going away, but it is taking quite a long time
to exit the ecosystem so I don't think we can get away with being TPM
2.0 only here.

James


