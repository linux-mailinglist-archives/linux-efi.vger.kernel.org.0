Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B262C622E11
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiKIOgj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 09:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiKIOgi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 09:36:38 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0C310A1;
        Wed,  9 Nov 2022 06:36:37 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1osmBa-0008KM-BE; Wed, 09 Nov 2022 15:36:14 +0100
Date:   Wed, 9 Nov 2022 14:36:11 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Y2u62z4DQVENz69L@makrotopia.org>
References: <Y2rgNEQlxKgiIDdk@makrotopia.org>
 <Y2uyBYyQOC4O5iep@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2uyBYyQOC4O5iep@casper.infradead.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 09, 2022 at 01:58:29PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 08, 2022 at 11:03:16PM +0000, Daniel Golle wrote:
> > +	/* map first page */
> > +	page = read_mapping_page(
> > +		mapping, fit_start_sector >> (PAGE_SHIFT - SECTOR_SHIFT), NULL);
> > +
> > +	if (IS_ERR(page))
> > +		return -EFAULT;
> > +
> > +	if (PageError(page))
> > +		return -EFAULT;
> 
> Why are you checking for PageError?  You won't ever get a page with an
> error back from read_mapping_page().  And you have the real error in
> 'page', so why return -EFAUlT, which would indicate a problem copying
> from the user.  Also, this is a great place to use the new folio APIs
> instead of the old page APIs.  So:
> 
> 	folio = read_mapping_folio(mapping,
> 			fit_start_sector >> PAGE_SECTORS_SHIFT, NULL);
> 	if (IS_ERR(folio))
> 		return PTR_ERR(folio);
> 
> > +	init_fit = page_address(page);
> 
> 	init_fit = folio_address(folio) +
> 			offset_in_folio(folio, fit_start_sector * SECTOR_SIZE);
> 
> > +	if (!init_fit) {
> > +		put_page(page);
> > +		return -EFAULT;
> > +	}
> 
> page_address() or folio_address() can't ever return NULL, you should
> just drop this nonsense check.

Thank you for the pointers, I will implement your suggestions and post
v5 after the upcoming weekend.

> 
> ... actually, why can't you call read_part_sector() and avoid all of
> this?

I've tried that before and the problem is that read_part_sector()
returns a pointer to one sector (typically 512 bytes) of data.
And this pointer should not be accesses beyond sector boundaries,
right? You'd have to call read_part_sector() again for the next
sector.

The FIT structure, however, usually exceeds the size of one sector,
and having a continous memory area covering the structure as a whole
is crucial for libfdt to do its job.

I could, of course, use read_part_sector() to copy all sectors
covering the FIT structure into a buffer, but that seemed strange
given that read_part_sector() actually used read_mapping_page()
(and now uses read_mapping_folio()) internally and then returns a
pointer to the offset within the page/folio. So why not read it in one
piece in first place instead of having it first split up to sectors
by read_part_sector() just to then having to reassemble it into a
continous buffer again.
