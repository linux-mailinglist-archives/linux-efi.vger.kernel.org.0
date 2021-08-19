Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EC3F2312
	for <lists+linux-efi@lfdr.de>; Fri, 20 Aug 2021 00:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhHSW1l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Aug 2021 18:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHSW1l (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Aug 2021 18:27:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E34C061575;
        Thu, 19 Aug 2021 15:27:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so16139394lfu.5;
        Thu, 19 Aug 2021 15:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ArctQfOIhjZxst06RUvgPGOnETI6tONN6GEIYocngV0=;
        b=HZGb3hQqffUQpm2UygIvPhr7J+CcPe75PvUHZszdG5WQ8+8osFXAOdArU5kbBHvV65
         V6lrfFz8i9RZSl3R2+snCC5hGr6Q0NEgNgj3Ar/ApLxV+sVN6q23mgnBZqZuaxdQluDF
         fn52V75hSg5RFjn7PZS8whd0yFzCnigTeuLYe0piov+N7iJiK6Bw0/PN/uCL+XHJuXhE
         8z1gad0PLfXf6gYdXASTeoUgpd/lotTMJSVwVo/GYsOySnQoCfC7yYXt4eUTch4jASVf
         8o9PPge+zhQHGXyTEzMerdcgq6M1tYHaDGpAxqgC8B3B/IjsIMfup2XYyzntDtixZg8K
         Eu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ArctQfOIhjZxst06RUvgPGOnETI6tONN6GEIYocngV0=;
        b=XGi2k01MMXytJsrlOBxZipynrmChNEiksibmtQgNDaTpKHT9/pmP/ZluF09NEtOIrB
         xlOYOUjMX23LtrNjkkT2yKOpiObCkhk43h40lv24AFRps45aqzKT716nxco5zs1Zv/+s
         3uKQ9IXv+Ap4NBPBG0uPhebFFG+ic8/KX63rUUxiSBRU3eDc1bbkOaOhY6TGOvLdVSwB
         RIEjUeR6+uLcSbs/kg19UHtlN5aOkYSgBGjwEStuVtqzJZ04/Ke0KB8kZAs7TNWAoMQ4
         EMR5PAXDMPK2Oh2bwUHE38I6Ay78uhzOyKtLaCt9hje3WNVtqziTPMxNFxhxl8U+3ceZ
         XPBQ==
X-Gm-Message-State: AOAM5336HmHZ3JH7GVS7b2EdBVInujz+MH8uxq77exOoSsSR9QbqIzhk
        g4Mfxj3R/97QUxvFUWKVx4nH8dIohTQ=
X-Google-Smtp-Source: ABdhPJyNXEwOXNdUmb07P+xqn34rOJ9QIDaeZqy8GoElyylu+BjbrOTAADRbeT8TMAVrUTRS9PBRDA==
X-Received: by 2002:a05:6512:3a90:: with SMTP id q16mr12150830lfu.448.1629412022333;
        Thu, 19 Aug 2021 15:27:02 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id j2sm384140ljc.49.2021.08.19.15.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 15:27:01 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Support EFI partition on NVIDIA Tegra devices
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
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818221920.3893-1-digetx@gmail.com>
 <20210819171854.hmpycxs5pqiwq4qg@offworld>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <cd8db560-a117-3592-57d6-bfd25738e3ae@gmail.com>
Date:   Fri, 20 Aug 2021 01:27:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819171854.hmpycxs5pqiwq4qg@offworld>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

19.08.2021 20:18, Davidlohr Bueso пишет:
> On Thu, 19 Aug 2021, Dmitry Osipenko wrote:
> 
>>    - Moved GPT calculation into MMC core and added
>> MMC_CAP2_ALT_GPT_SECTOR
>>      flag, like it was asked by Ulf Hansson. Me and Thierry have concerns
>>      about whether it's better to have Tegra-specific function in a core
>>      instead of Tegra driver, but it also works, so I decided to try that
>>      variant.
> 
> I think this is better as you had it in v5. This is specific to tegra and
> shouldn't be in generic code.

Yeah, but Ulf wants it to be in core. On the other hand, MMC core
already carries all kinds of quirks for hosts and cards, so it's not
something extraordinary for the MMC.
