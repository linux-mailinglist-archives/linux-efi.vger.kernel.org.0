Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C45EA40A
	for <lists+linux-efi@lfdr.de>; Mon, 26 Sep 2022 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiIZLjR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 26 Sep 2022 07:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238238AbiIZLij (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 26 Sep 2022 07:38:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6CF9FE9;
        Mon, 26 Sep 2022 03:44:39 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e74d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e74d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9EA6A1EC026E;
        Mon, 26 Sep 2022 12:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664188950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m2fPEgDDtO/IzEYfJYSHyFiKp7MZW9tUSDOcclgNSqo=;
        b=fvEAdNyrdr5y1LGU7YB3bri2Vxh4pEJoRLPQU2RmFqENN3NHDWCCF+PKj2pWWZb65pc2E9
        0lkZE1T6pkSamnMJ7fzDUQEdT2KWFW1szJ/IGdEvdL8hEfV1w884kgtDXkNJvuCmbMHeZ2
        2YWHHtizXmnyjUYjbJ95s309SLGHhVs=
Date:   Mon, 26 Sep 2022 12:42:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Justin He <Justin.He@arm.com>
Cc:     Len Brown <lenb@kernel.org>, James Morse <James.Morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH v6 5/8] EDAC/ghes: Make ghes_edac a proper module to
 remove the dependency on ghes
Message-ID: <YzGCEqLOtq4TgHK7@zn.tnic>
References: <20220912144005.212624-1-justin.he@arm.com>
 <20220912144005.212624-6-justin.he@arm.com>
 <Yyn2zYLP9So0heBW@zn.tnic>
 <DBBPR08MB4538F21BA01114A0D30485E0F74E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <Yy3UGgW3RWXcxr4w@zn.tnic>
 <DBBPR08MB45383B270676A17CEEC36E75F7539@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB45383B270676A17CEEC36E75F7539@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Sep 25, 2022 at 03:07:12PM +0000, Justin He wrote:
> Okay, I am fine with removing ghes_present and ghes_edac_preferred if
> It is ok to register empty ghes_dev list without prompting an error 

What "prompting an error"?

In that case, you simply return a NULL list which says that GHES hasn't
been initialized...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
