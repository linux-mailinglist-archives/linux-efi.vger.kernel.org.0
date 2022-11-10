Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF5624AD0
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKJTmr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Thu, 10 Nov 2022 14:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKJTmr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 14:42:47 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5B45EFF;
        Thu, 10 Nov 2022 11:42:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F075A63CDC5B;
        Thu, 10 Nov 2022 20:42:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7_oQ7gzt2uLp; Thu, 10 Nov 2022 20:42:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1B59C6226242;
        Thu, 10 Nov 2022 20:42:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BVEGG__kuGf2; Thu, 10 Nov 2022 20:42:41 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EE3BE63CDC5B;
        Thu, 10 Nov 2022 20:42:40 +0100 (CET)
Date:   Thu, 10 Nov 2022 20:42:40 +0100 (CET)
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
        linux-efi@vger.kernel.org
Message-ID: <2114450579.219028.1668109360889.JavaMail.zimbra@nod.at>
In-Reply-To: <Y2rgg6h22N6PfKNM@makrotopia.org>
References: <Y2rgg6h22N6PfKNM@makrotopia.org>
Subject: Re: [PATCH v4 5/5] mtd: ubi: block: add option to enable scanning
 for partitions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: add option to enable scanning for partitions
Thread-Index: xBTGe2VDlmMZly/EXlIh1C18tKLhCw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Daniel,

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
>
> Add Kconfig option CONFIG_MTD_UBI_BLOCK_PARTITIONS and enable block
> partition parsers on ubiblock devices in case it is selected.

I think we should stick with one Kconfig at most.
Not both CONFIG_MTD_UBI_BLOCK_PARTITIONS and CONFIG_MTD_BLOCK_PARTITION.

Thanks,
//richard
