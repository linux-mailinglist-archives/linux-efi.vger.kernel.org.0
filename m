Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82505F7D47
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJGSXc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Oct 2022 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJGSXb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Oct 2022 14:23:31 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A3BC61B;
        Fri,  7 Oct 2022 11:23:26 -0700 (PDT)
Message-ID: <80bb74f7-5198-51bd-82f1-ce3453647e7d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665167005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4EFSYNlAsWZCuH+Dz+haHcFzJ2ablsybQCXXVn+XQA=;
        b=aD9UptPgn1Wi0vIeER14YwpOm8GvyS3KMYSeFBqKDAp7FsoAPSP4PzLxKG1z84Clfgb5yQ
        rUIliIdqMmzbT41nJ2WPP+zHo2MI+tIODwE70OlTAS8Wr49inYHPvAi60Qtiimey34BcBO
        EnG5kUHY6LEovmnasibnHrcOLowIHZY=
Date:   Fri, 7 Oct 2022 12:23:21 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] block: sed-opal: SED Opal keystore
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, brking@linux.vnet.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au, nayna@linux.ibm.com,
        axboe@kernel.dk, akpm@linux-foundation.org,
        linux-efi@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, jarkko@kernel.org
References: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
 <20220819223138.1457091-2-gjoyce@linux.vnet.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220819223138.1457091-2-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>

On 8/19/2022 4:31 PM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> Add read and write functions that allow SED Opal keys to stored
> in a permanent keystore.
> 
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> ---
>  block/Makefile               |  2 +-
>  block/sed-opal-key.c         | 23 +++++++++++++++++++++++
>  include/linux/sed-opal-key.h | 15 +++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 block/sed-opal-key.c
>  create mode 100644 include/linux/sed-opal-key.h
> 
> diff --git a/block/Makefile b/block/Makefile
> index 4e01bb71ad6e..464a9f209552 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
>  obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
>  obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
> -obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
> +obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o sed-opal-key.o
>  obj-$(CONFIG_BLK_PM)		+= blk-pm.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
>  					   blk-crypto-sysfs.o
> diff --git a/block/sed-opal-key.c b/block/sed-opal-key.c
> new file mode 100644
> index 000000000000..32ef988cd53b
> --- /dev/null
> +++ b/block/sed-opal-key.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SED key operations.
> + *
> + * Copyright (C) 2022 IBM Corporation
> + *
> + * These are the accessor functions (read/write) for SED Opal
> + * keys. Specific keystores can provide overrides.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/sed-opal-key.h>
> +
> +int __weak sed_read_key(char *keyname, char *key, u_int *keylen)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int __weak sed_write_key(char *keyname, char *key, u_int keylen)
> +{
> +	return -EOPNOTSUPP;
> +}
> diff --git a/include/linux/sed-opal-key.h b/include/linux/sed-opal-key.h
> new file mode 100644
> index 000000000000..c9b1447986d8
> --- /dev/null
> +++ b/include/linux/sed-opal-key.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SED key operations.
> + *
> + * Copyright (C) 2022 IBM Corporation
> + *
> + * These are the accessor functions (read/write) for SED Opal
> + * keys. Specific keystores can provide overrides.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +
> +int sed_read_key(char *keyname, char *key, u_int *keylen);
> +int sed_write_key(char *keyname, char *key, u_int keylen);
