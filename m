Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C77A36EE
	for <lists+linux-efi@lfdr.de>; Sun, 17 Sep 2023 19:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjIQRup (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Sep 2023 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjIQRuW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Sep 2023 13:50:22 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283FF4;
        Sun, 17 Sep 2023 10:50:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3214de9cd8bso313737f8f.2;
        Sun, 17 Sep 2023 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694973015; x=1695577815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GIu2xad4yPPJphEXscXACo8A+mc86HHOHMLqh4/KKH8=;
        b=FV9VP6AvlR/cdTC6cFs//boxHepvhHpGFqK5SwUQa1QJE5fT9fhYpJbnl5Mpw9YXIa
         1hEaVldBTrrqSBDwXNCpG2an5MciHYCcJCrESgw1AgncM/bOtEMR55P4/3eTxt0/EoLV
         h2qYEN0LWH+Pi5aEJ7bD1EwMhOmgrwYhOJjcakNu3TGpThEG6A5kSu59tZR29GqEsVej
         FC8s0v0OM88fXNXpjiN2+e14v+y4+N1wU8b4Z6ZmfO6hF7NKc0OxfYc6qepQPGkmSNmQ
         qb3xec+4r1B4cSwQSegJfRiv9ccStfJ+OnxFFvVYkwj9WCnOVdZsrEaZ+XEIdNrNz21A
         hrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694973015; x=1695577815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIu2xad4yPPJphEXscXACo8A+mc86HHOHMLqh4/KKH8=;
        b=bWveCq+ID13kJGLETYdjrS1c8Y4fc5gHzdqc7Vll0akSGDpS9XistPLvhncM6yuedm
         k6EuusJs9LGdVSgOs/bqjJcat5CmnuGxyrAQm9XeFYGrXoQ+rvX3/ckGQms1MwrLJu0X
         zKMnZgtz2ZUjZQ4fMEeKeJyxQMIKEPBxOLyawaEc+n5nc/7kgVceN4sjDokLi3yo8jBz
         elaIC1eJ+xhPqGlZ6CCYByzQJxCRceD/1EKxr/S8xgVn5tugRHXswmbCBUnTPRqp/F9H
         THvpDGEUqWHN5QrgPk8oX1LXa1BCkwVGhkkvxiRWZPj/LHk/oi8tvjFgaTCYt/JNFwC+
         dEhQ==
X-Gm-Message-State: AOJu0YxzVujdDxJg+dC+kMYPZijrOgqApLE38y7wNZDKX6ky5kQZ0cbU
        MXDC7CCqNRGtDqtkLWP/n1E=
X-Google-Smtp-Source: AGHT+IHJC9hvoUpHcGYXrYI3w63xwp8sbaCqCFf/9IqQF/EEqAnFvOV+jeN2U/Ycg/iL7Ok7nncyMw==
X-Received: by 2002:a5d:5188:0:b0:318:7bc:122e with SMTP id k8-20020a5d5188000000b0031807bc122emr6450169wrv.23.1694973015444;
        Sun, 17 Sep 2023 10:50:15 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d42c8000000b00317a04131c5sm3329267wrr.57.2023.09.17.10.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:50:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 17 Sep 2023 19:50:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ard Biesheuvel <ardb@google.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZQc8U36oL/NES6oo@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <ZQQiUxh5vmeZnp7s@gmail.com>
 <ZQRAckHVxQZRNEGA@gmail.com>
 <CAGnOC3Zw49_30FkGY=RRLn-sCHNgFY_T0ugNJZCgg_T3opHm+Q@mail.gmail.com>
 <CAMj1kXEVA5iL79HwXdYOAXAr0ZemS6repMRi9b20VSU=u0Ee=Q@mail.gmail.com>
 <ZQVxIIh1byq65lK/@gmail.com>
 <CAMj1kXH7b+TRajewcY0hzh_j0qMV+X9Nm2PNFftWTTEBp9xr5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH7b+TRajewcY0hzh_j0qMV+X9Nm2PNFftWTTEBp9xr5g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> On Sat, 16 Sept 2023 at 11:11, Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > > > So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage bootup,
> > > > > due to the 8th patch:
> > > > >
> > > > >   988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
> > > > >   commit 988b52b207a9fe74c3699bda8c2256714926b94b
> > > > >   Author: Ard Biesheuvel <ardb@kernel.org>
> > > > >   Date:   Tue Sep 12 09:01:01 2023 +0000
> > > > >
> > > > >       x86/boot: Define setup size in linker script
> > > > >
> > > > > I've removed it for now - but this side effect was not expected.
> > > > >
> > > >
> > > > No, definitely not expected. I tested various combinations of i386 /
> > > > x86_64 built with GCC / Clang doing EFI or BIOS boot.
> > > >
> > > > I'll rebase the remaining stuff onto -tip and see if I can reproduce this.
> > >
> > > This is actually quite bizarre. x86_64_defconfig has
> > > CONFIG_EFI_MIXED=y and i tested that this change produces the exact
> > > same bzImage binary in that case.
> > >
> > > Could you send me the .config and the QEMU command line perhaps?
> >
> > So the patch below is the delta between v2 and v3 - that is expected
> > to fix the bzImage boot crash, right?
> >
> 
> Yes.
> 
> ld.bfd does something unexpected [to me] here, and the resulting value
> turns out not to be a multiple of 512 at all.
> 
> With this tweak, my claim that this patch does not affect the binary
> bzImage at all actually holds for ld.bfd as well (provided that
> CONFIG_EFI_MIXED=y and CONFIG_LOCAL_VERSION_AUTO is disabled)

Ok - it boots & works fine for me too now, with the full series applied.

Thanks,

	Ingo
