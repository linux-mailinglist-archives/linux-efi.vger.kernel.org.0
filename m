Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7303C1D64D6
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 02:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEQALF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgEQALF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 20:11:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CDAC061A0C;
        Sat, 16 May 2020 17:11:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h188so4906795lfd.7;
        Sat, 16 May 2020 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7RutZLM7sTgMICi4NTWTSRsk36VFF4JdskFPttU4j/s=;
        b=o0YM476vzwQlNxJpTuH9H+ijd8e3EvZqzdxWlzzpq1FPrn8L61EGfOu4HyqhgcMIOx
         DEjOLG0AdV0h8CPWUZwMdh8ti3WDm77Lfl9LzeB2QYU2hJ8CFoJ2lgybGuP14zh1Xpym
         dI3ff2pUwIrCDxXs8p2Z5s5Tuj0mzOLq968EAbKqq+KZWfMQNAXW6+I4v0ScA5roRGzv
         QGaUdgKlgkK5JXKH3ETnFFh7nNH7Dd18T080II0qslLGe1SbuNEpB4FzpjwvE0aViffR
         PAHGplchIdgOSEQ1fBQfjZiqTVZlc08OGdm7hWkfDnHauNaA5qnavjvrNfvmmNqn5xX8
         urTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7RutZLM7sTgMICi4NTWTSRsk36VFF4JdskFPttU4j/s=;
        b=c9XiUSPzP8DW0B1hXfzprAxtsRtnGhiOTpUDb1HtAmuVbux5j4CqhPh9XungmOwA0d
         XwUTKn6ZvSwCcQsvq/AV83rZprgLccfOcIEp+hox+ZDLwz+4tgCV1sTmbNd6ojM58l8D
         CE2VDD+BtDRMAkeFzXvkmDEf2EwAMYyL9aEZDBN8cyQp+Pcs5Oo3vgk4sgNGVX3AovoW
         vCbDdtsHox4d83XRgoefgBwSyoILPYdzBG84xP39U+nnEs2SgHk8+9GDKIog+CeVZhPp
         JfNbm8WWouuRucnn0uM/ZMNYAA3jWJMeMLmg7MFMV0XYPdLeK+v42LgOlQtJD7uZtXmX
         pozg==
X-Gm-Message-State: AOAM53231rPODXsmNjxAd7gWg3GaUQO0TMlVWMlGDfLK8nmbVXQK5EUZ
        uH0tFsF1BZsJ4I2oR7Qa92FoZZyb
X-Google-Smtp-Source: ABdhPJw7nBupc4+2lwltu5izN6Keaf3FMVvrR3LLLws4cyD6os+cDv47Cr9YSfN/AN/xkkT4bPGUmw==
X-Received: by 2002:a05:6512:3139:: with SMTP id p25mr1900664lfd.214.1589674263161;
        Sat, 16 May 2020 17:11:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id d16sm4007473lfm.35.2020.05.16.17.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 17:11:02 -0700 (PDT)
Subject: Re: [PATCH v5 4/6] partitions/efi: Support GPT entry lookup at a
 non-standard location
To:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>,
        =?UTF-8?Q?Nils_=c3=96stlund?= <nils@naltan.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steve McIntyre <steve@einval.com>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20200516153644.13748-1-digetx@gmail.com>
 <20200516153644.13748-5-digetx@gmail.com>
 <2ae298ca-016a-8867-52dd-86d99b9e0f3b@infradead.org>
 <595392b8-d950-4be6-f6cf-e274b4760b94@gmail.com>
 <4a0f6a9c-b652-598a-c8a0-580a3e98171b@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68d36582-5a47-11b4-360a-ceb2e272e459@gmail.com>
Date:   Sun, 17 May 2020 03:11:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4a0f6a9c-b652-598a-c8a0-580a3e98171b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

16.05.2020 19:58, Randy Dunlap пишет:
> On 5/16/20 9:50 AM, Dmitry Osipenko wrote:
>> 16.05.2020 18:51, Randy Dunlap пишет:
>>> On 5/16/20 8:36 AM, Dmitry Osipenko wrote:
>>>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>>>> index b64bfdd4326c..3af4660bc11f 100644
>>>> --- a/block/partitions/efi.c
>>>> +++ b/block/partitions/efi.c
>>>> @@ -621,6 +621,14 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>>>          if (!good_agpt && force_gpt)
>>>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>>>  
>>>> +	/* The force_gpt_sector is used by NVIDIA Tegra partition parser in
>>>> +	 * order to convey a non-standard location of the GPT entry for lookup.
>>>> +	 * By default force_gpt_sector is set to 0 and has no effect.
>>>> +	 */
>>>
>>> Please fix the multi-line comment format as described in
>>> Documentation/process/coding-style.rst.
>>>
>>>> +	if (!good_agpt && force_gpt && state->force_gpt_sector)
>>>> +		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
>>>> +					 &agpt, &aptes);
>>>> +
>>>>          /* The obviously unsuccessful case */
>>>>          if (!good_pgpt && !good_agpt)
>>>>                  goto fail;
>>>
>>> thanks.
>>>
>>
>> Hello Randy,
>>
>> I know that it's not a proper kernel-style formatting, but that's the
>> style used by the whole efi.c source code and I wanted to maintain the
>> same style, for consistency. Of course I can change to a proper style if
>> it's more desirable than the consistency. Thank you for the comment!
>>
> 
> too bad. Sorry to hear that.
> It should have been "fixed" much earlier.
> It's probably too late now.

Actually, I now see that there is a mix of different comment styles in
the efi.c code. So it should be fine to use the proper style, I'll
change it in v6.

I don't think it's too late, it's never late to make a correction :)
There are some other coding style problems in the efi.c that won't hurt
to fix, I may take a look at fixing them later on.
