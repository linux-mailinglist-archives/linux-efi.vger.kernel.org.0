Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4E1975FB
	for <lists+linux-efi@lfdr.de>; Mon, 30 Mar 2020 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgC3Hur (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Mar 2020 03:50:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgC3Hur (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Mar 2020 03:50:47 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6C020757
        for <linux-efi@vger.kernel.org>; Mon, 30 Mar 2020 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585554646;
        bh=RaqTJ6IPsmPKkHAMI7OUlKjTJHgFdCMuOUA7+YF/WzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=07egFliisyakvr3VVdbnencAzb1kszypH4BgYDdcaXhQ/KzZ2CqsraV+Zc5vi+wfT
         huGR9pe9mA6bTzcEHrFXnauakp20oV/Z9YXZCJqQawOfniApFF5HevC9e17cWvEjlc
         LhcGgYhbeYZ0YKmyUvYR44ChSD8I4GdYeXpEwVO0=
Received: by mail-io1-f53.google.com with SMTP id o3so11132664ioh.2
        for <linux-efi@vger.kernel.org>; Mon, 30 Mar 2020 00:50:46 -0700 (PDT)
X-Gm-Message-State: ANhLgQ282MZI9vNdrtsUMgavR8+NJNK8BA2Gbk5fzYU4oL6aa1uyzeQd
        3ESjSZlp3yOs1ZIkQaPUjucc9wsj23M8c3C3G0Y=
X-Google-Smtp-Source: ADFU+vtFcbvdMCPbXB0AjRsFQrvcNPc+17qBrWKWXSj6okj/Tr6w+4ZpiNqD5cbeJlnT761bV+iTIJjA5aGzOvcQrIY=
X-Received: by 2002:a05:6638:276:: with SMTP id x22mr10094486jaq.74.1585554645922;
 Mon, 30 Mar 2020 00:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200328205809.23825-1-ardb@kernel.org> <20200330074721.GV22097@bivouac.eciton.net>
In-Reply-To: <20200330074721.GV22097@bivouac.eciton.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Mar 2020 09:50:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
Message-ID: <CAMj1kXFPtY20afbAZgXT3As4TUuAqi3=pG8u19hjMjFxgN6HWA@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/arm64: avoid image_base value from efi_loaded_image
To:     Leif Lindholm <leif@nuviainc.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 30 Mar 2020 at 09:47, Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Sat, Mar 28, 2020 at 21:58:09 +0100, Ard Biesheuvel wrote:
> > Commit 9f9223778ef3 ("efi/libstub/arm: Make efi_entry() an ordinary
> > PE/COFF entrypoint") did some code refactoring to get rid of the
> > EFI entry point assembler code, and in the process, it got rid of the
> > assignment of image_addr to the value of _text. Instead, it switched
> > to using the image_base field of the efi_loaded_image struct provided
> > by UEFI, which should contain the same value.
> >
> > However, Michael reports that this is not the case: older GRUB builds
> > corrupt this value in some way, and since we can easily switch back to
> > referring to _text to discover this value, let's simply do that.
>
> It is not clear to me how "older GRUB builds" would differ here.
> I think more investigation is needed before making that claim.
> My suspicion is that some (old) version of non-upstream, shim-enabled
> distro-specific build is playing a part.
>
> So, do we have the option for more detailed investigations, or can we
> vague the claim up to say "some GRUB builds seen in the wild, based
> on an upstream 2.02" or suchlike?
>

I've queued a fix that prints a nastygram if the value deviates from
the expected one. Let's see if this triggers any reports.
