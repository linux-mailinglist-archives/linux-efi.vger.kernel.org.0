Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B2116672A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 20:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgBTT3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 14:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:33906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbgBTT3u (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 20 Feb 2020 14:29:50 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E480F24687
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582226990;
        bh=GV/7Z6BPvkCuYwwHpw8IBTf7A3D4QPvtwJzitfx1T6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NY4MaRv8JngHvbMHAtF976J78L8Qcl7fQLawE8Q56KbcKOJlnvrvJghZCqbHet53b
         n0wfnV6Ke10i/iid2krfoQoLs4ST0o3QZWwlQpP2r8SUXNNprr1zfXrJz85iqrOXyZ
         4C9f/9SoPuzyzJMFF71LeB+yA7enLoyP1h0IK3lU=
Received: by mail-wm1-f53.google.com with SMTP id n3so3258901wmk.4
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 11:29:49 -0800 (PST)
X-Gm-Message-State: APjAAAUqeLIdjX9BTLml3o9ojY4L5a2L/NKBcIEvLX6YphRHpTnu/+nZ
        U9vEBrGhHCAecxc5dOS3Uacg+ZwkOM3PkiCMZ70w5g==
X-Google-Smtp-Source: APXvYqxsILkynPZG57dCkEPzh4Z6GJnjxTtw8FU02Ouhl5QxVl6cAzmWOsxVNCuorCBFQXqnWeAZrw9CPjVAy8XWOBc=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr6354739wmf.133.1582226988187;
 Thu, 20 Feb 2020 11:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20200220110649.1303-1-ardb@kernel.org> <4d921ba6-5a34-4dfc-2a58-588933e995b7@gmx.de>
In-Reply-To: <4d921ba6-5a34-4dfc-2a58-588933e995b7@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Feb 2020 20:29:37 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_kTVY41AjMWx_R=UJbuqy9UP62m7CotyEtPC8TfCoHsQ@mail.gmail.com>
Message-ID: <CAKv+Gu_kTVY41AjMWx_R=UJbuqy9UP62m7CotyEtPC8TfCoHsQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] efi: put an API version number in the PE/COFF header
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 20 Feb 2020 at 15:56, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> On 2/20/20 12:06 PM, Ard Biesheuvel wrote:
> > After having added new ways to load the initrd and the mixed mode kernel,
> > we will need to tell the loader about this, so it can use the new, generic
> > method if supported, and fall back to the existing method(s) otherwise.
> >
> > This is an RFC - if there are better ways to record this in the image
> > somehow, please shout.
>
>
> Hello Ard,
>
> for boot loaders like GRUB I understand that the boot loader could use
> the initrd file path from its scripts to prepare a
> EFI_LOAD_FILE2_PROTOCOL matching the loaded kernel.
>
> I am not sure about the requirements for a firmware.
>
> Up to now the U-Boot UEFI sub-system does not care about initial RAM
> disk images at all. With Ilias suggested patch series U-Boot could offer
> a file from a fixed file location via a EFI_LOAD_FILE2_PROTOCOL.
>
> Is there anything else you expect a firmware like U-Boot or EDK2 to do?
>

It highly depends on the use case. The distros really want GRUB, but
others really don't want GRUB (like Ilias). There are other use cases
we are considering where the initrd load is just a memcpy() from NOR
flash.

Given that the u-boot EFI subsystem was originally conceived to be
able to run GRUB, you might see them as complimentary, but one of the
things I am trying to do is ensure that GRUB is not essential for
booting, even taking things like UEFI secure boot and measure boot
into account. Currently, on x86, these are all tied together in a way
that is hard to extrapolate to other architectures.
