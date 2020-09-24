Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADBB277807
	for <lists+linux-efi@lfdr.de>; Thu, 24 Sep 2020 19:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIXRud (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXRuc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 13:50:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA809C0613CE;
        Thu, 24 Sep 2020 10:50:32 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c950018c19313925c730a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9500:18c1:9313:925c:730a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2067F1EC032C;
        Thu, 24 Sep 2020 19:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600969831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jfRzOGxtZvjYf5N7iGsgF7Urgvx5Y3pGCuZvz+8Q08g=;
        b=fJQrWWBxWiTJFxYjQsiJTA0UTQ/IXImt1eu0XyQf2ZG3rCByXxu+0aHFUwX6chYSD8LHjm
        4FOKL0nUOJPCgbvpVCJSMXElbiXyD8lymAvjxl/GnWEePzZWZ2WTgSCTo9gPlIQCEXxYPV
        oVSyuPywWRjrUQiqdxdMs7p3RPSgpI4=
Date:   Thu, 24 Sep 2020 19:50:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200924175023.GN5030@zn.tnic>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
 <20200923140512.GJ28545@zn.tnic>
 <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
 <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Sep 24, 2020 at 12:23:27PM -0500, Smita Koralahalli Channabasappa wrote:
> > Even though it's not defined in the UEFI spec, it doesn't mean a
> > structure definition cannot be created.

Created for what? That structure better have a big fat comment above it, what
firmware generates its layout.

> > After all, the patch is relying on some guarantee of the meaning of
> > the values and their ordering.

AFAICT, this looks like an ad-hoc definition and the moment they change
it in some future revision, that struct of yours becomes invalid so we'd
need to add another one.

> > If the patch is relying on the definitions in the SMCA spec it is a good

Yes, what SMCA spec is that?

> > idea to reference it here - both for review and providing relevant
> > context for future developers.
> 
> Okay, I agree the structure definition will make the code less arbitrary
> and provides relevant context compared to pointer arithmetic. I did not
> think this way. I can try this out if no objections.

Again, this struct better have "versioning" info because the moment your
fw people change it in some future platform, this code needs touching
again.

It probably would need touching even with the offsets if those offsets
change but at least not having it adhere to some slow-moving spec is
probably easier in case they wanna add/change fields.

So Smita, you probably should talk to fw people about how stable that
layout at ctx_info + 1 is going to be wrt future platforms so that
we make sure we only access the correct offsets, now and on future
platforms.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
