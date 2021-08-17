Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C263EE5D6
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 06:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhHQErA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 00:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhHQEq7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 00:46:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BD9C061764;
        Mon, 16 Aug 2021 21:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0TwuFERteGkTjs0WmOuEENX+1L+W9XO1POA8I6FbVMc=; b=rbcX3KFgn2fALjf6OT95H5c0AG
        yAQMHm+mU0q/jHpsh3ZHhkw/7OCWWfDnoGuaf9K5G0r5zHT92gWikxVmjWj5PdyVlwNMpxTDp7DU6
        5xsx/wn6R9n1evn+uA0Pk5TC+SLtejSGkvXOiqnkrVGMpY5Kb5l/7dbWse0/Cc7FEcCp3WtFNpjd/
        10goi7gHkM4shjx6yvyf6SP9dPDeUi38Qmjt+l5PwlRXnHrOU+bgdRJIUW1+98TSoTt8uF/HyNYl9
        fzUyv0lK0Qn8NfTYYqlzQMzcvDqwP+iAwmxZRqf8M+ZQTNPx56910Iff6eU7QE358c5N3sGyCiEs2
        rmPx7uWA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFqwp-0028nF-4P; Tue, 17 Aug 2021 04:43:46 +0000
Date:   Tue, 17 Aug 2021 05:43:35 +0100
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
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
Message-ID: <YRs+dx1E72/R4Ael@infradead.org>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817013643.13061-4-digetx@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Just curious, why not add a new block_device_operations member
'alternative_gpt_sector', then move all the code calculating it to
the mmc layer?
