Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57191624ADA
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 20:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKJTo5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 10 Nov 2022 14:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJTo4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 14:44:56 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E81572F;
        Thu, 10 Nov 2022 11:44:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5757261B8B4D;
        Thu, 10 Nov 2022 20:44:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nGPtvOKwhp3V; Thu, 10 Nov 2022 20:44:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0B4A66226249;
        Thu, 10 Nov 2022 20:44:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yQrYoj6s4SOb; Thu, 10 Nov 2022 20:44:53 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC57B61B8B4D;
        Thu, 10 Nov 2022 20:44:53 +0100 (CET)
Date:   Thu, 10 Nov 2022 20:44:53 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>
Message-ID: <1691046252.219046.1668109493753.JavaMail.zimbra@nod.at>
In-Reply-To: <Y2rgbfpYfpbLKHaf@makrotopia.org>
References: <Y2rgbfpYfpbLKHaf@makrotopia.org>
Subject: Re: [PATCH v4 4/5] mtd_blkdevs: add option to enable scanning for
 partitions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtd_blkdevs: add option to enable scanning for partitions
Thread-Index: qesM6z2xTDVbTIYuNhENmoux2tHhiA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> +
> +		if (!IS_ENABLED(CONFIG_MTD_BLOCK_PARTITIONS) || mtd_type_is_nand(new->mtd))
> +			gd->flags |= GENHD_FL_NO_PART;

I know that NAND should not get used with mtdblock because lack of wearleveling and
in general too many writes. But what exactly is the rationale to deny part scanning for NAND?

Thanks,
//richard
