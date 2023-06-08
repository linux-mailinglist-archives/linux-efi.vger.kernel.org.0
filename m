Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20872774D
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 08:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjFHGfJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjFHGfI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 02:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E0A2729;
        Wed,  7 Jun 2023 23:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D74561778;
        Thu,  8 Jun 2023 06:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B204AC4339C;
        Thu,  8 Jun 2023 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686206091;
        bh=KmnT7XCroepgYF2ClTrdsM9kCCfAH8Cx9IUX06Rp8dY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HPH6KWOvotMpJFmOPUPARYZdqujdVs17hUfZ5y1WU7cI7o01TWJU/aDw9PTtVZshk
         YbEYn6AqSQ31+ZgKZHojSNb89rLrzuAPZ1lQaA1E7HoQRC4vgi04oAJTZLI4HGCSz6
         pqNLpNPS9fPop7F2BQ5KWWIkhBATkUx4jVMf8nUBGm0sW8ENYf7f+SX3c6x2+wcP8b
         WFOknlo0SOE8XsVPSCOYkEusTLNXRLqMjAR5mLXDl3gsE4hjCvJ1irOV9kgeHQYZYQ
         KwpV530KAliMLGD1129Jge1/1kLst49QWx+VsEp764N3EW6HXBnxLQrV4bLDL60Vw4
         i6aq4vEizuEEQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so346727e87.2;
        Wed, 07 Jun 2023 23:34:51 -0700 (PDT)
X-Gm-Message-State: AC+VfDwT8B6xc3HVsBVwIvrozd6a3XG1lCTCmXRhAFBXqkIlyBZBiJTL
        GGdY9CydvvYYYtkNHIUXkIPbjvDTeTnqq0GmDjY=
X-Google-Smtp-Source: ACHHUZ5IxcJ0qJ8x0nXQgm+sOdZUpmkmsa1Zw+qjUqw9LOzmasBq/2ch9saGZoGjcH8iT0W6yk3gJCg9hR/m35Og624=
X-Received: by 2002:a2e:855a:0:b0:2b0:2976:1726 with SMTP id
 u26-20020a2e855a000000b002b029761726mr3504404ljj.10.1686206089831; Wed, 07
 Jun 2023 23:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230607072342.4054036-1-ardb@kernel.org> <20230607072342.4054036-14-ardb@kernel.org>
 <20230607201924.GD3110@yjiang5-mobl.amr.corp.intel.com> <CAMj1kXE7nW6ED1CmCd-by5HC7oqFAZd4=-ky_Kx_g6Br28PNhQ@mail.gmail.com>
 <20230608004342.GA4340@yjiang5-mobl.amr.corp.intel.com>
In-Reply-To: <20230608004342.GA4340@yjiang5-mobl.amr.corp.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 08:34:38 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCAnNDFt+Ksex24PJj_rx5GcUsiS=S3OSZ6dw1HNOH3w@mail.gmail.com>
Message-ID: <CAMj1kXHCAnNDFt+Ksex24PJj_rx5GcUsiS=S3OSZ6dw1HNOH3w@mail.gmail.com>
Subject: Re: [PATCH v5 13/20] x86/efistub: Perform 4/5 level paging switch
 from the stub
To:     Yunhong Jiang <yunhong.jiang@linux.intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Jun 2023 at 02:43, Yunhong Jiang
<yunhong.jiang@linux.intel.com> wrote:
>
> On Wed, Jun 07, 2023 at 10:31:43PM +0200, Ard Biesheuvel wrote:
> > On Wed, 7 Jun 2023 at 22:19, Yunhong Jiang
> > <yunhong.jiang@linux.intel.com> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 09:23:35AM +0200, Ard Biesheuvel wrote:
...
> > > > +efi_status_t efi_setup_5level_paging(void)
> > > > +{
> > > > +     u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
> > > > +     efi_status_t status;
> > > > +     u8 *la57_code;
> > > > +
> > > > +     if (!efi_is_64bit())
> > > > +             return EFI_SUCCESS;
> > > > +
> > > > +     /* check for 5 level paging support */
> > > > +     if (native_cpuid_eax(0) < 7 ||
> > > > +         !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> > > > +             return EFI_SUCCESS;
> > > > +
> > > Do we need to check the need_toggle here instead of at efi_5level_switch and
> > > skip the whole setup if no need to switch the paging level? Sorry if I missed
> > > any point.
> > >
> >
> > No. There are reasons why firmware might run with 5 levels, and switch
> > to 4 levels at ExitBootServices() time.
>
> The need_toggle check at efi_5level_switch(), "need_toggle = want_la57 ^
> have_la57", should cover this scenario, right? If we check need_toggle on
> efi_setup_5level_paging() and it's false, then we don't need the setup in
> efi_setup_5level_paging(), right? I don't see the  la57_toggle() called on other
> places.
>
> Or I misunderstand your response?
>

The actual, current number of paging levels could be 5 during
efi_setup_5level_paging() and 4 during efi_5level_switch(). So whether
we need to toggle can only be decided at switch time, at which point
we can no longer allocate memory. So the allocation logic in
efi_setup_5level_paging() cannot depend on the actual number of
levels, only on whether or not 5 level paging is supported at all (in
which case a switch is never needed)
