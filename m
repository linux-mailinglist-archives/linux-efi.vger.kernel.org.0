Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB7164C65
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 18:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBSRor (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 12:44:47 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36550 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSRoq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Feb 2020 12:44:46 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so813561lfh.3;
        Wed, 19 Feb 2020 09:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uPOumAcBRmkHJ4EJLjVwjyx0UkodYRqLQx2fcbRzjcU=;
        b=e5cq4mF/bFwQMZTp+Vg5gt8plzWasQB/r379lvjWCErASKW+BA24SB2zyRZyLc7oSZ
         eKHynbtTSgcyUJYqX+Jqk+hTx5l+o5ytfPRpvB8WPsPBQHThkSIWoujH9ARG2lEYmljh
         Sa5plISmGyfd5q9hLgFzpxQKAELhTv2KoKASuA+jpf+fzErpbrZ/BUx7QH1X6S8ZlOUA
         z6S+YwuBYuPsVwJ9Auuythr9wVH6piDHCcXCH+ECIltgt6y6HT9dxZARyfD4LqYNSPZ8
         fSCHMfObm2ls8WuoqWT3eLjzLPLAp0P22mi/GAvLHFu7lzuvB88AQYdHT04Yfrvt4QH/
         RPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uPOumAcBRmkHJ4EJLjVwjyx0UkodYRqLQx2fcbRzjcU=;
        b=G5ouDUSr6vEQA41NgErXP1VhP0li4TOijwsliMr3ocroWYVecmLWW1tbHg1ZaQqKwa
         W7SUnZT/CevepzvPMlZ2FbMum52vDP+9S/0BP/f7LQhpTBRENY8WBsxQz3Mk2v7ktGZf
         nLTylRLWLCfFVophLOg1UvK353DUByf0ej1EZTt1zR60edoX3dBPkw6f0OhjfYErpDOp
         Gbi2GeJcou+oR0R9+laYpJrb8EzktuvV32+aJqMGFZQwHuYpoIwBfEXPca+DBXttiJlD
         jYMP5NkoBLkMx+MES7/xT/LKeBPDyza7ZO1tNkIaNgsaa7ifRg0XwARnkAXHwZwvOHWM
         84Qw==
X-Gm-Message-State: APjAAAX3a/lTZTXX+JpklliJ9nL3lTpTOKD3HrdpeJOsVB7Ei6WEXAmU
        5FsrMIVJ170rR5K3KSjBUGl8h9ah
X-Google-Smtp-Source: APXvYqw3ltqhA/bDiRtozOcGmk+Vo3B59KY45uUdjerXfOUHP0AtD/B/7ZhTC9AxNjJ9jBSxV6oGVA==
X-Received: by 2002:a19:5e41:: with SMTP id z1mr14182445lfi.101.1582134283843;
        Wed, 19 Feb 2020 09:44:43 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s17sm254568ljo.18.2020.02.19.09.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:44:43 -0800 (PST)
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
To:     Stephen Warren <swarren@wwwdotorg.org>,
        Christoph Hellwig <hch@infradead.org>
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
 <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0c0d0cff-7b20-f777-8724-0d2b07e60e3d@gmail.com>
Date:   Wed, 19 Feb 2020 20:44:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

19.02.2020 19:59, Stephen Warren пишет:
> On 2/19/20 9:27 AM, Christoph Hellwig wrote:
>> On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
>>> The gpt_sector=<sector> causes the GPT partition search to look at the
>>> specified sector for a valid GPT header if the GPT is not found at the
>>> beginning or the end of block device.
>>>
>>> In particular this is needed for NVIDIA Tegra consumer-grade Android
>>> devices in order to make them usable with the upstream kernel because
>>> these devices use a proprietary / closed-source partition table format
>>> for the EMMC and it's impossible to change the partition's format.
>>> Luckily
>>> there is a GPT table in addition to the proprietary table, which is
>>> placed
>>> in uncommon location of the EMMC storage and bootloader passes the
>>> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>>>
>>> This patch is based on the original work done by Colin Cross for the
>>> downstream Android kernel.
>>
>> I don't think a magic command line is the way to go.  The best would be
>> to reverse-engineer the proprietary partition table format.  If that is
>> too hard we can at least key off the odd GPT location based of it's
>> magic number.
> 
> I thought that the backup GPT was always present in the standard
> location; it's just the primary GPT that's in an odd location. So, this
> kernel parameter just forces the kernel to look first for the primary
> GPT in the unusual location, thus avoiding an error message when that's
> not there, and the system falls back to the backup GPT.
> 
> Or, do I misremember the layout, or the kernel's behaviour if primary
> GPT is missing?

The backup GPT not always presents in the standard location. For example
Tegra30 ASUS Google Nexus 7 has a backup GPT in the proper location and
this is what KMSG prints:

[    1.722888] Primary GPT is invalid, using alternate GPT.
[    1.723076]  mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10

But this doesn't work for Tegra20 Acer A500 and (IIRC) Tegra30 Ouya
because both primary and backup GPTs are invalid at the standard locations.
