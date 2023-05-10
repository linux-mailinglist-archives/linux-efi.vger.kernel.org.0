Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113F6FE783
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 00:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjEJWuZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 18:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjEJWuX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 18:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F9558F;
        Wed, 10 May 2023 15:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1D26409F;
        Wed, 10 May 2023 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE8C433EF;
        Wed, 10 May 2023 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683759015;
        bh=YD/Or+PbwlMw5nLqLwUs8WIz+6qSKOgfzTEXUu+LUaU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=pxMp9v6SeSm35itTUPF90uIEd3/BmkfcgaF7ldUflRCq89EerSR6GUhBiP9OF6r2b
         Nj/YTlv2HZ9KdE/ssh2GDQ7cn//wWyN+6niR+iggR3x3wBBEKZH56B2SZAoNvGUPXU
         HVQ4k6OdU+ADi8Lr/a3p/D4vAUN5VT7UANyi16+uBSNE70OEMiExBFFk5MyZWgxvF8
         fNsBAhkaqjnKzoxAEZpQLqsI0n5fk00X7yrX5FYP5x0S4YDqYSIT2pBVK5JGPWZJE8
         cAhH7cmhL8xrWtHp2kvheEW5NN1GUtUqlRyEke+aqUHDqhqULfN4wCfLt9JUCJ4J0I
         5m5jYq0OlF4aA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:50:10 +0300
Message-Id: <CSIYR76Z8U02.30IIQJ49LMY05@suppilovahvero>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <jonathan.derrick@linux.dev>,
        <brking@linux.vnet.ibm.com>, <msuchanek@suse.de>,
        <mpe@ellerman.id.au>, <axboe@kernel.dk>,
        <akpm@linux-foundation.org>, <linux-efi@vger.kernel.org>,
        <keyrings@vger.kernel.org>, <me@benboeckel.net>, <elliott@hpe.com>,
        <andonnel@au1.ibm.com>
Subject: Re: [PATCH 1/4] block:sed-opal: SED Opal keystore
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <gjoyce@linux.vnet.ibm.com>, <linux-block@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230505194402.2079010-1-gjoyce@linux.vnet.ibm.com>
 <20230505194402.2079010-2-gjoyce@linux.vnet.ibm.com>
In-Reply-To: <20230505194402.2079010-2-gjoyce@linux.vnet.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri May 5, 2023 at 10:43 PM EEST,  wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>
> Add read and write functions that allow SED Opal keys to stored
> in a permanent keystore.

Please be more verbose starting from "Self-Encrypting Drive (SED)",
instead of just "SED", and take time to explain what these keys are.

>
> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> ---
>  block/Makefile               |  2 +-
>  block/sed-opal-key.c         | 24 ++++++++++++++++++++++++
>  include/linux/sed-opal-key.h | 15 +++++++++++++++
>  3 files changed, 40 insertions(+), 1 deletion(-)
>  create mode 100644 block/sed-opal-key.c
>  create mode 100644 include/linux/sed-opal-key.h
>
> diff --git a/block/Makefile b/block/Makefile
> index 4e01bb71ad6e..464a9f209552 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+=3D blk-zoned.o
>  obj-$(CONFIG_BLK_WBT)		+=3D blk-wbt.o
>  obj-$(CONFIG_BLK_DEBUG_FS)	+=3D blk-mq-debugfs.o
>  obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+=3D blk-mq-debugfs-zoned.o
> -obj-$(CONFIG_BLK_SED_OPAL)	+=3D sed-opal.o
> +obj-$(CONFIG_BLK_SED_OPAL)	+=3D sed-opal.o sed-opal-key.o
>  obj-$(CONFIG_BLK_PM)		+=3D blk-pm.o
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+=3D blk-crypto.o blk-crypto-profile=
.o \
>  					   blk-crypto-sysfs.o
> diff --git a/block/sed-opal-key.c b/block/sed-opal-key.c
> new file mode 100644
> index 000000000000..16f380164c44
> --- /dev/null
> +++ b/block/sed-opal-key.c
> @@ -0,0 +1,24 @@
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
> +#include <linux/errno.h>
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
> --=20
> gjoyce@linux.vnet.ibm.com


BR, Jarkko
