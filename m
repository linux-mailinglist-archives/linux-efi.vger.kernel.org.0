Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D23041665F8
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 19:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgBTSOk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 13:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgBTSOk (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 13:14:40 -0500
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A073224681
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582222479;
        bh=RTCdewSJamGvFckV4P7YoFIgXLzqmB5f6ANXaCpYHr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MSHqx8bjGEK1n8F3wJchSnpqBcmKyG5ONWUNs2xWiUuhAfT0fALuWzdMimt3gyoVh
         UU+XvUCAiGiXh5kMuYQGctQoZqGpvoK+JoVmdjJm7+SIFdyapAa8RUlFVstw7dxQ2L
         GImKzEoYx8ucxacA+R3g9G9zWllMYUifwcY9FKHU=
Received: by mail-wr1-f51.google.com with SMTP id m16so5672392wrx.11
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 10:14:39 -0800 (PST)
X-Gm-Message-State: APjAAAU9gVF++VW7ZuXvm741D78YMJ89foRE8tZW2fQGCMpyBG8iMxD7
        6KUsBqYKbaSQJHfu+1Y02ZvOeY8HTN/bZOd7la+HCw==
X-Google-Smtp-Source: APXvYqzXwoexh0Cm2IqjjHwIzVHSPeqhFldJl9NnIIiwtUupNGAGvSXpeExmqjzSKmVgxmi3VITDDqUg0/kIWwHYDPk=
X-Received: by 2002:a5d:6404:: with SMTP id z4mr16722520wru.262.1582222478032;
 Thu, 20 Feb 2020 10:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20200220110649.1303-1-ardb@kernel.org> <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan> <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
 <20200220180454.GA2436919@rani.riverdale.lan>
In-Reply-To: <20200220180454.GA2436919@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 19:14:27 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_hVszLmChFvrv5MU5aS5-Vuc4AXB7R0XNXn+Amgx=Ogg@mail.gmail.com>
Message-ID: <CAKv+Gu_hVszLmChFvrv5MU5aS5-Vuc4AXB7R0XNXn+Amgx=Ogg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Feb 2020 at 19:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> > Another thing I wondered was whether we really need the .reloc
> > section. We don't have one on ARM, and it works fine with the existing
> > EDK2 loader.
> > Peter: any idea whether the issue with .reloc you pointed out to me
> > the other day still exists in EDK2 today?
>
> commit 743628e868c5 ("x86, efi stub: Add .reloc section back into
> image") says that
>         Some UEFI firmware will not load a .efi with a .reloc section
>         with a size of 0.
>
> Is that the issue you're refering to? It is a bit odd, since we actually
> leave base relocation table at a size of zero with an RVA of zero, so it
> shouldn't even look at the .reloc section according to the spec. At
> least current EKD2 code doesn't seem to -- I think it would even work if
> you specify fewer tables than 6 so that the base relocation table is
> missing altogether.

I can only agree with that, and I have never experienced any issues
loading PE/COFF images without .reloc sections on any architecture.

But looking at that patch, it seems it only changes the .reloc
section's size, it doesn't actually add it back. The .reloc section
has been there from the beginning, with a note saying that it is
required, which doesn't seem to be the case today, and looking at the
history of EDK2, I can't really spot any changes in that regard
either.
