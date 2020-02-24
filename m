Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C672616AD4B
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 18:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXRYB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 12:24:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46489 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgBXRYA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 12:24:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so10968530ljd.13;
        Mon, 24 Feb 2020 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e/n9e6xXZVWqsR/ccfjvEorJJCrqDEodlBdEgXxH7KQ=;
        b=Y0QODhPRguaX8OJD9rDgvP2EtyrGIbxGVpbPVVD6RG53i3a6j2i7oKQLkt0JuJXnDv
         RQphcPj3VGgTIu0XbRze9x68U0VXddGMhS+wHAhMtGX5ZDdCvN0sScwe6drXpG5LgTiD
         C5qUYn+fV674aCGBvxQ1BlcHtaDrhgNgzbV0cxAVQWZHBx1C9HznBXvtHce8nZ90trM6
         6uy9JDhNeTmS7YDsQ2u8yOtIL4KMxXd1ZFrSqfmayUuanlbgzckNHAvqP+CuFF5y2IRn
         ziBWiMiesLVmoY/6Qs99RLCpDtgHuS1668oV3AGlN3PCriWzm1tA97zh6YywQhC7PrNC
         69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e/n9e6xXZVWqsR/ccfjvEorJJCrqDEodlBdEgXxH7KQ=;
        b=VKA9eM+bSn0xaYJuTgcwhd5WdZv+jZvaer+ORK0Nvx+kFjdPtU9dbo1YCKUKndZRSy
         CsvabNKYGnFCh2l6PljwtJWVCToBS+VYEjBuYlamPE9P0qdyBQkN4IJsUOnVn1g5+MOW
         SnSxq15DXsyDQp5zj4lN1WFjFPKc4KwmFIm7uLNlgan8Ue9h6xJ8WrXawuKM3PfnDfwz
         lYrpDzoO3Vg4Tnc3IBfifmcm8yn452PB6Z7T3+afR0b5YbKnBcOkPjGNWDDP5a5VOza3
         lkEqgo/uSwIVl7E3stjtE6xeIlhTOtjfEsyFuZAEZ/X7DyLRkDEOS3MJMLYhZmsH+RgT
         HZkA==
X-Gm-Message-State: APjAAAW99zHpZz+swwG9qAh64/QIGa8gl6/9/hlWNod5YxtihT0rWqQ0
        UwUXZBzQ+bXyvtupOTv6MBvru9Jx
X-Google-Smtp-Source: APXvYqyl5/IGnI57GI66hWo0l2eoPegfDm71Rfp/cUYOlKJ4hNyYkMiFkSdZREQ9mKSBWyBSRUIFsg==
X-Received: by 2002:a05:651c:cf:: with SMTP id 15mr32516379ljr.288.1582565036740;
        Mon, 24 Feb 2020 09:23:56 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m16sm1006611lfb.59.2020.02.24.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:23:56 -0800 (PST)
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
To:     Karel Zak <kzak@redhat.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>,
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
 <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
 <20200224163342.d4acf224b56celup@ws.net.home>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9c7343eb-1b09-ffcf-cba0-11d6a26dfd77@gmail.com>
Date:   Mon, 24 Feb 2020 20:23:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200224163342.d4acf224b56celup@ws.net.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

24.02.2020 19:33, Karel Zak пишет:
> On Wed, Feb 19, 2020 at 09:59:54AM -0700, Stephen Warren wrote:
>> On 2/19/20 9:27 AM, Christoph Hellwig wrote:
>>> On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
>>>> The gpt_sector=<sector> causes the GPT partition search to look at the
>>>> specified sector for a valid GPT header if the GPT is not found at the
>>>> beginning or the end of block device.
>>>>
>>>> In particular this is needed for NVIDIA Tegra consumer-grade Android
>>>> devices in order to make them usable with the upstream kernel because
>>>> these devices use a proprietary / closed-source partition table format
>>>> for the EMMC and it's impossible to change the partition's format. Luckily
>>>> there is a GPT table in addition to the proprietary table, which is placed
>>>> in uncommon location of the EMMC storage and bootloader passes the
>>>> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>>>>
>>>> This patch is based on the original work done by Colin Cross for the
>>>> downstream Android kernel.
>>>
>>> I don't think a magic command line is the way to go.  The best would be
>>> to reverse-engineer the proprietary partition table format.  If that is
>>> too hard we can at least key off the odd GPT location based of it's
>>> magic number.
> 
>  +1
> 
>> I thought that the backup GPT was always present in the standard location;
> 
> If they have proprietary stuff on begin of the device and valid backup
> GPT at the end of the device then designer of this junk is crazy, because
> many GPT fdisk-like tools will try to recover from the backup header and 
> overwrite the unknown (invalid) stuff at the begin of the device...

It's a problem created by vendor, but these devices are assumed to run
Android-only. So it's not really that bad :)
