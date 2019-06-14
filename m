Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951FD454CE
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jun 2019 08:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfFNGer (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jun 2019 02:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNGer (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 14 Jun 2019 02:34:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 904C720850;
        Fri, 14 Jun 2019 06:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560494086;
        bh=CkKywgMmABsPnJapZTOG9f6KDfJsQaG7fpEOo4UPeIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tB9P5Z71Kj27xZnFlZrLVXZ6rtTkeM9DShoon4023U995XqGmKRtFJ67LgqimO8Fu
         qutSVdk2Okvv6zyrykkOTpOExuYPJiJFAqWWAPCLlz4v3eJ3RrdMRn5h6hz5TgWjvD
         xC7RGC3cOOrFhQY9CDEjDihB7v+UuM9sxRMmPSCI=
Date:   Fri, 14 Jun 2019 08:34:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: expose secure variables via sysfs
Message-ID: <20190614063443.GB17056@kroah.com>
References: <1560459027-5248-1-git-send-email-nayna@linux.ibm.com>
 <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560459027-5248-3-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 13, 2019 at 04:50:27PM -0400, Nayna Jain wrote:
> As part of PowerNV secure boot support, OS verification keys are stored
> and controlled by OPAL as secure variables. These need to be exposed to
> the userspace so that sysadmins can perform key management tasks.
> 
> This patch adds the support to expose secure variables via a sysfs
> interface It reuses the the existing efi defined hooks and backend in
> order to maintain the compatibility with the userspace tools.
> 
> Though it reuses a great deal of efi, POWER platforms do not use EFI.
> A new config, POWER_SECVAR_SYSFS, is defined to enable this new sysfs
> interface.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                 |   2 +
>  drivers/firmware/Makefile            |   1 +
>  drivers/firmware/efi/efivars.c       |   2 +-
>  drivers/firmware/powerpc/Kconfig     |  12 +
>  drivers/firmware/powerpc/Makefile    |   3 +
>  drivers/firmware/powerpc/efi_error.c |  46 ++++
>  drivers/firmware/powerpc/secvar.c    | 326 +++++++++++++++++++++++++++
>  7 files changed, 391 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/powerpc/Kconfig
>  create mode 100644 drivers/firmware/powerpc/Makefile
>  create mode 100644 drivers/firmware/powerpc/efi_error.c
>  create mode 100644 drivers/firmware/powerpc/secvar.c

If you add/remove/modify sysfs files, you also need to update the
relevant Documentation/ABI/ entry as well.  Please add something there
to describe your new files when you resend the next version of this
patch series.

> diff --git a/drivers/firmware/powerpc/Kconfig b/drivers/firmware/powerpc/Kconfig
> new file mode 100644
> index 000000000000..e0303fc517d5
> --- /dev/null
> +++ b/drivers/firmware/powerpc/Kconfig
> @@ -0,0 +1,12 @@
> +config POWER_SECVAR_SYSFS
> +	tristate "Enable sysfs interface for POWER secure variables"
> +	default n

default is always n, no need to list it.

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

Why not just export the symbol from the original file instead of
duplicating it here?

> +static int convert_buffer_to_efi_guid(u8 *buffer, efi_guid_t *guid)
> +{
> +	u32 *a1;
> +	u16 *a2;
> +	u16 *a3;
> +
> +	a1 = kzalloc(4, GFP_KERNEL);

No error checking in this function for memory issues at all?

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

Don't put debugging info like this in the kernel log of everyone :(

> +
> +	rc = opal_get_next_variable(key, &keylen, keysize);
> +	if (rc) {
> +		kfree(key);
> +		return opal_to_efi_status(rc);
> +	}
> +
> +	mdsize = kzalloc(sizeof(unsigned long), GFP_KERNEL);

No error checking?

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

Again, please remove all of your debugging code when resending.

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

Do not make up error numbers, use the defined values please.

thanks,

greg k-h
