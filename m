Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA101D4354
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 04:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEOCCp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 14 May 2020 22:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgEOCCo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 14 May 2020 22:02:44 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFDAC061A0C;
        Thu, 14 May 2020 19:02:44 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so494764ljg.8;
        Thu, 14 May 2020 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9J3xZ+0hufAZY8Q946Gd5z6inR3BlFb/SIlC7L1t+/U=;
        b=b6VnSZ3s0qXEVWpWflklrszaWqi+X8HiHVvHebezL/NDw6O4YIBSaA+q/JJpe5hJge
         WJsK9j99q81170CK8u0FIZWL4Elck7U17wxih3SGCMROyyi4rB5jxtVhbp9GwBmLQ8TC
         kkuM7oXK+h2Uuf4X6FFQr25xQlVBHtwPnORfeLkX0REbs4U4W3La+M3eWSHTcoodpi2C
         k5RxXJOQzKYDn50H5erRSvBtoL889M1d6iy17JqBgzJo9awiQr6h9cCDe8Hv+tuiZgHS
         zzT45O2rrcgYZ7hn7cag4r4arbnkzQGTh+pvwOQkax/GCtUWz7zINPX3DK/2RZtMibBb
         EgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9J3xZ+0hufAZY8Q946Gd5z6inR3BlFb/SIlC7L1t+/U=;
        b=pNqhfP1lGGGgJYU2jIaDddzolkTrw2y2Y8Lx2iL3bCESD/Ciw7u6qUnm3ZeNkv6BSk
         kqUjQnoGVq1K6v+LYDwyQIWhFxkwVcVh0lj7MitVFSqoq6YD/Upj7XXbPNRpry5zYfBM
         sgL07Swfisf0n5yxRoFouw8b++bPt9oJQ5TBhUgIX33DSG0pz4IgrSrFbl1GrDFNucOY
         FBpDRMrRRxhuejyOxfKUMyXN50h19H86Hlw6gohFbdciqp4G167uHFvCxhxa4Rlggu8V
         Vl4zeg2sIRMk3y8XeXQyQkhVCk7RxZmkfFcGPR+/B1qyrJOFynZqaYnvN071DszThqgw
         mUrg==
X-Gm-Message-State: AOAM532K7rAyRmvKuhpmq6tKFd5YAhr9TKwrNuXY/cz3HIMGv8afW/qn
        crTik2xaQBZ1Ip3vzzkaG2r6ka/Z
X-Google-Smtp-Source: ABdhPJxrA7JYJ7efiuq7ExKigt85VerS+c/wP3Mq06cQYJVvJyK2fp5UJIRAD8VCub9PBoBE2qjyVQ==
X-Received: by 2002:a2e:700b:: with SMTP id l11mr674278ljc.255.1589508162351;
        Thu, 14 May 2020 19:02:42 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id z17sm382496ljc.81.2020.05.14.19.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 19:02:41 -0700 (PDT)
Subject: Re: [PATCH v4 3/6] partitions: Introduce NVIDIA Tegra Partition Table
To:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
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
 <055fc187-6181-6ccb-04a8-ab4324270ed7@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <821ae388-07b2-5883-95b8-c551ddc7bdea@gmail.com>
Date:   Fri, 15 May 2020 05:02:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <055fc187-6181-6ccb-04a8-ab4324270ed7@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

15.05.2020 04:58, Randy Dunlap пишет:
> On 5/14/20 6:41 PM, Dmitry Osipenko wrote:
>> diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
>> index 702689a628f0..2c1408cba1a6 100644
>> --- a/block/partitions/Kconfig
>> +++ b/block/partitions/Kconfig
>> @@ -268,3 +268,11 @@ config CMDLINE_PARTITION
>>  	help
>>  	  Say Y here if you want to read the partition table from bootargs.
>>  	  The format for the command line is just like mtdparts.
>> +
>> +config TEGRA_PARTITION
>> +	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
>> +	default y if ARCH_TEGRA
>> +	depends on (ARCH_TEGRA && MMC_BLOCK) || COMPILE_TEST
> 
> That looks odd. Such depends are more often like:
> 	depends on MMC_BLOCK && (ARCH_TEGRA || COMPILE_TEST)
> 
> but that's just my experience. If this works when ARCH_TEGRA and MMC_BLOCK
> are not set and COMPILE_TEST is set, that's fine.

Ah, right! It shouldn't work since mmc_bdev_to_card() will be undefined
if MMC_BLOCK=n. Good catch, thank you! :)
