Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02712278E66
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgIYQ1W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 25 Sep 2020 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgIYQ1U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 25 Sep 2020 12:27:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8BC0613CE;
        Fri, 25 Sep 2020 09:27:20 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b3a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4B211EC0284;
        Fri, 25 Sep 2020 18:27:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601051237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=K6sGbhgfxwnmQZIyH+ysWIaxNNdvcxJU0y9gu+E0hU8=;
        b=LdPUlJAHdtaj0hAkfJ5AyHey6VAvxuL4x2dzyh9ersdpijNhAv02QlF3LfYPKTyc4S5pXV
        xBM+5yc9c2xByJ9PV1/xOt21dIYqI8egHmlopbikT7gC0e5A8/YgpzZGQl2bXiHe+4xvtk
        djGnMJkcNpyqfuK0A0Ru5VY4mNgvGgQ=
Date:   Fri, 25 Sep 2020 18:27:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
Message-ID: <20200925162710.GK16872@zn.tnic>
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
 <20200923140512.GJ28545@zn.tnic>
 <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
 <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
 <20200924175023.GN5030@zn.tnic>
 <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
 <20200925161940.GA21194@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925161940.GA21194@yaz-nikka.amd.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 25, 2020 at 11:19:40AM -0500, Yazen Ghannam wrote:
> This patch is checking if an MSR context info structure lines up with
> the MCAX register space used on Scalable MCA systems. This register
> space is defined in the AMD Processor Programming Reference for various
> products. This is considered a hardware feature extension, so the
> existing register layout won't change though new registers may be added.

Yeah, and exactly for that there's no need to add a special structure
because if new registers get added, you'd need to add a new struct
definition too. Let's keep it simple and do the offsets thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
