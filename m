Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC550FF92
	for <lists+linux-efi@lfdr.de>; Tue, 26 Apr 2022 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiDZNzx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 Apr 2022 09:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiDZNzw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 Apr 2022 09:55:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91FE12EB78;
        Tue, 26 Apr 2022 06:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=irD5TP5dvYOrrDctV6NZa3iVQyIsJ9/GKsDYgTCLneg=; b=GphFVrNB6afv2AYo22a/nMAAJY
        m8+WnybGo7Wr5Dql3SNlVIYf4LwEpiSVbiZqM36tRxQrB7A4iO5cgzbTG2HZMbBNdoWwHCr8es3f6
        fWLqL5IDYVkyvs5G9vpO+Q1ZQ41+Jrax07Fxju54ejsKuMo3CgoW2R6Qj3izCMjvdiJxc0h61ijAx
        EfPl+WBbV2jY4q2HoQQEf+kl9iiuHlvtpzAmfRp6QR8oZ2jbSNmbnBFzg5R63RM3g/CzjnrbqRTog
        HGYcSDvt8E74qPhlGWvsje5aOjuJhzmuTfEWVXTpNZcY37pk4eZBcz02YmqGGlDlwQM4PWuPIdDRL
        2n05+acQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njLcQ-00ElLb-N2; Tue, 26 Apr 2022 13:52:42 +0000
Date:   Tue, 26 Apr 2022 06:52:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 4/5] mtd_blkdevs: scan partitions on mtdblock if
 FIT_PARTITION is set
Message-ID: <Ymf5KpEAGybW8W17@infradead.org>
References: <Yma3ck/hygQ0badz@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yma3ck/hygQ0badz@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 25, 2022 at 04:00:02PM +0100, Daniel Golle wrote:
> Enable partition parsers on plain mtdblock devices in case of
> CONFIG_FIT_PARTITION being selected.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mtd/mtd_blkdevs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index f7317211146550..e9759c4182f8d5 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -359,7 +359,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  	} else {
>  		snprintf(gd->disk_name, sizeof(gd->disk_name),
>  			 "%s%d", tr->name, new->devnum);
> +#ifndef CONFIG_FIT_PARTITION
>  		gd->flags |= GENHD_FL_NO_PART;
> +#endif

This will just recreate the fixed regression, just with the extra
twist of needіng a completely unrelted config option to trigger it.
