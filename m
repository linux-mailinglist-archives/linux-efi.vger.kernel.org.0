Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1A8164A8E
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 17:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSQgi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 11:36:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38055 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBSQgh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Feb 2020 11:36:37 -0500
Received: by mail-lf1-f65.google.com with SMTP id r14so621880lfm.5;
        Wed, 19 Feb 2020 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vXh1VMvfvDfHD2y+Q2/VZWuGDoIMJdUUkgrMD7alNPc=;
        b=TUWZ2C3BLx6pFGzi711Kzm28XjqwZfjADvGmburkO9xBly4w6nNJ11ET0+hL1GefjW
         oUWvZdO4qSJ/fHH0DdtXq2MBsrxBsTO4gGd431dTlUtdkNMt4xWBADT1xBvvIGCCU5PW
         6OLu0yzE3o5VnivOAzMT3ArlndKjiLCkgFOorRpCPB6e4dCqit/LnnygkRGo6fgCz43m
         +WS656xZUF7xKZgNrtsy4lD0uXfzO3ZWShiEzBDTwJB+Agif4ucjZzO3kz+7NcgW1iG9
         fEhDR8suEdyONDFuJSe30/RQue57GRJbMPUI311Ed2aCWGXoRo6paHgpzyr5prA2XpIo
         ZUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vXh1VMvfvDfHD2y+Q2/VZWuGDoIMJdUUkgrMD7alNPc=;
        b=DF4TRrPvh+nsIsFar8EJNC6M8BrohHuuEkUZUFsbIgdeX+gEe/uONxAvo9nH5g9dDy
         vWR8C001PRNzatUSOBmCFOcn70H4Uf7EjvIid2KK9pwaIh8bfGBm4nGDD5GKz1aBUGqq
         75NB7xvAwaxpu2PRyoFFqnapbYlnvJVlPW0oAn2yxOGsnHLIxGPa5xx/izctr8RuuvKd
         zElETCEea7CeZELhv7O6z2dXTy5Fi3HE0DtWXtSFoBp4n5xLP/RQmIpMvB2Z0a/sGMCi
         rqZ0yFSN3R5ZuHNeOua8Zz+MNOB06Ps2lRAQD1Xk/PaOY55fxZPWaPe4HxuSRlYDen0m
         cLXA==
X-Gm-Message-State: APjAAAXZkR8n8T0nZ0NdFCYcXqSABnmoDPUqLtMFPg88uzgn2wEU+Szt
        7wv5tDWOgRUg5xXNyCTH5aueMdTD
X-Google-Smtp-Source: APXvYqyYv00AS0925LOonBZM+4OrCpcT7exm+p1YSBtU1xDpt6HnAt3upoZ9rGXeXiRAZezazTSe+Q==
X-Received: by 2002:ac2:59dd:: with SMTP id x29mr13756833lfn.95.1582130194886;
        Wed, 19 Feb 2020 08:36:34 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id r9sm36766lfc.72.2020.02.19.08.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 08:36:33 -0800 (PST)
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200219162339.16192-1-digetx@gmail.com>
 <CAKv+Gu9vOh5vmHTGLYA9nszQfGq-yMRPvyYUhSzwcYJD+ZYKHA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e97c45d8-42cc-fa38-957f-1d32e400d253@gmail.com>
Date:   Wed, 19 Feb 2020 19:36:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu9vOh5vmHTGLYA9nszQfGq-yMRPvyYUhSzwcYJD+ZYKHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

19.02.2020 19:26, Ard Biesheuvel пишет:
> On Wed, 19 Feb 2020 at 17:25, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> The gpt_sector=<sector> causes the GPT partition search to look at the
>> specified sector for a valid GPT header if the GPT is not found at the
>> beginning or the end of block device.
>>
>> In particular this is needed for NVIDIA Tegra consumer-grade Android
>> devices in order to make them usable with the upstream kernel because
>> these devices use a proprietary / closed-source partition table format
>> for the EMMC and it's impossible to change the partition's format. Luckily
>> there is a GPT table in addition to the proprietary table, which is placed
>> in uncommon location of the EMMC storage and bootloader passes the
>> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>>
>> This patch is based on the original work done by Colin Cross for the
>> downstream Android kernel.
>>
>> Cc: Colin Cross <ccross@android.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Which block device is this parameter applied to?

All available devices.
