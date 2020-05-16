Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B579C1D62BA
	for <lists+linux-efi@lfdr.de>; Sat, 16 May 2020 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEPQua (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 16 May 2020 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgEPQua (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 16 May 2020 12:50:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FA4C061A0C;
        Sat, 16 May 2020 09:50:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so5461784ljj.11;
        Sat, 16 May 2020 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f99U+q5cMTjr+AScEQdDuV6vKmP7Ztj+erax4cbrEps=;
        b=mcqE0ZP1L8fA9oZpjPLnHTQxj9DISlSkdUSjDS5MKMbk/j+03hUQLwd6z3B8B8MDVI
         wRn1/6n3jL0HPIM4eaeTkrvvTUGSqbcAk/L2fOqZmYQVUokExZrC15lpCNnoH7IEgvAs
         FyguYQs3v3ii5LK8OmRIpf8e3t3P8p6QuUeujYWdySBsdFwdmARutnbMCIFqIJuNW7hL
         RKu+0D0hxIucdDXrYurm/1/Lkhpk7yqccI9NNjKbY+vbIxD33Tbumf5ronaI/MRabGYL
         RqQiC0GdNh4HP942YsV0i0iVEhex68raCr/Du8jsmbBNvWi2DYljbPYjpyRKV2Z6+fPV
         +jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f99U+q5cMTjr+AScEQdDuV6vKmP7Ztj+erax4cbrEps=;
        b=KNHLNnMTR+PgCpJC1H94tIlZOusxpNkj+Kea7G7gv50m7VTfavOW8QMyOx93ng5J1a
         AoL7SQZDV2RIKnOc+0W47KApeOlV47zyLcTQjAsetMWZD9n/ykYihrtFGJXkZtxpc9CF
         J3p+l19t61rVDFAJ4uhDeOkWoovLlMxv/KbUPPsEWUjgas1z77rnw/LhPT6IPYfxgvd1
         m9AiwO48hByRvQ1u+/lPEI0j75ux//EnYW+NjnEe/zkJjpJFUEVIgQlCZUa2XHT7dhNT
         lDXC621vQ4/idMpUszYiReWtZRwmAkPy9d/ZJSWxMEDp/am2rDrA3n2R0SzT3XUtbvXg
         MVVg==
X-Gm-Message-State: AOAM530eGSWqGENItRcmVr2tWFQ97i5cdTNItRvr48IisxxJSx26yWzS
        JZ/teaqQ1yQhw6rQTu5OKXbCfPqt
X-Google-Smtp-Source: ABdhPJwIUIqwc5E8sr7K7W7qAuT9oG3a1T0Jbo8c/KLrXv9Oy6CPNoaLxRW7tfNYuUSYHEQnUic1Gw==
X-Received: by 2002:a2e:b043:: with SMTP id d3mr5189656ljl.77.1589647826805;
        Sat, 16 May 2020 09:50:26 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id f5sm3440127lfh.84.2020.05.16.09.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 09:50:26 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <595392b8-d950-4be6-f6cf-e274b4760b94@gmail.com>
Date:   Sat, 16 May 2020 19:50:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2ae298ca-016a-8867-52dd-86d99b9e0f3b@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

16.05.2020 18:51, Randy Dunlap пишет:
> On 5/16/20 8:36 AM, Dmitry Osipenko wrote:
>> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
>> index b64bfdd4326c..3af4660bc11f 100644
>> --- a/block/partitions/efi.c
>> +++ b/block/partitions/efi.c
>> @@ -621,6 +621,14 @@ static int find_valid_gpt(struct parsed_partitions *state, gpt_header **gpt,
>>          if (!good_agpt && force_gpt)
>>                  good_agpt = is_gpt_valid(state, lastlba, &agpt, &aptes);
>>  
>> +	/* The force_gpt_sector is used by NVIDIA Tegra partition parser in
>> +	 * order to convey a non-standard location of the GPT entry for lookup.
>> +	 * By default force_gpt_sector is set to 0 and has no effect.
>> +	 */
> 
> Please fix the multi-line comment format as described in
> Documentation/process/coding-style.rst.
> 
>> +	if (!good_agpt && force_gpt && state->force_gpt_sector)
>> +		good_agpt = is_gpt_valid(state, state->force_gpt_sector,
>> +					 &agpt, &aptes);
>> +
>>          /* The obviously unsuccessful case */
>>          if (!good_pgpt && !good_agpt)
>>                  goto fail;
> 
> thanks.
> 

Hello Randy,

I know that it's not a proper kernel-style formatting, but that's the
style used by the whole efi.c source code and I wanted to maintain the
same style, for consistency. Of course I can change to a proper style if
it's more desirable than the consistency. Thank you for the comment!
