Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C16F7CDB54
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjJRMLM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjJRMLL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 08:11:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7539598
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:11:09 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41b19dda4c6so198621cf.1
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697631068; x=1698235868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IB7mg1X3QPTPBiqjBX/zFOTiVkpsTx0EKkHhQADNBaM=;
        b=4ttcKnKwNWIV2AL5irXHc257QJFqHJc9l5E+gvJ+AzbsCUfRFBn0xAqryFUDtTASdY
         j2OiHinizmmQIXxhbChhz50zf5NVCad1zFcJYr3hCl+MNXZ+OJOnprc3A3/WQiEjSqYk
         fctIqjQ5FZFLeMMEaZZA/34CLM0IQaQDj8L9YxoB/QYCE4nnPPflbVPbhEVePVG16jWY
         raiWgiLPGQsKDpAvodUjZg2Vx4+bwA00VktjiEvbIx77OO5Q88g92AMS3YJkvPpl/b1F
         IwPtu0hWvAVmHuxqqTE+q75sRJ1q25ukCjX8QJHPQr/MtcglZgZbh2MDBJ7RrMCn7MvJ
         9Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697631068; x=1698235868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB7mg1X3QPTPBiqjBX/zFOTiVkpsTx0EKkHhQADNBaM=;
        b=LVaDNY4idBpzpbLNI/SmbN5KGJA1TyostoHzbmoSUTlfIcl2Ap/eSIxLqXLji+Xfh2
         Jvuf+MfZlIOAUsn9MS9w20Ofk9CbvAlkXvKSecmG1ZolJtZzKXUOmfGcOOrjBQ51l6do
         K+HILfwIKVaG1pxIcwoqlf+sMSuj+4rN7hTN0PumsYfWaex9uXLu0np10WfHAaxKqVKs
         k+H0QChzMLPbUCX5DBXDPC5tvscG2a8K6gycBJVTdd81/ixdoqQdRRTKxzYeXNz+Tv1x
         JVZ/eUnt0aszryE2MLK4UE/tmjRfx8PrCfmpQXn6XtbXOSZWS1/RT+ZoeFHRq677ok2b
         0kPg==
X-Gm-Message-State: AOJu0YyrzbFpHGvpXBJYvDUIW0U58qy0av2Ak01ICc9PlIIK0rLiLJTQ
        Zi5RoscMt9m89bzzvALm61ljnapiICA+A8U/9hhYuxqdvnLTd80yAoEoPA==
X-Google-Smtp-Source: AGHT+IE/cPpXA8NU2IvEzA8PFZB6n0J6EcLrGSvF6456YJxdCIbt1PHYsJRjz2cBRnRR9BMcdZOLO0tWeFbufSEEj4U=
X-Received: by 2002:a05:622a:6a8f:b0:41c:bfd9:b990 with SMTP id
 ih15-20020a05622a6a8f00b0041cbfd9b990mr77941qtb.17.1697631068271; Wed, 18 Oct
 2023 05:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231017132510.3845531-4-ardb@google.com> <ZS+rmaT2SAGdBxat@gmail.com>
In-Reply-To: <ZS+rmaT2SAGdBxat@gmail.com>
From:   Ard Biesheuvel <ardb@google.com>
Date:   Wed, 18 Oct 2023 14:10:56 +0200
Message-ID: <CAGnOC3YBN06Y5HkxLXcoWFMaS7hDFP=4Ug_p2qee9CD++a0Bgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/boot: Fix boot_params init in EFI stub
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 18, 2023 at 11:55=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Ard Biesheuvel <ardb@google.com> wrote:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > v2:
> > add separate patch to rename the decompressor's version of the
> > boot_params global variable
> >
> > Ard Biesheuvel (2):
> >   x86/boot: Rename conflicting boot_params pointer to boot_params_p
> >   x86/boot: efistub: Assign global boot_params variable
> >
> >  arch/x86/boot/compressed/acpi.c         | 14 +++++------
> >  arch/x86/boot/compressed/cmdline.c      |  4 +--
> >  arch/x86/boot/compressed/ident_map_64.c |  7 +++---
> >  arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
> >  arch/x86/boot/compressed/mem.c          |  6 ++---
> >  arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
> >  arch/x86/boot/compressed/misc.h         |  1 -
> >  arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
> >  arch/x86/boot/compressed/sev.c          |  2 +-
> >  arch/x86/include/asm/boot.h             |  2 ++
> >  drivers/firmware/efi/libstub/x86-stub.c |  2 ++
> >  11 files changed, 50 insertions(+), 47 deletions(-)
>
> Thanks!
>
> I renamed 'boot_params_p' to 'boot_params_ptr' for clarity - fortunately
> haven't run out of 't' and 'r' letters yet in the kernel.
>

OK thanks.

I noticed you queued this up for v6.7.
So what should we do for v6.6 wrt the second patch?
