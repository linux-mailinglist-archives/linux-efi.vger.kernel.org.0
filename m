Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9467535B4
	for <lists+linux-efi@lfdr.de>; Fri, 14 Jul 2023 10:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjGNIwh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 14 Jul 2023 04:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjGNIwg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 14 Jul 2023 04:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BD31FFC;
        Fri, 14 Jul 2023 01:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B618D61CAA;
        Fri, 14 Jul 2023 08:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D9BC43397;
        Fri, 14 Jul 2023 08:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689324754;
        bh=zSjLJFb39FNBSOh5wQyvDIfWzbGx5usUOhILzUK9hgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tz23xm0/NIzfbUxiApNIthA8Rcr9DIQ7TVF9IxLipiJb1+QiOh44dsMidIFkgDXCh
         kImpco0A227V59OzDVFOdwXayLJdMO6NXLzQgLlQBnVuGifGD4jw1aos2xA0dDJfaq
         HmSiivVZMfjF3usBlAhLVOrLyBSd/OB9tDpz8W5jIfVDqZVKMVS9fKPC9w7BwoVwdV
         qM8UY/UylCxQMn+Ub+gcRaxaDXpOLzqvUcMgdgQ/M0c1PZ5QtWZQnsoDlivt6JRZ93
         sDYgc3xVodvHfYigw/pspBEL87/l4GaNFWH8jU62bjZc+vDlCNLZISO31x7GFxOrpL
         HXwZCANd3xlKA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b703c900e3so24858461fa.1;
        Fri, 14 Jul 2023 01:52:34 -0700 (PDT)
X-Gm-Message-State: ABy/qLa85wLjV0CXrk1LHbeKgCXwIsrTKxtgdlaFLePJRUwczF6ecGOB
        Iwt2vrgl0PKmbzQjtx70UFibor90Qi1CgYQqj+E=
X-Google-Smtp-Source: APBJJlFEqHPtKKojrVgR815jlkZl11nKWRhLDK1jKEM81agbwtKiMMPmhZ5Nb8C6x/joRm/aVgcl/ga8lRPud1iVfdg=
X-Received: by 2002:a2e:9b15:0:b0:2b6:ec2b:659 with SMTP id
 u21-20020a2e9b15000000b002b6ec2b0659mr3473777lji.17.1689324752099; Fri, 14
 Jul 2023 01:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230711154449.1378385-1-eesposit@redhat.com> <ZK/9MlTh435FP5Ji@gambale.home>
 <ZLABozIRVGmwuIBf@gambale.home> <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
In-Reply-To: <CAMw=ZnSF_s-+74gURPpXCU+YSTeXDAYfVp_A9DOFoW7oL2T_Hw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Jul 2023 10:52:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
Message-ID: <CAMj1kXG1Sk1G=3PCRmiHZ24qPdUYiGRkSbq57u1-KUbyorX8Lg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
To:     Luca Boccassi <bluca@debian.org>, Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(cc Peter and Matthew)

On Fri, 14 Jul 2023 at 00:32, Luca Boccassi <bluca@debian.org> wrote:
>
> On Thu, 13 Jul 2023 at 14:52, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> >
> > Note that by Windows-crippled, I mean x86 PCs built by OEMs who care
> > about nothing other than the Windows logo sticker. These PCs often don't
> > allow secure boot keys to be modified by the owner of the machine, or
> > secure boot to be disabled at all. This is why shim exists, not because
> > UEFI secure boot is broken by design.
>
> AFAIK that's not only against the spec but also the logo
> certification, which x86 OEMs are doing that and in which models?
> Happy to flag that and inquire.

Thanks. My Yoga C630 Snapdragon laptop definitely does not allow me to
update the keys from the UI, but it does allow me to disable secure
boot. It might work with SetVariable() directly but I've never tried.

Maybe the OEMs have gotten better at this over the years, but it is
definitely not possible for the distros to rely on being able to get
their own cert into KEK and sign their builds directly.
