Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9271A49A5
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJSDw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 14:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJSDw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 10 Apr 2020 14:03:52 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033F52145D
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586541832;
        bh=QHBkQ6dMv1USg/67sQLAe6sDUMFk6Ka9GFRFDgwke0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yGkGnNluuivcN0qbUj54oOspQPhFyPFM7Qjfv/8ux7XCn9nrGwnzSxKuXMAqLTxaj
         Cj8YzZYIxEDRAEFE4ZY5DNhDUWOCfeDgKN9HvlpwMtjwPdbutABsZAU88fOUcAxdnM
         k10Rdk7OYOKFstOiamCUD9Xfh4bEW6ItW+z2nxh4=
Received: by mail-io1-f50.google.com with SMTP id n10so2567877iom.3
        for <linux-efi@vger.kernel.org>; Fri, 10 Apr 2020 11:03:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuaAQhMlmTL6lIT2fy09SWDEFPAmIiOekp3bxnsmFyRzmjgLzwQ5
        HbVkmNT7nDfNHw2G9zaVaWRToDuNPFFsLJryzmg=
X-Google-Smtp-Source: APiQypL6zEM4LIRlq84WDavdYmx90OKweYGWMZB6VlDI8hKt7Se6lQbXKSs9MedwWRm5KV+Tb6LfDOvmO7B6894SzOU=
X-Received: by 2002:a6b:7f48:: with SMTP id m8mr5517126ioq.142.1586541831368;
 Fri, 10 Apr 2020 11:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200410172824.86217-1-ignat@cloudflare.com> <CAMj1kXFu5Jd7RzY1tC-RXKof4_s=qU+xRa37qKSQqiZ5tta9Bg@mail.gmail.com>
 <CALrw=nE9W05PUA5RhNro97_3vEeN0WpnfENhcJD6Uc9TSawT3Q@mail.gmail.com>
In-Reply-To: <CALrw=nE9W05PUA5RhNro97_3vEeN0WpnfENhcJD6Uc9TSawT3Q@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 10 Apr 2020 20:03:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCj-tt5KY4hkz67csQ7-utgbGmGDF6AipgjK0PsSoA8w@mail.gmail.com>
Message-ID: <CAMj1kXHCj-tt5KY4hkz67csQ7-utgbGmGDF6AipgjK0PsSoA8w@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Expose number of entries in the EFI
 configuration table via sysfs
To:     Ignat Korchagin <ignat@cloudflare.com>, pjones@redhat.com
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Peter)

On Fri, 10 Apr 2020 at 19:54, Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> On Fri, Apr 10, 2020 at 6:38 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hello Ignat,
> >
> > Thanks for the patch.
> >
> > On Fri, 10 Apr 2020 at 19:28, Ignat Korchagin <ignat@cloudflare.com> wrote:
> > >
> > > Currently Linux exposes the physical address of the EFI configuration table via
> > > sysfs, but not the number of entries.
> > >
> >
> > It does so on x86 only, and the purpose is specifically defined as
> > kexec. This is for a good reason: kexec on x86 EFI machines has
> > accumulated some historical quirks dealing with issues that do not
> > exist on other architectures.
> >
> > > The number of entries for the EFI configuration table is located in the EFI
> > > system table and the EFI system table is not exposed, so there is no way for
> > > a userspace application to reliably navigate the EFI configuration table.
> > >
> > > One potential use case for such a userspace program would be a monitoring agent,
> > > which parses Image Execution Information Table from the EFI configuration table
> > > and reports all the UEFI executables, which have been denied execution due to
> > > the enforced Secure Boot policy thus providing intrusion detection capabilities.
> > >
> >
> > Exposing a physical address via syfs and using /dev/mem to scoop up
> > the data is not a robust, secure or portable interface, especially in
> > the quoted context of a UEFI secure boot enabled system.
>
> TBH, it is not hard to find this number by scanning the same mapped region for
> EFI system table (which is easily identifiable by its signature). So
> security is not an
> issue here, although robustness and portability indeed.
>
> > If you need to access this table from userland, I suggest we come up
> > with a generic method that does not rely on /dev/mem. It would be even
> > better if we could come up with some infrastructure that makes this
> > easily extendable to other configuration tables. But simply exposing
> > the address and size of the config table array in memory is not the
> > right way.
>
> Would you prefer something closer to the efivars filesystem then?
>

The problem with EFI configuration tables is that there is no standard
way to discover their size. Each GUID denotes a different type of
table, each of which has its own structure and layout in memory.

We already record and expose a substantial set of config tables, but
perhaps it is time to add a generic layer as well. I have cc'ed Peter,
which may have some observations of his own to share on this topic.

A pseudo file system might work, as long as it only exposes tables
that have been explicitly registered for this, along with the size of
each individual table. But then it becomes complicated if you want to
expose things like ACPI or SMBIOS, which are not flat tables, but sets
of tables pointing to other tables etc etc.
