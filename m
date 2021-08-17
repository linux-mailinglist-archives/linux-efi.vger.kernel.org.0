Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4363EEFFA
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 18:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhHQQL0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhHQQL0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 12:11:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68BC061764;
        Tue, 17 Aug 2021 09:10:52 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id c12so20869671ljr.5;
        Tue, 17 Aug 2021 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yyX1HSJoePfipXEb9F66mZCvJChBwNJmKPys8q0f9Fs=;
        b=npIq5/LDQP5+2vNnQKqbnWNdgGOI9OoduGUC3hai/dTyL4g/GXaFb6YD381/+njoU6
         VMauIBciVFEKt/6TfSIS6z91arSlO7Rhy0/mYwLg2fod4SjDFIZ96b80XWVI+xm8L7XN
         9TkuTUdlK2dJy2xMabMNRdwQyxxLjoX1xpxPbN26GDqSAQYEBfwFzaLNxg2CyyftgANr
         111jhPKwuj4+sdRZjBpdBj4CYFsPvFQ9ZW0jbQRvPvVtnbbRvGmFx7cf7+qSjGbsH3qu
         XdoDFSR0SJ1kHsRXzJ9Sa0HEn0aNljWoY+lwoYLXhJ1hYZq6s6UOGGGyz+dBeNj0oi2o
         V1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yyX1HSJoePfipXEb9F66mZCvJChBwNJmKPys8q0f9Fs=;
        b=HnrvskZqrzFfb00D/iM3AmZSJytQb0f3CmDMEfkqXL9/weEB/3A6jqaYyiCoCoPZGx
         WmKVf/bYmAyZvTuS+5p0Mew8hl8HbRc+habGbqXDalCnGNIP+6arnh5GZPKh5+SXNF82
         fA8Jozf5Q5+9zQZO0/nrxL5UY/4Gd908y3RL4ZL6b/FlFlvYi0AY8Od3OixpqMucNa+R
         Ji/IcI3/dgHlmuqH/OCJ3VstKWjJURc8KKqOBifx/rhdC8UGQC7J8pMcGGWndttCU1zx
         Frh789ru4Y87FncEBACioyEavUCjHlZOsssjzQ6UJoxLjzfLqEELDcOI6mvyn0zXoJZ1
         N4sg==
X-Gm-Message-State: AOAM531abShU1QpG0e4qbvzy+/gEnPk/R/2HSv1ZltEmR4TN6CVlyiZm
        IAubbCd/IqIMX2MV1Lss1wwWXMsvULg=
X-Google-Smtp-Source: ABdhPJwGqCaSb5BQ6KVd8e5B9kPAbANdDr6oepsSX/sRDv/tey4o6g7efbRotz4SyGd+m35SLhstsg==
X-Received: by 2002:a05:651c:2105:: with SMTP id a5mr3981948ljq.259.1629216651094;
        Tue, 17 Aug 2021 09:10:51 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id f1sm230462lfs.44.2021.08.17.09.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:10:50 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
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
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-4-digetx@gmail.com> <YRvDfMiYb0q7utX5@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b3556ee2-b81e-6ae9-e425-3b71b75e6278@gmail.com>
Date:   Tue, 17 Aug 2021 19:10:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvDfMiYb0q7utX5@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

17.08.2021 17:11, Thierry Reding пишет:
> On Tue, Aug 17, 2021 at 04:36:43AM +0300, Dmitry Osipenko wrote:
> [...]
>> diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
>> new file mode 100644
>> index 000000000000..4937e9f62398
>> --- /dev/null
>> +++ b/block/partitions/tegra.c
>> @@ -0,0 +1,75 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#define pr_fmt(fmt) "tegra-partition: " fmt
>> +
>> +#include <linux/blkdev.h>
>> +#include <linux/kernel.h>
>> +#include <linux/of.h>
>> +#include <linux/sizes.h>
>> +
>> +#include <linux/mmc/blkdev.h>
>> +#include <linux/mmc/card.h>
>> +#include <linux/mmc/host.h>
>> +
>> +#include <soc/tegra/common.h>
>> +
>> +#include "check.h"
>> +
>> +static const struct of_device_id tegra_sdhci_match[] = {
>> +	{ .compatible = "nvidia,tegra20-sdhci", },
>> +	{ .compatible = "nvidia,tegra30-sdhci", },
>> +	{ .compatible = "nvidia,tegra114-sdhci", },
> 
> I know of a couple of OEM devices using the above SoCs that support this
> alternate GPT sector mechanism...
> 
>> +	{ .compatible = "nvidia,tegra124-sdhci", },
> 
> ... but I'm unaware of any using this. The only one that I could imagine
> employing this quirk is the SHIELD Tablet K1 (a.k.a. ST8), but I thought
> it had been changed on that device already. Do you know specifics?

Nexus 9 tablet (T132) needs that.
