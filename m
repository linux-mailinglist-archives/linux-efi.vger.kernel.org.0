Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332A62314E
	for <lists+linux-efi@lfdr.de>; Wed,  9 Nov 2022 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKIRVP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Nov 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKIRVO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Nov 2022 12:21:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551E125C8;
        Wed,  9 Nov 2022 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U8E7Jm8e1876qUqey5/8BiJLc1XaDBvWcjC7yx9ROzg=; b=gmH5h/mQ6qEquszdoCqVrpILhD
        iK+Kn9JHkuehJ2b1rL/vezAXYWk0g3pgHr7Iy/bU1gc3he4FIVq3yXOY55t5UfEjBxHetnvUf7TEN
        sA7IMRXPsK/N42x13tITnCCN/virflVFzUjbq/NWOF+5NR7/TJJCqt76qufO0ugPmwCpdfJJivc5a
        osQkbkyKeXSgy0E4O0x9ZfTPlAFK/2N170Qq7YhrJqYEP+1KaiC2loLtcK8AdIBu3jn/6awOQon6Z
        jv7RxpJFjzlqVSJ4ty0ykIzFEYXt2wMLx5Hh5VwgxdpsOcaf/3h9HS4qDfKuj4uHxAEnu4qohzwjs
        2sB3e4pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osol3-00BLdJ-H0; Wed, 09 Nov 2022 17:21:01 +0000
Date:   Wed, 9 Nov 2022 17:21:01 +0000
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
Message-ID: <Y2vhfdhvw0PADeIF@casper.infradead.org>
References: <Y2rgNEQlxKgiIDdk@makrotopia.org>
 <Y2uyBYyQOC4O5iep@casper.infradead.org>
 <Y2u62z4DQVENz69L@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2u62z4DQVENz69L@makrotopia.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 09, 2022 at 02:36:11PM +0000, Daniel Golle wrote:
> On Wed, Nov 09, 2022 at 01:58:29PM +0000, Matthew Wilcox wrote:
> > ... actually, why can't you call read_part_sector() and avoid all of
> > this?
> 
> I've tried that before and the problem is that read_part_sector()
> returns a pointer to one sector (typically 512 bytes) of data.
> And this pointer should not be accesses beyond sector boundaries,
> right? You'd have to call read_part_sector() again for the next
> sector.
> 
> The FIT structure, however, usually exceeds the size of one sector,
> and having a continous memory area covering the structure as a whole
> is crucial for libfdt to do its job.
> 
> I could, of course, use read_part_sector() to copy all sectors
> covering the FIT structure into a buffer, but that seemed strange
> given that read_part_sector() actually used read_mapping_page()
> (and now uses read_mapping_folio()) internally and then returns a
> pointer to the offset within the page/folio. So why not read it in one
> piece in first place instead of having it first split up to sectors
> by read_part_sector() just to then having to reassemble it into a
> continous buffer again.

Are you guaranteed that it's "sufficiently" aligned on storage so
that it fits entirely within a single page?  If not, you'll have
to copy it, vmap it, or fix libfdt to handle a segmented buffer.
