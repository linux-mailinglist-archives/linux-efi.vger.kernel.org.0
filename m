Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD48753658
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jul 2023 11:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjGNJ0C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jul 2023 05:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjGNJ0B (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jul 2023 05:26:01 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456DC1FC9;
        Fri, 14 Jul 2023 02:26:00 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so1615038276.2;
        Fri, 14 Jul 2023 02:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326759; x=1691918759;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYNF9HcVfVcn/kw99SG+o7wE4m9+wPd9Q/o4Fey/z2s=;
        b=UwXpU0GZqGKJtfST0ZMHhvhO6Z54/JohLyqQPpsPo6nnN+d7G4sNzuAkWYvI922hJQ
         RUNyvmZQzv62EaSl7OhZ1oSMXq12ptf3693HQFRNte7KXMUaUl1U1LjRd4Ft2A4vmILn
         hNmkrIBclFkbm526ilBzoEKvGmhhnbtl5dpQoqZ78oXSOUN3ZVixleVe8j46+cSWprJu
         Cs3CuSqKtmZK95X3af4ijb+kKaGq7QHCeVDeDK18y1zaFXyqARELWN/t8B27MHICGNXm
         sXGt1Xno4UhIqoNmaDF0IwTnOigBhuZF6B0KvEdgGIj4yTTkdQeHl4mtFUxloAOt7/B0
         IPnQ==
X-Gm-Message-State: ABy/qLY7jKFo6S6JKi+U1MGMAHOIzREXaYk4zs+c/ixKLVQiMAozhIB6
        ZpGRntpXFd+m5v2y493PObjlXriKu5vd3g==
X-Google-Smtp-Source: APBJJlGLygW8PLxjDTguku0Fe/0ZkXz6bv2T3HKPVjbaPd7xjCxyW394RmS34jdEsR1VVaOguiz3Tg==
X-Received: by 2002:a81:8083:0:b0:576:93f1:d110 with SMTP id q125-20020a818083000000b0057693f1d110mr4368029ywf.14.1689326759340;
        Fri, 14 Jul 2023 02:25:59 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id i65-20020a819144000000b0057072e7fa77sm2211534ywg.95.2023.07.14.02.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:25:58 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-56fff21c2ebso15714697b3.3;
        Fri, 14 Jul 2023 02:25:58 -0700 (PDT)
X-Received: by 2002:a0d:e981:0:b0:56f:e7b0:1753 with SMTP id
 s123-20020a0de981000000b0056fe7b01753mr4066372ywe.17.1689326757805; Fri, 14
 Jul 2023 02:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
 <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
In-Reply-To: <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
From:   Luca Boccassi <bluca@debian.org>
Date:   Fri, 14 Jul 2023 10:25:45 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnRtLSQ38csrOU1aSjq2JoE4up5i5KciONJcS_T8ggB3LA@mail.gmail.com>
Message-ID: <CAMw=ZnRtLSQ38csrOU1aSjq2JoE4up5i5KciONJcS_T8ggB3LA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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

On Fri, 14 Jul 2023 at 09:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> (cc Peter and Matthew)
>
> On Fri, 14 Jul 2023 at 00:32, Luca Boccassi <bluca@debian.org> wrote:
> >
> > On Thu, 13 Jul 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > >
> > > Note that by Windows-crippled, I mean x86 PCs built by OEMs who care
> > > about nothing other than the Windows logo sticker. These PCs often don't
> > > allow secure boot keys to be modified by the owner of the machine, or
> > > secure boot to be disabled at all. This is why shim exists, not because
> > > UEFI secure boot is broken by design.
> >
> > AFAIK that's not only against the spec but also the logo
> > certification, which x86 OEMs are doing that and in which models?
> > Happy to flag that and inquire.
>
> Thanks. My Yoga C630 Snapdragon laptop definitely does not allow me to
> update the keys from the UI, but it does allow me to disable secure
> boot. It might work with SetVariable() directly but I've never tried.

That's not an x86 machine though? For Arm IIRC the logo certification
requirement was more lax there (or more locked down, depending on your
point of view), at least in the past. I am not sure what is the
current state.
