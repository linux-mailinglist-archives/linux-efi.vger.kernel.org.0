Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C189E635AE1
	for <lists+linux-efi@lfdr.de>; Wed, 23 Nov 2022 12:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbiKWK7m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Nov 2022 05:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237222AbiKWK7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Nov 2022 05:59:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BBA17ABC;
        Wed, 23 Nov 2022 02:52:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB784B81F03;
        Wed, 23 Nov 2022 10:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C7AC433C1;
        Wed, 23 Nov 2022 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669200765;
        bh=WCuZfrHfJi8JZnk4DYCT3piFu5GW3N8kXKAvJ0v7b7M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F43AtqmBGvByBl+jmywNCIWicC6I3TG7EnMvVna41n2ksHWcp6tVyNfnd7BLqSboW
         95tjUigoidk9Dnl45Xiu9IyKaO2C5XzmNbCoCtM/ghk8UIeQSopmprAi4Tl3GdcrrJ
         gQ2VBCWsLF2ltqAEz+usgQkyBZPVnw01Uh4U1L1TLtOeYljX8PT/zY/lnF/L+ElRMd
         F3T//wZHd+IOtB3Ol50xrzml2bOFX0M14shp+uiezrTrJ1DcmGSYQYjK0AylChznDI
         vR1Jjc70hQTYsr+/V/ZW3uFvNeNo21fi5i/arqEC/F+b/fUwYm3O8ZcjG+7MxdcKE9
         SCcfa1wN9HS4g==
Received: by mail-lj1-f172.google.com with SMTP id k19so20951904lji.2;
        Wed, 23 Nov 2022 02:52:45 -0800 (PST)
X-Gm-Message-State: ANoB5pn+BLWuY8Vh9m1yt/bkkXQ4QAcuR1Eu2ISbPCB/3SvVimCyFGCN
        aG8xHOLMpxY+Tz4V4rGYJlRZvmYK6zXDZkYLHvc=
X-Google-Smtp-Source: AA0mqf6ZW8M9k6cDLMjOHMAyA2B6Hh1zEf/ZUPDOQiE7lueFxBEHmcr0fCg7ThtrS0cEJL+5dKPAUcBrP9iarqFA8AU=
X-Received: by 2002:a05:651c:220a:b0:277:2428:3682 with SMTP id
 y10-20020a05651c220a00b0027724283682mr9482830ljq.291.1669200763666; Wed, 23
 Nov 2022 02:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20221122161017.2426828-1-ardb@kernel.org> <5750d157-43dd-6f3d-1407-f41af3cff207@amd.com>
 <CAMj1kXHUQFAcRKzRkuGG3Rsyrexdi7_NUS1-aXrS36LP4Q=rxw@mail.gmail.com>
 <26c34f9e-3b09-7b10-09a2-993a50790447@amd.com> <Y336yE4P3NjCGavN@zn.tnic>
In-Reply-To: <Y336yE4P3NjCGavN@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Nov 2022 11:52:32 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
Message-ID: <CAMj1kXGnGz+V3tmonitY+3TiWuWJFWj-mQLUbRo+xp8UwZ_SpQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] x86: head_64.S spring cleaning
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Nov 2022 at 11:49, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Nov 22, 2022 at 03:49:29PM -0600, Tom Lendacky wrote:
> > diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
> > index cb5f0befee57..a0bfd31358ba 100644
> > --- a/drivers/firmware/efi/libstub/x86-stub.c
> > +++ b/drivers/firmware/efi/libstub/x86-stub.c
> > @@ -23,7 +23,7 @@
> >  const efi_system_table_t *efi_system_table;
> >  const efi_dxe_services_table_t *efi_dxe_table;
> > -u32 image_offset;
> > +u32 image_offset __section(".data");
> >  static efi_loaded_image_t *image = NULL;
> >  static efi_status_t
> >
> > I assume it has to do with being in .data vs .bss and not being explicitly
> > cleared with the encryption bit set. With the change to put image_offset in
> > the .data section, it is read as zero, where as when it was in the .bss
> > section it was reading "ciphertext".
>
> Hmm, two points about this:
>
> 1. Can we do
>
> u32 image_offset __bss_decrypted;
>
> here instead? We have this special section just for that fun and it
> self-documents this way.
>

The patch moves it from .data to .bss inadvertently, and I am not
convinced Tom's analysis is entirely accurate: we may simply have
garbage in image_offset if we access it before .bss gets cleared.

> 2. Also, why does my SEV-ES guest boot just fine without that change?
>

Indeed, so it needs to be in .data


> [    0.000000] Linux version 6.1.0-rc6+ (root@ml) (gcc (Debian 11.3.0-1) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT_DYNAMIC Wed Nov 23 11:27:17 CET 2022
> ...
> [    0.336132] Memory Encryption Features active: AMD SEV SEV-ES
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
