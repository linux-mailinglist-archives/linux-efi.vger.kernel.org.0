Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E73EFA21
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbhHRFef (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbhHRFeG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:34:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E5C0613D9;
        Tue, 17 Aug 2021 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lmy7OgnzuANHXTdK5XRu4wGl7kTVofuBUfeSr7/NUUI=; b=T/pFvu0pVHbWWfKdh6qo6CQX4P
        vyemjRFtg9KmwRPPhkjKRSuAb1DSj2/RlfmarEHZtwJagpweQS4d18nllPtpDg9utuuupK1IRSRK4
        Xb+yucfTkt23JTnT/k1ZjoHJdUl+SceyGzNAgibyui+etrWKZpE4tZJjJCoEx078tE7f7yt2i1m9U
        M04GdE3U0usjmXZ4T7MkXf/g8XbLWAjZjGFP+L7Lbzr4WZcPgQrGX0YujDABgIa4yiB8oZGzY/pYb
        eX+Rvxy8EofxOwVCkOyb0b6yz/6fn+Yvh/eLVc0dnuZ0OWf5SqGgsSm0G8KIS+pd4CTiA4mE0l5k1
        HXtC+vkQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGEA5-003NDS-4N; Wed, 18 Aug 2021 05:31:24 +0000
Date:   Wed, 18 Aug 2021 06:30:49 +0100
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
Subject: Re: [PATCH v5 4/5] mmc: sdhci-tegra: Implement
 alternative_gpt_sector()
Message-ID: <YRybCfUX6/HNcbEs@infradead.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005547.14497-5-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 18, 2021 at 03:55:46AM +0300, Dmitry Osipenko wrote:
> Tegra20/30/114/124 Android devices place GPT at a non-standard location.
> Implement alternative_gpt_sector() callback of the MMC host ops which
> specifies that GPT location for the partition scanner.

Just curious:  how do the android kernels deal with this mess?
