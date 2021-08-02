Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EBD3DD518
	for <lists+linux-efi@lfdr.de>; Mon,  2 Aug 2021 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhHBMEW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 2 Aug 2021 08:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233446AbhHBMEU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 2 Aug 2021 08:04:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ACA460F70
        for <linux-efi@vger.kernel.org>; Mon,  2 Aug 2021 12:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627905851;
        bh=GuVRtiEZgwzB4ZHivw/4bqrAiCCM9VDp/UaLToarLYA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=clNdmb7gfW7RgEGOyULgl1KmyUX+pZ0KyKm9bfeS91mOvKsnll7U95LhG0YrisRK2
         zrSferw1N6VOocfcvKGhn5iq0jj4wpdD7NtPRyEAT/4F5SfaxgsLFA1E0NF4kbsw9W
         4NeQ0kvqoIP2GQwtVV8V8tVbvTYFclFPXE29DDjh/xZG0xIUQGvroGMVctra1Z6AEj
         kuNPGT/ONZ5XjFpotuFjtV9OMXl2nk6LErsTLGJlX26c1QdYPFPRyxxiUbEbbeCLx3
         JwzTJLEaBzt4x/w/mOMlMeAE9ZG5FGGhqqqtE9MsYCiD6PWJEb64XOlcIp4+3IXItg
         nSdgmFuWv4fQw==
Received: by mail-ot1-f41.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso17186554otb.10
        for <linux-efi@vger.kernel.org>; Mon, 02 Aug 2021 05:04:11 -0700 (PDT)
X-Gm-Message-State: AOAM530mR2tiHvaQVOcqjmVnkNuMw4P2Kp2NPXaJNcwuRCpf9M2YKUXU
        eT4Bbbieo/lNEmbMUarJbA13xNdTqnyn/Qhyds0=
X-Google-Smtp-Source: ABdhPJwpQ7RxbUcw7JElq4jXK61ZUU9WfqpfCah1O1BilNtesVeCTx/j3YV3BbPYEHRWBG7JPo+0wBmhyOp9215NVqc=
X-Received: by 2002:a9d:2625:: with SMTP id a34mr11233916otb.77.1627905850704;
 Mon, 02 Aug 2021 05:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210726145156.12006-1-ardb@kernel.org> <b3041039f08ffd524eef37d35950b30c5e11255e.camel@kernel.crashing.org>
In-Reply-To: <b3041039f08ffd524eef37d35950b30c5e11255e.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Aug 2021 14:03:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEu_C13WRaBML9T5gvXsukxP8B0hzH3bn5ZD6HpNshmZw@mail.gmail.com>
Message-ID: <CAMj1kXEu_C13WRaBML9T5gvXsukxP8B0hzH3bn5ZD6HpNshmZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] efi/arm64: work around Image placement issues
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2 Aug 2021 at 13:26, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Mon, 2021-07-26 at 16:51 +0200, Ard Biesheuvel wrote:
> > Ben reported that distro GRUB may fail to boot in some circumstances,
> > and tracked it down to an issue in the way distro GRUB allocates space
> > for the image. Due to an oversight (addressed in patch #2), this
> > condition is rarely triggered, but let's work around it in any case (#1)
> >
> > Remaining patches add further warnings for conditions that are unlikely
> > to occur, but should not be ignored.
> >
> > Build tested only.
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> All 4 patches:
>
> Tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> I checked that it catches all of the errors, including reverting my fix
> for randomalloc.c and verifying that it caught (and successfully worked
> around) the original boot  crash.
>

Excellent. Thanks for tracking this down and getting it fixed properly.
