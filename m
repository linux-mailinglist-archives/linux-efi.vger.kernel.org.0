Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF434D779
	for <lists+linux-efi@lfdr.de>; Mon, 29 Mar 2021 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhC2SjQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Mar 2021 14:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhC2SjB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Mar 2021 14:39:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCEC061574;
        Mon, 29 Mar 2021 11:39:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s17so17052550ljc.5;
        Mon, 29 Mar 2021 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9Z8K/trC+G6yoL/k53VgcMchi/z3mNg0kr06RQOzhE=;
        b=Jwxoq79ElWcwaLxYH14hzq+JYZ4ets+Lu1X+1cywppMzXt7rwdldgPGjx7j7Bn2Yag
         cdX02IR1wpBTtvz7oGq8yRqLo6gsy87zLDvsB6NdMAmmb5zz9LNEfagTCYuHLTID1lI1
         fo2V9/67BoWrehqIGCg3RoC+UsaPuwnoXbRTgJd/3BSU6PAw2Om8mD9mduOe6o2G4Y+O
         NlblQJdq8iKc6lGtE6/TkXwrGisl2G3DpFaobcjyYtakiUXrzqX47umQJke0KWWM384R
         s7j07YfOCwoMgFhyGtmyr2ezFEV5ux4ITfI2CBpAjqDIiYYZDctG4wKchb9jywqVVs2j
         G+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9Z8K/trC+G6yoL/k53VgcMchi/z3mNg0kr06RQOzhE=;
        b=oM3yNiEeoESWsphuWR3zE+KCkaAZCX2hGQMluHlGjuI274AltAmJI6QQSrckRf6+Ip
         O1o7xCqTHB9hGnnGCAkVUbjX54xj7QFCPEqpI/Gbdqu/CF743+RJqK17L4BofheBaD8b
         o0pz0ChS4pg9xgbV5kJy0MC1bOJcatH+dcc1JWcaUkxdIOXNG9mw+a/gCcw9oT+OlpXp
         3A9ZUJVl+dg1ZRNsMqyjynP3RISfJFsWzPBvj2JcSa0tWxNz0zlzioufGvXZgskvrGC5
         mJ3ExVY+R2X3N/tS+udJGHw50b7UOzCh293UOfRuYnRVE9rW9q3etbwcjO3xzqU6bTlQ
         t12A==
X-Gm-Message-State: AOAM5329+97L0BQAEW3HjBuZeNernVzxagqzrci7B8LRcnXkvQ473rVU
        K3OhiyjWo8b/tTW/rzM4PUOtWBBnQ5s=
X-Google-Smtp-Source: ABdhPJxPp0Qy6tWm0Yzw3OUIivxN9y/4RGWGKqCUDGhj0lFmqZpGe+C9XN2/bN+IzDrhrAEVVUPN1g==
X-Received: by 2002:a2e:8e87:: with SMTP id z7mr19011244ljk.142.1617043139174;
        Mon, 29 Mar 2021 11:38:59 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:b259:a10:76ff:fe69:21b6? ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id d21sm2526612ljo.55.2021.03.29.11.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 11:38:58 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] partitions/efi: Support gpt_sector parameter
 needed by NVIDIA Tegra devices
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210327212100.3834-1-digetx@gmail.com>
 <20210327212100.3834-4-digetx@gmail.com>
 <20210329173151.urs4x36m3bq6txrf@offworld>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <134f84a2-94e8-9f82-eb3e-8ec90fafe581@gmail.com>
Date:   Mon, 29 Mar 2021 21:38:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210329173151.urs4x36m3bq6txrf@offworld>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

29.03.2021 20:31, Davidlohr Bueso пишет:
> On Sun, 28 Mar 2021, Dmitry Osipenko wrote:
> 
>> All NVIDIA Tegra20..124 Android devices use proprietary bootloader
>> which supplies the gpt_sector=<sector> kernel cmdline parameter that
>> should be used for looking up the EFI partition table on internal EMMC
>> storage.  If the kernel cmdline parameter isn't supplied, then the
>> partition is expected to be placed around the last but one sector of
>> EMMC.
>>
>> Apparently this was done in order to hide the PT from a usual userspace
>> tools since EFI entry exists only for compatibility with a Linux kernel,
>> while a custom proprietary partition table is what is really used by
>> these Android devices, thus these tools may corrupt the real PT, making
>> device unbootable and very difficult to restore.
>>
>> Add support for the gpt_sector cmdline parameter which will be used
>> for finding EFI entry on internal EMMC storage of NVIDIA Tegra20+
>> devices.
> 
> Since this is proprietary and playing yucky games hiding the pt, why not
> just force for the fallback on Nvidia's side and always just use the entry
> at the end of the block device? I'm not loving introducing a generic
> parameter for an obscure ad-hoc feature.

I understand the reluctance to support the ad-hoc features, I wouldn't
want to support this myself if I was in yours position.  This all is
necessary solely in order to provide a good user experience using
mainline kernel on the consumer devices that have Tegra SoC inside.  A
more advanced users could bypass the secure boot restrictions and
reformat the partition table as they wish, but this is very involved.
The only reason I'm submitting these patches is to allow more people to
have fun with their devices running mainline Linux without a need to
bother with extra out-of-tree patches.

There are total four possible variants of the PT that I'm aware about:

1. GPT entry exists at the proper "backup" location in the end of a
block device.  Unfortunately only Nexus 7 is known to have this.

2. GPT entry exists at the give sector offset using the gpt_sector=<>
parameter.  This offset may or may not match the offset that we can
calculate based on EMMC boot offset.  This case is common for the vast
majority of devices.

3. GPT entry exists at the expected sector offset which is calculated
based on EMMC boot offset.  This is common for devices that use older
versions of NVIDIA bootloader which doesn't provide the gpt_sector=<>
parameter.

4. GPT entry doesn't exist at all and other means are used to convey the
partition table info.  This is rare, but happens for the oldest devices.
 Using a reversed-engineered tegra-partition format helps in this case.

Technically we could use the reversed-engineered tegra-partition without
caring about GPT at all, but this may result in a different number of a
visible partitions to the system in comparison to the GPT entry because
some of partitions may be hidden from the GPT, like partition where
media keys are stored and etc.  This could be confusing and quite
inconvenient when /dev/mmcblk0p4 becomes /dev/mmcblk0p6, so it's more
preferred to use the existing GPT entry.
