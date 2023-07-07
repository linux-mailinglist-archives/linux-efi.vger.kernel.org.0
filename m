Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04774AD75
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 10:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjGGI5j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGI5i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 04:57:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A01999;
        Fri,  7 Jul 2023 01:57:36 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0DE81EC0398;
        Fri,  7 Jul 2023 10:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688720254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GbkfdLxp9rbQ7AZmN6x307z1tOVXWnNsYY4HWTwrins=;
        b=bTkZdCbdw2GZhc2GvXaNOtj9+aqKb+BrFtxh5mguwFfQVyldtHs3xPkfXBXEyPWnPMsBBz
        krJh3j19J4FhWVWTC/78jcP6RZEFmFxZDzbAUe2EPooxvvPighLbwwc/ZwfNpG6c/SzV34
        k0S3pzuXoHUiaU9n50wJcNBr3Faijfw=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aOrEHwDTfLF3; Fri,  7 Jul 2023 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688720252; bh=GbkfdLxp9rbQ7AZmN6x307z1tOVXWnNsYY4HWTwrins=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Btv9s/ge/XigqKznJFeyxJDvvCxC4amkdlU18+hJG8mAULOQBZOSRqivw1XrmKyrb
         ZIK5fB1JTWJa6Wq/T2GAMA/yPNoitAo2hmTRqYBfJ9iuQlGxWSBgtmDbsWVGVI7jEh
         NlSHetQxvPGZIhv6TWQ2LsyTkrASV9rgvAel4SukBGn+MVu0jBYxzl5o4cfPz58EfE
         /coHNKiPukC3mVE1VpLL1hKBBg4sblcXPOel7s1eu6NMpfvFcuC9V0JB/YweRQmLLw
         mgQgkbFV0qk62n2JCbxDLNnRndFm+D3eGh/QCJmml57u1mH7WVqR+1qbYBXEtlAFVW
         CV3kodEru/Pp0091eSlbo2oM4x5zmB2tvBjc6IihDnN+kuopSgQtaGVIfhdBG1RKle
         IKUL2cVH9Qjxbxhr+BoRKpfuad5wnKbckpQWIEvaPNf/BO7hyjVg6iE0BKKNQhH9i8
         FN1sVkoxdHHBAVXiJ/rP9QSYho7PXaV4HIry4epe3aPtnm75WRTf7dIPVd49TfM5oN
         Ga/dbgdFNlsmbveHNVbV2HLKsbuqvicDbjPZR6GRcOKNwn7VcYl6AWyRwLwKqKcZsx
         YptrBQUkg4V15kl89VPwKWSgbz589YddKW4e618ehFKgHNWUTKyc2rQbFKZbvmeTPo
         2BJwfVNXl0MPqeec3SK4laeY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 109AC40E0187;
        Fri,  7 Jul 2023 08:57:17 +0000 (UTC)
Date:   Fri, 7 Jul 2023 10:57:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>, michael.roth@amd.com
Cc:     Baoquan He <bhe@redhat.com>, Tao Liu <ltao@redhat.com>,
        thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKfLYG_4DANc_i5r@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 07, 2023 at 10:22:56AM +0200, Joerg Roedel wrote:
> On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> > I am wondering why we don't detect the cpu type and return early inside
> > sev_enable() if it's Intel cpu.
> > 
> > We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> > executed or not because we usually enable them all in distros.
> 
> Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> bit should already be set in sev_status. Maybe use that to detect
> whether SEV is enabled and bail out early?

There was something about getting the CPUID page on SNP *before*
actually calling CPUID but this is not the first time we had trouble in
this area. This needs to be done differently.

Michael?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
