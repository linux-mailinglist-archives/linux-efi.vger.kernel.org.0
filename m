Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478B5622BCE
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 13:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKIMpe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 07:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKIMpe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 07:45:34 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE20220C3;
        Wed,  9 Nov 2022 04:45:32 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 547C91BF207;
        Wed,  9 Nov 2022 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667997930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CP5HR4/fW62hCUEuUWY+rJW5C3z5hPsLxg/D74tYsWg=;
        b=IQaY+i8KKGP7I+eJmahCk+nqdTj3vEIF7eoLt1ZRFZKkeRIwcVnF3JnaYCeSduXrh/bn6K
        w4UJf6oLc0ToqR/TsdchrX3M87LJsUqeVpdoxX/b79NlYnEFeN6ylERltWBiWFq4sbUpak
        H8DsZA7e/bBadHXaNogTXrMlnkYbI8auXlcKSTclxaGcbzlpqA3kbgP1jk6OFS2sF/+Ruw
        RyGNOg3Xhy3LmartbIq7ojm3aDQo3BOkBLEqXSSASDpJRMM27TPM17VWxqDgSEr/5bJsXa
        qvpXB2QjMXjsCSARHkY6FP5r6BgvzSrjHtzsSefQRXiFwqY2zMeUNO6XAQCfSQ==
Date:   Wed, 9 Nov 2022 13:45:26 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
Message-ID: <20221109134526.158047e1@xps-13>
In-Reply-To: <Y2rgbfpYfpbLKHaf@makrotopia.org>
References: <Y2rgbfpYfpbLKHaf@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Tue, 8 Nov 2022 23:04:13 +0000:

> Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
> partition parsers on non-NAND mtdblock devices in case it is selected.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/Kconfig       | 11 +++++++++++
>  drivers/mtd/mtd_blkdevs.c |  4 +++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index 796a2eccbef0..12874dec1569 100644
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

Actually I know I've acked this patch in the past but I am now
wondering again if this is the right way so I would like to discuss
this again. I don't feel making partitions on top of blk devices like
that is the right solution. Why not using the advanced partition
parsers that we now have in MTD to create these subpartitions and then
have blocks emulated on top of them?

> +
>  comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLO=
CK."
>  	depends on MTD_BLOCK || MTD_BLOCK_RO
> =20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 60b222799871..e6f2e0888246 100644
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
>  	}
> =20
>  	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);


Thanks,
Miqu=C3=A8l
