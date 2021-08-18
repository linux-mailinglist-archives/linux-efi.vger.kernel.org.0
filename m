Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8453EFA0A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbhHRF1e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHRF1e (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:27:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D93C061764;
        Tue, 17 Aug 2021 22:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2GcTbDmgLsouPyMEnfVbCOFWhGh+5ywbqcpH6RwhvHw=; b=jmwNoPrus/S5VWKF38A6NujbjY
        snRuXg4hvUwPJesythGV+EsF7giGTe14R5O6oaStzzcqMKsp1G6OfoePgRjo2JCLNvoLndk6vNObb
        QrRZwzRwt8SNJivL2OnefjRnqeuaNHFlcCDTFfgWUqEvhroZHZJygJFd7nF69vslPRzZBHtxyD8dx
        pSVaG7C9TAcnZMgZcrvKWLuD12PCoTw4dwsDNZRyl/aNkNZdwHrczVV4Qe0ufbdOLO8a4oOsGSul+
        cuDpCl8/lduO3Q+gRr7e4vd8AnDZYNP1Efprz4wjeHZBb9rDYxlF4bkZmhI8vQCYLOEDTi2bQmw7Z
        9b3pbQxw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGE4W-003MwX-9o; Wed, 18 Aug 2021 05:25:17 +0000
Date:   Wed, 18 Aug 2021 06:25:04 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v5 5/5] partitions/efi: Support non-standard GPT location
Message-ID: <YRyZsDAiDX8OEO35@infradead.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005547.14497-6-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 18, 2021 at 03:55:47AM +0300, Dmitry Osipenko wrote:
> Support looking up GPT at a non-standard location specified by a block
> device driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  block/partitions/efi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index aaa3dc487cb5..b9509f445b3c 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -585,6 +585,8 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>  	gpt_header *pgpt = NULL, *agpt = NULL;
>  	gpt_entry *pptes = NULL, *aptes = NULL;
>  	legacy_mbr *legacymbr;
> +	struct gendisk *disk = state->disk;
> +	const struct block_device_operations *fops = disk->fops;
>  	sector_t total_sectors = get_capacity(state->disk);
>  	u64 lastlba;
>  
> @@ -619,6 +621,17 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>          if (!good_agpt && force_gpt)
>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>  
> +	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
> +		struct block_device *bdev = disk->part0;
> +		sector_t agpt_sector;
> +		int err;
> +
> +		err = fops->alternative_gpt_sector(bdev, &agpt_sector);

Please call the method with the disk as the argument.  I've been moving
the block layer to generally pass the gendisk whenever we're dealing
with the whole device, as that makes the intent very clear.

Also do we really need the force_gpt check?  That is we always require
the user to pass a command line argument to use this?
