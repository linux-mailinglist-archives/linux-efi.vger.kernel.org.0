Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDA31135B7
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfLDTaD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 14:30:03 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:35110 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbfLDTaC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 14:30:02 -0500
Received: by mail-io1-f52.google.com with SMTP id v18so906277iol.2
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 11:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHZxpeTMFmIGKyX/u6Ck5ynkwqdqFqF88hy62xK7Ow0=;
        b=OfTsMSijIx5iDrE4MnefnhvZ+b7PAIFi7aycruSOY+czu8tdUMowgRXwWw4/bF8H5O
         Ms852QSI76/0YKXmx47+KdTOx6C70xf1FcZhmXAgIZjbQdvzpTHrK+SqRlyuXh5iJedZ
         sIl5S0NraNkCvtwIC7Sr/K9sh9nGezYjl6U7gv+gPoWX8ozE5fKwF9wBZeff3fW+WbbR
         WlK7F/sIQQX6xWIDYdQ72y0FPyoL8vLIc+6ZiGf/4SCkqw0rSX8wxPq/3MyHTE/BPlbb
         xdjsB8IPxpfwl3xYWudiWVcbzntzTrcPC84Jx9nLvv+1X66yHwTzJqn01NI4dlkniZ0J
         m63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHZxpeTMFmIGKyX/u6Ck5ynkwqdqFqF88hy62xK7Ow0=;
        b=K/YolGps0kaMuVF6GpmAz5gz2yK/0iCbhBj6PsQuG9keLP1kzwujwFQRKt6WvrRzZ+
         CW0OYpEJ/JnbPMNxDoHnaFhuhIpS0aZ9d9TFRAq3GLU+L9PR8D8Mfr4o+2dIjv0qjMeG
         8f1RbSbx0jNxvSHSRGA9XBBtcNHDcgepZsv6BUgiHQgVvdkqfzEBGZP61KPtFThLLN9Y
         Z3Xt+phNSuLwXV2s76yU4lPUjqSLW8iJ7pBGKGueit/FFj62AZmL6m+8ABbBHSiXSMbb
         psZLLP1gncG9sdWV5Xd4OWeFFJ+XIMH0cswQSeKgVbW7ydxkw+rpsSu2QDirHMT++aMN
         VQbQ==
X-Gm-Message-State: APjAAAXcuxQxNtjgxYSvZOGuRw9bLZKvV4wTzZQFPmjFQDuEr8PXNVCw
        n2bTS9e35lvD/wYGgtNIV9kBd4NnU3dRMdkO4mZjBg==
X-Google-Smtp-Source: APXvYqzrM6NiXcvbWHGmW+JQbnsF7zJDXp/ejaF1clWOLxX3z66xb2R736KZxc6Wf6gbbFELvGSztwLpl1blxyS/v5U=
X-Received: by 2002:a5e:880a:: with SMTP id l10mr3349954ioj.64.1575487801709;
 Wed, 04 Dec 2019 11:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20191203004043.174977-1-matthewgarrett@google.com>
 <CACdnJus7nHdr4p4H1j5as9eB=FG-uX+wy_tjvTQ5ObErDJHdow@mail.gmail.com>
 <CAKv+Gu8emrf7WbTyGc8QDykX_hZbrVtxJKkRVbGFhd8rd13yww@mail.gmail.com>
 <CACdnJusMeC+G3wq_oDGTYi1CBMWDiuq4NdANTBmhNBTDu5zCug@mail.gmail.com> <41cecdd8-f411-00c4-be82-be5d4d13fcb1@redhat.com>
In-Reply-To: <41cecdd8-f411-00c4-be82-be5d4d13fcb1@redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Dec 2019 11:29:48 -0800
Message-ID: <CACdnJuum5as_U1exNUOBqvXMq-cT_6vzYh7XvW-CteG5AqueqA@mail.gmail.com>
Subject: Re: [PATCH] [EFI,PCI] Allow disabling PCI busmastering on bridges
 during boot
To:     Laszlo Ersek <lersek@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 3, 2019 at 11:11 PM Laszlo Ersek <lersek@redhat.com> wrote:
> But in this case, we'd have to insert the PPB clearing *before* the
> (platform's) IOMMU driver's EBS handler (because the latter is going to
> deny, not permit, everything); and we can't modify the IOMMU driver.
>
> I guess we could install an EBS handler with TPL_NOTIFY (PciIo usage
> appears permitted at TPL_NOTIFY, from "Table 27. TPL Restrictions"). But:
> - if the IOMMU driver's EBS handler is also to be enqueued at
> TPL_NOTIFY, then the order will be unspecified
> - if a PCI driver sets up an EBS handler at TPL_CALLBACK, then in our
> handler we could shut down a PPB in front of a device bound by that
> driver too early.

Yeah, that's my concern - doing this more correctly seems to leave us
in a situation where we're no longer able to make guarantees about the
security properties of the feature. I think I prefer going with
something that's guaranteed to give us the properties we want, even at
the expense of some compatibility - users who want this can validate
it against their platform.
