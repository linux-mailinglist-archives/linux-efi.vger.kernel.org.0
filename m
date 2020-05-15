Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38621D552E
	for <lists+linux-efi@lfdr.de>; Fri, 15 May 2020 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgEOPw6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 May 2020 11:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgEOPw5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 May 2020 11:52:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B81C061A0C;
        Fri, 15 May 2020 08:52:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d22so2216335lfm.11;
        Fri, 15 May 2020 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l71weFdBgY/OPubK5TNcEV6JMPL70XXv0VPAI4BGmH8=;
        b=h+zhmsKdPrBiA91DhveEfpS8srEtG6zUpM0LynXaeBAEpjymBb7cGgwHobsxSjveai
         MczFjeQoUoR6hJ9K5WfBuDl6RUF3pIVcUH7a80+4OpUErSQVuHRoCukkkzKjzaC2mgjo
         mjKXqx8t8tuPjiwOG5LF1XcrQz6VP+Z0Bk18SGdBx0GNTou6BwFy2NDR5le9ScpHhEqA
         mYDelPDUPWjs3L6EPRXiDUmQ48Ni2B0+u1+p98HtmkYe4Bn57ASFvWY8W4/r1ZJzOOKK
         5qCUawwktx2EmXiU3luK9jSBqVJJ/SHxbs9gvkyv1JoPU/81ttsidcCYJCD/KY40kdGA
         e3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l71weFdBgY/OPubK5TNcEV6JMPL70XXv0VPAI4BGmH8=;
        b=M1n47HXBz/zH+lDK0suR2M5L53Pt1vdvNiDnaoCCH36lkWQp8MuX28hYUEh6uwd93Z
         EWL3n59rwWn7i3S3ubIQ8ZuMcdBlyI2HQfNWqHUZxp+b2WXY+NqdYw3LieNd4WUBx73W
         72sOZXx3Lq9ROZisqNe+b0thI7zDMTdb/HVjCARQql+yr6n2ZLnVbWj5/Ghl6d4edT9a
         DVMkFsqCEaagQWOSAyQagkCIXwDeuvREEX84ue9LOBwBLdPOBWKK8Ajparlg3iqJAf3X
         hiVcUfJ2SUUzFxcJxTbikNduBWRbr8gQ5B7sji3p/0968DvnobG8rlgcfGjuPjdve3RV
         Q6tg==
X-Gm-Message-State: AOAM532Rg6gPSN/W9GBeA6zcaVhmiUi+LrbBHGbsiPogvSsvQkk/A5aG
        VUJquoagHKPofhWV3yc6kvy16Lva
X-Google-Smtp-Source: ABdhPJxTNdXAf1FtSIiCyjYkNMI+hY5ajiYzUnof3HI0p3oY3hAgh9KXwjPIo2BOWmWGbMMBMBBZgg==
X-Received: by 2002:a19:2258:: with SMTP id i85mr2905186lfi.86.1589557975112;
        Fri, 15 May 2020 08:52:55 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id r3sm1529811lfm.52.2020.05.15.08.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:52:54 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] partitions/efi: Support GPT entry lookup at a
 non-standard location
To:     Steve McIntyre <steve@einval.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
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
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi <linux-efi@vger.kernel.org>
References: <20200515014143.12984-1-digetx@gmail.com>
 <20200515014143.12984-5-digetx@gmail.com>
 <20200515100320.GB30674@tack.einval.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2633429b-f014-15ea-c08c-d2157b0177b1@gmail.com>
Date:   Fri, 15 May 2020 18:52:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515100320.GB30674@tack.einval.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

15.05.2020 13:03, Steve McIntyre пишет:
> On Fri, May 15, 2020 at 04:41:41AM +0300, Dmitry Osipenko wrote:
>> Most of consumer-grade NVIDIA Tegra devices use a proprietary bootloader
>> that can't be easily replaced because it's locked down using Secure Boot
>> cryptography singing and the crypto keys aren't given to a device owner.
>               ^^^^^^^ typo
>> These devices usually have eMMC storage that is partitioned using a custom
>> NVIDIA Tegra partition table format.  Of course bootloader and other
>> "special things" are stored on the eMMC storage, and thus, the partition
>> format can't be changed.
> 
> ...
> 

Thanks! I'll correct it in v5.
