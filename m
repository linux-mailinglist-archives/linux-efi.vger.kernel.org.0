Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C8834D0F4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Mar 2021 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhC2NIH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Mar 2021 09:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhC2NHn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Mar 2021 09:07:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF10C061574;
        Mon, 29 Mar 2021 06:07:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 12so7953856lfq.13;
        Mon, 29 Mar 2021 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stYWrf6XqmrqozR7EKI3OutzUa6M7NoWU7A27SKipUk=;
        b=SO+Aaeu9h/qX5vUuAAEYjKxeugr3j+fLh6zztUyNzyi35/YzGozj9NFHkMugfYMOsn
         hdbv3HRDktcqJNqeX+ijxHZoxVvEkOENq0xC0WyMD9dDbQMoodsthWjQ56dlduRZor2W
         7jwNtyLcg5SPtnU/K86SsMKQD2TVgvCxTmIUZffGadAf/UXpy/pPisA0xCqlg5tcsAEb
         OZDUEV8ffqUtEgEK109F4W9emCj2mjL7OCbY+GoAX4eyYXNpQgsf5QCbLryfrUFsP1+b
         uU2PPtfLddgx/Td7vWsHfVIIkWAJYgkW78K94EyEgzFdXf0XcSq1gDah3tjlvvzLPFae
         F5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stYWrf6XqmrqozR7EKI3OutzUa6M7NoWU7A27SKipUk=;
        b=OC5QK9OJU79GMKBXN726ZKNu1FFrRf33g0TuqLgVU6o0eagFJN1iCpicH2iR3/nf+k
         lYkieeDGMlX00Iabw1fUXORzuj4A0jVvKTqABrOiiqYDRFgDJTRNrZkoD82HGvSL5yjq
         zHDcjaibKIKoScwBVH04pwUpMeNZfXAWwjyuV6T+qy1wRqOHgsa8Fw5epMw7HCwVGFFF
         XP9WLdluwNdBYhxLOnYTngGRxULrvZC2YDSaiW1p5gQzjo9EiMR5+kGKlFUtdUiRSnOJ
         NUJ03vh8/oM2GqDu8EyD9ffL+fd5uPJ5wgsspp2CzXrqaEx1Q76QP3RPiyw1gAiW+6NU
         hqkQ==
X-Gm-Message-State: AOAM5318HNiu3eei87+XvRHT8BIsg7px5HFXcTFgaLT0vt1XiNhOKqdq
        VciMN6Bvldr4XgusCO/9fxwpTGCYkiU=
X-Google-Smtp-Source: ABdhPJwDjWcRRWvvdt96aIeYPGRR0KJHG7TVqzSKddHHCzlbLMyz4bjc82k80czSwB5ZBsLM2cx8Wg==
X-Received: by 2002:ac2:4245:: with SMTP id m5mr16850937lfl.168.1617023261449;
        Mon, 29 Mar 2021 06:07:41 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:b259:a10:76ff:fe69:21b6? ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id d22sm1828163lfm.267.2021.03.29.06.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 06:07:40 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] partitions/efi: Support gpt_sector parameter
 needed by NVIDIA Tegra devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210327212100.3834-1-digetx@gmail.com>
 <20210327212100.3834-4-digetx@gmail.com>
 <20210329061850.GA258398@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4666087a-05a5-1065-da17-8dc86248b338@gmail.com>
Date:   Mon, 29 Mar 2021 16:07:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210329061850.GA258398@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

29.03.2021 09:18, Christoph Hellwig пишет:
> On Sun, Mar 28, 2021 at 12:21:00AM +0300, Dmitry Osipenko wrote:
>> All NVIDIA Tegra20..124 Android devices use proprietary bootloader
>> which supplies the gpt_sector=<sector> kernel cmdline parameter that
>> should be used for looking up the EFI partition table on internal EMMC
>> storage.  If the kernel cmdline parameter isn't supplied, then the
>> partition is expected to be placed around the last but one sector of EMMC.
>>
>> Apparently this was done in order to hide the PT from a usual userspace
>> tools since EFI entry exists only for compatibility with a Linux kernel,
> 
> That's weird, because nothin in Linux relies in EFI partition tables.
> 
>> while a custom proprietary partition table is what is really used by
>> these Android devices, thus these tools may corrupt the real PT, making
>> device unbootable and very difficult to restore.
>>
>> Add support for the gpt_sector cmdline parameter which will be used
>> for finding EFI entry on internal EMMC storage of NVIDIA Tegra20+ devices.
> 
> Didn't we plan to just support the actual partition table format insted?
> 

Ideally we need to support both forced-gpt and tegra-partition.  At
first we should check whether GPT entry exists and use it on success,
otherwise fall back to tegra-partition.  This will allow to properly
support all kind of devices.  The majority of devices have the GPT
entry, so will be good to support it at least.

My understanding that this all require involvement from Jens Axboe in
order to get the patches merged.  Previously he didn't show interest to
any of the patches and my assumption was that he didn't want to have
another partition, although I don't know for sure because he never answered.

If you could help with reviewing and applying of the patches, then I
will be happy to try again with re-sending a full patchset, which
includes the tegra-partition support.
