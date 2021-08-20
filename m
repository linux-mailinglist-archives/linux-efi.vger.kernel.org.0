Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBFD3F369D
	for <lists+linux-efi@lfdr.de>; Sat, 21 Aug 2021 00:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhHTWqJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Aug 2021 18:46:09 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:10174 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhHTWqI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 20 Aug 2021 18:46:08 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GrxYN3sXXzbS;
        Sat, 21 Aug 2021 00:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1629499528; bh=16gKLJUDkQ7g0JmAzH1SE2EE5CY64jDwYOhZeIxA1g8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Syvwzk2S35gJ9J/aw/QJcRoBqhn1mAPzPbMD2mq1AX5V5c6SAiCMepKd280SNNNse
         1n07WSjm19aVqG5gSdgWlvndQFAArpNtyWr+RDBSCfmm4dzrv5F5ZkXdRJFhuGfqsJ
         j7l/atIymYAO8yfHYuUUxdkKSYcrFaI6ZhATveTZwlYCo+YuS/cd2oVFyj9Nj4wFjr
         qlILDjP0jYwItLUILOP8T9ltfFZM9sGZS46EvQmHX8gywnHnFVGMB5cxv1FTmECSOd
         9hHt7IPdGX/HcpQ/Pn5zqiR5rlPJPTUSXvEfPV3qJa/+SP47TXa3UVpXAPF6q8Bt8W
         5S3FJ3PCbGfZQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sat, 21 Aug 2021 00:45:27 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
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
Message-ID: <YSAwh+3xEsutWWLG@qmqm.qmqm.pl>
References: <20210818221920.3893-1-digetx@gmail.com>
 <20210818221920.3893-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818221920.3893-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 19, 2021 at 01:19:17AM +0300, Dmitry Osipenko wrote:
> Support looking up GPT at a non-standard location specified by a block
> device driver.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  block/partitions/efi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index aaa3dc487cb5..7ca5c4c374d4 100644
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
> @@ -619,6 +621,16 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>          if (!good_agpt && force_gpt)
>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>  
> +	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
> +		sector_t agpt_sector;
> +		int err;
> +
> +		err = fops->alternative_gpt_sector(disk, &agpt_sector);
> +		if (!err)
> +			good_agpt = is_gpt_valid(state, agpt_sector,
> +						 &agpt, &aptes);
> +	}
> +

When alternative_gpt_sector is provided I would expect it to override
the default, not be a fallback for it. But if someone tries to put
a broken (decoy, garbage) GPT at a standard place, current ordering
will prevent overriding it.

Best Regards
Micha³ Miros³aw
