Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE11798B0
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCDTK5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 14:10:57 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41898 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDTK4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 14:10:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id b5so2765351qkh.8;
        Wed, 04 Mar 2020 11:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nM1dA0CwnvAM+gebairRIvq9J2g7Xu9WpCogn31XPBo=;
        b=TAIlV8aNIDDYyO3ACIaObRlbYK3dBnJamRbkfvCJbacLxiZgD7T6PhJrwsOM/t+BJ3
         pPWQVc2vDWHmcy+DS3TCkwxR+VnZAwBU9KoRg2adXHYZhWIlu1he3j6pukRHDnbKveGV
         WhRW6QUl3vlCIM2AN7JkH9xdtJuahL0JrtLGc3rOa4/UykNbHqYvj2639Jk7f6NzsBSk
         cgD3EdIWOeGy9DsqMhAmqK/iYgJJ092oG4XT24lb/VPaR0ItDN51TeqD0d/XGH+0ip05
         lbndHnePSLHZVULLe27S1rUALeGOx1+U7kdqri+VEnnGYXt5FnNLHhu+Eanxp0Wcfi6N
         7KpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nM1dA0CwnvAM+gebairRIvq9J2g7Xu9WpCogn31XPBo=;
        b=ryrasN/sjNGeKQ+HG2XGxOVvuzTkkGtIds9m7Yp03CWkW+3cFGKZ0n16/pnOsvLF5W
         8P8mXUJeNbwA0CH4y4HzrOgVjjlnwgoPlDBJRW4dK7aW1bFYNuGTCZAydrAyfhyVcB3U
         ZIV1u2+YxIkkcRVMZ8bK3/JKR/cEQUlRYJDaBeh7G5QHC+Yzo3HSUgsLLzQpqDMT2n4T
         3eMy7T734350JPfi0iDas9uJaBG30VYzwHaPgr5xtfQ0d4iNdpmfxiiLuCKllFTa3YEO
         kDN99Cmh9Gs/iqSf9zUEo8cjAKkUrJX/38UJZQ4J2QMkiV2fITDPXDFsoMkcwUzl9mXE
         WzoQ==
X-Gm-Message-State: ANhLgQ3g6qC6fsOkBdZZmGUlePIAUJLkpA4Sdfqo0TKX4uUEzo99oJfV
        G+kMFlvdgzJdKL2eVYmZ4tU=
X-Google-Smtp-Source: ADFU+vufyb826SsxzvUtT1EsUhRKy/q1n1dOTjmZJPqrU5E86YpX38WayTTGOVMur15k1YgmK6OeSQ==
X-Received: by 2002:a05:620a:5f8:: with SMTP id z24mr4396267qkg.203.1583349055725;
        Wed, 04 Mar 2020 11:10:55 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 89sm14483809qth.3.2020.03.04.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:10:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 14:10:53 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in
 populate_pud
Message-ID: <20200304191053.GA291311@rani.riverdale.lan>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu>
 <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan>
 <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan>
 <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 08:04:04PM +0100, Ard Biesheuvel wrote:
> On Wed, 4 Mar 2020 at 19:50, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Mar 04, 2020 at 07:44:50PM +0100, Ard Biesheuvel wrote:
> > >
> > > I've tried a couple of different ways, but I can't seem to get my
> > > memory map organized in the way that will trigger the error.
> >
> > What does yours look like? efi_merge_regions doesn't merge everything
> > that will eventually be mapped the same way, so if there are some
> > non-conventional memory regions scattered over the address space, it
> > might be breaking up the mappings to the point where this doesn't
> > trigger.
> 
> I have a region
> 
> [    0.000000] efi: mem07: [Conventional Memory|   |  |  |  |  |  |  |
>  |   |WB|WT|WC|UC] range=[0x0000000001400000-0x00000000b9855fff]
> (2948MB)
> 
> which gets covered correctly
> 
> [    0.401766] 0x0000000000a00000-0x0000000040000000        1014M
> RW         PSE         NX pmd
> [    0.403436] 0x0000000040000000-0x0000000080000000           1G
> RW         PSE         NX pud
> [    0.404645] 0x0000000080000000-0x00000000b9800000         920M
> RW         PSE         NX pmd
> [    0.405844] 0x00000000b9800000-0x00000000b9a00000           2M
> RW                     NX pte
> [    0.407436] 0x00000000b9a00000-0x00000000baa00000          16M
> ro         PSE         x  pmd
> [    0.408591] 0x00000000baa00000-0x00000000bbe00000          20M
> RW         PSE         NX pmd
> [    0.409751] 0x00000000bbe00000-0x00000000bc000000           2M
> RW                     NX pte
> [    0.410821] 0x00000000bc000000-0x00000000be600000          38M
> RW         PSE         NX pmd
> 
> However, the fact that you can provide a case where it does fail
> should be sufficient justification for taking this patch. I was just
> trying to give more than a regression-tested-by

No, this case is exactly one that should break. But I think you're
running on a processor model that _does_ support GB pages, as shown by
the "pud" mapping there for the 1G-2G range.

At least for my version of qemu, -cpu Haswell does not enable the
pdpe1gb feature. Which cpu did you specify?

Thanks.
