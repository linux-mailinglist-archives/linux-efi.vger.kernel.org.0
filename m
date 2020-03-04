Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23362179BD7
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 23:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgCDWiw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 17:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388312AbgCDWiw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 17:38:52 -0500
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B542084E
        for <linux-efi@vger.kernel.org>; Wed,  4 Mar 2020 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583361532;
        bh=mtEUWSACFq3wx/O9ua/zYi51pShN+7Wwl3THKld0vGA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OP+wwZho5k8DOSql7YbicixnD+qT9zRorhzq7SykBHETZy57fLzzSV+yzfQTnr/tG
         2mFFafEL9RK8r2YmKC6lmrefqXmcEuedSTNPM39XCuLk8a2jk+PD3Jy2Af3nuMwxpg
         eScP/ibk4CZfyl8pnQhRiwsSjdX72KFXRYh4oIxQ=
Received: by mail-wm1-f42.google.com with SMTP id j1so3586185wmi.4
        for <linux-efi@vger.kernel.org>; Wed, 04 Mar 2020 14:38:51 -0800 (PST)
X-Gm-Message-State: ANhLgQ0uMTGl2p86kKI8n1jRwqy0BrQ8KN8yPlCCYpv9ymKEXZ0eNCvy
        GQ+ZRPPXyhl0u1wQ9M73ZJfUKiLRxRQ37XsKEFUvwg==
X-Google-Smtp-Source: ADFU+vtI0wodlkHqYyB+jmtGcs8qkS0cqHNUGA//Xhy8eBMnkEAyI8fGVjhzozjzDCkS896wVtIyQm8gciPCo4o1Y8c=
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr5410843wme.62.1583361530200;
 Wed, 04 Mar 2020 14:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
In-Reply-To: <20200303205445.3965393-1-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Mar 2020 23:38:39 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_QtSJ7P6PBW-OQVZ7BQYQKkj_t8+y0qMLn-7Ddzn5qaw@mail.gmail.com>
Message-ID: <CAKv+Gu_QtSJ7P6PBW-OQVZ7BQYQKkj_t8+y0qMLn-7Ddzn5qaw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Bugfix + small cleanup to populate_p[mug]d
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

On Tue, 3 Mar 2020 at 21:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The first patch fixes a bug in populate_pud, which results in the
> requested mapping not being completely installed if the CPU does not
> support GB pages.
>
> The next three are small cleanups.
>
> Thanks.
>
> Arvind Sankar (4):
>   x86/mm/pat: Handle no-GBPAGES case correctly in populate_pud
>   x86/mm/pat: Ensure that populate_pud only handles one PUD
>   x86/mm/pat: Propagate all errors out of populate_pud
>   x86/mm/pat: Make num_pages consistent in populate_{pte,pud,pgd}
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/x86/include/asm/pgtable_types.h |  2 +-
>  arch/x86/mm/pat/set_memory.c         | 74 +++++++++++++++++-----------
>  2 files changed, 45 insertions(+), 31 deletions(-)
>
> --
> 2.24.1
>
