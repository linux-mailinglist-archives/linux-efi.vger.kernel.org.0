Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D87F282C
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfKGHkc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 02:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbfKGHkc (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Nov 2019 02:40:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A1F21882;
        Thu,  7 Nov 2019 07:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573112431;
        bh=2BS/rZTDi9unuwVB4ZB/ZFB0VRPqy6bNAF0+4AEjkB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIsH2seRUopDCpGxze0tP8nLOavOd8Olsk/SzRo+wyGTV878I/91nbOenJQnfGE21
         8qvEcbbZyqSAIPrJ0WqpT2v8eD0nzmQAOtNsa5ALw5lU/y36328yxfz6BZPVx74Qyl
         hLDwB+7OeuYNFgnYzDQGpQOb+qyBhGZA/PhBktqM=
Date:   Thu, 7 Nov 2019 08:40:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Richter <erichte@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v7 2/4] powerpc: expose secure variables to userspace via
 sysfs
Message-ID: <20191107074028.GA1118867@kroah.com>
References: <20191107042205.13710-1-erichte@linux.ibm.com>
 <20191107042205.13710-3-erichte@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107042205.13710-3-erichte@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 06, 2019 at 10:22:03PM -0600, Eric Richter wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
> 
> PowerNV secure variables, which store the keys used for OS kernel
> verification, are managed by the firmware. These secure variables need to
> be accessed by the userspace for addition/deletion of the certificates.
> 
> This patch adds the sysfs interface to expose secure variables for PowerNV
> secureboot. The users shall use this interface for manipulating
> the keys stored in the secure variables.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-secvar |  46 +++++
>  arch/powerpc/Kconfig                   |  11 ++
>  arch/powerpc/kernel/Makefile           |   1 +
>  arch/powerpc/kernel/secvar-sysfs.c     | 247 +++++++++++++++++++++++++
>  4 files changed, 305 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-secvar
>  create mode 100644 arch/powerpc/kernel/secvar-sysfs.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
> new file mode 100644
> index 000000000000..911b89cc6957
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-secvar
> @@ -0,0 +1,46 @@
> +What:		/sys/firmware/secvar
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	This directory is created if the POWER firmware supports OS
> +		secureboot, thereby secure variables. It exposes interface
> +		for reading/writing the secure variables
> +
> +What:		/sys/firmware/secvar/vars
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	This directory lists all the secure variables that are supported
> +		by the firmware.
> +
> +What:		/sys/firmware/secvar/backend
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	A string indicating which backend is in use by the firmware.
> +		This determines the format of the variable and the accepted
> +		format of variable updates.
> +
> +What:		/sys/firmware/secvar/vars/<variable name>
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	Each secure variable is represented as a directory named as
> +		<variable_name>. The variable name is unique and is in ASCII
> +		representation. The data and size can be determined by reading
> +		their respective attribute files.
> +
> +What:		/sys/firmware/secvar/vars/<variable_name>/size
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	An integer representation of the size of the content of the
> +		variable. In other words, it represents the size of the data.
> +
> +What:		/sys/firmware/secvar/vars/<variable_name>/data
> +Date:		August 2019
> +Contact:	Nayna Jain h<nayna@linux.ibm.com>
> +Description:	A read-only file containing the value of the variable. The size
> +		of the file represents the maximum size of the variable data.
> +
> +What:		/sys/firmware/secvar/vars/<variable_name>/update
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:	A write-only file that is used to submit the new value for the
> +		variable. The size of the file represents the maximum size of
> +		the variable data that can be written.
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c795039bdc73..cabc091f3fe1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -945,6 +945,17 @@ config PPC_SECURE_BOOT
>  	  to enable OS secure boot on systems that have firmware support for
>  	  it. If in doubt say N.
>  
> +config PPC_SECVAR_SYSFS
> +	bool "Enable sysfs interface for POWER secure variables"
> +	default y
> +	depends on PPC_SECURE_BOOT
> +	depends on SYSFS
> +	help
> +	  POWER secure variables are managed and controlled by firmware.
> +	  These variables are exposed to userspace via sysfs to enable
> +	  read/write operations on these variables. Say Y if you have
> +	  secure boot enabled and want to expose variables to userspace.
> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 3cf26427334f..b216e9f316ee 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -162,6 +162,7 @@ obj-y				+= ucall.o
>  endif
>  
>  obj-$(CONFIG_PPC_SECURE_BOOT)	+= secure_boot.o ima_arch.o secvar-ops.o
> +obj-$(CONFIG_PPC_SECVAR_SYSFS)	+= secvar-sysfs.o
>  
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> new file mode 100644
> index 000000000000..a3ba58ee4285
> --- /dev/null
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 IBM Corporation <nayna@linux.ibm.com>
> + *
> + * This code exposes secure variables to user via sysfs
> + */
> +
> +#define pr_fmt(fmt) "secvar-sysfs: "fmt
> +
> +#include <linux/slab.h>
> +#include <linux/compat.h>
> +#include <linux/string.h>
> +#include <linux/of.h>
> +#include <asm/secvar.h>
> +
> +#define NAME_MAX_SIZE	   1024
> +
> +static struct kobject *secvar_kobj;
> +static struct kset *secvar_kset;
> +
> +static ssize_t backend_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			    char *buf)
> +{
> +	ssize_t ret = 0;
> +	struct device_node *node;
> +	const char *compatible;
> +
> +	node = of_find_node_by_name(NULL, "secvar");
> +	if (!of_device_is_available(node))
> +		return -ENODEV;
> +
> +	ret = of_property_read_string(node, "compatible", &compatible);
> +	if (ret)
> +		return ret;
> +
> +	ret = sprintf(buf, "%s\n", compatible);
> +
> +	of_node_put(node);
> +
> +	return ret;
> +}
> +
> +
> +static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	uint64_t dsize;
> +	int rc;
> +
> +	rc = secvar_ops->get(kobj->name, strlen(kobj->name) + 1, NULL, &dsize);
> +	if (rc) {
> +		pr_err("Error retrieving variable size %d\n", rc);

For this, and the other errors in the show/store functions, you might
want to print the kobject name as well, so that userspace has a hint as
to what variable is the one having problems.

thanks,

greg k-h
