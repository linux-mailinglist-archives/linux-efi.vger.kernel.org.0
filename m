Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064A7CDC10
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJRMlh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjJRMlf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 08:41:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB3189
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:31:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bda758748eso803039266b.2
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697632279; x=1698237079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35oAf6ZebjJj5UsJp3CbZRi/blCSZRB2shv4Ucouqyg=;
        b=eugBFDSCVdeeZFTuvxyzC+UwYK76k+X8VHErzqR2S2cXqXh3gp6kme9+CcFFEbinfd
         ddY7B2zkV6D9HQ04Me8fe1AAMFgvC3b0RrDL+7IlLI0H7koTCTZijvGBth1kTCPqnfUf
         GwEkLO6THjCqAvMzkQe57HiyZSUiGxe7oJzxS1mkUiyuPjoa/rAClEWOEZ14KE/cbKAU
         FT9OhHXzj0tQi99iu3c26EPHDhhi+GTtRc7flVoFE0EqxrVj0WISJ5h1dNP5mXzoQb1m
         NnpMUQfDzBhgqC2hlxLfoM4qmGn6dVOhuLuDWIAyW+hEPd7QwlolGh8l9ECbX5xduxH3
         mdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632279; x=1698237079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35oAf6ZebjJj5UsJp3CbZRi/blCSZRB2shv4Ucouqyg=;
        b=R4gvH/VqP+xwALqv510qBTWPXf6kxx/NbmpSBHO+dDDjN9iqDXNCt3OuQxry1wgggX
         OwXtJnzSWfqHBMB/zDQ+1+6ZV3sTVrwcQXgQETzp4TU4G3ltP0gcFjtQJbCtYY3Eqfbx
         YXwbA8B0ETFoOm1H12ne91Am1l9iF6wrYllnEwvHTPvik9MiZlcZWuo0G0CF+m+Yb0Yy
         7d6iCS64YkFR+sPy3cAf8nK1yQ3IjqhUjca0r4U2feM4janXgHMNydyfWCqQGTCL19xG
         4Bw2f0mjoXDwEAAiyH4vv2dPHZQ8rvh4X8KeOeOuREtk8OC5XbStNbW7ORdWTUnVMoD2
         mrEA==
X-Gm-Message-State: AOJu0YwQxjSIDQmsWoTHqydiVRtYHSarDaQ/OnHFkdMXpvNhur9CVS4E
        blvriI2neyxe0zsdRTkmiA5SEhI5cdw=
X-Google-Smtp-Source: AGHT+IFfAVmp6goKj5L2H8z1MvgAzLxSVJ1dZESbvBetV1gO+CV9yiBM6k9oZ7LzB2iUcmUf+9ZiuA==
X-Received: by 2002:a17:906:da87:b0:9be:6bf0:2f95 with SMTP id xh7-20020a170906da8700b009be6bf02f95mr4298412ejb.20.1697632278656;
        Wed, 18 Oct 2023 05:31:18 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id y4-20020a1709064b0400b009b947aacb4bsm1594151eju.191.2023.10.18.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:31:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 18 Oct 2023 14:31:16 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/2] x86/boot: Fix boot_params init in EFI stub
Message-ID: <ZS/QFF/afdftXiaU@gmail.com>
References: <20231017132510.3845531-4-ardb@google.com>
 <ZS+rmaT2SAGdBxat@gmail.com>
 <CAGnOC3YBN06Y5HkxLXcoWFMaS7hDFP=4Ug_p2qee9CD++a0Bgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGnOC3YBN06Y5HkxLXcoWFMaS7hDFP=4Ug_p2qee9CD++a0Bgw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@google.com> wrote:

> On Wed, Oct 18, 2023 at 11:55 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@google.com> wrote:
> >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > v2:
> > > add separate patch to rename the decompressor's version of the
> > > boot_params global variable
> > >
> > > Ard Biesheuvel (2):
> > >   x86/boot: Rename conflicting boot_params pointer to boot_params_p
> > >   x86/boot: efistub: Assign global boot_params variable
> > >
> > >  arch/x86/boot/compressed/acpi.c         | 14 +++++------
> > >  arch/x86/boot/compressed/cmdline.c      |  4 +--
> > >  arch/x86/boot/compressed/ident_map_64.c |  7 +++---
> > >  arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
> > >  arch/x86/boot/compressed/mem.c          |  6 ++---
> > >  arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
> > >  arch/x86/boot/compressed/misc.h         |  1 -
> > >  arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
> > >  arch/x86/boot/compressed/sev.c          |  2 +-
> > >  arch/x86/include/asm/boot.h             |  2 ++
> > >  drivers/firmware/efi/libstub/x86-stub.c |  2 ++
> > >  11 files changed, 50 insertions(+), 47 deletions(-)
> >
> > Thanks!
> >
> > I renamed 'boot_params_p' to 'boot_params_ptr' for clarity - fortunately
> > haven't run out of 't' and 'r' letters yet in the kernel.
> >
> 
> OK thanks.
> 
> I noticed you queued this up for v6.7.
> So what should we do for v6.6 wrt the second patch?

I presumed you'd queue it up in the EFI tree, and I'll merge it & resolve 
the conflict once it hits upstream?

Thanks,

	Ingo
