Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD3622C23
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 14:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKINLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 08:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiKINK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 08:10:56 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED8F1B1F1;
        Wed,  9 Nov 2022 05:10:53 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1oskqh-000828-0n; Wed, 09 Nov 2022 14:10:35 +0100
Date:   Wed, 9 Nov 2022 13:10:31 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
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
Message-ID: <Y2umx75DC8+XDlgd@makrotopia.org>
References: <Y2rgbfpYfpbLKHaf@makrotopia.org>
 <20221109134526.158047e1@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109134526.158047e1@xps-13>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Miquel,

On Wed, Nov 09, 2022 at 01:45:26PM +0100, Miquel Raynal wrote:
> Hi Daniel,
> 
> daniel@makrotopia.org wrote on Tue, 8 Nov 2022 23:04:13 +0000:
> 
> > Add Kconfig boolean CONFIG_MTD_BLOCK_PARTITIONS and enable block
> > partition parsers on non-NAND mtdblock devices in case it is selected.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/mtd/Kconfig       | 11 +++++++++++
> >  drivers/mtd/mtd_blkdevs.c |  4 +++-
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> > index 796a2eccbef0..12874dec1569 100644
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
> 
> Actually I know I've acked this patch in the past but I am now
> wondering again if this is the right way so I would like to discuss
> this again. I don't feel making partitions on top of blk devices like
> that is the right solution. Why not using the advanced partition
> parsers that we now have in MTD to create these subpartitions and then
> have blocks emulated on top of them?

Simply because then we would need the same parser implemented one time
as block/partitions/fit.c (for devices booting from SATA or eMMC, for
example) and then another time as drivers/mtd/parsers/parse_fit.c (for
devices using raw NOR flash) and for UBI there isn't even any
infrastructure allowing the dynamic splitting of UBI volumes (hence we
would need to invent a new splitting/partitioning mechanism on top of
UBI just for that).

Using the block partition parser as common ground for all three storage
types typically found in embedded devices seemed like the best idea, as
in that way I only had to implement the uImage.FIT parser once.


> 
> > +
> >  comment "Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK."
> >  	depends on MTD_BLOCK || MTD_BLOCK_RO
> >  
> > diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> > index 60b222799871..e6f2e0888246 100644
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
> >  	}
> >  
> >  	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
> 
> 
> Thanks,
> Miquèl
