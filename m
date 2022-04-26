Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958550F2B5
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiDZHko (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 03:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344130AbiDZHkc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 03:40:32 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED641331BB;
        Tue, 26 Apr 2022 00:37:23 -0700 (PDT)
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 87A8DC7D66;
        Tue, 26 Apr 2022 07:37:22 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A2B15240005;
        Tue, 26 Apr 2022 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650958633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0qBOgNyh8voQ1Cq8xvcGs0VWNzEpgJVmBmlg1kmNXM=;
        b=fjWUZ6VGHzQIycm0+2Q6HwF2JSXWP2MnpyxPKkWCQmNAmDmms8EDOMQYKLD+o3j8hB+qj3
        viy24v8Q49I3/yOkYS5VvP5VTy3Zi/t1eJNc2hCqJWjpyCTHoaqfBz7iYl4MHF2M/HBUIx
        bnyTs3j8GKcW/fLYnvWvNl35tkTnIH/+xF+D3AXL3QQl/4oW1V65Zs+gvlpGn9uraLQ+OQ
        UDaMqAYchPF3NQfK//ot9KlwVvS2mYsJmCF364GYC7bSta7ctfaY9KK3yZ8HJbHNPOEEJs
        ZVUuOc+vaTnfXgkcQ238FhAExM09m3aJAPJm20t2D+ofJrVUpeVIMBPUtA/HCg==
Date:   Tue, 26 Apr 2022 09:37:10 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 4/5] mtd_blkdevs: scan partitions on mtdblock if
 FIT_PARTITION is set
Message-ID: <20220426093710.6ec48b5e@xps13>
In-Reply-To: <Yma3ck/hygQ0badz@makrotopia.org>
References: <Yma3ck/hygQ0badz@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Mon, 25 Apr 2022 16:00:02 +0100:

> Enable partition parsers on plain mtdblock devices in case of
> CONFIG_FIT_PARTITION being selected.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mtd/mtd_blkdevs.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index f7317211146550..e9759c4182f8d5 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	} else {
>  		snprintf(gd->disk_name, sizeof(gd->disk_name),
>  			 "%s%d", tr->name, new->devnum);
> +#ifndef CONFIG_FIT_PARTITION

Can we use a regular 'if' here?

>  		gd->flags |=3D GENHD_FL_NO_PART;
> +#endif
>  	}
> =20
>  	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);

Thanks,
Miqu=C3=A8l
