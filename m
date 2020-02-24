Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88016AE99
	for <lists+linux-efi@lfdr.de>; Mon, 24 Feb 2020 19:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgBXSWl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 24 Feb 2020 13:22:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43785 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgBXSWl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 24 Feb 2020 13:22:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id s23so7474756lfs.10;
        Mon, 24 Feb 2020 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lO1820yXM1kR2FVVGTZ+ujBZ4C9qGvFZNasnsnO3YqI=;
        b=g41PErF6G9DUh+x9iXgEt0exu0g4nKSFES0SiW/+ruBNlipaoJagG84+h1+ASnZVCs
         LN4OWgy4A7rbxtoePdMfCMfGMsm92tfJ5LRcuIELnndLIRw7czgWnPEoltZUmWWsZyHb
         AX6uq/Z8MOu8GzNIznwlX1tChE3ERvU2gScJr7geIV/7fKANCp6omuhwuJuG80rGVBJJ
         kv3SN5dkscPUutWqgs8NPrvFUK7EoVnsG/qHlcblo194p5aU0KQjo7k0mJvwqQNJECxO
         zHjvJAIa+aNKUG84kEjEnEf91dda1u1M1x04V6Rh93lyC79TXNQrwq4dIA519eKktNpM
         aL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lO1820yXM1kR2FVVGTZ+ujBZ4C9qGvFZNasnsnO3YqI=;
        b=ps75zpI7pNkY4dHa1gO8Celc5fdtvlIGaACCGr3RRPTdg4GyyrZMtlMZqh5/LrAqJp
         R1byctcP/HXSdbnt0alz/bKgF3BOid6SDTYcYQy1UfCKMzzz8M4t0r1Z+08eHwy7Z6MU
         pUCxV6C1uRmEuANX4uBbmEA0NjrYRJqmAgcelnzRAxvWxZW/Ng3n/1zl7EPUML1ocjFU
         SGzQieZyB8yRnMvST3ugVhcJdfDZUPCOv3FRVRuq2RLHOidA8nH8Yj1l1FHUmRU01FcG
         ctEGQ0+5nMIehTQ7jFF+KC+b4C994z/ZZJfvWq6v4IKVAzFmhwI59v6WXSvOXR6wQu1U
         ofNg==
X-Gm-Message-State: APjAAAUt2x2/0istOtA+aqKMgN/gJa7nMbiW2TFSqNfWQEPl1vWyiyJt
        LCYY/C+L1kliX6YG3qr4h3mV5/oN
X-Google-Smtp-Source: APXvYqxnxim8gbAsgYo6E4n7YKceLi0CMN4LN5Qy8wdqUm37IovUbcalEUWRIr/o65enOGgrw7hAkQ==
X-Received: by 2002:a19:2d53:: with SMTP id t19mr2250423lft.206.1582568556912;
        Mon, 24 Feb 2020 10:22:36 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id i67sm3895013lfi.11.2020.02.24.10.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 10:22:36 -0800 (PST)
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Karel Zak <kzak@redhat.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
 <9c7343eb-1b09-ffcf-cba0-11d6a26dfd77@gmail.com>
Message-ID: <eb1e3a64-b1ac-94d0-07f7-c84a83d9b21e@gmail.com>
Date:   Mon, 24 Feb 2020 21:22:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <9c7343eb-1b09-ffcf-cba0-11d6a26dfd77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

24.02.2020 20:23, Dmitry Osipenko пишет:
> 24.02.2020 19:33, Karel Zak пишет:
>> On Wed, Feb 19, 2020 at 09:59:54AM -0700, Stephen Warren wrote:
>>> On 2/19/20 9:27 AM, Christoph Hellwig wrote:
>>>> On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
>>>>> The gpt_sector=<sector> causes the GPT partition search to look at the
>>>>> specified sector for a valid GPT header if the GPT is not found at the
>>>>> beginning or the end of block device.
>>>>>
>>>>> In particular this is needed for NVIDIA Tegra consumer-grade Android
>>>>> devices in order to make them usable with the upstream kernel because
>>>>> these devices use a proprietary / closed-source partition table format
>>>>> for the EMMC and it's impossible to change the partition's format. Luckily
>>>>> there is a GPT table in addition to the proprietary table, which is placed
>>>>> in uncommon location of the EMMC storage and bootloader passes the
>>>>> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>>>>>
>>>>> This patch is based on the original work done by Colin Cross for the
>>>>> downstream Android kernel.
>>>>
>>>> I don't think a magic command line is the way to go.  The best would be
>>>> to reverse-engineer the proprietary partition table format.  If that is
>>>> too hard we can at least key off the odd GPT location based of it's
>>>> magic number.
>>
>>  +1
>>
>>> I thought that the backup GPT was always present in the standard location;
>>
>> If they have proprietary stuff on begin of the device and valid backup
>> GPT at the end of the device then designer of this junk is crazy, because
>> many GPT fdisk-like tools will try to recover from the backup header and 
>> overwrite the unknown (invalid) stuff at the begin of the device...
> 
> It's a problem created by vendor, but these devices are assumed to run
> Android-only. So it's not really that bad :)
> 

Is there any way to mark parts of block device as read-only? Such that
userspace couldn't write to the RO-marked sectors, I guess that could
help to save someone's bacon.
