Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC13715CEFC
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 01:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgBNAVr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 19:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNAVq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 13 Feb 2020 19:21:46 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03E822314
        for <linux-efi@vger.kernel.org>; Fri, 14 Feb 2020 00:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581639706;
        bh=fFxcHKGqsnnryolaekcwMamiWaYL1ghNllNr1GlKSlc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1uS8bfwyiCqmTSZK+Ay/YoyOSkmvLrTGwNekaFq8eqv1jRr7ikV7JPFctrc/969uQ
         xXpidpbggRymLU363Q9jAtd6EJ474JpmzlJGqu9b6XVmXEq/vjz3aXjDIrlAv0+REE
         zD7BS7pCvJZThLsPLDvrXVhtzvTPaTDKgY0KYq68=
Received: by mail-qt1-f178.google.com with SMTP id n17so5859855qtv.2
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 16:21:45 -0800 (PST)
X-Gm-Message-State: APjAAAVdbIU8bY0eRgiDMsq6O0n2yBlQ11zfqaL67ZzJXcgNRsTKnHpp
        V5+KhQcmd3i7+p/p+roaa0hKy0DNOBYBjUgEv8j9lQ==
X-Google-Smtp-Source: APXvYqyeN6yL1/VuwqYWMNCwyW+7WK5Z541o+aWniGuOqzgJunAwb26w/CEZRf+t6m3rS1OzHVRkfQsbEwQXNCahdzo=
X-Received: by 2002:ac8:1194:: with SMTP id d20mr546422qtj.243.1581639704938;
 Thu, 13 Feb 2020 16:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20200213145928.7047-1-ardb@kernel.org> <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
 <20200213184752.GA1424509@rani.riverdale.lan> <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
 <20200214001048.GA3054227@rani.riverdale.lan> <20200214001257.GB3054227@rani.riverdale.lan>
In-Reply-To: <20200214001257.GB3054227@rani.riverdale.lan>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Feb 2020 00:21:30 +0000
X-Gmail-Original-Message-ID: <CAKv+Gu92Tny_PJjddAtLrhdFJm0GqgSfj3NA26PX6xOiaStozg@mail.gmail.com>
Message-ID: <CAKv+Gu92Tny_PJjddAtLrhdFJm0GqgSfj3NA26PX6xOiaStozg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode boot
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Brown <mbrown@fensystems.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 14 Feb 2020 at 01:13, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Feb 13, 2020 at 07:10:49PM -0500, Arvind Sankar wrote:
> > On Thu, Feb 13, 2020 at 10:36:14PM +0000, Ard Biesheuvel wrote:
> > > On Thu, 13 Feb 2020 at 19:47, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Thu, Feb 13, 2020 at 05:55:44PM +0000, Ard Biesheuvel wrote:
> > > > > On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > > > > As an alternative to the new section, how about having a CONFIG option
> > > > > > to emit the 64-bit kernel with a 32-bit PE header instead, which would
> > > > > > point to efi32_pe_entry? In that case it could be directly loaded by
> > > > > > existing firmware already. You could even have a tool that can mangle an
> > > > > > existing bzImage's header from 64-bit to 32-bit, say using the newly
> > > > > > added kernel_info structure to record the existence and location of
> > > > > > efi32_pe_entry.
> > > > > >
> > > > >
> > > > > That wouldn't work with, say, signed distro kernels.
> > > >
> > > > No, the idea would be that the distro would distribute two signed
> > > > images, one 32-bit and one 64-bit, which are identical except for the
> > > > header. At install time, the installer chooses based on the system's
> > > > firmware bit-ness.
> > > >
> > >
> > > I guess it would be possible, but then we'd need two different images
> > > while today, we can run the same image on both kinds of firmwares. The
> > > only thing I am trying to do is remove all the quirky bootparams stuff
> > > from the loader so that we can switch to LoadImage
> >
> > Yeah, but doing that will allow you to boot directly from firmware on
> > existing machines, and only one image needs to be chosen at install
> > time, so it just adds a few MiB to the package. I guess most people will
> > still use a boot manager or loader that can be easily enhanced to use
> > LoadImage and the new section, but it would be nice to have the option
> > to avoid that.


I see the value of having a 64-bit image that can boot natively on
32-bit firmware, but I am not expecting any buy in from the distros
for this scheme.


>
> Also not quite today, right? You still need this patchset and the
> modifications to bootloaders to get away with one image.

Sure. But we already have mixed mode support today that doesn't
require this, so it's going to be a difficult sell to switch to a new
scheme that requires infrastructure to distribute different kernels,
and logic to choose between the two.

A generic EFI bootloader/firmware will need to implement the initrd
loadfile2 protocol as well, so some Linux specific features will need
to be implemented anyway. This series is intended to ensure that mixed
mode doesn't get left behind, even though very few people use it
today.
