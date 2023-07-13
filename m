Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A1C752D0A
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jul 2023 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGMWcS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jul 2023 18:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMWcQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jul 2023 18:32:16 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D41BF4;
        Thu, 13 Jul 2023 15:32:14 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-57045429f76so11257417b3.0;
        Thu, 13 Jul 2023 15:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689287534; x=1691879534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4pFHcAmk3Q1iQB/Gu74tpxcYopN6NbzrtwMYxLVtjk=;
        b=GxgxqyFoeVMPukKMlCOYNOd3Q3ZykRSxpaz1HGiVD/QmAeJfVJ3U5v2Aam2aDUhji8
         E7x8h6dgaW4zEERl8eYSkVURZVdVHbMkPkqCNGtZHkOt9G3NIWd2PGoRkwbym5jIFaaa
         VbWY4wE3VxZ2Kt6JCccF+Iu2ROawhzonoASCCa7DU5BujBKK4phopBul2JQmzOer+eQ+
         0PTPoyj72qBQn2PSlTzddZMOSlec1rOXyS3Zas7WgDt+k7jY5q03A3YWdnSVmRNI15sZ
         ujbWBXoHi4Cw6i+tJOGsmjDJS/0Tqax8xjty7RKsN94zkyu+HAV/YY11mSHTbbWp4zxb
         5awQ==
X-Gm-Message-State: ABy/qLY9sJBwQHe9/NjUdjbGHMmNuHv7ti3qQvXKoI56zueZ4/uXNYqR
        wE++7cVD/0crkZPBNb7+bhPai7naRGhUlg==
X-Google-Smtp-Source: APBJJlE7nUKiH2iKpr9aw4qrJ3In7/9iBkjTKwsYu42iSr6JBinp7Kst6hJ2+YVy/Gjnpq46ap+xlw==
X-Received: by 2002:a0d:c986:0:b0:561:d1ef:3723 with SMTP id l128-20020a0dc986000000b00561d1ef3723mr3219403ywd.38.1689287533596;
        Thu, 13 Jul 2023 15:32:13 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id r186-20020a8181c3000000b0056d3d7a59cesm1998668ywf.12.2023.07.13.15.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 15:32:12 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-57045429f76so11257237b3.0;
        Thu, 13 Jul 2023 15:32:11 -0700 (PDT)
X-Received: by 2002:a81:6908:0:b0:56c:fce5:ac2d with SMTP id
 e8-20020a816908000000b0056cfce5ac2dmr3235554ywc.39.1689287531751; Thu, 13 Jul
 2023 15:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home>
In-Reply-To: <ZLABozIRVGmwuIBf@gambale.home>
From:   Luca Boccassi <bluca@debian.org>
Date:   Thu, 13 Jul 2023 23:31:59 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
Message-ID: <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 13 Jul 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (add linux-efi@ cc)
>
> On Thu, Jul 13, 2023 at 03:33:38PM +0200, Ard Biesheuvel wrote:
> > Hello Emanuele,
> >
> > Please cc the linux-efi@ mailing list and myself on EFI related patches.
> >
> > First of all, I think the tone of the discussion is way out of hand on
> > both sides of the debate. Please keep it civil and courteous.
> >
> > On Tue, Jul 11, 2023 at 11:44:49AM -0400, Emanuele Giuseppe Esposito wrote:
> > > *Important*: this is just an RFC, as I am not expert in this area and
> > > I don't know what's the best way to achieve this.
> > >
> > > v2:
> > > * add standard "sbat,1,SBAT Version,..." header string
> > >
> > > The aim of this patch is to add a .sbat section to the linux binary
> > > (https://github.com/rhboot/shim/blob/main/SBAT.md).
> > > We mainly need SBAT in UKIs (Unified Kernel Images), as we might want
> > > to revoke authorizations to specific signed PEs that were initially
> > > considered as trusted. The reason might be for example a security issue
> > > related to a specific linux release.
> > >
> > > A .sbat is simply a section containing a string with the component name
> > > and a version number. This version number is compared with the value in
> > > OVMF_VARS, and if it's less than the variable, the binary is not trusted,
> > > even if it is correctly signed.
> > >
> >
> > Most people will not known what OVMF_VARS is or a PE.
> >
> > Also, 'version number' is a bit vague, better to stick with existing
> > terminology that makes this more self explanatory: the component that
> > authenticates the kernel image keeps a revocation counter, and refuses
> > to load authentic images whose revocation index is lower than the
> > revocation counter. This approach removes the need for revoking
> > individual image hashes or having to rotate the signing keys when a
> > vulnerability is discovered.
> >
> > The argument that we need this in the upstream kernel seems to be
> > predicated on the assumption that there is one universal signing
> > authority and revocation domain, but this is not necessarily true. Even
> > if the distros appear to have decided that it is a reasonable choice to
> > deploy the MicroSoft signed shim and the associated components on other
> > systems than Windows-crippled x86 PCs, this is not universally true, and
> > UEFI secure boot can be (and is) deployed in sane ways as well.
> >
>
> Note that by Windows-crippled, I mean x86 PCs built by OEMs who care
> about nothing other than the Windows logo sticker. These PCs often don't
> allow secure boot keys to be modified by the owner of the machine, or
> secure boot to be disabled at all. This is why shim exists, not because
> UEFI secure boot is broken by design.

AFAIK that's not only against the spec but also the logo
certification, which x86 OEMs are doing that and in which models?
Happy to flag that and inquire.
