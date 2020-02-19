Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2B164EB3
	for <lists+linux-efi@lfdr.de>; Wed, 19 Feb 2020 20:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSTRT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Feb 2020 14:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgBSTRT (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 19 Feb 2020 14:17:19 -0500
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0AE124677
        for <linux-efi@vger.kernel.org>; Wed, 19 Feb 2020 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582139839;
        bh=Rz3gA8pqtrOsAahW0iNPNupgwgTfbAcLsvWMp4vM50A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hn6VymJ1d12ETDXLhYYlSVNgsdZem9b5/bK6D+mn3Xtv0z761hKCMIo0z/ny3R9TK
         X1qj0sUzMKTUe6lhjyiKepUXjRtSiy6fqVP0+GWqQzEIHwgofnpMnfmEmfHG/bncOF
         nYcax/sa9WofCobXq9s2fH5CdtrI/fApbXk99Djk=
Received: by mail-wm1-f50.google.com with SMTP id c84so1900857wme.4
        for <linux-efi@vger.kernel.org>; Wed, 19 Feb 2020 11:17:18 -0800 (PST)
X-Gm-Message-State: APjAAAVIr8dwWPca4JxkK2BmZMpTfdlRPqkDwC6TMvdGPV1qsctJ6Ftq
        ITyOT1YzVJaDr/c9hoXlqI2fIJQoB78qc84f3XZXNg==
X-Google-Smtp-Source: APXvYqwwFvUdDA98QP3gcwLfSOxg45tLCIv+rjYJBKU9N0W7CEIG8g1sc5mGIJXHPrDqovFjziH3V7p9TPtK0U3fME0=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr12232415wmf.133.1582139837109;
 Wed, 19 Feb 2020 11:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20200219171907.11894-1-ardb@kernel.org> <6613b89d-113a-5f18-35d0-fba46bd53677@gmx.de>
In-Reply-To: <6613b89d-113a-5f18-35d0-fba46bd53677@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Feb 2020 20:17:06 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_Vu29yGYw25uw7_dH3KGTX-L6xy2kp3=n=O0NZPysiPw@mail.gmail.com>
Message-ID: <CAKv+Gu_Vu29yGYw25uw7_dH3KGTX-L6xy2kp3=n=O0NZPysiPw@mail.gmail.com>
Subject: Re: [PATCH 0/9] efi: implement support for EFI RT properties table
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Alexander Graf <agraf@csgraf.de>,
        Jeff Brasen <jbrasen@nvidia.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 19 Feb 2020 at 19:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/19/20 6:18 PM, Ard Biesheuvel wrote:
> > The UEFI spec version 2.8 errata A defines a configuration table called
> > EFI_RT_PROPERTIES_TABLE that carries a mask describing which EFI runtime
> > services are still functional at OS runtime.
> This configuration table defined in UEFI spec 2.8A is replacing the
> RuntimeServicesSupported variable introduced in UEFI spec 2.8 (which is
> already implemented in U-Boot).
>

Indeed. But using a variable was a mistake, and no OS implemented
support for it yet, so we decided it was best to issue an errata and
pretend that the variable never existed.

> Replacing APIs as an "erratum" is unfortunate.
>

It was a dilemma. Having the two solutions co-exist was not a great
prospect either.

> I am wondering whether in your implementation you will have to check for
> both the variable if the firmware implements UEFI 2.8 and for the table
> if the firmware implements UEFI 2.8A.
>

No, Linux will only look for the config table - that was the whole point.
