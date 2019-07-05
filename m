Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB1600C2
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jul 2019 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbfGEGFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jul 2019 02:05:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEGFN (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 5 Jul 2019 02:05:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45g47m1vd1z9sNp;
        Fri,  5 Jul 2019 16:05:08 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: expose secure variables via sysfs
In-Reply-To: <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com> <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
Date:   Fri, 05 Jul 2019 16:05:07 +1000
Message-ID: <87o92910fg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Nayna,

Nayna Jain <nayna@linux.ibm.com> writes:
> As part of PowerNV secure boot support, OS verification keys are stored
> and controlled by OPAL as secure variables. These need to be exposed to
> the userspace so that sysadmins can perform key management tasks.
>
> This patch adds the support to expose secure variables via a sysfs
> interface It reuses the the existing efi defined hooks and backend in
> order to maintain the compatibility with the userspace tools.

Which tools? Can you include a log demonstrating how they're used, ie.
so that I can test the sequence of commands.

> Though it reuses a great deal of efi, POWER platforms do not use EFI.
> A new config, POWER_SECVAR_SYSFS, is defined to enable this new sysfs
> interface.

Sorry I haven't been able to keep up with all the discussions, but I
thought the consensus was that pretending to be EFI-like was a bad idea,
because we don't have actual EFI and we're not implementing an entirely
compatible scheme to EFI anyway.

Greg suggested just putting the variables in sysfs, why does that not
work? Matthew mentioned "complex semantics around variable deletion and
immutability" but do we have to emulate those semantics on powerpc?

cheers


> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9de77bb14f54..1548dd8cf1a0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -916,6 +916,8 @@ config PPC_SECURE_BOOT
>  	  allows user to enable OS Secure Boot on PowerPC systems that
>  	  have firmware secure boot support.
>  
> +source "drivers/firmware/powerpc/Kconfig"
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 3fa0b34eb72f..8cfaf7e6769d 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -33,3 +33,4 @@ obj-$(CONFIG_UEFI_CPER)		+= efi/
>  obj-y				+= imx/
>  obj-y				+= tegra/
>  obj-y				+= xilinx/
> +obj-$(CONFIG_POWER_SECVAR_SYSFS) += powerpc/
> diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
> index 7576450c8254..30ef53003c24 100644
> --- a/drivers/firmware/efi/efivars.c
> +++ b/drivers/firmware/efi/efivars.c
> @@ -664,7 +664,7 @@ int efivars_sysfs_init(void)
>  	struct kobject *parent_kobj = efivars_kobject();
>  	int error = 0;
>  
> -	if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +	if (IS_ENABLED(CONFIG_EFI) && !efi_enabled(EFI_RUNTIME_SERVICES))
>  		return -ENODEV;
>  
>  	/* No efivars has been registered yet */
> diff --git a/drivers/firmware/powerpc/Kconfig b/drivers/firmware/powerpc/Kconfig
> new file mode 100644
> index 000000000000..e0303fc517d5
> --- /dev/null
> +++ b/drivers/firmware/powerpc/Kconfig
> @@ -0,0 +1,12 @@
> +config POWER_SECVAR_SYSFS
> +	tristate "Enable sysfs interface for POWER secure variables"
> +	default n
> +	depends on PPC_SECURE_BOOT
> +	select UCS2_STRING
> +	help
> +	  POWER secure variables are managed and controlled by OPAL.
> +	  These variables are exposed to userspace via sysfs to allow
> +	  user to read/write these variables. Say Y if you have secure
> +	  boot enabled and want to expose variables to userspace.
> +
> +source "drivers/firmware/efi/Kconfig"
> diff --git a/drivers/firmware/powerpc/Makefile b/drivers/firmware/powerpc/Makefile
> new file mode 100644
> index 000000000000..d5fa3b007315
> --- /dev/null
> +++ b/drivers/firmware/powerpc/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_POWER_SECVAR_SYSFS) += ../efi/efivars.o efi_error.o ../efi/vars.o secvar.o
> diff --git a/drivers/firmware/powerpc/efi_error.c b/drivers/firmware/powerpc/efi_error.c
> new file mode 100644
> index 000000000000..b5cabd52e6b4
> --- /dev/null
> +++ b/drivers/firmware/powerpc/efi_error.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + * efi_error.c
> + *      - Error codes as understood by efi based tools
> + *      Taken from drivers/firmware/efi/efi.c
> + */
> +#include<linux/efi.h>
> +
> +int efi_status_to_err(efi_status_t status)
> +{
> +	int err;
> +
> +	switch (status) {
> +	case EFI_SUCCESS:
> +		err = 0;
> +		break;
> +	case EFI_INVALID_PARAMETER:
> +		err = -EINVAL;
> +		break;
> +	case EFI_OUT_OF_RESOURCES:
> +		err = -ENOSPC;
> +		break;
> +	case EFI_DEVICE_ERROR:
> +		err = -EIO;
> +		break;
> +	case EFI_WRITE_PROTECTED:
> +		err = -EROFS;
> +		break;
> +	case EFI_SECURITY_VIOLATION:
> +		err = -EACCES;
> +		break;
> +	case EFI_NOT_FOUND:
> +		err = -ENOENT;
> +		break;
> +	case EFI_ABORTED:
> +		err = -EINTR;
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	return err;
> +}
> diff --git a/drivers/firmware/powerpc/secvar.c b/drivers/firmware/powerpc/secvar.c
> new file mode 100644
> index 000000000000..f1f134a0bb7c
> --- /dev/null
> +++ b/drivers/firmware/powerpc/secvar.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 IBM Corporation
> + * Author: Nayna Jain <nayna@linux.ibm.com>
> + *
> + * secvar.c
> + * - wrappers to expose secure variables to userspace
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/spinlock.h>
> +#include <linux/fs.h>
> +#include <linux/slab.h>
> +#include <linux/ioctl.h>
> +#include <linux/uaccess.h>
> +#include <linux/kdebug.h>
> +#include <linux/efi.h>
> +#include <linux/module.h>
> +#include <linux/ucs2_string.h>
> +#include <asm/opal-secvar.h>
> +#include <asm/opal.h>
> +
> +static struct efivars efivars;
> +struct kobject *powerpc_kobj;
> +
> +efi_status_t opal_to_efi_status_log(int rc, const char *func_name)
> +{
> +	efi_status_t status;
> +
> +	switch (rc) {
> +	case OPAL_EMPTY:
> +		status = EFI_NOT_FOUND;
> +		break;
> +	case OPAL_HARDWARE:
> +		status = EFI_DEVICE_ERROR;
> +		break;
> +	case OPAL_NO_MEM:
> +		pr_err("%s: No space in the volatile storage\n", func_name);
> +		status = EFI_OUT_OF_RESOURCES;
> +		break;
> +	case OPAL_PARAMETER:
> +		status = EFI_INVALID_PARAMETER;
> +		break;
> +	case OPAL_PARTIAL:
> +		status = EFI_BUFFER_TOO_SMALL;
> +		break;
> +	case OPAL_PERMISSION:
> +		status = EFI_WRITE_PROTECTED;
> +		break;
> +	case OPAL_RESOURCE:
> +		pr_err("%s: No space in the non-volatile storage\n", func_name);
> +		status = EFI_OUT_OF_RESOURCES;
> +		break;
> +	case OPAL_SUCCESS:
> +		status = EFI_SUCCESS;
> +		break;
> +	default:
> +		pr_err("%s: Unknown OPAL error %d\n", func_name, rc);
> +		status = EFI_DEVICE_ERROR;
> +		break;
> +	}
> +
> +	return status;
> +}
> +
> +#define opal_to_efi_status(rc) opal_to_efi_status_log(rc, __func__)
> +
> +static void createkey(efi_char16_t *name, u8 **key, unsigned long *keylen)
> +{
> +	*keylen = ucs2_utf8size(name) + 1;
> +
> +	*key = kzalloc(*keylen, GFP_KERNEL);
> +	if (!*key) {
> +		*keylen = 0;
> +		*key = NULL;
> +		return;
> +	}
> +
> +	ucs2_as_utf8(*key, name, *keylen);
> +}
> +
> +static void createmetadata(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
> +			   u8 **mdata, unsigned long *mdsize)
> +{
> +	int size = 0;
> +
> +	*mdsize = ucs2_strsize(name, 1024) + sizeof(efi_guid_t) + sizeof(u32);
> +	*mdata = kzalloc(*mdsize, GFP_KERNEL);
> +
> +	memcpy(*mdata, name, ucs2_strsize(name, 1024));
> +	size = ucs2_strsize(name, 1024);
> +
> +	memcpy(*mdata + size, vendor, sizeof(efi_guid_t));
> +	size += sizeof(efi_guid_t);
> +
> +	if (attr != NULL)
> +		memcpy(*mdata + size, attr, sizeof(u32));
> +	else
> +		memset(*mdata + size, 0, sizeof(u32));
> +}
> +
> +static int convert_buffer_to_efi_guid(u8 *buffer, efi_guid_t *guid)
> +{
> +	u32 *a1;
> +	u16 *a2;
> +	u16 *a3;
> +
> +	a1 = kzalloc(4, GFP_KERNEL);
> +	memcpy(a1, buffer, 4);
> +	*a1 = be32_to_cpu(*a1);
> +
> +	a2 = kzalloc(2, GFP_KERNEL);
> +	memcpy(a2, buffer+4, 2);
> +	*a2 = be16_to_cpu(*a2);
> +
> +	a3 = kzalloc(2, GFP_KERNEL);
> +	memcpy(a3, buffer+6, 2);
> +	*a3 = be16_to_cpu(*a3);
> +
> +	*guid = EFI_GUID(*a1, *a2, *a3, *(buffer + 8),
> +			*(buffer + 9),
> +			*(buffer + 10),
> +			*(buffer + 11),
> +			*(buffer + 12),
> +			*(buffer + 13),
> +			*(buffer + 14),
> +			*(buffer + 15));
> +
> +	kfree(a1);
> +	kfree(a2);
> +	kfree(a3);
> +	return 0;
> +}
> +
> +static efi_status_t powerpc_get_variable(efi_char16_t *name, efi_guid_t *vendor,
> +					 u32 *attr, unsigned long *data_size,
> +					 void *data)
> +{
> +	int rc;
> +	u8 *key;
> +	unsigned long keylen;
> +	u8 *metadata;
> +	unsigned long mdsize;
> +	unsigned long dsize;
> +	unsigned long namesize;
> +
> +	if (!name)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (!vendor)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (*data_size == 0) {
> +		/* If *data_size is zero, it implies data size is being asked */
> +		createkey(name, &key, &keylen);
> +		rc = opal_get_variable_size(key, keylen, &mdsize, &dsize);
> +		*data_size = dsize;
> +		kfree(key);
> +		return opal_to_efi_status(rc);
> +	}
> +
> +	createkey(name, &key, &keylen);
> +	createmetadata(name, vendor, attr, &metadata, &mdsize);
> +
> +	rc = opal_get_variable(key, keylen, metadata, &mdsize, data, data_size);
> +
> +	if (rc)
> +		return opal_to_efi_status(rc);
> +
> +	if (mdsize > 0) {
> +		namesize = mdsize - sizeof(efi_guid_t) - sizeof(u32);
> +		if (!attr)
> +			return opal_to_efi_status(rc);
> +		memset(attr, 0, sizeof(u32));
> +		memcpy(attr, metadata + namesize + sizeof(efi_guid_t),
> +		       sizeof(u32));
> +		*attr = be32_to_cpu(*attr);
> +	}
> +
> +	kfree(key);
> +	kfree(metadata);
> +
> +	return opal_to_efi_status(rc);
> +}
> +
> +
> +static efi_status_t powerpc_get_next_variable(unsigned long *name_size,
> +					      efi_char16_t *name,
> +					      efi_guid_t *vendor)
> +{
> +	int rc;
> +	u8 *key;
> +	int namesize;
> +	unsigned long keylen;
> +	unsigned long keysize = 1024;
> +	unsigned long *mdsize;
> +	u8 *mdata = NULL;
> +	efi_guid_t guid;
> +
> +	if (ucs2_strnlen(name, 1024) > 0) {
> +		createkey(name, &key, &keylen);
> +	} else {
> +		keylen = 0;
> +		key = kzalloc(1024, GFP_KERNEL);
> +	}
> +
> +	pr_info("%s: powerpc get next variable, key is %s\n", __func__, key);
> +
> +	rc = opal_get_next_variable(key, &keylen, keysize);
> +	if (rc) {
> +		kfree(key);
> +		return opal_to_efi_status(rc);
> +	}
> +
> +	mdsize = kzalloc(sizeof(unsigned long), GFP_KERNEL);
> +	rc = opal_get_variable_size(key, keylen, mdsize, NULL);
> +	if (rc)
> +		goto out;
> +
> +	if (*mdsize <= 0)
> +		goto out;
> +
> +	mdata = kzalloc(*mdsize, GFP_KERNEL);
> +
> +	rc = opal_get_variable(key, keylen, mdata, mdsize, NULL, NULL);
> +	if (rc)
> +		goto out;
> +
> +	if (*mdsize > 0) {
> +		namesize = *mdsize - sizeof(efi_guid_t) - sizeof(u32);
> +		if (namesize > 0) {
> +			memset(&guid, 0, sizeof(efi_guid_t));
> +			convert_buffer_to_efi_guid(mdata + namesize, &guid);
> +			memcpy(vendor, &guid, sizeof(efi_guid_t));
> +			memset(name, 0, namesize + 2);
> +			memcpy(name, mdata, namesize);
> +			*name_size = namesize + 2;
> +			name[namesize++] = 0;
> +			name[namesize] = 0;
> +		}
> +	}
> +
> +out:
> +	kfree(mdsize);
> +	kfree(mdata);
> +
> +	return opal_to_efi_status(rc);
> +}
> +
> +static efi_status_t powerpc_set_variable(efi_char16_t *name, efi_guid_t *vendor,
> +					 u32 attr, unsigned long data_size,
> +					 void *data)
> +{
> +	int rc;
> +	u8 *key;
> +	unsigned long keylen;
> +	u8 *metadata;
> +	unsigned long mdsize;
> +
> +	if (!name)
> +		return EFI_INVALID_PARAMETER;
> +
> +	if (!vendor)
> +		return EFI_INVALID_PARAMETER;
> +
> +	createkey(name, &key, &keylen);
> +	pr_info("%s: nayna key is %s\n", __func__, key);
> +
> +	createmetadata(name, vendor, &attr, &metadata, &mdsize);
> +
> +	rc = opal_set_variable(key, keylen, metadata, mdsize, data, data_size);
> +
> +	return opal_to_efi_status(rc);
> +}
> +
> +
> +static const struct efivar_operations efivar_ops = {
> +	.get_variable = powerpc_get_variable,
> +	.set_variable = powerpc_set_variable,
> +	.get_next_variable = powerpc_get_next_variable,
> +};
> +
> +
> +static __init int power_secvar_init(void)
> +{
> +	int rc = 0;
> +	unsigned long ver = 0;
> +
> +	rc = opal_variable_version(&ver);
> +	if (ver != BACKEND_TC_COMPAT_V1) {
> +		pr_info("Compatible backend unsupported\n");
> +		return -1;
> +	}
> +
> +	powerpc_kobj = kobject_create_and_add("secvar", firmware_kobj);
> +	if (!powerpc_kobj) {
> +		pr_info("secvar: Failed to create firmware kobj\n");
> +		goto out_err;
> +	}
> +
> +	rc = efivars_register(&efivars, &efivar_ops, powerpc_kobj);
> +	if (rc) {
> +		pr_info("powerpc: Failed to register efivars\n");
> +		return rc;
> +	}
> +
> +	return 0;
> +out_err:
> +	kobject_put(powerpc_kobj);
> +	pr_info("powerpc: failed to load: %d\n", rc);
> +	return rc;
> +}
> +arch_initcall(power_secvar_init);
> +
> +static void __exit power_secvar_exit(void)
> +{
> +	efivars_unregister(&efivars);
> +	kobject_put(powerpc_kobj);
> +}
> +module_exit(power_secvar_exit);
> +
> +MODULE_AUTHOR("Nayna Jain");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
