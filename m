Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27EC3EE5BD
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 06:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhHQEjN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 00:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhHQEjM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 00:39:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE498C061764;
        Mon, 16 Aug 2021 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nVcIFW/MfFT3fDN43SLJ55OegN0VXbbr3reCnh3K1WQ=; b=j290cV5G5n/uuGFyEBOmHDMz3T
        ASmdekZQJjW+eGOUbYc6EL3XrYUsDLqAobkqYiz0DsLGu5NeJIP3/Hoa9hWaZqTpuX/FaF5VZFKal
        4WCtl75VzgXCGYAsSprEsNHW+bKN8mlAVUZOwsZ8nhVXRHvTKUx8WvS2pid6JooBCkheRamG7nNzj
        95inS94EUu0iT+EBjhr23khXkJBfYWuYKq2g+kY42YIsFNrLAGoQoSJ+s8Q2YTZkmN4yOcV7W61+a
        CT8DulPdmQTid4e9kx9SVBic/MnyZsJS+EjnCSuB2cAW3MEgKTrpqO1nawPppx2kbQN1umQOj3mPr
        IhftAN5g==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFqql-0028Ya-3F; Tue, 17 Aug 2021 04:37:23 +0000
Date:   Tue, 17 Aug 2021 05:37:19 +0100
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
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] mmc: block: Add mmc_bdev_to_card() helper
Message-ID: <YRs8/zfrU06No+Qv@infradead.org>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817013643.13061-3-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 17, 2021 at 04:36:42AM +0300, Dmitry Osipenko wrote:
> +	if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
> +		return NULL;

The major is a dangerous check as we have all kinds of ways to override
it.  Please check the block device operations as they must be unique.
