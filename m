Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75853CADE
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jun 2022 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiFCNsQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jun 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240804AbiFCNsP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 3 Jun 2022 09:48:15 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C597D11A33;
        Fri,  3 Jun 2022 06:48:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0FDF924000C;
        Fri,  3 Jun 2022 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654264091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jtp/yRc/uyATXr5jntdl9ignuQiC6FOqLOyBRDlGt+Y=;
        b=F2ou3Is5D9zfFmlCo29B+n0hLZiuMnFPTKyH5VOk/3lNoaB8BLxhyYTElUMpEaZVnXAl+s
        oRUxF0gRrtBnJdAmXTsSSQPvcN0zS6pZPebBTjbVtiKp8Nee6uZlhjmgyjsd6DhLxq+BSH
        hj4kuHjUblCaCrkd6K8+mDw//k8bcJCGcRsSkSPqcYv0PmfCfp69pYSz7nqTVIvLBNbvCK
        X6f70eaHLacWTIyuvcWkpBAu1mpXsk9aDawWFvhGEwINIbt+js24VHZxmXjlCeU98vWoML
        cby6HBmFVF/YpWZg0JxkKdswRhUS5y0704Aj6qQ79dXHmRT06DH99ZeIDCMprQ==
Date:   Fri, 3 Jun 2022 15:48:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v3 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
Message-ID: <20220603154804.2705bcb6@xps-13>
In-Reply-To: <Yn1ibyUeXZttNX2a@makrotopia.org>
References: <Yn1ibyUeXZttNX2a@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Thu, 12 May 2022 20:39:27 +0100:

> Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
> partition parsers on non-NAND mtdblock devices in case it is selected.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mtd/Kconfig       | 11 +++++++++++
>  drivers/mtd/mtd_blkdevs.c |  4 +++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 796a2eccbef0b8..12874dec15692a 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -69,6 +69,17 @@ config MTD_BLOCK_RO
>  	  You do not need this option for use with the DiskOnChip devices. For
>  	  those, enable NFTL support (CONFIG_NFTL) instead.
> =20
> +config MTD_BLOCK_PARTITIONS
> +	bool "Scan for partitions on MTD block devices"
> +	depends on MTD_BLOCK || MTD_BLOCK_RO
> +	default y if FIT_PARTITION
> +	help
> +	  Scan MTD block devices for partitions (ie. MBR, GPT, uImage.FIT, ...).
> +	  (NAND devices are omitted, ubiblock should be used instead when)
> +
> +	  Unless your MTD partitions contain sub-partitions mapped using a
> +	  partition table, say no.
> +
>  comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLO=
CK."
>  	depends on MTD_BLOCK || MTD_BLOCK_RO
> =20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index f7317211146550..c67ce2e6fbeb0a 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	} else {
>  		snprintf(gd->disk_name, sizeof(gd->disk_name),
>  			 "%s%d", tr->name, new->devnum);
> -		gd->flags |=3D GENHD_FL_NO_PART;
> +
> +		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->=
mtd))
> +			gd->flags |=3D GENHD_FL_NO_PART;

I really wonder if we need this in mtdblock ? Isn't ubiblock enough?

Anyhow,
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

I'll let Richard ack the ubiblock patch.

Thanks,
Miqu=C3=A8l
