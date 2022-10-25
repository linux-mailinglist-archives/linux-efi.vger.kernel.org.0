Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EE360CE77
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiJYOKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJYOKM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:10:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CBBDF6B;
        Tue, 25 Oct 2022 07:08:34 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C3C11EC06BD;
        Tue, 25 Oct 2022 16:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666706913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jc8a/OSsnYlaB3S1Nvjq3uClUaYYpKLD90hg9EtVTPg=;
        b=dNsHnIjdnHhC8+xUB97zasgFuOmSYMWY39W1wTEtyQctFCxqF7QDUUKixfu/4CcfLNMdSq
        pvCsskZxRpiBYEWK3OCLR4Cez0qzINVFnqBRP9REuCyAM8VPtJeHpbX8+Cd17qdC6vELCO
        BERkzd/7dBx7uKASQkGyGGay3hVKIHs=
Date:   Tue, 25 Oct 2022 16:08:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
        devel@acpica.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 0/7] Make ghes_edac a proper module
Message-ID: <Y1ft3KxOGXd7I6F9@zn.tnic>
References: <20221018082214.569504-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018082214.569504-1-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Oct 18, 2022 at 08:22:07AM +0000, Jia He wrote:
> Commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of HEST and GHES in
> apci_init()") introduced a bug that ghes_edac_register() would be invoked
> before edac_init(). Because at that time, the bus "edac" hasn't been even
> registered, this created sysfs /devices/mc0 instead of
> /sys/devices/system/edac/mc/mc0 on an Ampere eMag server.
> 
> The solution is to make ghes_edac a proper module.
> 
> Changelog:
> v10:

All queued, thanks for the effort.

It'll appear in Linux next soon.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
