Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4123A51024A
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 17:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352695AbiDZP7L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 11:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352680AbiDZP7E (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 11:59:04 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3FC2E9F0;
        Tue, 26 Apr 2022 08:55:52 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1njNXX-0005kf-Tn; Tue, 26 Apr 2022 17:55:48 +0200
Date:   Tue, 26 Apr 2022 16:55:45 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 4/5] mtd_blkdevs: scan partitions on mtdblock if
 FIT_PARTITION is set
Message-ID: <YmgWAXieuXTlz1bk@makrotopia.org>
References: <Yma3ck/hygQ0badz@makrotopia.org>
 <20220426093710.6ec48b5e@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426093710.6ec48b5e@xps13>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Apr 26, 2022 at 09:37:10AM +0200, Miquel Raynal wrote:
> Hi Daniel,
> 
> daniel@makrotopia.org wrote on Mon, 25 Apr 2022 16:00:02 +0100:
> 
> > Enable partition parsers on plain mtdblock devices in case of
> > CONFIG_FIT_PARTITION being selected.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  drivers/mtd/mtd_blkdevs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> > index f7317211146550..e9759c4182f8d5 100644
> > --- a/drivers/mtd/mtd_blkdevs.c
> > +++ b/drivers/mtd/mtd_blkdevs.c
> > @@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
> >  	} else {
> >  		snprintf(gd->disk_name, sizeof(gd->disk_name),
> >  			 "%s%d", tr->name, new->devnum);
> > +#ifndef CONFIG_FIT_PARTITION
> 
> Can we use a regular 'if' here?

I'll introduce additional Kconfig options to enable scanning for
(sub-)partitions on MTD block and UBI block devices as Christoph Hellwig
correctly critizied that re-using this unrelated Kconfig option is
misleading.

I'll also use
if (IS_ENABLED(...))
instead of
#ifdef ...
for better coverage testing.

Now going to wait a few more days for more comments and then re-send.

Thank you for the review!

> 
> >  		gd->flags |= GENHD_FL_NO_PART;
> > +#endif
> >  	}
> >  
> >  	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
> 
> Thanks,
> Miquèl
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
