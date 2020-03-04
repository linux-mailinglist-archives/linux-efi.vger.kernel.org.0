Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308AD179889
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgCDTER (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 14:04:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgCDTER (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 14:04:17 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92C25217F4
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583348656;
        bh=hJurs/av6t9EdSglXfHGBNi3KPMs5TYGjABwzZDQpvE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=klGEirEbpThP8ooWE8dkBzcXU9SMcLyNVJdEupJNWHHRuE+yFKUZ4i2otL7e8UiPj
         6jTeC6YrNIt4tnG1pmsHqjUUuiVBRfRCm4e3DXlord0QVtEIR/SR8M64Jd1Y0Rvsjz
         PtunlmKWwlj36cFFHw59i1TWJELFnp2+92QTwp7s=
Received: by mail-wr1-f53.google.com with SMTP id n7so3793722wrt.11
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 11:04:16 -0800 (PST)
X-Gm-Message-State: ANhLgQ1MY9UyvZ3Qf2PRY2axhvJTIsZ5KP+4pOWIA9EzJBsELvhpIL85
        7eCggFESEaG5zmxquUwpfVcMVjXFsE3Z0cYiVFaBfA==
X-Google-Smtp-Source: ADFU+vvNwUmp7UUfbaV0t7YWCbx3o1VoR36mkm9WU2rUlP6aAWyjGRVGsnHUEBD6CsLghQhpGlsvblBIBoa0uLJRlY8=
X-Received: by 2002:adf:e742:: with SMTP id c2mr5384523wrn.262.1583348655022;
 Wed, 04 Mar 2020 11:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu> <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan> <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan>
In-Reply-To: <20200304185042.GA281042@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 20:04:04 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
Message-ID: <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Mar 2020 at 19:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Wed, Mar 04, 2020 at 07:44:50PM +0100, Ard Biesheuvel wrote:
> >
> > I've tried a couple of different ways, but I can't seem to get my
> > memory map organized in the way that will trigger the error.
>
> What does yours look like? efi_merge_regions doesn't merge everything
> that will eventually be mapped the same way, so if there are some
> non-conventional memory regions scattered over the address space, it
> might be breaking up the mappings to the point where this doesn't
> trigger.

I have a region

[    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |  |  |  |
 |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000b9855fff]
(2948MB)

which gets covered correctly

[    0.401766] 0x0000000000a00000-0x0000000040000000        1014M
RW         PSE         NX pmd
[    0.403436] 0x0000000040000000-0x0000000080000000           1G
RW         PSE         NX pud
[    0.404645] 0x0000000080000000-0x00000000b9800000         920M
RW         PSE         NX pmd
[    0.405844] 0x00000000b9800000-0x00000000b9a00000           2M
RW                     NX pte
[    0.407436] 0x00000000b9a00000-0x00000000baa00000          16M
ro         PSE         x  pmd
[    0.408591] 0x00000000baa00000-0x00000000bbe00000          20M
RW         PSE         NX pmd
[    0.409751] 0x00000000bbe00000-0x00000000bc000000           2M
RW                     NX pte
[    0.410821] 0x00000000bc000000-0x00000000be600000          38M
RW         PSE         NX pmd

However, the fact that you can provide a case where it does fail
should be sufficient justification for taking this patch. I was just
trying to give more than a regression-tested-by
