Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1579155503
	for <lists+linux-efi@lfdr.de>; Fri,  7 Feb 2020 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGJsl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Feb 2020 04:48:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58297 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726619AbgBGJsk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Feb 2020 04:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581068919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ni1+CBiwyROilcVxcp0QzeIJq5ThDRbID99E9iIRkZM=;
        b=G5AuX5Xfloq451in6B4wxVhx8hme6Upx1hsRE0ep9gxvW88N4HjLuL9rVFr8fRsRlHvcfT
        bldl9eD+itzhRQPJC0J1ddkX7yMzkpOS8HMIxCrQCOf1Zx8ZIe1gapNv/dY/td2/7FTkbH
        x/vRHKXMWzzf9ExgqH3bfRwKJs9cIgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-yZ5zJWAlMYOtSqpUOHqdpQ-1; Fri, 07 Feb 2020 04:48:35 -0500
X-MC-Unique: yZ5zJWAlMYOtSqpUOHqdpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A5AB1081FA2;
        Fri,  7 Feb 2020 09:48:33 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D92F89F04;
        Fri,  7 Feb 2020 09:48:30 +0000 (UTC)
Subject: Re: [PATCH 1/2] efi/libstub: add support for loading the initrd from
 a device path
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com
References: <20200206140352.6300-1-ardb@kernel.org>
 <20200206140352.6300-2-ardb@kernel.org>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <43362e18-eddc-9903-0e63-9d3eebe70313@redhat.com>
Date:   Fri, 7 Feb 2020 10:48:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200206140352.6300-2-ardb@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 02/06/20 15:03, Ard Biesheuvel wrote:
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
>  drivers/firmware/efi/libstub/arm-stub.c        | 16 +++--
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 65 ++++++++++++++++++++
>  drivers/firmware/efi/libstub/efistub.h         | 12 ++++
>  drivers/firmware/efi/libstub/x86-stub.c        | 36 ++++++++++-
>  include/linux/efi.h                            |  1 +
>  5 files changed, 123 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
> index c7b091f50e55..1db943c1ba2b 100644
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -157,6 +157,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>  	enum efi_secureboot_mode secure_boot;
>  	struct screen_info *si;
>  	efi_properties_table_t *prop_tbl;
> +	unsigned long max_addr;
>  
>  	sys_table = sys_table_arg;
>  
> @@ -255,11 +256,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
>  	if (!fdt_addr)
>  		pr_efi("Generating empty DTB\n");
>  
> -	status = efi_load_initrd(image, ULONG_MAX,
> -				 efi_get_max_initrd_addr(dram_base, *image_addr),
> -				 &initrd_addr, &initrd_size);
> +	max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
> +	status = efi_load_initrd_devpath(&initrd_addr, &initrd_size, max_addr);
> +	if (status == EFI_SUCCESS)
> +		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
> +	else if (status == EFI_NOT_FOUND) {
> +		status = efi_load_initrd(image, ULONG_MAX, max_addr,
> +					 &initrd_addr, &initrd_size);

- So this seems to be fallback#1, for ARM, which looks good.

- Are you sure you only want to fall back to the old method on
EFI_NOT_FOUND? Wouldn't other return values from
efi_load_initrd_devpath() justify that too?

... After checking the boot services called in
efi_load_initrd_devpath(), this idea seems reasonable, but then I'd
suggest documenting the significance of returning EFI_NOT_FOUND near the
efi_load_initrd_devpath() function declaration, in "efistub.h".

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
> index 8e60a39df3c5..eaf45ea749b3 100644
> --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> @@ -323,3 +323,68 @@ void efi_char16_printk(efi_char16_t *str)
>  	efi_call_proto(efi_table_attr(efi_system_table(), con_out),
>  		       output_string, str);
>  }
> +
> +static const struct {
> +	struct efi_vendor_dev_path	vendor;
> +	struct efi_generic_dev_path	end;
> +} __packed initrd_devpath = {
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
> +efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
> +				     unsigned long *load_size,
> +				     unsigned long max)
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
> +
> +	dp = (efi_device_path_protocol_t *)&initrd_devpath;
> +	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
> +			     (void **)&lf2);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	initrd_size = 0;
> +	status = efi_call_proto(lf2, load_file,
> +				(efi_device_path_protocol_t *)&initrd_devpath,
> +				false, &initrd_size, NULL);

The second argument to EFI_LOAD_FILE2_PROTOCOL.LoadFile() is "FilePath",
specified as "The device specific path of the file to load". This means
it is supposed to be a (possibly empty) sequence of FILEPATH_DEVICE_PATH
nodes, terminated by and "End Entire Device Path" node. See

- 10.3.1 Generic Device Path Structures
- 10.3.5.4 File Path Media Device Path

in UEFI-2.8.

And "initrd_devpath" is not a device path like that; instead it's the
VenMedia device path that's installed on the handle that also carries
our LoadFile2 instance.

Now, I do see that this all theoretical here, as we don't expect the
LoadFile2 instance that we've found via our special
LINUX_EFI_INITRD_MEDIA_GUID VenMedia devpath to do *any* device-specific
filename / pathname parsing.

But in that case (i.e., given that the FilePath argument is totally
irrelevant), I think it's much clearer if we simply pass an empty device
path -- one that consists of a single "End Entire Device Path" node.

I've checked, and your ArmVirtQemu patch ignores the FilePath argument
too -- justifiedly so. I just think it's better to pass in a well-formed
device path, rather than NULL. Because, the FilePath parameter is not
marked OPTIONAL in the spec.

> +	if (status != EFI_BUFFER_TOO_SMALL)
> +		return EFI_LOAD_ERROR;
> +
> +	status = efi_allocate_pages(initrd_size, &initrd_addr, max);
> +	if (status != EFI_SUCCESS)
> +		return status;
> +
> +	status = efi_call_proto(lf2, load_file,
> +				(efi_device_path_protocol_t *)&initrd_devpath,
> +				false, &initrd_size, (void *)initrd_addr);

Same here.

> +	if (status != EFI_SUCCESS) {
> +		efi_free(initrd_size, initrd_addr);
> +		return status;
> +	}
> +
> +	*load_addr = initrd_addr;
> +	*load_size = initrd_size;
> +	return EFI_SUCCESS;
> +}
> diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
> index 99e93fd76ec5..fbf9f9442eed 100644
> --- a/drivers/firmware/efi/libstub/efistub.h
> +++ b/drivers/firmware/efi/libstub/efistub.h
> @@ -566,6 +566,14 @@ union efi_load_file_protocol {
>  	} mixed_mode;
>  };
>  
> +struct efi_vendor_dev_path {
> +	u8		type;
> +	u8		sub_type;
> +	u16		length;
> +	efi_guid_t	vendorguid;
> +	u8		vendordata[];
> +} __packed;
> +
>  void efi_pci_disable_bridge_busmaster(void);
>  
>  typedef efi_status_t (*efi_exit_boot_map_processing)(
> @@ -651,4 +659,8 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
>  			     unsigned long *load_addr,
>  			     unsigned long *load_size);
>  
> +efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
> +				     unsigned long *load_size,
> +				     unsigned long max);
> +
>  #endif
> diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> index f3e2ff31b624..7f38f95676dd 100644
> --- a/drivers/firmware/efi/libstub/x86-stub.c
> +++ b/drivers/firmware/efi/libstub/x86-stub.c
> @@ -419,9 +419,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
>  	if (status != EFI_SUCCESS)
>  		goto fail2;
>  
> -	status = efi_load_initrd(image, hdr->initrd_addr_max,
> -				 above4g ? ULONG_MAX : hdr->initrd_addr_max,
> -				 &ramdisk_addr, &ramdisk_size);
> +	/*
> +	 * The initrd loaded from the Linux initrd vendor device
> +	 * path should take precedence, as we don't want the
> +	 * [unverified] command line to override the initrd
> +	 * supplied by the [potentially verified] firmware.
> +	 */
> +	status = efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
> +					 above4g ? ULONG_MAX
> +						 : hdr->initrd_addr_max);
> +	if (status == EFI_NOT_FOUND)
> +		status = efi_load_initrd(image, hdr->initrd_addr_max,
> +					 above4g ? ULONG_MAX
> +						 : hdr->initrd_addr_max,
> +					 &ramdisk_addr, &ramdisk_size);

Fallback#2, for x86, also looks good.

>  	if (status != EFI_SUCCESS)
>  		goto fail2;
>  	hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
> @@ -732,6 +743,25 @@ struct boot_params *efi_main(efi_handle_t handle,
>  			 ((u64)boot_params->ext_cmd_line_ptr << 32));
>  	efi_parse_options((char *)cmdline_paddr);
>  
> +	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size) {
> +		unsigned long max = hdr->initrd_addr_max;
> +		unsigned long addr, size;
> +
> +		if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
> +			max = ULONG_MAX;
> +
> +		status = efi_load_initrd_devpath(&addr, &size, max);
> +		if (status == EFI_SUCCESS) {
> +			hdr->ramdisk_image		= (u32)addr;
> +			hdr->ramdisk_size 		= (u32)size;
> +			boot_params->ext_ramdisk_image	= (u64)addr >> 32;
> +			boot_params->ext_ramdisk_size 	= (u64)size >> 32;
> +		} else if (status != EFI_NOT_FOUND) {
> +			efi_printk("efi_load_initrd_devpath() failed!\n");
> +			goto fail;
> +		}
> +	}
> +

No fallback here; this is not a replacement for efi_load_initrd(), but a
brand new call. Why? (It's probably justified, I just don't know enough
about the kernel.)

>  	/*
>  	 * If the boot loader gave us a value for secure_boot then we use that,
>  	 * otherwise we ask the BIOS.
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 9ccf313fe9de..75c83c322c40 100644
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

Thanks,
Laszlo

