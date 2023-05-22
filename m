Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3970BF2C
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjEVNHj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 09:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjEVNHi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 09:07:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6021103;
        Mon, 22 May 2023 06:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8253B622A6;
        Mon, 22 May 2023 13:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36D1C433B0;
        Mon, 22 May 2023 13:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684760849;
        bh=rLIjMH2epiWQ/3Lob2C6ObKYXvlX/q1x4S2igdYWzY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NE0oDkB2ESWTG0cYJwhI6j2f3UeG38SEQs/tuIfWrCD1HjzYSZ9k603k1rM2XMLxq
         N0kzsfuIZ1oRfAHeu2GS1QJDtNrX0YxVDorEsbX+OWOu8GIQda2R/9ht4PWy2ZwdTa
         Agos9U3owbngNVq2cRDABuAGLWd+MBx6U4xvWfI98FHZaCAzSE3MmyY5V/U14IPaxT
         jR50aLuqbBhzcSnUB1mreYNZiD12aw/Xht/VbAhJzBf7jZ+9CRXEvwfO9WKeHz1PkQ
         S5oPnVtOfweaSmE0eTeqROw5f0JwylNtQEYHavFvn/4qdQYuKmypybHEsfeCF1SQKd
         p41BDkaaMsGqA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af30a12e84so22904311fa.0;
        Mon, 22 May 2023 06:07:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDxTRcYEsbsDCtVStsSFJypKoDYOOCcGpJ4VegQnGPaaRGBlPBVE
        K2/c6+ylWVpf3wTTuYCf8njduF70eW46Tu5kf+0=
X-Google-Smtp-Source: ACHHUZ6jBYxtBJ20x3dyBOtcyxjudm9aRO6zY87opQnzHem7ZhhwocmcTdymNzAa8Vfg8tcvzjCvyCpHvYpmiJd+NSw=
X-Received: by 2002:a2e:8615:0:b0:2ad:b01b:d458 with SMTP id
 a21-20020a2e8615000000b002adb01bd458mr3813882lji.30.1684760847855; Mon, 22
 May 2023 06:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230508070330.582131-1-ardb@kernel.org> <20230508070330.582131-18-ardb@kernel.org>
 <ca76ed3b-5835-9f1b-7e10-dd417249b7bd@amd.com> <CAMj1kXE+7SKVZN3p2_NXg5VeH+hbwnqwaGTj6HLE1a89QGtraw@mail.gmail.com>
 <b6192de1-26a4-a7a7-63bf-76c36f55a8ff@amd.com> <ZGtkrKhxqUiTlXY0@suse.de>
In-Reply-To: <ZGtkrKhxqUiTlXY0@suse.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 15:07:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQ-hv8ZAtoFwqN9DYYjSnkXaaMrOuXsL5_92M3E6gdHQ@mail.gmail.com>
Message-ID: <CAMj1kXEQ-hv8ZAtoFwqN9DYYjSnkXaaMrOuXsL5_92M3E6gdHQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/20] x86: efistub: Check SEV/SNP support while
 running in the firmware
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Evgeniy Baskov <baskov@ispras.ru>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, 22 May 2023 at 14:48, Joerg Roedel <jroedel@suse.de> wrote:
>
> On Fri, May 19, 2023 at 09:04:46AM -0500, Tom Lendacky wrote:
> > Deferring the checks is probably the safest thing to do, since that would
> > match the way things are done today and known to work. I'm not sure what
> > other things might pop up if we stay with this approach, for example, page
> > state change calls using the GHCB MSR protocol that also don't save/restore
> > the MSR value.
> >
> > It is possible to audit these areas and stay with this approach, but I'm
> > wondering if that wouldn't be better done as a separate patch series.
> >
> > Adding @Joerg for any additional thoughts he might have around this area, too.
>
> If I got it correctly the patch actually moves two things before
> ExitBootServices:
>
>         1) SEV features check
>
>         2) SEV initialization
>
> I think it makes a lot of sense to have 1) before ExitBootServices. It
> allows to soft-fail in case the kernel does not support all required
> SEV-SNP features and move on to a kernel which does. This check also only
> needs the SEV_STATUS MSR and not any GHCB calls.
>
> The problem is the GHCB protocol negotiation with the HV, but the GHCB
> protocol is downward-compatible, so an older kernel can work with a
> newer HV.
>
> But 2) needs to stay after ExitBootServices, as it needs resources owned
> by UEFI, e.g. the GHCB MSR and potentially the configured GHCB itself.
> Fiddling around with the GHCB MSR while it is still owned by UEFI will
> bite us in one or the other way (e.g. UEFI, before ExitBootServices, is
> free to take IRQs with handlers that rely on the GHCB MSR content).
>

Thanks for the insight. Note that I have sent a v3 in the mean time
that moves all of this *after* ExitBootServices() [0], but I failed to
cc you - apologies.

So IIUC, we could just read sev_status much earlier just to perform
the SNP feature check, and fail the boot gracefully on a mismatch. And
the sev_enable() call needs to move after ExitBootServices(), right?

That would result in only very minor duplication, afaict. I'll have a
stab at implementing this for v4.

Thanks,




[0] https://lore.kernel.org/all/20230522071415.501717-21-ardb@kernel.org/
