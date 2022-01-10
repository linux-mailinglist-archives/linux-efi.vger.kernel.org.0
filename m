Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8884D489E9A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 18:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiAJRpw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 12:45:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52494 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiAJRpv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 12:45:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BBBB81745;
        Mon, 10 Jan 2022 17:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96415C36AFE;
        Mon, 10 Jan 2022 17:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641836748;
        bh=qIK1F6b3658fsjAhigKdpjJrtwsWF5zqnQS/c1V9IBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PNqPjAOACKHv4CtScWtHLrSw3UDjwkOYPvvD8Jx/Rr/rA4Xg0irh+CKjx6VziT3Za
         Esd+hnMnSNqwHqYG7uomTFWVu+PAdwQ9Vx+eln6xV1a1Xdm7Rpu/oVbqi9U5e4h8B9
         9ciqNaC0paTT5C5LvG8hnt2RwgGFcy4QcTUdbjqpgN9AW5IibHxI7f4q080p8sWPYY
         mfJeMj4Qzlo5Sy4rHlxWVAy2FogjTvtHgh2MGivt64kn8pNII82aZ+jnLwvnzpE35t
         s/vw8147HTQLIe+CLg9wFORht5bujsfLH0i13m6KvR4dKwsjSFTgIp17+RyvaNoO2X
         ErWr/bp95RogA==
Received: by mail-wr1-f54.google.com with SMTP id r10so20589003wrc.3;
        Mon, 10 Jan 2022 09:45:48 -0800 (PST)
X-Gm-Message-State: AOAM531XDnaiHKr3IoaCDDTpHnBuxq7GZ13XWhaMgWd8p6t0xQOJp3q6
        Sou3AK7V3Du3m36EqJdApQK4JK0wj9tpO24oS4o=
X-Google-Smtp-Source: ABdhPJz33dVI7QVb0QRXO9JzgBNHg1jSh5NdyCuSBj9IdRGzbTVPIlZBfuPpqGZeHxFtPApXcXDE3qZ4x/qsKNd9jrY=
X-Received: by 2002:a5d:4087:: with SMTP id o7mr580535wrp.189.1641836746735;
 Mon, 10 Jan 2022 09:45:46 -0800 (PST)
MIME-Version: 1.0
References: <6D757C75-65B1-468B-842D-10410081A8E4@live.com>
 <CAMj1kXETPO9iJoFm26v5gof2xpakHkvz3YV4ahet7BLjX5m5FQ@mail.gmail.com>
 <D3B9962F-F6F0-4622-9E0F-A3EABACAD471@live.com> <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
In-Reply-To: <CAMj1kXGem3QB0rj-b57xrcDYkCv6Moi=RX1OUspj3s4vMtsdug@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 10 Jan 2022 18:45:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
Message-ID: <CAMj1kXEjmJxS-_r4HK_v_Qm85y2oeawk+bWUpSY7mV5NLFCm4g@mail.gmail.com>
Subject: Re: [BUG][SEVERE] Enabling EFI runtime services causes panics in the
 T2 security chip on Macs equipped with it.
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "jk@ozlabs.org" <jk@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 10 Jan 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 10 Jan 2022 at 17:28, Aditya Garg <gargaditya08@live.com> wrote:
...
> > >>
> > >> This seems to be triggered by EFI_QUERY_VARIABLE_INFO here
> > >>
> > >
> > > This is interesting. QueryVariableInfo() was introduced in EFI 2.00,
> > > and for a very long time, Intel MACs would claim to implement EFI 1.10
> > > only. This means Linux would never attempt to use QueryVariableInfo()
> > > on such platforms.
> > >
> > > Can you please check your boot log which revision it claims to implement now?
> > >
> > > Mine says
> > >
> > > efi: EFI v1.10 by Apple
> >
> > Mine says
> >
> > efi: EFI v2.40 by Apple
> >

Can you check whether things work as before after applying the change below?

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 147c30a81f15..d7203355cc69 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -399,7 +399,7 @@ static int __init efi_systab_init(unsigned long phys)
                efi_nr_tables           = systab32->nr_tables;
        }

-       efi.runtime_version = hdr->revision;
+       efi.runtime_version = EFI_1_10_SYSTEM_TABLE_REVISION;

        efi_systab_report_header(hdr, efi_fw_vendor);
        early_memunmap(p, size);
