Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A761D6520
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 04:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgEQCH4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 22:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgEQCHz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 22:07:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6BC05BD09;
        Sat, 16 May 2020 19:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=jYsH3V4w6+m7UpSLG16Z+T62n7FwSrrB/HogFSqz6mQ=; b=L+tYfVJP0eD0J+b/bL5Roh1znl
        DXaI98CFHgO3upEWJVw9j0o7aJZ7MoeFPcuUywND7fYoSh38hxHa6Hzw7uPIzIhEGDiWLSADm83L6
        U95KipryMx53N5VCXetQq3cF6SEJj2NE5rgrCir3oqWHZEUQQDVV9hPPrJ3Y6PlTMJeDyY5evQjhd
        1UN+s0Tpe6J4QYm3JrabEHDe4Jr+hDo/DNFlkWCultHrzC3CEV0wjU/8/VPAaE3Bpwh4+n9kE93GL
        HyEFwFK6ksr3mlMhOwuJG7Ih4p52ePrKtn58MiNDehzRnjjsnJ2rd5tHcP2nxf3nwEB292MNHDM3b
        a2N8NrfA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja8iO-0002Ec-Lt; Sun, 17 May 2020 02:07:44 +0000
Subject: Re: [PATCH v5 4/6] partitions/efi: Support GPT entry lookup at a
 non-standard location
To:     Dmitry Osipenko <digetx@gmail.com>, Jens Axboe <axboe@kernel.dk>,
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
 <68d36582-5a47-11b4-360a-ceb2e272e459@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <27b18ce5-1f73-3acd-ed84-87f98498b256@infradead.org>
Date:   Sat, 16 May 2020 19:07:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <68d36582-5a47-11b4-360a-ceb2e272e459@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/20 5:11 PM, Dmitry Osipenko wrote:
> 16.05.2020 19:58, Randy Dunlap пишет:
>> On 5/16/20 9:50 AM, Dmitry Osipenko wrote:
>>> 16.05.2020 18:51, Randy Dunlap пишет:
>>>> On 5/16/20 8:36 AM, Dmitry Osipenko wrote:
>>>>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>>>>> index b64bfdd4326c..3af4660bc11f 100644
>>>>> --- a/block/partitions/efi.c
>>>>> +++ b/block/partitions/efi.c
>>>>> @@ -621,6 +621,14 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>>>>          if (!good_agpt && force_gpt)
>>>>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>>>>  
>>>>> +	/* The force_gpt_sector is used by NVIDIA Tegra partition parser in
>>>>> +	 * order to convey a non-standard location of the GPT entry for lookup.
>>>>> +	 * By default force_gpt_sector is set to 0 and has no effect.
>>>>> +	 */
>>>>
>>>> Please fix the multi-line comment format as described in
>>>> Documentation/process/coding-style.rst.
>>>>
>>>>> +	if (!good_agpt && force_gpt && state->force_gpt_sector)
>>>>> +		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
>>>>> +					 &agpt, &aptes);
>>>>> +
>>>>>          /* The obviously unsuccessful case */
>>>>>          if (!good_pgpt && !good_agpt)
>>>>>                  goto fail;
>>>>
>>>> thanks.
>>>>
>>>
>>> Hello Randy,
>>>
>>> I know that it's not a proper kernel-style formatting, but that's the
>>> style used by the whole efi.c source code and I wanted to maintain the
>>> same style, for consistency. Of course I can change to a proper style if
>>> it's more desirable than the consistency. Thank you for the comment!
>>>
>>
>> too bad. Sorry to hear that.
>> It should have been "fixed" much earlier.
>> It's probably too late now.
> 
> Actually, I now see that there is a mix of different comment styles in
> the efi.c code. So it should be fine to use the proper style, I'll
> change it in v6.
> 
> I don't think it's too late, it's never late to make a correction :)
> There are some other coding style problems in the efi.c that won't hurt
> to fix, I may take a look at fixing them later on.
> 

OK, great. Thanks.

-- 
~Randy

