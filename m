Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB33DC7C2
	for <lists+linux-efi@lfdr.de>; Sat, 31 Jul 2021 20:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhGaSq6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 31 Jul 2021 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhGaSq5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 31 Jul 2021 14:46:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A09C06175F;
        Sat, 31 Jul 2021 11:46:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y34so25191752lfa.8;
        Sat, 31 Jul 2021 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f9mH7GxoUvwQhZmcblBHqMZcgMjxB0VFserqhea/TKU=;
        b=CBqmFppPYdO06ERQx2RNzKBgI9zrYi2ri3gfb137prqZ5ZluaakXmvXjI7e27gjCq0
         s1ZF7C3nrcEpmDj73hzhbhREHtM58okX2Re8RFBBS9h64QRtooSJuA9kwxt/DEn5h2fV
         HYi3Q+1Jqx7y8VqSV1EN7aBHBcDvas+v/4JQfFdsp5TNqUY0XdqQDSJ8rjJXUPuFyT5u
         0O7AAalmlTlDFe90rapJAdLlr8IB3VwWmMyFFLgVxGyh3eyMFpDURaCjx3xzQ740ub9g
         zcbkUZnA6ch25cAaHMtjYV/RbGZQOlc2sQlZP42CmqRh1iwv7qI3Btiszn41tSyqc8c5
         9nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9mH7GxoUvwQhZmcblBHqMZcgMjxB0VFserqhea/TKU=;
        b=rkJ1q4jKgCu8W0XA6mzZHWnBevZMfUia8WV925m/0xtvjJPFGgwjddVucNl4/7/sRZ
         hnsKdTVD6EAuueaFWZjwtNGekHxnLhhlKu0PYmLFwiJAlcm4CGOeQ5NbeGtuVYbh3K3B
         2UV9XA/jwaZcm1yc/AUdvitJ19GDo6YO5V7kFkI/gcBfFgcyuQ4VOpW4Dzr3bnJEY0GY
         5k1cNbl3XqDpJZ1qFbLwmFDKx7if3URwXupHFhER6KWTTsWLVqxH3kJSFWwN6qAUEncl
         hyZR+B3jaKUj6AZYEu5zoFtLDosvotv706O3qeoJCalcYiSZ4h66FpdutPiNA7Unc9V+
         cq9g==
X-Gm-Message-State: AOAM530x3egifzj3EPkd0zBq7OMqnRKaT03oncWgB7sgpt5tKBLTy6BI
        vr8wcyQRmRgUTUzLs6K/nd+mcYKTMxU=
X-Google-Smtp-Source: ABdhPJzzNUqZ7ZCsfj2v/sqLp+tz8+xToeofAP6yQRy4x9aPbIC1NkyegNgs72fj9ml4345TFtUZQA==
X-Received: by 2002:a05:6512:138a:: with SMTP id p10mr6562178lfa.505.1627757209358;
        Sat, 31 Jul 2021 11:46:49 -0700 (PDT)
Received: from [192.168.2.145] (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.googlemail.com with ESMTPSA id j2sm426769ljc.49.2021.07.31.11.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jul 2021 11:46:49 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] partitions/efi: Support NVIDIA Tegra devices
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210731183626.18568-1-digetx@gmail.com>
 <20210731183626.18568-4-digetx@gmail.com>
Message-ID: <3d175de0-3c4e-1fcd-984c-0d9bf147779f@gmail.com>
Date:   Sat, 31 Jul 2021 21:46:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210731183626.18568-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

31.07.2021 21:36, Dmitry Osipenko пишет:
> diff --git a/block/partitions/efi.c b/block/partitions/efi.c
> index e2716792ecc1..dced55c0d2e1 100644
> --- a/block/partitions/efi.c
> +++ b/block/partitions/efi.c
> @@ -98,6 +98,15 @@ static int force_gpt;
>  static int __init
>  force_gpt_fn(char *str)
>  {
> +	/*
> +	 * This check allows to properly parse cmdline variants like
> +	 * "gpt gpt_sector=<sector>" and "gpt_sector=<sector> gpt" since
> +	 * "gpt" overlaps with the "gpt_sector=", see tegra_gpt_sector_fn().
> +	 * The argument is absent for a boolean cmdline option.
> +	 */
> +	if (strlen(str))
> +		return 0;

This is not needed anymore in this patch, I noticed it only once v2 was
already sent out. Will correct it in v3.
