Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC303F3BB2
	for <lists+linux-efi@lfdr.de>; Sat, 21 Aug 2021 19:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhHUR16 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Aug 2021 13:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhHUR16 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Aug 2021 13:27:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B395C061575;
        Sat, 21 Aug 2021 10:27:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l18so15327295lji.12;
        Sat, 21 Aug 2021 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K0MMdaxEKcNrN2KQbtwROF5fRZNqNXPZUbaS3G92l9A=;
        b=j19BOOy8umcex6QY99aQ0ZZCQuTIYeFSYAp5MV38IhTAmBz17PBb0+91b/6/wb1kGK
         6BWlS8CqnCPD/2I+v0cievEBo6XQDh3Dmi0JmfGTQlAl05PQgOZ39P2YDupWOLOb5zWG
         28+0f4+9utiDASsiFSsQJ0RJs0Ex3oOLufisQCvy5e3XJF6gpBqgXna22gRbk5J0wT05
         UDFZBY6EZxAQ5LxVSrVuHO2HDe1MMdokgwmGLrsqvUOdPDSKXUDyLPJk3OYu89oBY8sQ
         O6kxSyVsn/pvNVNsGIWiHSsbAfAZIEJiEb8F/gYNwjuVinu5UfdHVeMa3x7f0keZbLFm
         sGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K0MMdaxEKcNrN2KQbtwROF5fRZNqNXPZUbaS3G92l9A=;
        b=hN95oT6sz9/bZq6Lmnn91UEcTYZsmZQCv6ERoFu5Q3FeiGYTAIV72BIPf0g98l5B2Y
         0UNBg7Lfc2Sx1tgdhBAY2KtiqqA4QnZKRHRVWpKJ82GaY+dkItAAtH9hIgnS9uDqNyBW
         tePJzIm14AVrNBtH7VGUOCtPRqslOpkqhHJ+1Gu86DBfP5cWsri8eG3GCxI3Hd1qFsEK
         h4tvdr0e2Fgi/cJzqm73Mx1UL8yNgq+zABt6mu7imJLFvJ2Qb3si/ydcBw4GYs6jB9jJ
         WcNn3q9lKPLP5eh/xrzTyIDg9e3L5Ad/07OLm+qbPCNSMGzDxvRZ68Mo/ZfZYjq1zFna
         SPhg==
X-Gm-Message-State: AOAM530ot7Iw8nkiZLPsdtlMxphWQ0WNG+V81e4vMo0sFnIG/eTrDrb4
        /CwBCqjV6z8Fha7fEsmzSUCznb2E7rE=
X-Google-Smtp-Source: ABdhPJx7BAQ0zHjQEplRMaUm+CnQrb8Md8PEiZ4sLIOTtDxl3tVa4zYusy23n24tOG7zyLj1xwlfsw==
X-Received: by 2002:a2e:8185:: with SMTP id e5mr21033591ljg.31.1629566836805;
        Sat, 21 Aug 2021 10:27:16 -0700 (PDT)
Received: from [192.168.2.145] (46-138-120-72.dynamic.spd-mgts.ru. [46.138.120.72])
        by smtp.googlemail.com with ESMTPSA id b20sm146199ljp.104.2021.08.21.10.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 10:27:16 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e35a9053-a793-d189-ff79-04212e1227c2@gmail.com>
Date:   Sat, 21 Aug 2021 20:27:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSAvnQb29XlhqY7k@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

21.08.2021 01:41, Michał Mirosław пишет:
> On Thu, Aug 19, 2021 at 01:19:15AM +0300, Dmitry Osipenko wrote:
>> This series adds the most minimal EFI partition support for NVIDIA Tegra
>> consumer devices, like Android tablets and game consoles, making theirs
>> eMMC accessible out-of-the-box using downstream bootloader and mainline
>> Linux kernel.  eMMC now works on Acer A500 tablet and Ouya game console
>> that are already well supported in mainline and internal storage is the
>> only biggest thing left to support.
> [...]
> 
> Could we provide the GPT sector via DT? As I understand this is for
> non-removable eMMC storage. It would remove the need for a cap bit and
> hardcoded calculations instead just checking if DT node of the controller
> contains a magic entry with a number.

The same device model usually comes in different flavors that have a
different eMMC unit and size. So no, it can't be hardcoded in DT.
