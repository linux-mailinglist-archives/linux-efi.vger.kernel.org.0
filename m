Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22263F142A
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 09:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhHSHOE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhHSHOD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 03:14:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE97C061575;
        Thu, 19 Aug 2021 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JM+txvbbN9qHKR6HmDE1hJhvustedDdZ+eM/QD9oSHI=; b=gQgvT9kcUIWjm/IdZ7EPLPxNzA
        wKA3BC4kV5Deq0rZtlxPVpTj1tvBnpiI4EeTtualny7a2z4VAaT6/pkWoamlSbfFsnsbBshIwMcn6
        sVFQ0FzQDww7YeFn82Lf4DrBnOAGTyWbYKbdcjgap3OXysU+wLa0sIX4UvLknZimW+i2Y3kBTw7Nr
        asGnGErH6FCOrsjj5AfhmyB7LoHFVSz422lXZdaEViGCD6iCGLd6TpRgIGNFSmAsX6TsqbCghYixB
        dY5yv6ZDxfCvD5JyFr9rkXsHt85iYA4CTfRzoq6uR5sAowGHklDUYLdFvhA1vEekZZS/H0PZg0jq2
        sbTMbwmQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGcDG-004lF9-PX; Thu, 19 Aug 2021 07:11:53 +0000
Date:   Thu, 19 Aug 2021 08:11:42 +0100
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
Subject: Re: [PATCH v6 2/5] partitions/efi: Support non-standard GPT location
Message-ID: <YR4ELm5/8BQkicxI@infradead.org>
References: <20210818221920.3893-1-digetx@gmail.com>
 <20210818221920.3893-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818221920.3893-3-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 01:19:17AM +0300, Dmitry Osipenko wrote:
> Support looking up GPT at a non-standard location specified by a block
> device driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
