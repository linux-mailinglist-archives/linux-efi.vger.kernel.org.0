Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAF1D626E
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 17:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPPwn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgEPPwn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 11:52:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288EBC061A0C;
        Sat, 16 May 2020 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=0jodEySlCm4LlCAkt1IFjMwE1bcEpTs7CKocuMqqKIs=; b=HTEtd/o1jYXt5tFWLMg3yw5VTB
        jafi4+mq4NVtr2t5FgBZtbDN5gMvS7f18rO7CiXw8ksdpBEA8axSP53RxjuMuZ0/NDw2ZR7CkzPtp
        YK0XLHljpcF6lJwsx9yEbuxo24GhKdEmqw01wYKDXYKAiIfAje7AAm4HHvoE7zIpCQd2D9TAHkCu9
        JSiBMoi36/U1KFIzi3C3Kytzm4eDJwR8tg5VzNAzgbPLS1zvZTSIXRkMgRr/nb+5eIfd5WT0P01HW
        nwpFLongpfCvr1fkn6kTAqa6WThkbifpl69GyOtJapkYKyNr40r/vYkndGY7lmYB+6q2LwMjdYeuV
        8VglOWTw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZz7C-0001Dr-UZ; Sat, 16 May 2020 15:52:42 +0000
Subject: Re: [PATCH v5 5/6] partitions/tegra: Support enforced GPT scanning
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
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20200516153644.13748-1-digetx@gmail.com>
 <20200516153644.13748-6-digetx@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6d86e17f-6431-e9eb-6613-e8d6e889e079@infradead.org>
Date:   Sat, 16 May 2020 08:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516153644.13748-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/20 8:36 AM, Dmitry Osipenko wrote:
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index 3af4660bc11f..4eb4496fbb1b 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -98,6 +98,12 @@ static int force_gpt;
>  static int __init
>  force_gpt_fn(char *str)
>  {
> +	/* This check allows to parse "gpt gpt_sector=" properly since
> +	 * "gpt" overlaps with "gpt_sector", see tegra_gpt_sector_fn().
> +	 */

same here.

> +	if (force_gpt)
> +		return 0;
> +
>  	force_gpt = 1;
>  	return 1;
>  }


-- 
~Randy

