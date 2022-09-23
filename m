Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18A05E7EC0
	for <lists+linux-efi@lfdr.de>; Fri, 23 Sep 2022 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiIWPoR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 23 Sep 2022 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiIWPnc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 23 Sep 2022 11:43:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091C013E7CC;
        Fri, 23 Sep 2022 08:43:27 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FA021EC0628;
        Fri, 23 Sep 2022 17:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663947802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/f25GBB1zWD1jyTjH2zd7owsfk647Q32TDHnzD33NxA=;
        b=oZYsrJcIvKm9jgHKZDPp/7ACfM7QyDXNJRWZRh8GBGTBGCq7iYGNZVHfrZToyFTxo+ztv8
        hdD9mP3BzeB2gw9JofroVumUaUSrfwgGsabJEQ0iOctGH/BvGsm2LPMwCVToonY+x+IFxO
        gxOz0qUyVYULW8a6T+2ZkxR2MCVvn8c=
Date:   Fri, 23 Sep 2022 17:43:22 +0200
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
Message-ID: <Yy3UGgW3RWXcxr4w@zn.tnic>
References: <20220912144005.212624-1-justin.he@arm.com>
 <20220912144005.212624-6-justin.he@arm.com>
 <Yyn2zYLP9So0heBW@zn.tnic>
 <DBBPR08MB4538F21BA01114A0D30485E0F74E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DBBPR08MB4538F21BA01114A0D30485E0F74E9@DBBPR08MB4538.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 22, 2022 at 08:26:16AM +0000, Justin He wrote:
> If there is no ghes_present flag.
> What if ghes.disable is passed to kernel boot parameter and then ghes_edac is
> loaded by modprobe?
> Thus, ghes_edac can be loaded even if ghes is disabled. (ghes_dev list is null)

Yes, and what happens if ghes_dev is NULL?

The other drivers would do in their init function:

	struct list_head *ghes_devs;

	ghes_devs = ghes_get_devices();
	if (ghes_devs)
		return -ENODEV;

	/* Continue init */

and then load in that case because user has disabled GHES and thus no
ghes_edac either. So the platform-specific one loads.

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
