Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC85987AC
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbiHRPmU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245389AbiHRPmT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 11:42:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6ECB81C1;
        Thu, 18 Aug 2022 08:42:16 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81A1B1EC0529;
        Thu, 18 Aug 2022 17:42:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660837331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xq97BbKXuhMjjyID6xy9W4YK5RoR7G8Hq8nOXVqA+LQ=;
        b=l6/j4H5N6zrC8x4ZRh1VW2ocqe5Sc0R2tIBooInTNUa7Oa1JddaPbOz6BFjpgLWxzDkfFE
        JEp7HsHY+x7x/aa1mQ5XgUoz1ai9U/447nRSdvnnooQ/DPwPG5C7VX95YDN6SaU26eDEdg
        U/mmwpuLIOAV0A1VkhBMPvStUmZlvgk=
Date:   Thu, 18 Aug 2022 17:42:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        toshi.kani@hpe.com, nd@arm.com
Subject: Re: [PATCH v2 2/7] EDAC/ghes: Add notifier to report ghes_edac mem
 error
Message-ID: <Yv5dzyiI1TPtAO5F@zn.tnic>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817143458.335938-3-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 17, 2022 at 02:34:53PM +0000, Jia He wrote:
> Subject: Re: [PATCH v2 2/7] EDAC/ghes: Add notifier to report ghes_edac mem error

Subject: ...: Add a notifier for reporting memory errors.

> To modularize ghes_edac driver, any ghes_edac codes should not be invoked

s/modularize/make a proper module/

and replace that everywhere.

There's no such thing as "codes" - please try to write proper English.

> in ghes. Add a notifier of registering the ghes_edac_report_mem_error() to
> resolve the build dependency.

"Add a notifier for reporting memory errors."

When you say "to resolve the build dependency" it sounds like this is
some kind of a nuisance. But it isn't one - it is simply an improvement.

> The atomic notifier is used because
> ghes_proc_in_irq() can be in the irq context.

"Use an atomic notifier because calls sites like ghes_proc_in_irq() run
in interrupt context."

> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/acpi/apei/ghes.c | 16 +++++++++++++++-
>  drivers/edac/ghes_edac.c | 19 +++++++++++++++++--
>  include/acpi/ghes.h      | 10 +++-------
>  3 files changed, 35 insertions(+), 10 deletions(-)

Patch itself looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
