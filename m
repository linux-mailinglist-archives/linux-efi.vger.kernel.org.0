Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D785F7D42
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJGSWo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 14:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJGSWj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 14:22:39 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062FCC824;
        Fri,  7 Oct 2022 11:22:35 -0700 (PDT)
Message-ID: <177ea4f0-93f7-85ac-5cad-9579ecfc5731@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665166954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnPKNG0j+IN0Ge/wRHpaA5Z/4yXvqlWZTNAavzHY4Jc=;
        b=edaA/ehyo0QT1O/z0nqEM7pFx4qndnTFGcfhh9np0DYDqgYE3f4XZh6bs08NpideYGw4DT
        x/WSxAmQ8Rh+3Lkv/n6wPSXD/ZX3Ic9Sz/Z6NVFd9AyChmoA91bmYt8PcNE7JbRa/Xs6yw
        puhFs+Ec+M/g50LsfNfzKGou4xEeDNc=
Date:   Fri, 7 Oct 2022 12:22:30 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore support
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au, nayna@linux.ibm.com,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
References: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
 <20220819223138.1457091-3-gjoyce@linux.vnet.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220819223138.1457091-3-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

LGTM

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>

On 8/19/2022 4:31 PM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> Define operations for SED Opal to read/write keys
> from POWER LPAR Platform KeyStore(PLPKS). This allows
> for non-volatile storage of SED Opal keys.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/Makefile       |   1 +
>  .../powerpc/platforms/pseries/plpks_sed_ops.c | 124 ++++++++++++++++++
>  2 files changed, 125 insertions(+)
>  create mode 100644 arch/powerpc/platforms/pseries/plpks_sed_ops.c
> 
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> index 14e143b946a3..b7fea9e48a58 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
>  obj-$(CONFIG_PPC_SVM)		+= svm.o
>  obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
>  obj-$(CONFIG_PSERIES_PLPKS) += plpks.o
> +obj-$(CONFIG_PSERIES_PLPKS) += plpks_sed_ops.o
>  
>  obj-$(CONFIG_SUSPEND)		+= suspend.o
>  obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
> diff --git a/arch/powerpc/platforms/pseries/plpks_sed_ops.c b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
> new file mode 100644
> index 000000000000..833226738448
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * POWER Platform specific code for non-volatile SED key access
> + * Copyright (C) 2022 IBM Corporation
> + *
> + * Define operations for SED Opal to read/write keys
> + * from POWER LPAR Platform KeyStore(PLPKS).
> + *
> + * Self Encrypting Drives(SED) key storage using PLPKS
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/ioctl.h>
> +#include <linux/sed-opal-key.h>
> +#include "plpks.h"
> +
> +/*
> + * structure that contains all SED data
> + */
> +struct plpks_sed_object_data {
> +	u_char version;
> +	u_char pad1[7];
> +	u_long authority;
> +	u_long range;
> +	u_int  key_len;
> +	u_char key[32];
> +};
> +
> +#define PLPKS_PLATVAR_POLICY            WORLDREADABLE
> +#define PLPKS_PLATVAR_OS_COMMON         4
> +
> +#define PLPKS_SED_OBJECT_DATA_V0        0
> +#define PLPKS_SED_MANGLED_LABEL         "/default/pri"
> +#define PLPKS_SED_COMPONENT             "sed-opal"
> +#define PLPKS_SED_KEY                   "opal-boot-pin"
> +
> +/*
> + * authority is admin1 and range is global
> + */
> +#define PLPKS_SED_AUTHORITY  0x0000000900010001
> +#define PLPKS_SED_RANGE      0x0000080200000001
> +
> +void plpks_init_var(struct plpks_var *var, char *keyname)
> +{
> +	var->name = keyname;
> +	var->namelen = strlen(keyname);
> +	if (strcmp(PLPKS_SED_KEY, keyname) == 0) {
> +		var->name = PLPKS_SED_MANGLED_LABEL;
> +		var->namelen = strlen(keyname);
> +	}
> +	var->policy = PLPKS_PLATVAR_POLICY;
> +	var->os = PLPKS_PLATVAR_OS_COMMON;
> +	var->data = NULL;
> +	var->datalen = 0;
> +	var->component = PLPKS_SED_COMPONENT;
> +}
> +
> +/*
> + * Read the SED Opal key from PLPKS given the label
> + */
> +int sed_read_key(char *keyname, char *key, u_int *keylen)
> +{
> +	struct plpks_var var;
> +	struct plpks_sed_object_data *data;
> +	u_int offset = 0;
> +	int ret;
> +
> +	plpks_init_var(&var, keyname);
> +
> +	offset = offsetof(struct plpks_sed_object_data, key);
> +
> +	ret = plpks_read_os_var(&var);
> +	if (ret != 0)
> +		return ret;
> +
> +	if (offset > var.datalen)
> +		offset = 0;
> +
> +	data = (struct plpks_sed_object_data *)var.data;
> +	*keylen = be32_to_cpu(data->key_len);
> +
> +	if (var.data) {
> +		memcpy(key, var.data + offset, var.datalen - offset)> +		key[*keylen] = '\0';
> +		kfree(var.data);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Write the SED Opal key to PLPKS given the label
> + */
> +int sed_write_key(char *keyname, char *key, u_int keylen)
> +{
> +	struct plpks_var var;
> +	struct plpks_sed_object_data data;
> +	struct plpks_var_name vname;
> +
> +	plpks_init_var(&var, keyname);
> +
> +	var.datalen = sizeof(struct plpks_sed_object_data);
> +	var.data = (u8 *)&data;
> +
> +	/* initialize SED object */
> +	data.version = PLPKS_SED_OBJECT_DATA_V0;
> +	data.authority = cpu_to_be64(PLPKS_SED_AUTHORITY);
> +	data.range = cpu_to_be64(PLPKS_SED_RANGE);
> +	memset(&data.pad1, '\0', sizeof(data.pad1));
> +	data.key_len = cpu_to_be32(keylen);
> +	memcpy(data.key, (char *)key, keylen);
> +
> +	/*
> +	 * Key update requires remove first. The return value
> +	 * is ignored since it's okay if the key doesn't exist.
> +	 */
> +	vname.namelen = var.namelen;
> +	vname.name = var.name;
> +	plpks_remove_var(var.component, var.os, vname);
> +
> +	return plpks_write_var(var);
> +}
