Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA81C3EF9FF
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHRFYP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHRFYP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:24:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09731C061764;
        Tue, 17 Aug 2021 22:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j7wnjfg3XGnUoaxd6WvLIghvLlyj31dNMsW6MgXpyAU=; b=SABWEzechneXfKNd5kV/s4sI64
        e8II4QLox1Qv1ezGUXX5zbXAwK6m2uwK+cL9DYZ1W5WfVqbuWFgGO2e5yOiNNRQW9QdGNKOWTcwo+
        BiamgsWHTrtlr+7DMM2yxNfB1GEVRfCV2C+6IbCuiBAF9PzNs4RW6/+0KP2Ws4SGtYwmB58vPraMg
        wLiAQRE7OHO6iOr3l6+KQtwZrrlfizWHt/aBOcK8m3ztdwJT5j1w74Wan8ubQZzFq7RwtSGWmqa8b
        7LNiwvr/77Pef+QGj80MAv9tASO2DTRniv1B81zak9wU+2pMGwTl/CYdHtztWYKwL1CrqxpB2VM8V
        S+/OqJ7A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGE0O-003Miu-Jl; Wed, 18 Aug 2021 05:21:08 +0000
Date:   Wed, 18 Aug 2021 06:20:48 +0100
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
Subject: Re: [PATCH v5 1/5] block: Add alternative_gpt_sector() operation
Message-ID: <YRyYsNs10AoPg069@infradead.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818005547.14497-2-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 18, 2021 at 03:55:43AM +0300, Dmitry Osipenko wrote:
> Add alternative_gpt_sector() block device operation which specifies
> alternative location of a GPT entry. This allows us to support Android
> devices which have GPT entry at a non-standard location and can't be
> repartitioned easily.

Probably worth adding a little comment explaining this rather odd
operation.
