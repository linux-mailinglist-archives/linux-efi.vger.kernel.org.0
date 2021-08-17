Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF8DF3EEFF7
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhHQQLQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhHQQLQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 12:11:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE66C061764;
        Tue, 17 Aug 2021 09:10:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p38so42544161lfa.0;
        Tue, 17 Aug 2021 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7EsSxl39cnHJja2G2J/O+57zySrqheydwkiXWPHpeog=;
        b=pknb8Iwg6Wl0GrlCt5h7y/6odqUz1chqSifQ6c+WJZWfRWbBf+jQ4Axqsgm30hM0oz
         Zs9p8JgxtJ87Tcfe3qAeRpp4w5ZrEXo4ZP+h5nwfi8SSI7JYe0fihaqbj+c5MPNe/iGy
         BQ65IAJzTcBmyWh147FwDBCA1HuU+/muem/pdWqEYVXITv4HkJOVMfN/WCEvetE3kOEa
         u3XM/TdesXGAtMpc2jA9iry62Txk8iNmr5CfumazxFGIGV0zAUP4ZL8dvG0bn+t+Eez8
         XxYTLnc1Z85I/ygDacuqz33vfTxkpbm7ivbK17UaRgxtAaNmxQ5iApfg/OnsSdsHy3PV
         uUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7EsSxl39cnHJja2G2J/O+57zySrqheydwkiXWPHpeog=;
        b=FAP1HDNLhb3jxx6O5i5ZXdJEf3y5RyZ9i6nTjZiL67Co4lxvCE9qeSVwwsHUxkGnkT
         B2GZORk+6BBmUuspsAtYrM6mkn7psEcW44+j0J0Xs8I7QKV/JMLptiOUR3UpmJctVN7s
         7WX5dC5TGjA/NoZ2YKAE3ektehBkcrh/LkyEztPAo7sEbJH2102Nlv0BdJx1SEYpBz7X
         Q2paACIIyxIoraWFiptuOJZoGhhedsFj7cVGglwn1/bWXg70XbtyVmFQDoXO2tBIaZqG
         auYgCZByKg/hEQvzEn37rMssmA6TXzkB8KPFWqtgIoIPF73q11Edo50/gfXt+6PWVPXW
         zdXg==
X-Gm-Message-State: AOAM531BZhddF/xT6bcl1UVDBOHNmroxlUsO0ji40wkWAF1cRoKzDKyA
        ARmcCvQts24+J5Wdcy/KzjFdZMS3QKM=
X-Google-Smtp-Source: ABdhPJxH46JFUMbvOHtZ3nQwfA6gAr6ZDLs2MPQM66pU2Gxwmrdf4tTUrylG/o7O3c1z3b3hclea4w==
X-Received: by 2002:ac2:508d:: with SMTP id f13mr13485lfm.576.1629216639785;
        Tue, 17 Aug 2021 09:10:39 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id y27sm248487lfa.260.2021.08.17.09.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:10:39 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mmc: block: Add mmc_bdev_to_card() helper
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
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-3-digetx@gmail.com> <YRs8/zfrU06No+Qv@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <3d3d1fe8-cad8-6ff8-9f70-a5580af6d6b5@gmail.com>
Date:   Tue, 17 Aug 2021 19:10:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRs8/zfrU06No+Qv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

17.08.2021 07:37, Christoph Hellwig пишет:
> On Tue, Aug 17, 2021 at 04:36:42AM +0300, Dmitry Osipenko wrote:
>> +	if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
>> +		return NULL;
> 
> The major is a dangerous check as we have all kinds of ways to override
> it.  Please check the block device operations as they must be unique.
> 

Alright, thank you for the suggestion.
