Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A893F6234
	for <lists+linux-efi@lfdr.de>; Tue, 24 Aug 2021 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhHXQHI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Aug 2021 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhHXQHH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 24 Aug 2021 12:07:07 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C53FC061757;
        Tue, 24 Aug 2021 09:06:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y34so46567024lfa.8;
        Tue, 24 Aug 2021 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D11sK5S4u0k92UmGqoMMxhYoHykBWojrgFuEY2ExXmU=;
        b=j5oO4YKmEtjSrdR/LRj29FWm7ZWscvf0YAlLIfAbyma3i3xrWYkpvj23lq/s4jKLE+
         DavhkxNmCpeksmEa9ILWNvefGO5sHEir4OmqgbcJHJOUoMNicjxztDcPvd0W6llZqodk
         iLM3ma7BKISG56oSvWcS2EkPq41rxN5jwXF6P1godZkgsiOAEGOclX4qjzZq6Kf8Tvnk
         TAACxyA0bO/whCciVK3/tdeWV5EdbIHK9i0gjc6j4qOZNMx+7Mzls9NTzzBIXwRsvp8U
         CY4mjXdFvKQG9Z6DEm9VZQETRLwTRkE3aKWkkJygXsUGz/Ob2E4kDB89q2XBS4XuMUKd
         xwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D11sK5S4u0k92UmGqoMMxhYoHykBWojrgFuEY2ExXmU=;
        b=awXpaQRGL3fw/201gd9DQ0AUqCebv243gaFwe+nbUfqrRVTDDUxoSzf5DB61Ltaiki
         zIOzD022BZgRdnAh0V8bwDhwNJN+AFvuoeJMgHaufngJsRmTombZmLD66LT5HwZj3abr
         /KfXTi4R1mh8c8g4Yprydl2fqaB25Vl6bsvTRfoa/Nkr62d1MQwQ+hWRJXtlBySE5eQD
         JEVU4YJ3YIuS/ZVvC/8WbuxXA5BvOiUSLhfXL7OqfEDhLBYqtk8MEn1441oUx4F+XtgV
         jOHPIAs7wYzgExw9elgZcn4kRkfytoMTl5fFNcnsHKtI0dPfefaWxrcy13/Zudgm6haL
         yqow==
X-Gm-Message-State: AOAM531AQRFY++DmUx9jOmsMeLptFjjg4CvKrDXO53wd06eN2dOuvSs6
        AFvJIRBe8sx6hmBbsM23tgHUMxEztYU=
X-Google-Smtp-Source: ABdhPJzA1IM5inZCgPtbYZdKRO7U/f1qher0J7t9nwf9UI0Buk/Ky3hyycBUfekwwW2FBGLU2f9KvA==
X-Received: by 2002:a05:6512:b09:: with SMTP id w9mr12937661lfu.394.1629821181740;
        Tue, 24 Aug 2021 09:06:21 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id z7sm1787878lft.302.2021.08.24.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:06:20 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] Support EFI partition on NVIDIA Tegra devices
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
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
References: <20210818221920.3893-1-digetx@gmail.com>
 <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
 <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
 <YSQx0vRrpIGb4OIj@qmqm.qmqm.pl> <YSTMEM8JwwypL8Me@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <390673a8-f275-fd96-50a3-15db416aa6e6@gmail.com>
Date:   Tue, 24 Aug 2021 19:06:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSTMEM8JwwypL8Me@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

24.08.2021 13:38, Michał Mirosław пишет:
> On Tue, Aug 24, 2021 at 01:40:02AM +0200, Michał Mirosław wrote:
>> On Sat, Aug 21, 2021 at 08:27:15PM +0300, Dmitry Osipenko wrote:
>>> 21.08.2021 01:41, Michał Mirosław пишет:
>>>> On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
>>>>> This series adds the most minimal EFI partition support for NVIDIA Tegra
>>>>> consumer devices, like Android tablets and game consoles, making theirs
>>>>> eMMC accessible out-of-the-box using downstream bootloader and mainline
>>>>> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
>>>>> that are already well supported in mainline and internal storage is the
>>>>> only biggest thing left to support.
>>>> [...]
>>>>
>>>> Could we provide the GPT sector via DT? As I understand this is for
>>>> non-removable eMMC storage. It would remove the need for a cap bit and
>>>> hardcoded calculations instead just checking if DT node of the controller
>>>> contains a magic entry with a number.
>>>
>>> The same device model usually comes in different flavors that have a
>>> different eMMC unit and size. So no, it can't be hardcoded in DT.
>>
>> I see. I was thinking how to avoid of going the whole way and creating
>> another controller capability (since this is going to be core code) -
>> could this workaround be enabled just by a boolean DT property at
>> controller's node instead? Or do we expect non-DT platforms to be
>> similarly broken?
> 
> Rewording my concern: I believe that this is platform's and not 
> a controller's misfeature, so the controller driver feels like wrong
> place fix. That's why I'd prefer that the enable came from the DT
> and not from driver's code.

The alternative GPT entry requires user to add 'gpt' argument to
kernel's cmdline. If board already uses proper alternative GPT entry at
the last sector, then nothing changed for that board.

The case where board uses 'gpt' cmdline + it had stale GPT entry at the
special location used by Android devices and chance that now suddenly
that GPT entry will pop up is close to zero.

All old partition table entries should be erased on reparation. If it
wasn't done, then it's not a kernel's problem, it's much more a user's
problem. Even though kernel could help that poor user if will be really
needed.

There is no reason to over-engineer unless somebody will tell that it
broke the very special board. Neither of currently supported boards
should require more quirks. Hence, why bother?
