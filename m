Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D521D6060E8
	for <lists+linux-efi@lfdr.de>; Thu, 20 Oct 2022 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJTNEd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Oct 2022 09:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiJTNEa (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Oct 2022 09:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208582D1EA
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 06:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A187619F4
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 13:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE8C433C1
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 13:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666271067;
        bh=fHlDFkcjDwdnCtGEQPR2VsaEMbbxq4aNbFzYuzHS3ys=;
        h=References:In-Reply-To:From:Date:Subject:Cc:From;
        b=Yni/Dohggc/oF6ge3TPb8kLC0A4edhH8dfKc3NZSRtCPsjnf0iC4LNCuBX7X0yPvI
         HwzZ0ZdQM/axCwy81cxCf6jjD9F3nYl79tfOx9YyfLjZFuEeOFwvkGL/8XCaeLBfOp
         PnoVjgfvHmg0sH/HCDiBkTNbOT3DtmhLZKuDf0JiXXlyI4bOrdpacR5acc+TkJ1Ueb
         bVNkerwkWSj3Njy5Z3LQP9y8XFQ5wskIOOWhzla0Snl2pNzP2FdpsUC28SypevIu1/
         gwiuUvTOGLw5ErSSJEOifw0d1Y7VuaULwDQ3+VuUfRtFrYzqQNn8ZRwjHzFWgD4srm
         JF0QDfO57jhng==
Received: by mail-lj1-f171.google.com with SMTP id c22so24941666lja.6
        for <linux-efi@vger.kernel.org>; Thu, 20 Oct 2022 06:04:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf1MWmtN+NNZ3Sv4VL7rs3SmIz+6j7MQDcEK7ECl1BGseosOHRAx
        QS47B6PVzvp5JBVDaf216Wcwkt8WdaLDentpBOg=
X-Received: by 2002:a05:651c:1590:b0:26c:4311:9b84 with SMTP id
 h16-20020a05651c159000b0026c43119b84mt3495158ljq.152.1666271065926; Thu, 20
 Oct 2022 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220916101843.495879-1-ardb@kernel.org> <56877644-8173-d2ed-ed00-7973734a3698@huawei.com>
 <9c06c75d-5079-dd27-6533-c053c986083e@leemhuis.info>
In-Reply-To: <9c06c75d-5079-dd27-6533-c053c986083e@leemhuis.info>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Oct 2022 15:04:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG=aE4yn-OvQdzRLE17BS=tGBySZ9DV0pHj9LN8onaerA@mail.gmail.com>
Message-ID: <CAMj1kXG=aE4yn-OvQdzRLE17BS=tGBySZ9DV0pHj9LN8onaerA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: arm64: avoid SetVirtualAddressMap() when possible
Cc:     Yicong Yang <yangyicong@huawei.com>, linux-efi@vger.kernel.org,
        yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, probinson@gmail.com, andersson@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> On 19.10.22 05:24, Yicong Yang wrote:
> >
> > After entering 6.1-rc1 the efi runtime services is not working on my platform:
> >
> > [    0.054039] Remapping and enabling EFI services.
> > [    0.054043] UEFI virtual mapping missing or invalid -- runtime services will not be available
> >
> > Not sure this patch is the root cause since I see some refactor of efi codes in 6.1-rc1,
> > but simply reverting this make EFI runtime services works again. Tested on HiSilicon's
> > Kunpeng 920 arm64 server using 48 bit VA address:
> >
> > CONFIG_ARM64_VA_BITS_48=y
> > CONFIG_ARM64_VA_BITS=48
> >
> > Thanks.

Hi,

Can you try the change below please?

+++ b/drivers/firmware/efi/arm-runtime.c
@@ -63,7 +63,7 @@ static bool __init efi_virtmap_init(void)

                if (!(md->attribute & EFI_MEMORY_RUNTIME))
                        continue;
-               if (md->virt_addr == 0)
+               if (md->virt_addr == 0 && md->phys_addr != 0)
                        return false;

                ret = efi_create_mapping(&efi_mm, md);
