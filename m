Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA53F08D7
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHRQQW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhHRQQV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 12:16:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99616C061764;
        Wed, 18 Aug 2021 09:15:46 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so6124633ljn.1;
        Wed, 18 Aug 2021 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1hKEYv+Fr6C7EKch69Wd8Zt8f3YFEBcPg/InLCEUJH0=;
        b=DlGZ4gR97mpf2cthrcTkSHnW4ubQjP55OzuLMZ5FJ3WzJHWmXdMj9I1J/wa3iFKxbV
         reTTXA1FdeH0Lnh7LeCaYAsP1ms5xymPaIc89etWdd6ilpV7DqzkeUDODydlbS3g57LY
         OLQw33yl9EcKWcKzoHwZuOmGQX84H+5l5uwCCjxd7Zl3zvf3BHCHy+74SMwVQCdSUfyk
         LtDRs10b5IWjRfJqbs8v5eUano+zIMC5NNZuXSmeoy7IYGyppN3BkFVeK+xwimNrtSM2
         YRknBJPkpGCj6lbmhS/4y5plsqLJFZTd9neXaL+CFUC1+SqOvfJj32YmKEvvzUoZJZrj
         n50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hKEYv+Fr6C7EKch69Wd8Zt8f3YFEBcPg/InLCEUJH0=;
        b=W8qJ7Ca5KlZA3IGhOBfeMaQE/PtmomSf4UeJOUGclDN5hqVYz1gktcwSTIqnH7Ekad
         gstFDFpnymVoVT+Nl4jz+GUmzOGAHEyhXb7XWLr97OjrwQ94mlmGFO4Fh6ZthIuTNkOb
         sHlEJ5umZbQ81Jm8uS3xmfbts/bVPenxyhl+gvt4oZ7m8imDIf13QXW2fuV5MtlyTIA6
         jwuizFLtp0w7rad3Ymg4MtGZdrAIcMlLgKf8MEW3FM4LbVHqI1beefQEC2xF5wPkKUX2
         CodkWWzQUAXBgqlQeEJSSzLfmEDU5P87ysqQe0fg3SEp5X4HKTkWeiPsA31KMJDMLp5G
         jFiQ==
X-Gm-Message-State: AOAM532cTQCA79ynSycYNDngMNeFQR2QuCCd512gS++JC3wMliVFnpsA
        gUkbdQgmaBrq5M/UDoUJpojzgW0t1Go=
X-Google-Smtp-Source: ABdhPJxWo8J3/Yk16JNcOWy4IODSkq8yj5RsFCPqgmTt0th+73KqVgrS8LlFvPMGpwmXw+uMKaFBEw==
X-Received: by 2002:a2e:a88b:: with SMTP id m11mr8603688ljq.51.1629303344842;
        Wed, 18 Aug 2021 09:15:44 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id d9sm35914ljq.54.2021.08.18.09.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 09:15:44 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] mmc: sdhci-tegra: Implement
 alternative_gpt_sector()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-5-digetx@gmail.com>
 <CAPDyKFqQbe4k-Sem436Fzsr6mbvwZr83VtEaEZTF8oWYoHHQwg@mail.gmail.com>
 <YR0MrlxFLTpsR628@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <90dcb1e9-30df-e721-5ddc-156ae295636e@gmail.com>
Date:   Wed, 18 Aug 2021 19:15:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR0MrlxFLTpsR628@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.08.2021 16:35, Thierry Reding пишет:
>>> +static int sdhci_tegra_alternative_gpt_sector(struct mmc_card *card,
>>> +                                             sector_t *gpt_sector)
>>> +{
>>> +       unsigned int boot_sectors_num;
>>> +
>>> +       /* filter out unrelated cards */
>>> +       if (card->ext_csd.rev < 3 ||
>>> +           !mmc_card_mmc(card) ||
>>> +           !mmc_card_is_blockaddr(card) ||
>>> +            mmc_card_is_removable(card->host))
>>> +               return -ENOENT;
>>> +
>>> +       /*
>>> +        * eMMC storage has two special boot partitions in addition to the
>>> +        * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
>>> +        * accesses, this means that the partition table addresses are shifted
>>> +        * by the size of boot partitions.  In accordance with the eMMC
>>> +        * specification, the boot partition size is calculated as follows:
>>> +        *
>>> +        *      boot partition size = 128K byte x BOOT_SIZE_MULT
>>> +        *
>>> +        * Calculate number of sectors occupied by the both boot partitions.
>>> +        */
>>> +       boot_sectors_num = card->ext_csd.raw_boot_mult * SZ_128K /
>>> +                          SZ_512 * MMC_NUM_BOOT_PARTITION;
>>> +
>>> +       /* Defined by NVIDIA and used by Android devices. */
>>> +       *gpt_sector = card->ext_csd.sectors - boot_sectors_num - 1;
>>> +
>>> +       return 0;
>>> +}
>> I suggest you move this code into the mmc core/block layer instead (it
>> better belongs there).
>>
>> Additionally, let's add a new host cap, MMC_CAP_ALTERNATIVE_GPT, to
>> let the core know when it should use the code above.
> Couldn't a generic "alternative GPT" mean pretty much anything? As far
> as I know this is very specific to a series of Tegra chips and firmware
> running on them. On some of these devices you can even replace the OEM
> firmware by something custom that's less quirky.
> 
> I'm not aware of anyone else employing this kind of quirk, so I don't
> want anyone to get any ideas that this is a good thing. Putting it into
> the core runs the risk of legitimizing this.

I also think it's better to keep it internal to Tegra. Ulf, could you
please clarify why do you want to have it moved into the core? Are you
aware of any other platforms that want exactly the same quirk? Thierry
should be correct that it's relevant only to Tegra SoCs.

Regarding the 'legitimizing', it's not a bad thing to me at all. If we
want to run more devices with a mainline kernel, then such quirks are
inevitable.
