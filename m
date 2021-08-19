Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32B3F1414
	for <lists+linux-efi@lfdr.de>; Thu, 19 Aug 2021 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhHSHKj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhHSHKi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 03:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526F0C061575;
        Thu, 19 Aug 2021 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=NVNgO3H3TRQdukK5brtNeeT2j1
        yhfOYeVfsp7cwPYnuhL6c7MAr/XcNMJbcMIM/+1VS1hsQUaKJmyktM5+9cIO0P51VXmy/k/8MmWzN
        BFreh8w4AraeaSMd93xIRPCu0PN6kGJMS3JyHKNAtFPwt5CHAxs7lUVnlEYg9aLTr9GklySbh9KGH
        gVLKLzTtEPH7bWdrmseeT3o21U+D2ALvaHyIz0W5+QRC03XQE8HuPW38h3FFpcjamfLSkvtdbz8O6
        /1q5QqVsYaK2aZztaxemmQRBlAzzt0GmGNbavCecsbvcCYN9KGH6Oz216GEqOfTenaFffsP0qkMTo
        vSTT4m+w==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGc9v-004l26-55; Thu, 19 Aug 2021 07:08:24 +0000
Date:   Thu, 19 Aug 2021 08:08:15 +0100
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
Subject: Re: [PATCH v6 1/5] block: Add alternative_gpt_sector() operation
Message-ID: <YR4DX5BT2fK3LE0H@infradead.org>
References: <20210818221920.3893-1-digetx@gmail.com>
 <20210818221920.3893-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818221920.3893-2-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
