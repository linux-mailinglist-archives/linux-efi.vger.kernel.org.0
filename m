Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897BF98019
	for <lists+linux-efi@lfdr.de>; Wed, 21 Aug 2019 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfHUQaV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Aug 2019 12:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbfHUQaV (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 21 Aug 2019 12:30:21 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6ED216F4;
        Wed, 21 Aug 2019 16:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566405020;
        bh=3zWshCSgl5Ja3NydnUFdksqCinpsT1cQYzJyEXEfzMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZNSZ2GJ0xyBQTfKrOFJ/IXhRr/M3FKO/47C/90FPZUbZNbRcN1vWnkezzFFAk7FF
         LGP6tlxjh9QtWkDSxKrvqNDJHG88Ge/n8x4tYmoEdP2WjPLEuQENAWD53SfHosT437
         42o+Pp7SCHvc5mKfKodFZFUL1P/7nl/FHDe6V1ws=
Date:   Wed, 21 Aug 2019 09:30:18 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
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
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc: expose secure variables to userspace via
 sysfs
Message-ID: <20190821163018.GA28571@kroah.com>
References: <1566400103-18201-1-git-send-email-nayna@linux.ibm.com>
 <1566400103-18201-3-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566400103-18201-3-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 21, 2019 at 11:08:21AM -0400, Nayna Jain wrote:
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-secvar
> @@ -0,0 +1,27 @@
> +What:		/sys/firmware/secvar
> +Date:		August 2019
> +Contact:	Nayna Jain <nayna@linux.ibm.com>
> +Description:
> +		This directory exposes interfaces for interacting with
> +		the secure variables managed by OPAL firmware.
> +
> +		This is only for the powerpc/powernv platform.
> +
> +		Directory:
> +		vars:		This directory lists all the variables that
> +				are supported by the OPAL. The variables are
> +				represented in the form of directories with
> +				their variable names. The variable name is
> +				unique and is in ASCII representation. The data
> +				and size can be determined by reading their
> +				respective attribute files.
> +
> +		Each variable directory has the following files:
> +		name:		An ASCII representation of the variable name
> +		data:		A read-only file containing the value of the
> +				variable
> +		size:		An integer representation of the size of the
> +				content of the variable. In other works, it
> +				represents the size of the data
> +		update:		A write-only file that is used to submit the new
> +				value for the variable.

Can you break this out into one-entry-per-file like most other entries
are defined?  That makes it easier for tools to parse (specifically the
tool in the tree right now...)



> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 42109682b727..b4bdf77837b2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -925,6 +925,15 @@ config PPC_SECURE_BOOT
>  	  allows user to enable OS Secure Boot on PowerPC systems that
>  	  have firmware secure boot support.
>  
> +config SECVAR_SYSFS
> +        tristate "Enable sysfs interface for POWER secure variables"
> +        depends on PPC_SECURE_BOOT

No depends on SYSFS?

> +        help
> +          POWER secure variables are managed and controlled by firmware.
> +          These variables are exposed to userspace via sysfs to enable
> +          read/write operations on these variables. Say Y if you have
> +	  secure boot enabled and want to expose variables to userspace.

Mix of tabs and spaces :(

> +
>  endmenu
>  
>  config ISA_DMA_API
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 9041563f1c74..4ea7b738c3a3 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -158,6 +158,7 @@ obj-$(CONFIG_EPAPR_PARAVIRT)	+= epapr_paravirt.o epapr_hcalls.o
>  obj-$(CONFIG_KVM_GUEST)		+= kvm.o kvm_emul.o
>  
>  obj-$(CONFIG_PPC_SECURE_BOOT)	+= secboot.o ima_arch.o secvar-ops.o
> +obj-$(CONFIG_SECVAR_SYSFS)     += secvar-sysfs.o

No tab?

>  
>  # Disable GCOV, KCOV & sanitizers in odd or sensitive code
>  GCOV_PROFILE_prom_init.o := n
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> new file mode 100644
> index 000000000000..e46986bb29a0
> --- /dev/null
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 IBM Corporation <nayna@linux.ibm.com>
> + *
> + * This code exposes secure variables to user via sysfs
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/compat.h>
> +#include <linux/string.h>
> +#include <asm/opal.h>
> +#include <asm/secvar.h>
> +
> +//Approximating it for now, it is bound to change.

" " before "A" here please.

> +#define VARIABLE_MAX_SIZE  32000
> +
> +static struct kobject *powerpc_kobj;
> +static struct secvar_operations *secvarops;
> +struct kset *secvar_kset;
> +
> +static ssize_t name_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	return sprintf(buf, "%s", kobj->name);
> +}

Why do you need this entry as it is the directory name?  Userspace
already "knows" it if they can open this file.


> +
> +static ssize_t size_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	unsigned long dsize;
> +	int rc;
> +
> +	rc = secvarops->get_variable(kobj->name, strlen(kobj->name) + 1, NULL,
> +				     &dsize);
> +	if (rc) {
> +		pr_err("Error retrieving variable size %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = sprintf(buf, "%ld", dsize);
> +
> +	return rc;
> +}
> +
> +static ssize_t data_read(struct file *filep, struct kobject *kobj,
> +			 struct bin_attribute *attr, char *buf, loff_t off,
> +			 size_t count)
> +{
> +	unsigned long dsize;
> +	int rc;
> +	char *data;
> +
> +	rc = secvarops->get_variable(kobj->name, strlen(kobj->name) + 1, NULL,
> +				     &dsize);
> +	if (rc) {
> +		pr_err("Error getting variable size %d\n", rc);
> +		return rc;
> +	}
> +	pr_debug("dsize is %ld\n", dsize);
> +
> +	data = kzalloc(dsize, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	rc = secvarops->get_variable(kobj->name, strlen(kobj->name)+1, data,
> +				     &dsize);
> +	if (rc) {
> +		pr_err("Error getting variable %d\n", rc);
> +		goto data_fail;
> +	}
> +
> +	rc = memory_read_from_buffer(buf, count, &off, data, dsize);
> +
> +data_fail:
> +	kfree(data);
> +	return rc;
> +}
> +
> +static ssize_t update_write(struct file *filep, struct kobject *kobj,
> +			    struct bin_attribute *attr, char *buf, loff_t off,
> +			    size_t count)
> +{
> +	int rc;
> +
> +	pr_debug("count is %ld\n", count);
> +	rc = secvarops->set_variable(kobj->name, strlen(kobj->name)+1, buf,
> +				     count);
> +	if (rc) {
> +		pr_err("Error setting the variable %s\n", kobj->name);
> +		return rc;
> +	}
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute name_attr =
> +__ATTR(name, 0444, name_show, NULL);

__ATTR_RO()?

> +
> +static struct kobj_attribute size_attr =
> +__ATTR(size, 0444, size_show, NULL);

__ATTR_RO()?

> +
> +static struct bin_attribute data_attr = {
> +	.attr = {.name = "data", .mode = 0444},
> +	.size = VARIABLE_MAX_SIZE,
> +	.read = data_read,
> +};

__BIN_ATTR_RO()?

> +
> +
> +static struct bin_attribute update_attr = {
> +	.attr = {.name = "update", .mode = 0200},
> +	.size = VARIABLE_MAX_SIZE,
> +	.write = update_write,
> +};

__BIN_ATTR_RO()?


> +
> +static struct bin_attribute  *secvar_bin_attrs[] = {
> +	&data_attr,
> +	&update_attr,
> +	NULL,
> +};
> +
> +static struct attribute *secvar_attrs[] = {
> +	&name_attr.attr,
> +	&size_attr.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group secvar_attr_group = {
> +	.attrs = secvar_attrs,
> +	.bin_attrs = secvar_bin_attrs,
> +};

static?

> +
> +int secvar_sysfs_load(void)
> +{
> +
> +	char *name;

No blank line.  You didn't run this this through checkpatch, did you :(


> +	unsigned long namesize;
> +	struct kobject *kobj;
> +	int status;
> +	int rc = 0;
> +
> +	name = kzalloc(1024, GFP_KERNEL);

Why 1024?

> +	if (!name)
> +		return -ENOMEM;
> +
> +	do {
> +
> +		status = secvarops->get_next_variable(name, &namesize, 1024);
> +		if (status != OPAL_SUCCESS)
> +			break;
> +
> +		pr_info("name is %s\n", name);

Please delete debugging messages.

> +		kobj = kobject_create_and_add(name, &(secvar_kset->kobj));
> +		if (kobj) {
> +			rc = sysfs_create_group(kobj, &secvar_attr_group);

You just raced userspace and lost :(

If you set your kobj_type to have the attribute group you will not race
and loose, the core will handle it for you.


> +			if (rc)
> +				pr_err("Error creating attributes for %s variable\n",
> +				name);
> +		} else {
> +			pr_err("Error creating sysfs entry for %s variable\n",
> +				name);
> +			rc = -EINVAL;
> +		}
> +
> +	} while ((status == OPAL_SUCCESS) && (rc == 0));
> +
> +	kfree(name);
> +	return rc;
> +}
> +
> +int secvar_sysfs_init(void)
> +{
> +	powerpc_kobj = kobject_create_and_add("secvar", firmware_kobj);
> +	if (!powerpc_kobj) {
> +		pr_err("secvar: Failed to create firmware kobj\n");
> +		return -ENODEV;
> +	}
> +
> +	secvar_kset = kset_create_and_add("vars", NULL, powerpc_kobj);
> +	if (!secvar_kset) {
> +		pr_err("secvar: sysfs kobject registration failed.\n");

You juat leaked a kobject :(

> +		return -ENODEV;
> +	}
> +
> +	secvarops = get_secvar_ops();
> +	if (!secvarops) {
> +		kobject_put(powerpc_kobj);
> +		pr_err("secvar: failed to retrieve secvar operations.\n");
> +		return -ENODEV;

You just leaked 2 things from above :(

> +	}
> +
> +	secvar_sysfs_load();
> +	pr_info("Secure variables sysfs initialized");

Do not be noisy when all goes just fine.  The kernel log should be quiet
when all goes well.

thanks,

greg k-h
