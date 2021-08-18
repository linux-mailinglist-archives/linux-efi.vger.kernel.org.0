Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3D3EFA15
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhHRFbQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbhHRFbP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:31:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D0C061764;
        Tue, 17 Aug 2021 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kROUUTeir+rnXUHLpBHkF1iieqqC+uJ6Vdwebp/jwj0=; b=SOjM3nabUFhDBiC5mjrq97Q1iQ
        uJNgHFbSREWYOqaii3DcEjXfMBai/p4Ln5JmiLWyNGWpRO8Typnt6OpzAfCITLUm9zlKOxlOZd9pz
        Qxf1pY8gpNJeoi+zN903PtW5wMozf8c0Pae9H4bQq15lRci4Zw2mCbsSVoxMJYyi0Q8aC9szbVi9I
        3Mm1aqhJsFPtIu4cj6ZAfey+IEeOw2hVgQvcMdeVAYcvnSnDpx7homB/dT8eJa9sKjkdDG4XjbmU9
        Kcviono2nO46Xr9YE1GNiGwOLxlzWkk7De0Ofql4ajulyCGyDQkWzK7cJLp4HUzuIxN94IxFsMBLl
        1Y+oVzYw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGE7u-003N85-6v; Wed, 18 Aug 2021 05:28:56 +0000
Date:   Wed, 18 Aug 2021 06:28:34 +0100
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
Subject: Re: [PATCH v5 2/5] mmc: block: Support alternative_gpt_sector()
 operation
Message-ID: <YRyagtKThKYK+Eah@infradead.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005547.14497-3-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 18, 2021 at 03:55:44AM +0300, Dmitry Osipenko wrote:
> +static int mmc_blk_alternative_gpt_sector(struct block_device *bdev,
> +					  sector_t *sector)
> +{
> +	struct mmc_card *card = mmc_bdev_to_card(bdev);
> +
> +	if (!card)
> +		return -ENODEV;
> +
> +	if (!card->host->ops->alternative_gpt_sector)
> +		return -EOPNOTSUPP;
> +
> +	return card->host->ops->alternative_gpt_sector(card, sector);
> +}
> +

> +static struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
> +{
> +	struct mmc_blk_data *md;
> +
> +	if (bdev->bd_disk->fops != &mmc_bdops)
> +		return NULL;

No need for this check bow that it is only called through mmc_bdops.

> +
> +	md = mmc_blk_get(bdev->bd_disk);
> +	if (!md)
> +		return NULL;
> +
> +	return md->queue.card;
> +}

This reference seems to never be dropped anywhere.

