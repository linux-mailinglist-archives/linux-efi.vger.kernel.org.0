Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5229B1669C1
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgBTVWh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 16:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgBTVWh (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 16:22:37 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C536F20801
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582233757;
        bh=kU37zXqy2qU2s2QPNtziE/bUCf0HaO5zzeRb5pJhe7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TGjn0YxxG8+p3q56UqmlT7OsdyTcP9zniUK+iFBHKuAmSAwkUXCTCpvLOaYCzpQPU
         kV+BLt+x8yruoyMiJukjL0CCyMal/VZZIHGXYzlPDlkZOfV6mrxveF++V2hWcy86aA
         KN+gB3t5KbUO8AMz+aE/W1oc/G9Vwh2ByELTjpyg=
Received: by mail-wr1-f53.google.com with SMTP id e8so6247765wrm.5
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 13:22:36 -0800 (PST)
X-Gm-Message-State: APjAAAUrjgs69ddwGrXD+nB0PAP9OOxiosPQiz7Q7QDfySnC951iuMO/
        ekmF3L9cwnOpXf1pxmop4xYFUfwAqYZ1Rq8cqWwmWQ==
X-Google-Smtp-Source: APXvYqw2CAiy5HB1hzvzeBRkHNDLyf3CSoCs65NtOviyqmciIvVXFavKf6pwhM+PU2HL+sRVRVsIw0vtrGdUNQgnknA=
X-Received: by 2002:adf:8564:: with SMTP id 91mr45352981wrh.252.1582233755311;
 Thu, 20 Feb 2020 13:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20200220110649.1303-1-ardb@kernel.org> <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan> <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
 <20200220195157.GA2483987@rani.riverdale.lan>
In-Reply-To: <20200220195157.GA2483987@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 22:22:23 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu8WkE419HofC3T_EVYDbJyV8k69agz2Jqx-CGaNtgkvZw@mail.gmail.com>
Message-ID: <CAKv+Gu8WkE419HofC3T_EVYDbJyV8k69agz2Jqx-CGaNtgkvZw@mail.gmail.com>
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

On Thu, 20 Feb 2020 at 20:52, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> > On Thu, 20 Feb 2020 at 18:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > The .text section contains data as well. Shouldn't it be marked
> > > IMAGE_SCN_MEM_WRITE also?
> > >
> >
> > Another good point. For ARM and arm64, I actually changed this into
> > split R-X and RW- sections, in case the loader decides to honour these
> > attributes (which it should imo)
> >
> > So yes, we should either add IMAGE_SCN_MEM_WRITE, or add a .data
> > section (although we probably don't have the space for that).
> >
> > Another thing I wondered was whether we really need the .reloc
> > section. We don't have one on ARM, and it works fine with the existing
> > EDK2 loader.
> > Peter: any idea whether the issue with .reloc you pointed out to me
> > the other day still exists in EDK2 today?
>
> Is there any reason we couldn't combine .setup + .text as R-X, then
> .reloc, then .data + .bss as RW-? That would leave room for the new
> .compat section then even without removing .reloc.
>
> Although if the loader actually honored the non-writable setting,
> efi_relocate_kernel has to be done unconditionally. It currently happens
> to be unconditional if you come in via PE loader, since we don't set
> ImageBase to tell it our preferred address, and even if we did, the
> existence of .setup means startup32 isn't at that address.

Shouldn't matter, given that we don't use the same page tables to run
the startup code.
