Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BED622D03
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 14:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiKIN67 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKIN6y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 08:58:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B21E75;
        Wed,  9 Nov 2022 05:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4VpRHLspr5DIHc7t4t1HYUCiM3aAiSiNI2OEfUU8cU4=; b=pCUS5y6P7N1AyeFOOeR6NkwUBM
        o7SFa1YK/Ev7FSLtVhVBmdQxGv553RSadfJIkfJ768FKs/KKeqtIspPSo9SOHi/78zGMTPgWd46h+
        XCkdozXIeQzXhqA18C7ZUrlxMHqEA7huMsm6GQbyNrSloJCnLm54X9+F37Sqo9qiUxXMPeE30e8w3
        2YzLhBTf4x2LkKUqxVjlLxnGW79Av6bIpO0+XB/zHAp2qbmP5KYHkwuu5Zo99ZBfh78coLR/FP8fG
        7Lje7P7Fsutf5ELtj7q5oXUS4b2IV9PlmZ+JcnyzlB8BDij/0UaD1MuHPvntDLA8lSoal/Xe1POpM
        il7/hZYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oslb3-00BEj0-Ll; Wed, 09 Nov 2022 13:58:29 +0000
Date:   Wed, 9 Nov 2022 13:58:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/5] block: add partition parser for U-Boot uImage.FIT
Message-ID: <Y2uyBYyQOC4O5iep@casper.infradead.org>
References: <Y2rgNEQlxKgiIDdk@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2rgNEQlxKgiIDdk@makrotopia.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 08, 2022 at 11:03:16PM +0000, Daniel Golle wrote:
> +	/* map first page */
> +	page = read_mapping_page(
> +		mapping, fit_start_sector >> (PAGE_SHIFT - SECTOR_SHIFT), NULL);
> +
> +	if (IS_ERR(page))
> +		return -EFAULT;
> +
> +	if (PageError(page))
> +		return -EFAULT;

Why are you checking for PageError?  You won't ever get a page with an
error back from read_mapping_page().  And you have the real error in
'page', so why return -EFAUlT, which would indicate a problem copying
from the user.  Also, this is a great place to use the new folio APIs
instead of the old page APIs.  So:

	folio = read_mapping_folio(mapping,
			fit_start_sector >> PAGE_SECTORS_SHIFT, NULL);
	if (IS_ERR(folio))
		return PTR_ERR(folio);

> +	init_fit = page_address(page);

	init_fit = folio_address(folio) +
			offset_in_folio(folio, fit_start_sector * SECTOR_SIZE);

> +	if (!init_fit) {
> +		put_page(page);
> +		return -EFAULT;
> +	}

page_address() or folio_address() can't ever return NULL, you should
just drop this nonsense check.

... actually, why can't you call read_part_sector() and avoid all of
this?

