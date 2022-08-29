Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89B5A55B3
	for <lists+linux-efi@lfdr.de>; Mon, 29 Aug 2022 22:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2Uj0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Aug 2022 16:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2UjZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Aug 2022 16:39:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E69923F4;
        Mon, 29 Aug 2022 13:39:24 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50A9E1EC01D4;
        Mon, 29 Aug 2022 22:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661805559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=crGRNr6fFKkrhokxbop0wrvY2dC/zvoi9jya+3ZhLN4=;
        b=fNrFlFmcncZr9VhC1Hyr++19lF8xXPkCzfjmJ2TXYyfslHSSbClD4qFI5qP6TbNV4yDtY2
        6OQ/2S6w7ZWOw2J4CdB7VW46bvORIOv5W5uuQNLBMporKYT3/aXV6av0UCqE4Fjoy0Yq/M
        oYPrBFB9Q73eylWY6uKeu+Vwn2snZcg=
Date:   Mon, 29 Aug 2022 22:39:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     Jia He <justin.he@arm.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jan Luebbe <jlu@pengutronix.de>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [RESEND PATCH v3 3/9] EDAC/ghes: Make ghes_edac a proper module
 to remove the dependency on ghes
Message-ID: <Yw0j+5tSZXGW0gDy@nazgul.tnic>
References: <20220822154048.188253-1-justin.he@arm.com>
 <20220822154048.188253-4-justin.he@arm.com>
 <MW5PR84MB1842F7107770654C46CB0311AB759@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <YwmqKPaYtgTS4xYT@zn.tnic>
 <YwziYFGWyEe2/kIp@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwziYFGWyEe2/kIp@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 29, 2022 at 03:59:28PM +0000, Yazen Ghannam wrote:
> GHES can be used for more than just memory errors. There are platforms where
> memory errors are handled through the OS MCA, and PCIe AER errors are handled
> through the FW, for example.
> 
> Is the HPE Server platform guaranteed to always provide memory errors through
> GHES regardless of CPU vendor/architecture?

/me looks in the direction of HPE folks...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
