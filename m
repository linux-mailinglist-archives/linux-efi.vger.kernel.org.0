Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B631D62CE
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEPQ6e (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 12:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgEPQ6d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 12:58:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C456EC061A0C;
        Sat, 16 May 2020 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=bbQ33WbtSFvsxRCkDIlragiDXl1OWmfa4TTs5FuIACg=; b=XWB8nVVv662/mphg0Jh2HbkVI+
        +K5uoI5x7pxHZR76NkYSBI5gzEj2Zwa1IV/7ZkvRsnmauxN/dRNYpaJr40OFlQBhW61V1j3c8QMFK
        zvc6etJpZg/M2ku2vVX58KgeKmuBHf6RVz7QZ2d0zk5RG5nvc60bkWFCpMut9jBBy32LqwzvTrcy3
        m+bJBewURE5kzUIfnAv+oXPVDyGbd9UYJHpwHKvaPDQCcfttDazQZlkoMffKKMgi0oAbKgnsKwb6g
        Sx0FD4KB8/LZ8CcJVOxjgeU0xP/mo+5gj7umJlBIWIJbmOlUp63EoySQb5DodLN6FREfTLW65BFSa
        WzFHKO1Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ja08p-0000oq-An; Sat, 16 May 2020 16:58:27 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a0f6a9c-b652-598a-c8a0-580a3e98171b@infradead.org>
Date:   Sat, 16 May 2020 09:58:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <595392b8-d950-4be6-f6cf-e274b4760b94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/16/20 9:50 AM, Dmitry Osipenko wrote:
> 16.05.2020 18:51, Randy Dunlap пишет:
>> On 5/16/20 8:36 AM, Dmitry Osipenko wrote:
>>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>>> index b64bfdd4326c..3af4660bc11f 100644
>>> --- a/block/partitions/efi.c
>>> +++ b/block/partitions/efi.c
>>> @@ -621,6 +621,14 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>>          if (!good_agpt && force_gpt)
>>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>>  
>>> +	/* The force_gpt_sector is used by NVIDIA Tegra partition parser in
>>> +	 * order to convey a non-standard location of the GPT entry for lookup.
>>> +	 * By default force_gpt_sector is set to 0 and has no effect.
>>> +	 */
>>
>> Please fix the multi-line comment format as described in
>> Documentation/process/coding-style.rst.
>>
>>> +	if (!good_agpt && force_gpt && state->force_gpt_sector)
>>> +		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
>>> +					 &agpt, &aptes);
>>> +
>>>          /* The obviously unsuccessful case */
>>>          if (!good_pgpt && !good_agpt)
>>>                  goto fail;
>>
>> thanks.
>>
> 
> Hello Randy,
> 
> I know that it's not a proper kernel-style formatting, but that's the
> style used by the whole efi.c source code and I wanted to maintain the
> same style, for consistency. Of course I can change to a proper style if
> it's more desirable than the consistency. Thank you for the comment!
> 

too bad. Sorry to hear that.
It should have been "fixed" much earlier.
It's probably too late now.

-- 
~Randy

