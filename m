Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFB560D3AC
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiJYSis (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 14:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbiJYSir (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 14:38:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267F2F5CE5;
        Tue, 25 Oct 2022 11:38:46 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B1F4E1EC0567;
        Tue, 25 Oct 2022 20:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666723124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nA75nT1HVy6oCtTRTITzmGuFve7GrNdysF1oI7kQQeo=;
        b=n7bpE556AscLRc8okAYTjgPFaSC/y6BdipKGHY2L4KCj/I2dg21cMwM7nJigZ/t5Tu7KI7
        jrjNTUkFjdMS5Ku+P75mTqezEG5PcNEsNsr/G5MM+A+HOjzv7aGlV1gXez8DO2pEGJgEAe
        HIZtpOPAHdg10efgs9QukMI2F6nDZLY=
Date:   Tue, 25 Oct 2022 20:38:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Jia He <justin.he@arm.com>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Kani Toshi <toshi.kani@hpe.com>,
        James Morse <james.morse@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org, Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] apei/ghes: Use xchg_release() for updating new cache
 slot instead of cmpxchg()
Message-ID: <Y1gtMIq0QgR3VTDb@zn.tnic>
References: <20221018082214.569504-1-justin.he@arm.com>
 <20221018082214.569504-7-justin.he@arm.com>
 <Y1OtRpLRwPPG/4Il@zn.tnic>
 <CAMj1kXFu36faTPoGSGPs9KhcKsoh_DE9X2rmwdenxaJwa3P_yw@mail.gmail.com>
 <Y1O/QN32d2AlzEiA@zn.tnic>
 <Y1ayrYZgLqjp7WOG@zn.tnic>
 <CAJZ5v0gvHZ7WwyC5F2y3NTEno8J-VLdAOp-JjohON7MNnbmt6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gvHZ7WwyC5F2y3NTEno8J-VLdAOp-JjohON7MNnbmt6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 25, 2022 at 08:28:37PM +0200, Rafael J. Wysocki wrote:
> I think I can take it.

Ok, I have it already in the EDAC branch which goes into linux-next but
I can zap it.

> Is this urgent or is it OK to queue it up for 6.2?

No, 6.2 is fine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
