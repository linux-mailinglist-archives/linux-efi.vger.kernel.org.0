Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1460012BD20
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 10:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL1J1k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 04:27:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33150 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfL1J1k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 04:27:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so28239090wrq.0
        for <linux-efi@vger.kernel.org>; Sat, 28 Dec 2019 01:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tr6FEsI7Y4NriAV34npxPZr7aOvnqa3aHuXkSCdfabw=;
        b=EFGMslM1/sR9dsoua9nu8gpKixm0u5HdK8Ud+fQvCBs5XPDKgluPPFCnycs6yZtd1t
         /ku+5lR5r4ywfvvkCBs129khHqcoyvbG0cRv50s/4OBh3aaJyVOPmofYh2rUjUGyrF+V
         uvS+7eX1Y7tS23YG0UVpjsYXMb+YN2X39yvq8k9gbgW/lcKjEfdVU9i+DDVtYW1qDBbc
         sDpHvJCQ6nsEy6xpG/8docBJfCN767wgXmTI0BR8Q1aX/1yyHZ+ueUisjM0kJBfXJJkN
         10TTRuexwWV+1WOLqUXre3IXPIk+tIwOrGm8t1Nkxfgu+6n8Dg0LJhtOcs8RI8EGbnSH
         zndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tr6FEsI7Y4NriAV34npxPZr7aOvnqa3aHuXkSCdfabw=;
        b=PRn3BjUqQPvHwC4g2334RWmnIuOKD58whoHnN2fw3BKEV2n3Y7EFrAxDWss3UqGEBr
         M4W1upsyqqv2CGc/VBj8+uy+kpf5s8cb097ZKyXQi0fGQUm3qB1lDG/vh0OcrSIFXFcb
         jv3IuV02n7BbQsaDaUIZHPuDW6rM/dY1wvYrPq1IHVMnw3I7jszmcs4phnFQMausjniH
         jiuc1AX3wzsMlQWFYfkt8uK010925zn24MecZ+x36lqqa9o2q2LOkRZtCwEAa69zvEri
         NQTWDoqsx45/bcLlEEykTOwUJt3FvoMQSEbcmWaCt916pgKpZ/6FkA5XjwjHNdK/mkrE
         gTow==
X-Gm-Message-State: APjAAAX96vkp3V55+oK0UTg4sVjseYFGJCuuF/rInIYiBevjNCYBY7kL
        oZ9gfE36s5ce2WCXbGsbp125NKAVjntbXO5q/uaQPw==
X-Google-Smtp-Source: APXvYqzfWdlvOwQ2k5a5inJkbfxxrJsLP70c2W5f/bRe3chh3rStNOA9Dv9fgzep0vTtl9kkOpK1Id01ToawfFUsbX0=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr57524479wrv.0.1577525257870;
 Sat, 28 Dec 2019 01:27:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKv+Gu9WF4iRQy9qpxaeFg+3CJkcDXxGePpn4f5ZnaA5yj4cmw@mail.gmail.com>
 <63CD3BC7-8BA7-41D4-9818-48827BBE3573@amacapital.net>
In-Reply-To: <63CD3BC7-8BA7-41D4-9818-48827BBE3573@amacapital.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 28 Dec 2019 10:27:39 +0100
Message-ID: <CAKv+Gu8o2cv8Kki93vOQUvugykCQu-XPB++1YWrQ=yUx1Lj+MQ@mail.gmail.com>
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

On Sat, 28 Dec 2019 at 10:00, Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>
> > On Dec 28, 2019, at 4:51 PM, Ard Biesheuvel <ard.biesheuvel@linaro.org>=
 wrote:
> >
> > =EF=BB=BFOn Sat, 28 Dec 2019 at 08:03, Andy Lutomirski <luto@amacapital=
.net> wrote:
> >>
> >>
> >>
> >>>> On Dec 28, 2019, at 2:35 PM, Arvind Sankar <nivedita@alum.mit.edu> w=
rote:
> >>>
> >>> =EF=BB=BFOn Sat, Dec 28, 2019 at 01:29:00PM +0800, Andy Lutomirski wr=
ote:
> >>>>
> >>>>> * The stack must be 16-byte aligned
> >>>>
> >>>> Nope. The asm needs to do this for runtime services. The kernel runs=
 with 8-byte stack alignment.
> >>>>
> >>> 32-bit code is actually only 4-byte aligned in the kernel proper, rig=
ht?
> >>
> >> Right. By =E2=80=9C8=E2=80=9D I meant =E2=80=9Clong=E2=80=9D.  Sorry.
> >>
> >>>
> >>> Currently, only native 64-bit calls always respect the 16-byte alignm=
ent
> >>> requirement, by aligning explicitly in the asm stubs, or after the
> >>> cleanup patches, via the efi bootloader running with 16-byte stack
> >>> alignment.
> >>>
> >>> I think mixed mode might actually be aligned via the asm stub in the
> >>> kernel proper, though it doesn't look like it is in the bootloader
> >>> portion.
> >>
> >> The underlying problem is that gcc doesn=E2=80=99t give us a way to do=
 CALL from asm while preserving more than a single word of alignment. This =
forces us to compile the kernel proper with reduced alignment.  (Also, the =
generated code is better with reduced alignment.)
> >
> > At runtime, the 64-bit kernel always uses a 16 byte aligned stack when
> > calling into EFI (32 or 64 bit), either by aligning the stack pointer,
> > or by switching to a special stack.
>
> Can you point me at the stack switching code?  Stack switches always make=
 me nervous due to interactions with other things, especially NMIs.

It's in patch 3/3 in this series.
