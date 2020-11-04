Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD9A2A6D9E
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKDTMr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 14:12:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgKDTMq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Nov 2020 14:12:46 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4632080D;
        Wed,  4 Nov 2020 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604517165;
        bh=x8Z4vI5xusCxbaiv1HIPRu+C1+7Dtw3P0cGlUFk9NAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=amq1iOZQ53SdR/nox/ircKzv/Rwc+Pug3b3dVZ/1ItwS0FZ5KuR339betQWhUYSp7
         cGoGD8NrDD9Yem9Zdpt6NePnPljY5agQ3JpxPm/SYLlb36MOTtzSDwkQiUt/83k+e3
         f08hLXgwDvQ/8gqK51mllN7oKipkRI28QLkrEfgQ=
Received: by mail-oo1-f47.google.com with SMTP id l26so5334552oop.9;
        Wed, 04 Nov 2020 11:12:45 -0800 (PST)
X-Gm-Message-State: AOAM532BfQLL4SA1zn3Uyo5BS8F32K38PbeoWB1SWIbH+UJiFHOsZFrF
        6gmUM3VAvsLC9drSKt2Lf88mycNNV1orBJYXLok=
X-Google-Smtp-Source: ABdhPJxIEicSfXra/TnAUXm7t8vezHD9GOpBWLj9M/qAj91RrOwE7DixamCjJPcC3jCGJytqI3LVl+Z5spHnaW6OICk=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr19928543ooi.45.1604517164848;
 Wed, 04 Nov 2020 11:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20201102223800.12181-1-ardb@kernel.org> <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
 <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com> <c044fc25be309e7b25a4c64845fd753515c84804.camel@linux.ibm.com>
In-Reply-To: <c044fc25be309e7b25a4c64845fd753515c84804.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 4 Nov 2020 20:12:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFuHTruFRudKT512Cmj35KJjcJkTfeHtEjVbfCUZ6oBFQ@mail.gmail.com>
Message-ID: <CAMj1kXFuHTruFRudKT512Cmj35KJjcJkTfeHtEjVbfCUZ6oBFQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Nov 2020 at 20:03, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-11-04 at 19:50 +0100, Ard Biesheuvel wrote:
> > On Wed, 4 Nov 2020 at 19:20, Mimi Zohar <zohar@linux.ibm.com> wrote:
> > >
> > > Hi Ard, Chester,
> > >
> > > On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> > > > This is a follow-up to Chester's series [0] to enable IMA to the secure
> > > > boot state of arm64 platforms, which is EFI based.
> > > >
> > > > This v4 implements the changes I suggested to Chester, in particular:
> > > > - disregard MokSbState when factoring out secure boot mode discovery
> > > > - turn the x86 IMA arch code into shared code for all architectures.
> > > >
> > > > This reduces the final patch to a one liner enabling a Kconfig option
> > > > for arm64 when EFI is enabled.
> > > >
> > > > Build tested only.
> > >
> > > Thank you!  This patch set is now queued in the linux-integrity next-
> > > integrity-testing branch.
> > >
> >
> > I don't mind per se, but this touches a number of different trees,
> > including x86 and arm64, and nobody has acked it yet.
> >
> > As far as the EFI tree is concerned, it looks like I should be able to
> > avoid any conflicts with other stuff that is in flight, and if not, we
> > can always use your branch up until the last patch in this serires as
> > a shared tag (assuming you won't rebase it).
>
> The next-integrity-testing branch is just a place holder waiting for
> additional tags.  I've reviewed and tested the patch set on x86.  Based
> on the secure boot status and how the kernel is configured, the
> appropriate policy rules are enabled.   Similarly the IMA appraise mode
> (ima_appraise=) is working properly.  I have not tested on arm64.
>
> I do not have a problem with this patch set being upstream via EFI.
>

Ah right. That is probably better, as EFI goes via the x86 tree, and I
work closely with the arm64 maintainers on other things as well.

Please let me know once you are ready to ack this from IMA pov, and I
will carry it further.
