Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B1D53F305
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jun 2022 02:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbiFGAmT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jun 2022 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiFGAmS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jun 2022 20:42:18 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B62F42;
        Mon,  6 Jun 2022 17:42:11 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1nyNIM-0000rx-Ke; Tue, 07 Jun 2022 02:42:06 +0200
Date:   Tue, 7 Jun 2022 01:42:01 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v3 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
Message-ID: <Yp6e2XXJ7SlkdX+B@makrotopia.org>
References: <Yn1ibyUeXZttNX2a@makrotopia.org>
 <20220603154804.2705bcb6@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220603154804.2705bcb6@xps-13>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 03, 2022 at 03:48:04PM +0200, Miquel Raynal wrote:
> Hi Daniel,
> 
> daniel@makrotopia.org wrote on Thu, 12 May 2022 20:39:27 +0100:
> 
> > Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
> > partition parsers on non-NAND mtdblock devices in case it is selected.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/mtd/Kconfig       | 11 +++++++++++
> >  drivers/mtd/mtd_blkdevs.c |  4 +++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> > index 796a2eccbef0b8..12874dec15692a 100644
> > --- a/drivers/mtd/Kconfig
> > +++ b/drivers/mtd/Kconfig
> > @@ -69,6 +69,17 @@ config MTD_BLOCK_RO
> >  	  You do not need this option for use with the DiskOnChip devices. For
> >  	  those, enable NFTL support (CONFIG_NFTL) instead.
> >  
> > +config MTD_BLOCK_PARTITIONS
> > +	bool "Scan for partitions on MTD block devices"
> > +	depends on MTD_BLOCK || MTD_BLOCK_RO
> > +	default y if FIT_PARTITION
> > +	help
> > +	  Scan MTD block devices for partitions (ie. MBR, GPT, uImage.FIT, ...).
> > +	  (NAND devices are omitted, ubiblock should be used instead when)
> > +
> > +	  Unless your MTD partitions contain sub-partitions mapped using a
> > +	  partition table, say no.
> > +
> >  comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK."
> >  	depends on MTD_BLOCK || MTD_BLOCK_RO
> >  
> > diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> > index f7317211146550..c67ce2e6fbeb0a 100644
> > --- a/drivers/mtd/mtd_blkdevs.c
> > +++ b/drivers/mtd/mtd_blkdevs.c
> > @@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
> >  	} else {
> >  		snprintf(gd->disk_name, sizeof(gd->disk_name),
> >  			 "%s%d", tr->name, new->devnum);
> > -		gd->flags |= GENHD_FL_NO_PART;
> > +
> > +		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->mtd))
> > +			gd->flags |= GENHD_FL_NO_PART;
> 
> I really wonder if we need this in mtdblock ? Isn't ubiblock enough?

One of the ideas behind this series is to be able to use the exact same
image (which includes a rootfs filesystem sub-image) on devices with
different boot storage options instead of having to write kernel and
root filesystems separately in a storage-type specific manner.

So the very same uImage.FIT on devices with block-based storage can be
written into a GPT partition (see 3/5), on devices with NAND flash
where UBI is used into a UBI volume (see 5/5) and on devices with NOR
flash into an MTD partition (this patch).

> 
> Anyhow,
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thank you for the review!


> 
> I'll let Richard ack the ubiblock patch.
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
