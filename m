Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11A0164AB0
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 17:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgBSQif (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 11:38:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42310 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgBSQie (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Feb 2020 11:38:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so612954lfl.9;
        Wed, 19 Feb 2020 08:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oc1iG+0sFqJJpFuBmYp8D6jIrAENImR/n43R/TFZnyw=;
        b=BvD2WyXLCVUryS3IROysHumXd7lOaFWsK5xX8FY7TszpdKrxg87K22WgG22BFXbTW9
         SDZEOU3LHeFx3Hqhw9XUnVlMICmren3S8VPcyidelhDD8qiQuTnIa55EpyT9yb+Cw1M9
         YSJQrKeDxDx7S4DVf6XHTgNNjeHZgJrVHjYX+IJphxq5s1L7Huv6qnN7ScnWmh0szmfS
         zQ5L5Jr6jjCAYyqPMDxDcVpxDAst9f0l4gmaHXSrlMkaAtqLknDxeN1+0nUFfJvPGAQv
         2P8JZZj33zSE4ewTQqorNetCc9CtjWqaH/7RHECd8BOadTgnVcYulx+Jw2ksL1nPFQqv
         q2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oc1iG+0sFqJJpFuBmYp8D6jIrAENImR/n43R/TFZnyw=;
        b=EjhwbyqWWKL0+7H+hHUuRl30pJzFMz1ZsSx1Scji8GXtGaaQgopZH/LM84Sq91m/Z3
         kcinN4O8wC9I9YlneAN2Ydk8P0BATOSPlIDyXLc3+Wtv0f7pM5sK8hjoRxdB1f57v0I9
         EYPmtFFpqLf8lcN9Irb++dFBs5W71/buWXJGj5O7mzmBbHAyy1sxuWI4nRBn3oFAV9us
         NUw1TDKluCr5JCenWPd3SJISLnG5cE2WEZkve3IBYZuU6GQM2rbNZzqcuuZdtUYhmuHA
         g7GAGpsszcAFxZd/AQ3UwGmJCQyXRY2MqE5Aoer1Kad7zp47ZyiwVqhNvPVrWHVVUPxg
         WpdA==
X-Gm-Message-State: APjAAAVK+Wyl4jUNtfIznblaoZvIyvzO7Weh9jNiRvTxQ7b6E3A5BijB
        g9XPUyOkIxCxwTMp67/+6+jakhMN
X-Google-Smtp-Source: APXvYqx6W6H73i4GCMqbHQV8ZP9n8MEmNzglcNRDvno5D2hF3kFde722JXZXZYwB//bVHj8V+qSFcw==
X-Received: by 2002:ac2:5964:: with SMTP id h4mr13913125lfp.213.1582130311784;
        Wed, 19 Feb 2020 08:38:31 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm54074lfi.36.2020.02.19.08.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 08:38:31 -0800 (PST)
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-efi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200219162339.16192-1-digetx@gmail.com>
 <20200219162738.GA10644@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d0df41ca-e14a-1bbf-5632-781d3e46f279@gmail.com>
Date:   Wed, 19 Feb 2020 19:38:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200219162738.GA10644@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

19.02.2020 19:27, Christoph Hellwig пишет:
> On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
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
> 
> I don't think a magic command line is the way to go.  The best would be
> to reverse-engineer the proprietary partition table format.  If that is
> too hard we can at least key off the odd GPT location based of it's
> magic number.

I'll try to take a look at RE, pretty sure somebody tried to do that before.
