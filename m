Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F513EEFFD
	for <lists+linux-efi@lfdr.de>; Tue, 17 Aug 2021 18:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhHQQL6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Aug 2021 12:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhHQQL5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Aug 2021 12:11:57 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA7C061764;
        Tue, 17 Aug 2021 09:11:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d16so15786363ljq.4;
        Tue, 17 Aug 2021 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E4MDW/RmkSPaT++25OsaYRhW1+DEQBdRe9+eNrXz1FE=;
        b=uDXKMa9pl+KOkiyf53/DsNtH+4zF2NSw/AaHHwgTyq4B+pcYtblv+2JTWjtDiVlhSn
         lx4P0YKzLJeoFy7Ow7lpGRECPa/1kB45eJJQ5ytG8XCYpLN++myFRFHWhDVjKfX5Kfqi
         mSbhpr/ouo01xLs/OzffiB3AKSmQgkd4d81LE5hLGxdxMHSXFDssy1cNlhsuG5//p+U7
         6umX11MxizZPprwQ8Kp7fsi4SVE/yebVfNdqwPujZehM5iIe9IX15iR4yoEMvL7pSSFf
         Q5Qq7EVX64eylX73vzLxWXgzpn8s51BfqTtVB4Jmu6qA082X3mAFPHUBX/nJ4ehBGP1p
         Wo/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E4MDW/RmkSPaT++25OsaYRhW1+DEQBdRe9+eNrXz1FE=;
        b=MslJkxdtBhAa20Tk1aXbqv+VCds9WytDv2TA3a5yrAio05cvs2fk3FMtGcqIdJ30df
         zI6BFOuuT8vW/acOA/plj1f/yFEckyfuE9XGFDboxSY73ARPC1wQmZmxOGnH5UwcP9Lv
         GWs0DKVod8A0Zu9cuUUL4GSsPlplPiXyAVfkSWJAFIS1jnMZK1fs1gc+AgXEtU4iCB7L
         3SLKMiq0KT5gUM04ft5VC7AILfmNxgFW5/zwL6BOrh1KrqaU5ELFnopUM7DFHL0TEDoT
         pqX0ZKdJLa50unyTKurHsfBoBDnC3IGmz6I6BzVSoFMmiCqSHGYEww2RfUnjVMbUzntY
         2ZLg==
X-Gm-Message-State: AOAM530EOdri0mgeeCmwEXxUUGCMEqbJt7hgX+oruDTAEHkrce1HSuj6
        yS0JTRUk4uuDoAWBa+y7wcnQAlmyNFg=
X-Google-Smtp-Source: ABdhPJyFp8TvQUVcuStHf1Eo5w5JmOWWP06uZ3rsXyQsJZBYt7i+K3T9/mRKmNFWsaOg+B1oG/Sy/A==
X-Received: by 2002:a05:651c:1582:: with SMTP id h2mr3951769ljq.372.1629216681831;
        Tue, 17 Aug 2021 09:11:21 -0700 (PDT)
Received: from [192.168.2.145] (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.googlemail.com with ESMTPSA id n17sm227055lfu.201.2021.08.17.09.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 09:11:21 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] partitions/efi: Support NVIDIA Tegra devices
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
        Ion Agorria <AG0RRIA@yahoo.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>
References: <20210817013643.13061-1-digetx@gmail.com>
 <20210817013643.13061-4-digetx@gmail.com> <YRs+dx1E72/R4Ael@infradead.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9885e8de-7d38-380c-a107-4b94f40df24c@gmail.com>
Date:   Tue, 17 Aug 2021 19:11:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRs+dx1E72/R4Ael@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

17.08.2021 07:43, Christoph Hellwig пишет:
> Just curious, why not add a new block_device_operations member
> 'alternative_gpt_sector', then move all the code calculating it to
> the mmc layer?
> 

That will work too.
