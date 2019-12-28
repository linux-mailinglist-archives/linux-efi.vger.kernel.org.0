Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 568DA12BD08
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 09:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfL1Ivy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 03:51:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43754 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfL1Ivy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 03:51:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so28123456wre.10
        for <linux-efi@vger.kernel.org>; Sat, 28 Dec 2019 00:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wkBR9IbcaVD8L1ewW2psNu81u8zga2bMfAHz8Wf/+fo=;
        b=x9oGOs9+zFhULbT9DeaPTBH5nUdZaOzkvIwrulJT0t1DyE2IEOhu3yd9Tqr72Rspo0
         IPDufVknxtQKnSuMIThFWXhzmiFzFYtHonE6NgZ0BRa6mIuPMb+LhvzM8kfYf05VpvzA
         CPgt8uUYyZ1HPwPLBJEEY96DckJODsvxSZFVvF8ORAZgUHdFnfsHol6Ox7JS5LIAW1L9
         lgGTie3U0WcnNcVhjSrsc7H9b7c9qn458gsCQljjYkUcV39YamyiPmgjBJhUYRfcGUVZ
         CmOpsWkdZOjGxiZqcTqTlk/LRm3vN/gxYwSfncDzJyJjEc2m02YnQP3ZtCweFPUGursC
         bvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wkBR9IbcaVD8L1ewW2psNu81u8zga2bMfAHz8Wf/+fo=;
        b=HDiO9pIahAGcEd0pxE5F7UiMwuoJdI51B5EHGFPsmBMLBpW/M+SaxOmoO3ZEmFNryd
         /4AoNpNNX4M4xFJsdEsh1wi5WRLzZDqjnSka+DH1e3wPJVgeMsbWYgoW84cBTgYP5T6r
         3i8uwTVRJzCSZR2vFDMXFTNisDpa9/qHGyfcX11iTvD0itLNdpR3mq7moPGy0GNDErhE
         IqAijG+qUDcq9Tuf4ubA0K0EGLvlGG4cZ6Os5ZcOkhCM17KnwSmpl+/l5PRh5Ct+bRFq
         sBJG/k15aWC+UiCdgi2UT1gxYWtuisUZXMaPfqISLUf2apC6gbr8Fygypa1neLmMgd0E
         fyjA==
X-Gm-Message-State: APjAAAU4vvoDcI9VFJUiL+cWL9hhp9HIWyYwgLyd2oRYriRbLOrRtJyZ
        G1Bd2KAvugi5stA5VE/fg0/K4sdKfH6XweON4CFKpg==
X-Google-Smtp-Source: APXvYqxw7rEHBJJDVDlN9IvUiLMDD46POvZap1a92JqzB0w3enAeCMLgTopzzxQR54OHmEZQOkhYhxxJJIEORl246pY=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr53749009wrs.200.1577523110962;
 Sat, 28 Dec 2019 00:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20191228063531.GB1194635@rani.riverdale.lan> <FF35B317-0AE9-46AB-A829-3C94E5598A1C@amacapital.net>
In-Reply-To: <FF35B317-0AE9-46AB-A829-3C94E5598A1C@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 28 Dec 2019 09:51:52 +0100
Message-ID: <CAKv+Gu9WF4iRQy9qpxaeFg+3CJkcDXxGePpn4f5ZnaA5yj4cmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 28 Dec 2019 at 08:03, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Dec 28, 2019, at 2:35 PM, Arvind Sankar <nivedita@alum.mit.edu> wrot=
e:
> >
> > =EF=BB=BFOn Sat, Dec 28, 2019 at 01:29:00PM +0800, Andy Lutomirski wrot=
e:
> >>
> >>> * The stack must be 16-byte aligned
> >>
> >> Nope. The asm needs to do this for runtime services. The kernel runs w=
ith 8-byte stack alignment.
> >>
> > 32-bit code is actually only 4-byte aligned in the kernel proper, right=
?
>
> Right. By =E2=80=9C8=E2=80=9D I meant =E2=80=9Clong=E2=80=9D.  Sorry.
>
> >
> > Currently, only native 64-bit calls always respect the 16-byte alignmen=
t
> > requirement, by aligning explicitly in the asm stubs, or after the
> > cleanup patches, via the efi bootloader running with 16-byte stack
> > alignment.
> >
> > I think mixed mode might actually be aligned via the asm stub in the
> > kernel proper, though it doesn't look like it is in the bootloader
> > portion.
>
> The underlying problem is that gcc doesn=E2=80=99t give us a way to do CA=
LL from asm while preserving more than a single word of alignment. This for=
ces us to compile the kernel proper with reduced alignment.  (Also, the gen=
erated code is better with reduced alignment.)

At runtime, the 64-bit kernel always uses a 16 byte aligned stack when
calling into EFI (32 or 64 bit), either by aligning the stack pointer,
or by switching to a special stack. On 32-bit kernels, the EFI calls
are simply indirect calls generated by the compiler, so there we may
enter with a misaligned stack pointer.

The EFI stub+decompressor are not built with
-mpreferred-stack-boundary=3D3, and so as long as we ensure that we
enter the C code with the proper alignment, the EFI calls will see the
correct alignment as well. We currently only do this for native 64-bit
boot, though, as 32-bit EFI firmware doesn't seem to require 16-byte
alignment in practice.
