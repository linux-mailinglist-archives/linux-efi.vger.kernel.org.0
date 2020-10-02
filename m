Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685C8281DBB
	for <lists+linux-efi@lfdr.de>; Fri,  2 Oct 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJBViS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Oct 2020 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBViR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Oct 2020 17:38:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D100FC0613D0
        for <linux-efi@vger.kernel.org>; Fri,  2 Oct 2020 14:38:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so2233114pfn.8
        for <linux-efi@vger.kernel.org>; Fri, 02 Oct 2020 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BkeyaNc379+rmFlMxKoqdtmCXLr04UwoNjZDGrW9WDQ=;
        b=lsQYj1LmYSATIcKw7t6GatdByUeYFi5qTGn4f786FZZeCAMKp7N1ihGZCBSlR1VWSM
         btHAOWptJmuBoCYFE4OqvK1a39O6Uk5TGn/Q4An6wKsPNWkijA4bNTPTURIeRgrbt7NY
         jLfNbrD4VUdNSslW+ZY6lP0urGwBuZU6dxbJo/PMRnnLDxL5+Nu8tQMje/CgGylP4odT
         DDX24g8Ij/oip1bsh+sqZJDWYOTugXsBPqLdRmVOCjnb2vV475HK48ybKMjncwNWKzIg
         zhgV3zLaW1yIh5TVzp+G65itIv3YB2oFDuGY+hfDre1caw1GjT9LCEx3nFtTCrQvlTqv
         7Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BkeyaNc379+rmFlMxKoqdtmCXLr04UwoNjZDGrW9WDQ=;
        b=Zd2CHmzDL2CKMe98ID4wd2WwLNqa52RoTYqm6DhK0p2BkEu8NYC3uvJ46hrmxxHpVW
         oU9zyojiA2EQgHodsasb9APAtuuctL5MpwD0eOt02Pjz0zRSS+gkJiiHdODMKfVKgb3K
         b27rRAL1NYyJvCqWgPLnimvfR3AfO7bCk6O6Fv67Y87q5kFVEGYYnPI5EUWhsqm2wieM
         VKcpLiDg9njtlCxoLIx1Um8QBKO3Ms6I9hhDDzmBtOkoOXCwxXdrwXPLskoiIDyLwic5
         I/BwtWsRUkTWhOLMmWvRkQwLK0nPHsCOgkgUZsEo49dwOdRVahIv9l0muL1TmTUnhXfW
         PIBw==
X-Gm-Message-State: AOAM531KfmTe1Xxr4NdS18M2v02fiS8EbMPPSO0lGLfbbAobjiR8h9Sz
        Bl7qYLZLpDxFD5O0zuQK3njLfg==
X-Google-Smtp-Source: ABdhPJw62mh5fmOWbiRdQymV1NGzb23R7SDPtopMC0852HpRC8jYwfUpY38HlP84dOHcD233rrlf3g==
X-Received: by 2002:a62:52ce:0:b029:13e:50c8:499b with SMTP id g197-20020a6252ce0000b029013e50c8499bmr4829715pfb.14.1601674697178;
        Fri, 02 Oct 2020 14:38:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n125sm3064404pfn.185.2020.10.02.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 14:38:16 -0700 (PDT)
Date:   Fri, 02 Oct 2020 14:38:16 -0700 (PDT)
X-Google-Original-Date: Fri, 02 Oct 2020 14:38:14 PDT (-0700)
Subject:     Re: [PATCH v8 0/7] Add UEFI support for RISC-V
In-Reply-To: <20200917223716.2300238-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        akpm@linux-foundation.org, Anup Patel <Anup.Patel@wdc.com>,
        ardb@kernel.org, nivedita@alum.mit.edu, bp@suse.de,
        greentime.hu@sifive.com, hca@linux.ibm.com, mingo@kernel.org,
        keescook@chromium.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        maxim.uvarov@linaro.org, michal.simek@xilinx.com, rppt@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-12da283b-ad4d-4a55-9196-ccd91ca08c8b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 17 Sep 2020 15:37:09 PDT (-0700), Atish Patra wrote:
> This series adds UEFI support for RISC-V.

Thanks, this is on for-next.
