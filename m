Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68903EFA47
	for <lists+linux-efi@lfdr.de>; Wed, 18 Aug 2021 07:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhHRFmh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Aug 2021 01:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhHRFmc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Aug 2021 01:42:32 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2BC061764;
        Tue, 17 Aug 2021 22:41:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s3so2837574ljp.11;
        Tue, 17 Aug 2021 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v4K7w81sEi3OCwQ/2vCx2Fz1iD73LWwUrqmXz3J7diA=;
        b=WE+bp9bfb2w+49dYBgXat9qhuKddO2QpZkaUvSBF9CFaCL77pVlVPwCMCq0SQaGKRP
         GuWSi055ddl44jGnwp+4WKUv5KmwpGiHLrIZHhK8ECx1X0T1jlkFXVhksQwJV4gW0sSf
         c7fTlTgSrx+/q+QkD4qtxOyD17knCPZhb2j2VpJK8pErVdWHMmPulwgEMTktV0iECnFC
         QB39KHyXtAFpXjfOxOHGwGiUJlF4y2Zqdx+67mLlNwxB9jJPUg0QQDbE61S0ANoPEug1
         TVvXCtxmZMPVI43DNysNvfc6u0EE7eOO/MQNPLrRGbosYIzWzblFPSWX0vfDLvJghZ5c
         KDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4K7w81sEi3OCwQ/2vCx2Fz1iD73LWwUrqmXz3J7diA=;
        b=hTcGdTwsDZo1Q67ytHSrlb1BdAjxe8n/uucS7GySALts0OwZkSFWcGRNgPBbgeHgYl
         8FdfBnbMggF8uMGqjxS+4MVA1ngDEihBKcv8sOwcbM9O7hkkZjXMGtWPwC/DuDHjdjid
         798OzLZ+HYPrmWhf2ls86ipZ8D/0DVIguXKcnMXWVcZ0FhCC5EWpzAcaubAtY+YsNYs6
         FRwvyeghx2jko0s+wiEoavnNoo2iEv11wzAtgsxiMXvTjMDW+orxxtB0P9ueJPrAS3I0
         tWNcfvc/5enkunzntDcOS4qkS011Fd5USbbgV0Xef8UY6Lr5qZFXNlAF82H5JDFhAzZr
         GTzw==
X-Gm-Message-State: AOAM5333ax4r2b/V3QN6GB/hPu7RGsf/bjowqB0sAgBIvs1LU+LWON44
        bUk4gIakEG/QyMJfXt9IHQJy9m/tLnM=
X-Google-Smtp-Source: ABdhPJxm8poHS+JDYzrZtgIzhEock9n9i4wmBZmsAS+dVh+28i4+nPXnJA613FfSh1MaUKz3TldfpQ==
X-Received: by 2002:a2e:740a:: with SMTP id p10mr4351024ljc.177.1629265313861;
        Tue, 17 Aug 2021 22:41:53 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id t142sm390615lff.269.2021.08.17.22.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 22:41:53 -0700 (PDT)
Subject: Re: [PATCH v5 1/5] block: Add alternative_gpt_sector() operation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Micha?? Miros??aw <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rob Herring <robh+dt@kernel.org>,
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210818005547.14497-1-digetx@gmail.com>
 <20210818005547.14497-2-digetx@gmail.com> <YRyYsNs10AoPg069@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <03eb4638-1cc2-47fc-6e21-f92783033068@gmail.com>
Date:   Wed, 18 Aug 2021 08:41:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRyYsNs10AoPg069@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

18.08.2021 08:20, Christoph Hellwig пишет:
> On Wed, Aug 18, 2021 at 03:55:43AM +0300, Dmitry Osipenko wrote:
>> Add alternative_gpt_sector() block device operation which specifies
>> alternative location of a GPT entry. This allows us to support Android
>> devices which have GPT entry at a non-standard location and can't be
>> repartitioned easily.
> 
> Probably worth adding a little comment explaining this rather odd
> operation.
> 

I'll add the comment in v6.
