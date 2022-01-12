Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21CD48BFC1
	for <lists+linux-efi@lfdr.de>; Wed, 12 Jan 2022 09:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351533AbiALIWM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Jan 2022 03:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351532AbiALIWM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Jan 2022 03:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A27C06173F;
        Wed, 12 Jan 2022 00:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88A88B81E16;
        Wed, 12 Jan 2022 08:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F482C36AF2;
        Wed, 12 Jan 2022 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641975729;
        bh=d1ftraH1O4GFl/RXb8fXChBLOCIhUwf/rKeBnWF2s8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q7waHOVUFhvNFQTXN+bEUvSp4H2G4AcvGNpeaKQUa/gMO1Juu0PBugZ/Y3aC+hGWF
         pqgozGmw694BBEMxKh0W+1/W1284dc47cQi5bl0hgizZD3tJSq1alw7x5LOusXDyq5
         +/RHBdTOt/G9YxoCWmS2dCTZJ4Kk0Vp/kC3o8Ucnw7ieXgzCVs8zMfD3mymKNJNyfK
         ANc/Mg8n6ZbCbSHvVG07wARdX5c5076eUvlM3II1FkJz56AmPhcD1SvEpmcr1V4vLG
         roJIfPm9iupAsBHPRnBGebU+a+f1qEauQ0BCgA+ehjlX9FCh9DbNym3TZVnakwpLeX
         oRG0MyK61POGQ==
Received: by mail-wm1-f44.google.com with SMTP id o203-20020a1ca5d4000000b003477d032384so1049621wme.2;
        Wed, 12 Jan 2022 00:22:09 -0800 (PST)
X-Gm-Message-State: AOAM533ccGGm1GEBv1jCG1NuqCNWlDAl4grqC0UHySR3FZ9R48c3+tZb
        6kllgrQWseg5js0Fx8qQoi4HQiyFxcLFwMc/tKc=
X-Google-Smtp-Source: ABdhPJwfVQHV8dCC/CGugsEkwv/3ZgZDt4Bim6g91t8GLh1Wwd2xBJTCtFfEx9qOP82LNIcRj3Cjqq8gpMbx43y4YjU=
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr5673757wmq.25.1641975727594;
 Wed, 12 Jan 2022 00:22:07 -0800 (PST)
MIME-Version: 1.0
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com> <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
 <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com> <787447CE-C7DC-4EA3-B498-6FEA88C523A1@live.com>
In-Reply-To: <787447CE-C7DC-4EA3-B498-6FEA88C523A1@live.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Jan 2022 09:21:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXExPTyxSaioSmwhz+bTYwLjQJQ5PHRJKY11cX9M71STSQ@mail.gmail.com>
Message-ID: <CAMj1kXExPTyxSaioSmwhz+bTYwLjQJQ5PHRJKY11cX9M71STSQ@mail.gmail.com>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 12 Jan 2022 at 07:23, Aditya Garg <gargaditya08@live.com> wrote:
>
> Hi Ard
> As I said before, if I apply the patch below, the things work well
> >
> > Can you check whether things work as before after applying the change below?
> >
> > diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> > index 147c30a81f15..d7203355cc69 100644
> > --- a/arch/x86/platform/efi/efi.c
> > +++ b/arch/x86/platform/efi/efi.c
> > @@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long phys)
> >                efi_nr_tables           = systab32->nr_tables;
> >        }
> >
> > -       efi.runtime_version = hdr->revision;
> > +       efi.runtime_version = EFI_1_10_SYSTEM_TABLE_REVISION;
> >
> >        efi_systab_report_header(hdr, efi_fw_vendor);
> >        early_memunmap(p, size);
>
> Now, I tried to quirk on the basis of DMI data for some t2 Macs using this patch :-
>

Hello Aditya,

This code runs far too early for DMI checks.

What we might do is just use EFI 1.10 for all Apple x86 EFI machines.

Please try the below:

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ae79c3300129..2303f9b06412 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -722,6 +722,13 @@ void __init efi_systab_report_header(const
efi_table_hdr_t *systab_hdr,
                systab_hdr->revision >> 16,
                systab_hdr->revision & 0xffff,
                vendor);
+
+       if (IS_ENABLED(CONFIG_X86_64) &&
+           systab_hdr->revision > EFI_1_10_SYSTEM_TABLE_REVISION &&
+           !strcmp(vendor, "Apple")) {
+               pr_info("Apple EFI Mac detected, using EFI v1.10
runtime services only\n");
+               efi.runtime_version = EFI_1_10_SYSTEM_TABLE_REVISION;
+       }
 }

 static __initdata char memory_type_name[][13] = {
