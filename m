Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04757160E40
	for <lists+linux-efi@lfdr.de>; Mon, 17 Feb 2020 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgBQJP4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Feb 2020 04:15:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728735AbgBQJP4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Feb 2020 04:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581930954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EgMb7L+Jk+NDmD6nral/wNc+0FHp0VgeO19GoZkzzE0=;
        b=PTy14ry/RFxEE2iAqDXqcx1C7pnnnObmUzgVYQ9FS1jhVF3DYzJFpzRRzAQQDO9Sjp/5c8
        L5x5WS9R/ZQ6qbU+4QIlIWh20GlnZlHNGOsoAvlzUovvGYRgsjxXGVOYuuma1eHQC3kxhW
        K+jMGBPwN4e/JhAzYUy1ocKfpwucfF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qPbres-FOd2BrfqhS5yOjw-1; Mon, 17 Feb 2020 04:15:53 -0500
X-MC-Unique: qPbres-FOd2BrfqhS5yOjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C181D107ACCC;
        Mon, 17 Feb 2020 09:15:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-195.ams2.redhat.com [10.36.116.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70EAB5DA75;
        Mon, 17 Feb 2020 09:15:47 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] efi/libstub: Add support for loading the initrd
 from a device path
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, ilias.apalodimas@linaro.org,
        xypron.glpk@gmx.de, daniel.kiper@oracle.com, nivedita@alum.mit.edu,
        James.Bottomley@hansenpartnership.com, lukas@wunner.de
References: <20200216141104.21477-1-ardb@kernel.org>
 <20200216141104.21477-3-ardb@kernel.org>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <4e427366-4141-e360-b1da-c5cb37f8092b@redhat.com>
Date:   Mon, 17 Feb 2020 10:15:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200216141104.21477-3-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/16/20 15:11, Ard Biesheuvel wrote:
> There are currently two ways to specify the initrd to be passed to the
> Linux kernel when booting via the EFI stub:
> - it can be passed as a initrd= command line option when doing a pure PE
>   boot (as opposed to the EFI handover protocol that exists for x86)
> - otherwise, the bootloader or firmware can load the initrd into memory,
>   and pass the address and size via the bootparams struct (x86) or
>   device tree (ARM)
> 
> In the first case, we are limited to loading from the same file system
> that the kernel was loaded from, and it is also problematic in a trusted
> boot context, given that we cannot easily protect the command line from
> tampering without either adding complicated white/blacklisting of boot
> arguments or locking down the command line altogether.
> 
> In the second case, we force the bootloader to duplicate knowledge about
> the boot protocol which is already encoded in the stub, and which may be
> subject to change over time, e.g., bootparams struct definitions, memory
> allocation/alignment requirements for the placement of the initrd etc etc.
> In the ARM case, it also requires the bootloader to modify the hardware
> description provided by the firmware, as it is passed in the same file.
> On systems where the initrd is measured after loading, it creates a time
> window where the initrd contents might be manipulated in memory before
> handing over to the kernel.
> 
> Address these concerns by adding support for loading the initrd into
> memory by invoking the EFI LoadFile2 protocol installed on a vendor
> GUIDed device path that specifically designates a Linux initrd.
> This addresses the above concerns, by putting the EFI stub in charge of
> placement in memory and of passing the base and size to the kernel proper
> (via whatever means it desires) while still leaving it up to the firmware
> or bootloader to obtain the file contents, potentially from other file
> systems than the one the kernel itself was loaded from. On platforms that
> implement measured boot, it permits the firmware to take the measurement
> right before the kernel actually consumes the contents.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/firmware/efi/libstub/arm-stub.c        | 15 +++-
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 82 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h         |  4 +
>  drivers/firmware/efi/libstub/x86-stub.c        | 23 ++++++
>  include/linux/efi.h                            |  1 +
>  5 files changed, 122 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index 2edc673ea06c..4bae620b95b9 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -160,6 +160,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>  	enum efi_secureboot_mode secure_boot;
>  	struct screen_info *si;
>  	efi_properties_table_t *prop_tbl;
> +	unsigned long max_addr;
>  
>  	sys_table = sys_table_arg;
>  
> @@ -258,10 +259,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>  	if (!fdt_addr)
>  		pr_efi("Generating empty DTB\n");
>  
> -	status = efi_load_initrd(image, &initrd_addr, &initrd_size, ULONG_MAX,
> -				 efi_get_max_initrd_addr(dram_base, *image_addr));
> +	max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
> +	status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
> +	if (status == EFI_SUCCESS) {
> +		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> +	} else if (status == EFI_NOT_FOUND) {
> +		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
> +					 ULONG_MAX, max_addr);
> +		if (status == EFI_SUCCESS)
> +			pr_efi("Loaded initrd from command line option\n");
> +	}
>  	if (status != EFI_SUCCESS)
> -		pr_efi_err("Failed initrd from command line!\n");
> +		pr_efi_err("Failed to load initrd!\n");
>  
>  	efi_random_get_seed();
>  
> diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
> index 49008ac88b63..e37afe2c752e 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -299,3 +299,85 @@ void efi_char16_printk(efi_char16_t *str)
>  	efi_call_proto(efi_table_attr(efi_system_table(), con_out),
>  		       output_string, str);
>  }
> +
> +/*
> + * The LINUX_EFI_INITRD_MEDIA_GUID vendor media device path below provides a way
> + * for the firmware or bootloader to expose the initrd data directly to the stub
> + * via the trivial LoadFile2 protocol, which is defined in the UEFI spec, and is
> + * very easy to implement. It is a simple Linux initrd specific conduit between
> + * kernel and firmware, allowing us to put the EFI stub (being part of the
> + * kernel) in charge of where and when to load the initrd, while leaving it up
> + * to the firmware to decide whether it needs to expose its filesystem hierarchy
> + * via EFI protocols.
> + */
> +static const struct {
> +	struct efi_vendor_dev_path	vendor;
> +	struct efi_generic_dev_path	end;
> +} __packed initrd_dev_path = {
> +	{
> +		EFI_DEV_MEDIA,
> +		EFI_DEV_MEDIA_VENDOR,
> +		sizeof(struct efi_vendor_dev_path),
> +		LINUX_EFI_INITRD_MEDIA_GUID
> +	}, {
> +		EFI_DEV_END_PATH,
> +		EFI_DEV_END_ENTIRE,
> +		sizeof(struct efi_generic_dev_path)
> +	}
> +};
> +
> +/**
> + * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
> + * @load_addr:	pointer to store the address where the initrd was loaded
> + * @load_size:	pointer to store the size of the loaded initrd
> + * @max:	upper limit for the initrd memory allocation
> + * @return:	%EFI_SUCCESS if the initrd was loaded successfully, in which case
> + * 		@load_addr and @load_size are assigned accordingly
> + * 		%EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
> + * 		device path
> + *		%EFI_LOAD_ERROR in all other cases

[*]

> + */
> +efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
> +				      unsigned long *load_size,
> +				      unsigned long max)
> +{
> +	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
> +	efi_device_path_protocol_t *dp;
> +	efi_load_file2_protocol_t *lf2;
> +	unsigned long initrd_addr;
> +	unsigned long initrd_size;
> +	efi_handle_t handle;
> +	efi_status_t status;
> +
> +	if (!load_addr || !load_size)
> +		return EFI_INVALID_PARAMETER;

Doesn't return EFI_LOAD_ERROR.

> +
> +	dp = (efi_device_path_protocol_t *)&initrd_dev_path;
> +	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> +	if (status != EFI_SUCCESS)
> +		return status;

Seems safe (the only plausible error could be EFI_NOT_FOUND).

> +
> +	status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> +			     (void **)&lf2);
> +	if (status != EFI_SUCCESS)
> +		return status;

Interesting case; this should never fail... but note, if it does, it
returns EFI_UNSUPPORTED, not EFI_NOT_FOUND (if the protocol is missing
from the handle).

> +
> +	status = efi_call_proto(lf2, load_file, dp, false, &initrd_size, NULL);
> +	if (status != EFI_BUFFER_TOO_SMALL)
> +		return EFI_LOAD_ERROR;
> +
> +	status = efi_allocate_pages(initrd_size, &initrd_addr, max);
> +	if (status != EFI_SUCCESS)
> +		return status;

Not sure about the efi_allocate_pages() wrapper (?); the UEFI service
could return EFI_OUT_OF_RESOURCES.

Looks OK to me otherwise.

(... I'm a bit doubtful of passing and End node to LF2 rather than a
filepath node with "" for pathname, but it's an LF2 on our own vendor
path, so I guess we dictate what we accept.)

Thanks
Laszlo

> +
> +	status = efi_call_proto(lf2, load_file, dp, false, &initrd_size,
> +				(void *)initrd_addr);
> +	if (status != EFI_SUCCESS) {
> +		efi_free(initrd_size, initrd_addr);
> +		return EFI_LOAD_ERROR;
> +	}
> +
> +	*load_addr = initrd_addr;
> +	*load_size = initrd_size;
> +	return EFI_SUCCESS;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 34fe3fad042f..b58cb2c4474e 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -640,4 +640,8 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>  			     unsigned long soft_limit,
>  			     unsigned long hard_limit);
>  
> +efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
> +				      unsigned long *load_size,
> +				      unsigned long max);
> +
>  #endif
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index 681b620d8d40..16bf4ed21f1f 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -699,9 +699,14 @@ struct boot_params *efi_main(efi_handle_t handle,
>  {
>  	unsigned long bzimage_addr = (unsigned long)startup_32;
>  	struct setup_header *hdr = &boot_params->hdr;
> +	unsigned long max_addr = hdr->initrd_addr_max;
> +	unsigned long initrd_addr, initrd_size;
>  	efi_status_t status;
>  	unsigned long cmdline_paddr;
>  
> +	if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
> +		max_addr = ULONG_MAX;
> +
>  	sys_table = sys_table_arg;
>  
>  	/* Check if we were booted by the EFI firmware */
> @@ -734,6 +739,24 @@ struct boot_params *efi_main(efi_handle_t handle,
>  			 ((u64)boot_params->ext_cmd_line_ptr << 32));
>  	efi_parse_options((char *)cmdline_paddr);
>  
> +	/*
> +	 * At this point, an initrd may already have been loaded, either by
> +	 * the bootloader and passed via bootparams, or loaded from a initrd=
> +	 * command line option by efi_pe_entry() above. In either case, we
> +	 * permit an initrd loaded from the LINUX_EFI_INITRD_MEDIA_GUID device
> +	 * path to supersede it.
> +	 */
> +	status = efi_load_initrd_dev_path(&initrd_addr, &initrd_size, max_addr);
> +	if (status == EFI_SUCCESS) {
> +		hdr->ramdisk_image		= (u32)initrd_addr;
> +		hdr->ramdisk_size 		= (u32)initrd_size;
> +		boot_params->ext_ramdisk_image	= (u64)initrd_addr >> 32;
> +		boot_params->ext_ramdisk_size 	= (u64)initrd_size >> 32;
> +	} else if (status != EFI_NOT_FOUND) {
> +		efi_printk("efi_load_initrd_dev_path() failed!\n");
> +		goto fail;
> +	}
> +
>  	/*
>  	 * If the boot loader gave us a value for secure_boot then we use that,
>  	 * otherwise we ask the BIOS.
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 0976e57b4caa..1bf482daa22d 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -353,6 +353,7 @@ void efi_native_runtime_setup(void);
>  #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
>  #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
>  #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
> +#define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
>  
>  /* OEM GUIDs */
>  #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
> 

