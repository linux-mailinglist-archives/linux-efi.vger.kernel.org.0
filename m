Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF75D3EFA4A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhHRFnd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhHRFnc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:43:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB7C061764;
        Tue, 17 Aug 2021 22:42:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p38so2228640lfa.0;
        Tue, 17 Aug 2021 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IXIyKB7rfPwWT1Fxxw+rukLSC6elVsqkHYe6z4cjKsk=;
        b=mMUV23dMc5APdym+YbqhaoZhRsDr+37FrKjKlpcypQxo7F9TL64TPAsH5Ppij/Z1Cn
         H6ZHsfIKdUX/sBMb5hM8ZQqMKY9z0/k75n6pEH4hwyulZNv2p6VGDizglp9vAf2pbfhN
         sAee0gAhApbEXQasZo5N+No1paw7KnAGh5nQFpyObl8HGiUQouvGfl0DT8AdQB4WCarm
         MLG6j0UrHkwrRUi4DXJ38aoKzkWes42Cb36tHR/j0gJnuGdCHsZNoF97H2wu2iYL/0ne
         gQ30I4EPuWp/rWbypKy+hMj8cfARv/BMJOwBp22kZ0Byz5DudVwpgnGs7T5HBSE7cJfA
         HXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXIyKB7rfPwWT1Fxxw+rukLSC6elVsqkHYe6z4cjKsk=;
        b=C5We+sWylmOnTvx7heG7h6OqRzlI5yFnTTeo7EXLB/3r8zjQWu7+vR56kTb4RnXfUA
         1+L5SUlLAhDpcY0bN2ahO5g9CKQnArnRm5At506a3YnVV5ByA2uBsBsdlulpJEyAuZST
         Aei4V8Wmw2AJPTEc8uGIZo3ZFJH09K52Ztz9kKArzatekGKHUvguOXRWvT/MWHTCPPtQ
         9A5vn9+C34OQ4Cjimx8Y6hUV3Wwq/Ls8njDnkf0/4jOo163PRMNUDk7SmdYE5qosaYE/
         8w064Sie9+ScmTs+6nAZjcEnuhMdku/HBw5gSQSk4SfD68wyOOoHw0hCHqBFf17mSlYc
         U85w==
X-Gm-Message-State: AOAM532CUzNS3IFRlkupUeHElDHZp9m/KmiW7cYdUOl4n0YOmG7Yy1VH
        9ssz7dcaxHZBOC0DiZqtzJYh4VmNUWg=
X-Google-Smtp-Source: ABdhPJwX+sFtsbCA3tEO3Tswh5qqboayWRltXktMLW452wZGl6fn3tu2MWY6TuF5WgIS4FmVn+LO3A==
X-Received: by 2002:a05:6512:ac9:: with SMTP id n9mr5073533lfu.635.1629265376585;
        Tue, 17 Aug 2021 22:42:56 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id b12sm169974ljf.62.2021.08.17.22.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 22:42:56 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] mmc: sdhci-tegra: Implement
 alternative_gpt_sector()
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
 <20210818005547.14497-5-digetx@gmail.com> <YRybCfUX6/HNcbEs@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <252a91b9-cfca-4ec4-a5ef-841301c24ef0@gmail.com>
Date:   Wed, 18 Aug 2021 08:42:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRybCfUX6/HNcbEs@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.08.2021 08:30, Christoph Hellwig пишет:
> On Wed, Aug 18, 2021 at 03:55:46AM +0300, Dmitry Osipenko wrote:
>> Tegra20/30/114/124 Android devices place GPT at a non-standard location.
>> Implement alternative_gpt_sector() callback of the MMC host ops which
>> specifies that GPT location for the partition scanner.
> 
> Just curious:  how do the android kernels deal with this mess?

They either hack MMC core to cut off the last sector from blk dev or use
non-standard gpt_sector=<sector> kernel cmdline argument that is passed
by downstream bootloaders.
