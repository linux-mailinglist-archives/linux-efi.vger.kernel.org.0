Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8813EF008
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhHQQQj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhHQQQi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 12:16:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B213FC061764;
        Tue, 17 Aug 2021 09:16:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g13so42345984lfj.12;
        Tue, 17 Aug 2021 09:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sr3avq56PYejYeB2Me2mzHjNTPeEs3a02cpJLO7/D6U=;
        b=qwhpvCTYuEpxYyDJgSBovtiE85s5rKgmF+DxhtA5V5lOcFt6CISL+8RHcWMkQ4tp68
         SbO6IjG2y25leDfUv+RvQAG9HWaj7jrF8OnchWfyEOXX1Tb8DUABMpwsnBGRqe11RC/6
         GP5x8Xa5N/tvitCfqTmCrMyuzRee25bE9LthZZvP4QBnr6jCqZwv7DaLePzg3Na5tBMx
         jKRwLIs/I4uhTU3UeKgEp1U8CgoJ7dVXDwGARzW6pyOsZHa9IRBfeHV/HPID7l1xQ+zc
         zyXM6K0R9Z+ZYi9W7Q0BIW+qwhPK90dVrEbUrmfX7iVItX8SXbv4fAbbAA1lQE/wqN8p
         MQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sr3avq56PYejYeB2Me2mzHjNTPeEs3a02cpJLO7/D6U=;
        b=Cyffk0pKvc1vIByAe2R1CnNYR734bpHdqmOlZzY2Y+1iYpr7P9Lmx7R4JJt0+YfyfV
         1HwaT6KDXy/+U7G9xxd+n442/Ocou/0bdaIku13q/mD61BfUqoO88FYizYahdv3JIivR
         GKIoLHuBJs/BzNEk7Fqf9GKUepWeb7N6vgF3MI7egv1bikFvD6wTQ8csHTcLCKxcM4CC
         vnFppwnziBBG7l2jOeJ7HjLopBtRIuphzI7E0ixGJi6t5OjOqWJHeo+nKlRgoVjh/4aM
         XNcD2/LrBcFdMl9UlF0tA4T5sLK1I4GtFYzkQkl/1EshvMX1fXLBg6BSUNL7Y5b6RHXi
         Syog==
X-Gm-Message-State: AOAM533P+vbmaYnlHE5XU5mmdIxQ3gKUvHQRH38PVjKbQUCAXfvPiemI
        qGa5NPUhdmJyPJYqg2YFvGyCSDUOdFQ=
X-Google-Smtp-Source: ABdhPJwVPpaQiTFgxDrurEO/5BlrPD6UoCBghjkErm6OjS4O+FIeprnIovhj8Ym0bfe7h/BF10OFwQ==
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr3069736lfd.207.1629216962947;
        Tue, 17 Aug 2021 09:16:02 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id w14sm228979lfk.161.2021.08.17.09.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:16:02 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-4-digetx@gmail.com>
 <CAPDyKFr3d5tTsKVhgvqw1C-Np=6N2onJ+bo_hoFqtD6JSPn2Bg@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7268eb54-614c-df98-c685-6cc360116941@gmail.com>
Date:   Tue, 17 Aug 2021 19:16:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr3d5tTsKVhgvqw1C-Np=6N2onJ+bo_hoFqtD6JSPn2Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

17.08.2021 11:24, Ulf Hansson пишет:
>> +int tegra_partition_forced_gpt(struct parsed_partitions *state)
>> +{
>> +       struct gendisk *disk = state->disk;
>> +       struct block_device *bdev = disk->part0;
>> +       struct mmc_card *card = mmc_bdev_to_card(bdev);
>> +       int ret, boot_offset;
>> +
>> +       if (!soc_is_tegra())
>> +               return 0;
>> +
>> +       /* filter out unrelated and untested boot sources */
>> +       if (!card || card->ext_csd.rev < 3 ||
>> +           !mmc_card_is_blockaddr(card) ||
>> +            mmc_card_is_removable(card->host) ||
>> +            bdev_logical_block_size(bdev) != SZ_512 ||
>> +           !of_match_node(tegra_sdhci_match, card->host->parent->of_node)) {
> I think you need to convince Rob Herring that the location of the GPT
> table in the eMMC flash memory is allowed to depend on the compatible
> string of the sdhci controller.

I'll CC Rob on the next revision, although I think he doesn't care much
about this.

> In any case, I think Christoph raised some interesting ideas in his
> reply. Moving more of this code into the mmc core/block layer seems
> reasonable to me as well.

Will prepare v5, thanks.
