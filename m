Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E650C5A274C
	for <lists+linux-efi@lfdr.de>; Fri, 26 Aug 2022 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245365AbiHZMA3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 26 Aug 2022 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiHZMA0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 26 Aug 2022 08:00:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D08523BE2
        for <linux-efi@vger.kernel.org>; Fri, 26 Aug 2022 05:00:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id kk26so2693528ejc.11
        for <linux-efi@vger.kernel.org>; Fri, 26 Aug 2022 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=MxGGd+3msz7Zn8awEDtaAUBprmyOYrYaH1QuR+N4/7o=;
        b=Gpo7N7AFg7ypzz4ziWV5/xqGFn6VPSfepZxdPxvYxjBT44+e2TYfUynhvuN4bgXRS/
         Y1lMBDwSuSvsL4hGB4NVY0v3EWF3sT7n/bwVeuIOO0ODHJdT0/abtE6mRH2DymksTXXO
         r1ObcZJ+e7Ndu8lJcEp/bXAX2zEQ1GVh4vtmyJ2otqk5MeOeGigP0uXSnvUviUdyKMUb
         9msUNjrYLw+GCjpRbA06oyQANC2DsCXnYbXtaRvOYkeCMk/UHYKt4JhjPsqcwksrWypU
         p8o94YuVPtobGYa1F4jwdkuKvP6bhOSsOcBBEtFTo7INwdfxMTydzpLeyUkWamzDAgnB
         0w8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=MxGGd+3msz7Zn8awEDtaAUBprmyOYrYaH1QuR+N4/7o=;
        b=0PrbVqjmvVW5g907sg8yp0LcOH/og8PNTBhuunJdrF9LkM8FTb40QkcgSbLWCrLiM9
         FZf9QBKfn8Yax1ovY/y4PvL8aaQyBwiKogaPSnOuIk/DZzmIhZnJCi4e2hFy18C73SC/
         64+cVxMK71nbjmWHr/kl/HMR+kP3FccZAs8NhfUiwMr8LZu9mAQXPlnxpG0Sectb0Ek0
         JtB0TEAoZgJVPRa/IRq+mWSIOIjsg895IjNzJL3PGTS6Bkh8RM3TxB9lG9JOrS8DLQDR
         gRwLQrHlPxzvDOpF5lVhrVboINvIfv3B3l0+EzIEsg/1REXGCp7KOsrCOtChAzNBqRTw
         7FOA==
X-Gm-Message-State: ACgBeo1mVlFAJKEMsnHfrKXvDjPV0DrOJUDFotNYJkKx3U8G8kerlWqO
        //I1Aj9RQqdjcVePTEPRqDMNAw==
X-Google-Smtp-Source: AA6agR6pWzpqNgeu5nYDI5mFIoqg2F0SdV1dhlacTRMXfwMX4RTLBi/UMn/Zte3pGXH6yssBl9NJZA==
X-Received: by 2002:a17:907:6d2a:b0:73d:9ba5:633a with SMTP id sa42-20020a1709076d2a00b0073d9ba5633amr5386524ejc.201.1661515223724;
        Fri, 26 Aug 2022 05:00:23 -0700 (PDT)
Received: from mutt (c-e429e555.07-21-73746f28.bbcust.telenor.se. [85.229.41.228])
        by smtp.gmail.com with ESMTPSA id w20-20020a05640234d400b00447c2c1b9a0sm1164957edc.91.2022.08.26.05.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 05:00:22 -0700 (PDT)
Date:   Fri, 26 Aug 2022 14:00:20 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.bennee@linaro.org, arnd@arndb.de
Subject: Re: [PATCH V2] arm64/mm: Fix __enable_mmu() for new TGRAN range
 values
Message-ID: <20220826120020.GB520@mutt>
References: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1615355590-21102-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-03-10 11:23, Anshuman Khandual wrote:
> From: James Morse <james.morse@arm.com>
> 
> As per ARM ARM DDI 0487G.a, when FEAT_LPA2 is implemented, ID_AA64MMFR0_EL1
> might contain a range of values to describe supported translation granules
> (4K and 16K pages sizes in particular) instead of just enabled or disabled
> values. This changes __enable_mmu() function to handle complete acceptable
> range of values (depending on whether the field is signed or unsigned) now
> represented with ID_AA64MMFR0_TGRAN_SUPPORTED_[MIN..MAX] pair. While here,
> also fix similar situations in EFI stub and KVM as well.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-efi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Hi,

When building an arm64 defconfig kernel from stable/linux-5.10.y and
booting that in QEMU (version: 1:7.0+dfsg-2~bpo11+2) with '-cpu max' the
kernel doesn't boot. I don't get any output.  The kernel boots fine if I
change to '-cpu cortex-a72'.

If I cherry-pick this patch to stable/linux-5.10.y I'm able too boot the
kernel with '-cpu max'.

However, I'm not comfortable to backport this patch to older kernels
since there are a lot of conflicts.
Can someone help out to do the packport?

Cheers,
Anders
