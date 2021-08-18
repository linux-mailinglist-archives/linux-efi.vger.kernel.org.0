Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD783EFA44
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHRFl4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhHRFlz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:41:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E847C061764;
        Tue, 17 Aug 2021 22:41:21 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id x7so2831197ljn.10;
        Tue, 17 Aug 2021 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LgaztypwHOuux+3EfKG5YAexoTrlMb3JoRy+4l/W+a0=;
        b=YOmqhxUoB1cCf/nrZJ4X++rOT7JUE1N77azq+aTWVswlHz/4VBxf0VrtfH1Gm6GxK2
         3pmSsJ92MDlUe7unfmxgcLsD0IZpgBj/4VgnH8Ou1D36QHdvI8SAaW65o0eoaIiT5pPE
         dqBcp7TqKpSgMmHQALUSE+f1XLRVqHo1f2zgT4o4OZUb/nAr0AL1vQBJlVu1ws56rAaS
         Euq7UDIr8nHdqQVMY2UGCIzHaI+6s6MeKj0h8GJEDMY+SCFccGqxhDy4XO1C2NR4tCnQ
         AmWSsZ8K/M64Vwh2km72ZijiBVgA7ry1pvZK0hltXUp/TH9Jg5B+uII/BEGo91lItkP/
         HHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LgaztypwHOuux+3EfKG5YAexoTrlMb3JoRy+4l/W+a0=;
        b=km5dXrZTkIJRSUos5jMycMhMXoH5W+eFmp8X5xKwrEufY2es1nu616DFdm8zRPdycQ
         yRpddB1xodDxvQDlLDhgtuSLcv7u3XRCBHSIhsLJekqaOOHoE3YK0GBCrWUsUpODWN/H
         fPUMu3W9aYLyyimwAlbOtrV8lSEDIjBW/ZpJFcKiTLcNTpp7tI0duKaOf1uxD+6z3GK4
         pXhcDMNYYD4Dzuhj715qCRHtT6MJ3wjXv6QeqodwNG0sUdmcoqr+3idb1GBeSxqsddPq
         Gv1McEF1la77f4C5Daja7D6YllfYW3ymtWv+rzsewiiHVjvTGBWiUzpOHChQL0ew86wv
         Xh4Q==
X-Gm-Message-State: AOAM531YzBTLc9V3Hw8HXTrYkphLuU0YY3fQlLYh2rrTc5A0osz4R/rv
        ls6EArD9kjgYoMNT4dRHK1vGDvuOh2U=
X-Google-Smtp-Source: ABdhPJzogo+e6LEosiozLvOD1rpYvP4gVzDFZPVfZUUoINyVIZIQnCQJErd65A5AhSTRtOfC87Bqsg==
X-Received: by 2002:a2e:a549:: with SMTP id e9mr6361217ljn.500.1629265279653;
        Tue, 17 Aug 2021 22:41:19 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id f1sm396437lfs.44.2021.08.17.22.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 22:41:19 -0700 (PDT)
Subject: Re: [PATCH v5 5/5] partitions/efi: Support non-standard GPT location
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-6-digetx@gmail.com> <YRyZsDAiDX8OEO35@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <101227e9-b101-ffc9-1dc2-fc23a9d4905b@gmail.com>
Date:   Wed, 18 Aug 2021 08:41:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRyZsDAiDX8OEO35@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.08.2021 08:25, Christoph Hellwig пишет:
> On Wed, Aug 18, 2021 at 03:55:47AM +0300, Dmitry Osipenko wrote:
>> Support looking up GPT at a non-standard location specified by a block
>> device driver.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  block/partitions/efi.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>> index aaa3dc487cb5..b9509f445b3c 100644
>> --- a/block/partitions/efi.c
>> +++ b/block/partitions/efi.c
>> @@ -585,6 +585,8 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>  	gpt_header *pgpt = NULL, *agpt = NULL;
>>  	gpt_entry *pptes = NULL, *aptes = NULL;
>>  	legacy_mbr *legacymbr;
>> +	struct gendisk *disk = state->disk;
>> +	const struct block_device_operations *fops = disk->fops;
>>  	sector_t total_sectors = get_capacity(state->disk);
>>  	u64 lastlba;
>>  
>> @@ -619,6 +621,17 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>          if (!good_agpt && force_gpt)
>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>  
>> +	if (!good_agpt && force_gpt && fops->alternative_gpt_sector) {
>> +		struct block_device *bdev = disk->part0;
>> +		sector_t agpt_sector;
>> +		int err;
>> +
>> +		err = fops->alternative_gpt_sector(bdev, &agpt_sector);
> 
> Please call the method with the disk as the argument.  I've been moving
> the block layer to generally pass the gendisk whenever we're dealing
> with the whole device, as that makes the intent very clear.

I'll change it in v6.

> Also do we really need the force_gpt check?  That is we always require
> the user to pass a command line argument to use this?

User indeed must pass the 'gpt' argument to kernel cmdline. That's what
all those Android devices do. Should be okay to keep that requirement.
