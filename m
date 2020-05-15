Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEDC1D434A
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 03:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgEOB6R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 21:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgEOB6R (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 21:58:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F68DC061A0C;
        Thu, 14 May 2020 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=MigIs8+MSs175TeEb7Pa4gsLZS9q5xByc1dl+HIlrjI=; b=bHwtY2fPAXiCAJTE92WpQJ8hkD
        NV225SU2KCY5/IpoGIk4zgOjXVq1excRKzaM4OOab2arXZ7WK0O8Vpp8PVF9gbjpL8TuJ3YKIL/wM
        ewPIpXqPkmDG2pOD7WS6btZ06s71Bcx2KNoS9txFlHhpTAlFrjeHXdt0Inzw/wAeD7VxpJxG+fGSM
        1AqCrfB4xixXsLru2AjhnVE7ZyYwvQxxBvs8yf7rHWBiz0ADuR5q0siv01fR/rr/3riGGyLEmm8mr
        Lcy7mVqyx8o0ePnQCOSEHQBJFQLcERBghWOBPDfaljQkgd+MTIt3SoOSDkRUWKj9tmmao5Cc7Lj6h
        Jl5cgWVw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZPbz-0002KY-E5; Fri, 15 May 2020 01:58:07 +0000
Subject: Re: [PATCH v4 3/6] partitions: Introduce NVIDIA Tegra Partition Table
To:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?Q?Nils_=c3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
References: <20200515014143.12984-1-digetx@gmail.com>
 <20200515014143.12984-4-digetx@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <055fc187-6181-6ccb-04a8-ab4324270ed7@infradead.org>
Date:   Thu, 14 May 2020 18:58:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515014143.12984-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/14/20 6:41 PM, Dmitry Osipenko wrote:
> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
> index 702689a628f0..2c1408cba1a6 100644
> --- a/block/partitions/Kconfig
> +++ b/block/partitions/Kconfig
> @@ -268,3 +268,11 @@ config CMDLINE_PARTITION
>  	help
>  	  Say Y here if you want to read the partition table from bootargs.
>  	  The format for the command line is just like mtdparts.
> +
> +config TEGRA_PARTITION
> +	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
> +	default y if ARCH_TEGRA
> +	depends on (ARCH_TEGRA && MMC_BLOCK) || COMPILE_TEST

That looks odd. Such depends are more often like:
	depends on MMC_BLOCK && (ARCH_TEGRA || COMPILE_TEST)

but that's just my experience. If this works when ARCH_TEGRA and MMC_BLOCK
are not set and COMPILE_TEST is set, that's fine.

> +	help
> +	  Say Y here if you would like to be able to read the hard disk
> +	  partition table format used by NVIDIA Tegra machines.

thanks.
-- 
~Randy

