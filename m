Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC04127811C
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 09:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgIYHHL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgIYHHL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Sep 2020 03:07:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD2C0613CE;
        Fri, 25 Sep 2020 00:07:11 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00d3756fc4b2470eaa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:d375:6fc4:b247:eaa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F1EB01EC02F2;
        Fri, 25 Sep 2020 09:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601017629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/E6RdRBmvGwU0p8DLrUcOcaOIRZyj/g85rzHAgseeGw=;
        b=gtkBtGDT9r0KQPIOddpeLR/7oNdnDeOHwHJ7sDH/I4mF+M/nY+L2+hyBbaviY5MEo2cKX8
        8rDdJak7QiRepLyMQUuxd2apwfIozXvpKykayJULYoHphJG3u0qH4EAwJ01DDV0Dnpz0As
        Kdm3YYrTFtjVYflkybQvBAWmqywG/Pg=
Date:   Fri, 25 Sep 2020 09:07:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
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
Message-ID: <20200925070707.GB16872@zn.tnic>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
 <20200923140512.GJ28545@zn.tnic>
 <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
 <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
 <20200924175023.GN5030@zn.tnic>
 <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 25, 2020 at 09:54:06AM +0900, Punit Agrawal wrote:
> Maybe I could've used a better choice of words - I meant to define a
> structure with meaningful member names to replace the *(ptr + i)
> accesses in the patch.

I know exactly what you mean - I had the same question during last
review.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
