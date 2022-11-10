Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D8624500
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 16:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKJPDp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 10:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKJPDo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 10:03:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743718B1C;
        Thu, 10 Nov 2022 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dyByMJ1FnM8pS9wy50nx7QIU4ShnY0C2LEYs5nLdq7s=; b=BZ59WACHJvZgfqFRB11gUk1yT1
        brXqYTm1gv1aZxTv8tk2GAw2D+qpM99gV17oc69z0YTx6XC3caEX7i0sW7hIJXiCULSh5GMSgPDMe
        Ayqde6NPh7Cm5mazI4Gkmtd/s6UIg8p4x00orrdTwetPvHsBWREXjl0weKX53b3pDBMWeskm4idE7
        +IMqt/j9BV4KeytyL2eH4DoqZgEs5lDw5BKe8dlgSG8lfOlfOvRGnm/ecdmuCZ913y68IGrk3zBpO
        OzCgbyl+7DRlX2T8WzHF0abvztYBzhOcVcZh87PWfTLSuuLeZBDFqthO2I8LtrbuR7kbBp0TsopOl
        8zIn8MzA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot953-00C9kk-GP; Thu, 10 Nov 2022 15:03:01 +0000
Date:   Thu, 10 Nov 2022 15:03:01 +0000
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
Message-ID: <Y20SpcPNbdhcM9ps@casper.infradead.org>
References: <Y2rgNEQlxKgiIDdk@makrotopia.org>
 <Y2uyBYyQOC4O5iep@casper.infradead.org>
 <Y2u62z4DQVENz69L@makrotopia.org>
 <Y2vhfdhvw0PADeIF@casper.infradead.org>
 <Y2xZa9z3HHtddG3t@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2xZa9z3HHtddG3t@makrotopia.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 10, 2022 at 01:52:43AM +0000, Daniel Golle wrote:
> On Wed, Nov 09, 2022 at 05:21:01PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 09, 2022 at 02:36:11PM +0000, Daniel Golle wrote:
> > > On Wed, Nov 09, 2022 at 01:58:29PM +0000, Matthew Wilcox wrote:
> > > > ... actually, why can't you call read_part_sector() and avoid all of
> > > > this?
> > > 
> > > I've tried that before and the problem is that read_part_sector()
> > > returns a pointer to one sector (typically 512 bytes) of data.
> > > And this pointer should not be accesses beyond sector boundaries,
> > > right? You'd have to call read_part_sector() again for the next
> > > sector.
> > > 
> > > The FIT structure, however, usually exceeds the size of one sector,
> > > and having a continous memory area covering the structure as a whole
> > > is crucial for libfdt to do its job.
> > > 
> > > I could, of course, use read_part_sector() to copy all sectors
> > > covering the FIT structure into a buffer, but that seemed strange
> > > given that read_part_sector() actually used read_mapping_page()
> > > (and now uses read_mapping_folio()) internally and then returns a
> > > pointer to the offset within the page/folio. So why not read it in one
> > > piece in first place instead of having it first split up to sectors
> > > by read_part_sector() just to then having to reassemble it into a
> > > continous buffer again.
> > 
> > Are you guaranteed that it's "sufficiently" aligned on storage so
> > that it fits entirely within a single page?  If not, you'll have
> > to copy it, vmap it, or fix libfdt to handle a segmented buffer.
> 
> Yes, for the uImage.FIT to be usable for the partition parser it has
> to be page-aligned.
> 
> There is a check which makes sure that this is the case:
> > +	/* uImage.FIT should be aligned to page boundaries */
> > +	if (fit_start_sector % (1 << (PAGE_SHIFT - SECTOR_SHIFT)))
> > +		return 0;
> 
> In case of mtdblock or ubiblock devices, the image always starts at
> offset 0, so this is never a problem.
> In case of the image being stored in a GPT partition, one has to make
> sure that the start sector of the partition is page aligned, otherwise
> the above check will fail and the partition parser will bail out.

OK.  Then I think open coding it is the right idea, just with all
the cruft removed ;-)  I looked at extracting parts of
read_part_sector() into read_part_page(), but it ended up being
a two line function that wasn't terribly useful.

