Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9E4277D3D
	for <lists+linux-efi@lfdr.de>; Fri, 25 Sep 2020 02:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIYAyi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Sep 2020 20:54:38 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:34964 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgIYAyi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Sep 2020 20:54:38 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 08P0sBXU010109; Fri, 25 Sep 2020 09:54:11 +0900
X-Iguazu-Qid: 34trJYZuoCRlJhwH8R
X-Iguazu-QSIG: v=2; s=0; t=1600995250; q=34trJYZuoCRlJhwH8R; m=5x7FASoPHBhzBBc9o2Kptvc5cYFjVXPhl+ozBC+N1SU=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id 08P0s84l004113;
        Fri, 25 Sep 2020 09:54:08 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 08P0s72w005008;
        Fri, 25 Sep 2020 09:54:07 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 08P0s7NM011090;
        Fri, 25 Sep 2020 09:54:07 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli Channabasappa <skoralah@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, Tony Luck <tony.luck@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v4] cper, apei, mce: Pass x86 CPER through the MCA handling chain
References: <20200904140444.161291-1-Smita.KoralahalliChannabasappa@amd.com>
        <87wo0kiz6y.fsf@kokedama.swc.toshiba.co.jp>
        <20200923140512.GJ28545@zn.tnic>
        <87pn6chwil.fsf@kokedama.swc.toshiba.co.jp>
        <52c50f37-a86c-57ad-30e0-dac0857e4ef7@amd.com>
        <20200924175023.GN5030@zn.tnic>
Date:   Fri, 25 Sep 2020 09:54:06 +0900
In-Reply-To: <20200924175023.GN5030@zn.tnic> (Borislav Petkov's message of
        "Thu, 24 Sep 2020 19:50:23 +0200")
X-TSB-HOP: ON
Message-ID: <877dsiislt.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Sep 24, 2020 at 12:23:27PM -0500, Smita Koralahalli Channabasappa wrote:
>> > Even though it's not defined in the UEFI spec, it doesn't mean a
>> > structure definition cannot be created.
>
> Created for what? That structure better have a big fat comment above it, what
> firmware generates its layout.

Maybe I could've used a better choice of words - I meant to define a
structure with meaningful member names to replace the *(ptr + i)
accesses in the patch.

The requirement for documenting the record layout doesn't change -
whether using raw pointer arithmetic vs a structure definition.

>> > After all, the patch is relying on some guarantee of the meaning of
>> > the values and their ordering.
>
> AFAICT, this looks like an ad-hoc definition and the moment they change
> it in some future revision, that struct of yours becomes invalid so we'd
> need to add another one.

If there's no spec backing the current layout, then it'll indeed be an
ad-hoc definition of a structure in the kernel. But considering that
it's part of firmware / OS interface for an important part of the RAS
story I would hope that the code is based on a spec - having that
reference included would help maintainability.

Incompatible changes will indeed break the assumptions in the kernel and
code will need to be updated - regardless of the choice of kernel
implementation; pointer arithmetic, structure definition - ad-hoc or
spec provided.

Having versioning will allow running older kernels on newer hardware and
vice versa - but I don't see why that is important only when using a
structure based access.

>
>> > If the patch is relying on the definitions in the SMCA spec it is a good
>
> Yes, what SMCA spec is that?
>
>> > idea to reference it here - both for review and providing relevant
>> > context for future developers.
>> 
>> Okay, I agree the structure definition will make the code less arbitrary
>> and provides relevant context compared to pointer arithmetic. I did not
>> think this way. I can try this out if no objections.
>
> Again, this struct better have "versioning" info because the moment your
> fw people change it in some future platform, this code needs touching
> again.
>
> It probably would need touching even with the offsets if those offsets
> change but at least not having it adhere to some slow-moving spec is
> probably easier in case they wanna add/change fields.
>
> So Smita, you probably should talk to fw people about how stable that
> layout at ctx_info + 1 is going to be wrt future platforms so that
> we make sure we only access the correct offsets, now and on future
> platforms.
>
> Thx.
