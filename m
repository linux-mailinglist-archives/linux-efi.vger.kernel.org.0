Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FEF275AC8
	for <lists+linux-efi@lfdr.de>; Wed, 23 Sep 2020 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIWOwb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Sep 2020 10:52:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgIWOwb (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 23 Sep 2020 10:52:31 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E7C21D43;
        Wed, 23 Sep 2020 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600872750;
        bh=BuNEmV3RbwiVDXoElwTtCudTourRjlDPhW6anCvkcOI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=omls3z2aNzSeO7YXJU8B+XpmHWyF7nGvgmS7/nl0TsXghchmwrQSj6W/Fr3D5YEEA
         J7QcVSmwme+9NAIeJhS1gJ0GcDpRBpSLJ1SPedz5eghiQ4uCcTSt/OrjAVrb1FR3eB
         lhPYORoRYhhHGaxA1Uc1//fJY0ro08uk0kL2Zw+s=
Received: by mail-ot1-f49.google.com with SMTP id u25so19229375otq.6;
        Wed, 23 Sep 2020 07:52:30 -0700 (PDT)
X-Gm-Message-State: AOAM532qvSuuWokCOVRdtUsJQZxJwEgbw6r7UtI/FW+vDTftHV5mrjEW
        mZmbVbvOzcVExMZ9B9WC4p8GhV/X2HjptSPc744=
X-Google-Smtp-Source: ABdhPJz1tB0v4rYXWKiVzq4CO7HqLAQuT148DttuOsfIeDd/8T6HdfGV6yNZdU27bv3drjcxGrhH7zes5DzzT22HS3U=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr43512otk.108.1600872749842;
 Wed, 23 Sep 2020 07:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
 <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp> <20200923140512.GJ28545@zn.tnic>
In-Reply-To: <20200923140512.GJ28545@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Sep 2020 16:52:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH2uWEfAxTf_+6YN-Sp2VNKtaGhqAx4jyvhW3xR=0Jaug@mail.gmail.com>
Message-ID: <CAMj1kXH2uWEfAxTf_+6YN-Sp2VNKtaGhqAx4jyvhW3xR=0Jaug@mail.gmail.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA
 handling chain
To:     Borislav Petkov <bp@alien8.de>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 23 Sep 2020 at 16:05, Borislav Petkov <bp@alien8.de> wrote:
>
> Smita,
>
> pls sync the time of the box where you create the patch:
>
>  Date: Fri,  4 Sep 2020 09:04:44 -0500
>
> but your mail headers have:
>
>  Received: from ... with mapi id 15.20.3370.019; Fri, 18 Sep 2020 14:49:12 +0000
>                                                 ^^^^^^^^^^^^^^^^^^
>
> On Wed, Sep 23, 2020 at 07:07:17PM +0900, Punit Agrawal wrote:
> > I know Boris asked you to add the reason for the Reported-by, but
> > usually we don't track version differences in the committed patch.
> >
> > Boris, can you confirm if you want the Reported-by to be retained?
>
> How else would you explain what the Reported-by: tag is for on a patch
> which adds a feature?
>

I think the question is why we are retaining this Reported-by header
to begin with. Even though the early feedback is appreciated,
crediting the bot for eternity for a version of the patch that never
got merged seems a bit excessive. Also, it may suggest that the bot
was involved in reporting an issue that the patch aims to fix but that
is not the case. The last thing we want is Sasha's bot to jump on
patches adding new functionality just because it has a reported-by
line.

So I suggest dropping the Reported-by credit as well as the [] context
regarding v1
