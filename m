Return-Path: <linux-efi+bounces-3898-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223BBAE27F2
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D11174021
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jun 2025 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC41CCEC8;
	Sat, 21 Jun 2025 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYtLxsbR"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D645642A96;
	Sat, 21 Jun 2025 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750493766; cv=none; b=YBtR+korZ2EL3KIo/dKl7f8jGcR4NnjAYqG9cwYtCQiR3hcFZyd6ah2xeYiICEDUOfqek9tBhNtO4oJV+69HRgFPIKrVKPh4h4xX16M8F7G7hVOZGl6OapkzhphfIR+JGm04kc8Gbt1VAF+Ip+uOgl1JuwjHrhw46LwomUkjNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750493766; c=relaxed/simple;
	bh=oN1ZX1XWIvOgdq3a5xRnlSs5Yw9BiIoC3X45+HjSENk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5lU1UWw1Eb/KqRdD+8QImnenj/tIAPqHVTCCnT8m2QOrzjFK/exGat4ryGAJQ0k9nN/pD/VpqD6qbq4Zq2X6tj3aV1GRpXFkdntoKsMGP/YAzq28LF5S2o2QTRRhM98BnYBxOyQSU4WAR0QmSA+fetaGguXARU9qNilNNZjSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYtLxsbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A12C4CEE7;
	Sat, 21 Jun 2025 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750493765;
	bh=oN1ZX1XWIvOgdq3a5xRnlSs5Yw9BiIoC3X45+HjSENk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sYtLxsbRQ+Pf/Q1LzoMMge3CoxJso/FSDGjW2taSSBQvxtzAwIwHfzz+9hRJNsd5c
	 Gcz+z6X3KY9FN1CenXi6JNy8AVZp3PQv69maINV/3j2yliTuyOwIIhn7/u6VDW8JFY
	 RO3BWFJjhp2Ea1VxgX0y4teSzd3AMrfPkq6in69tQwkjspoZpZAoguK5ZQ2KF5gi6D
	 BEztz9Ae6TQj++HSK3P9gMbToAnu/kRB+OMLIC1nOUaWeEEP0sZidoKx16xAR1vMvf
	 rhDCMZB3+Ij61Bd31QZIT3qD+GbwmgkNLx0kXZmQpyjS7W0t8AD5Oxfi37PqGbKutB
	 OAwbSBu6cy+dg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b3c292bb4so22584871fa.1;
        Sat, 21 Jun 2025 01:16:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIqToRRyEFWL7lAnN6XGMxk6uUM09CLKV9WditTYTIU5zm5MC6vcgt8ccsPTEp6vt3c/QgV07/pirBEhRO@vger.kernel.org, AJvYcCV0DRq+ZpNzH2jxXKzBmL1GmsQA/O7DhQTQQ96f2H17Us/ntO+ralJ9ah6R+BxO7i8yp3TQS/aruFjtDA==@vger.kernel.org, AJvYcCX+Doxn5m0J4utHOBWnTgeupOG4IjbFTf3sRkoeb+Qw2CrrhudkVZUAtFm9S73Md4i/gKvexR8Xx0Cj@vger.kernel.org, AJvYcCXCwfaOTmtWTocSmrRmLDMkls9T/hBZiua6t3HjXVepbtvSaln4MSFiQqwe1/+aqk+7DgcIHISWdCCD@vger.kernel.org, AJvYcCXk5v7qEKMXjTvZSwQmpafx/IwYyDclcC72uz3mb2Pxl3doULLVaOEGDt2cU39Wi37SNcYvw4jWOBNP@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMiBqCaUaoy2EG/or+LcE+ZaJmNHvWWm5STVIGcvYkRLa5cas
	qPbQzlvrmjyoGFtxHhVBw1Vfd3BW3g17GKYnb46lJCAY5NPwqtk2OhruZY9+Ry9QCR3nlMMxzCN
	k+LA1R7rKzH0dUa9y6LsJEdBDLk8shMI=
X-Google-Smtp-Source: AGHT+IG7G1p+eMBQX8l5H3KUmCP0DYsHNGAcJGRnYN1fOb7tfyfV+XhAE8P+Qi1We2rHg3wDZBrW8geftynHAWEFjgU=
X-Received: by 2002:a05:6512:3da6:b0:553:2dce:3ab2 with SMTP id
 2adb3069b0e04-553e3b9910emr2075407e87.6.1750493763725; Sat, 21 Jun 2025
 01:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725429659.git.mchehab+huawei@kernel.org>
 <20241011115707.GCZwkSk5ybx-s9AqMM@fat_crate.local> <CAMj1kXGQSgeshrns7-EwTkG_c1dHgaxaVxO_FxWumdFx6m4vRQ@mail.gmail.com>
 <efbc8109-1854-43b2-bff4-095ecd5970cd@os.amperecomputing.com>
In-Reply-To: <efbc8109-1854-43b2-bff4-095ecd5970cd@os.amperecomputing.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 21 Jun 2025 10:15:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSNT08QrCp1jazmi9ANpZ7RCuS4kHo9x6hwxtp6z0Nhg@mail.gmail.com>
X-Gm-Features: AX0GCFvW2Y9Ngxmoff6t5ijZh-D91PAeNXLsY6MvtMOOptWR8A-DweeytvCeo3M
Message-ID: <CAMj1kXGSNT08QrCp1jazmi9ANpZ7RCuS4kHo9x6hwxtp6z0Nhg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fix issues with ARM Processor CPER records
To: Daniel Ferguson <danielf@os.amperecomputing.com>
Cc: Borislav Petkov <bp@alien8.de>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>, 
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 20:30, Daniel Ferguson
<danielf@os.amperecomputing.com> wrote:
>
>
>
> On 10/14/2024 3:00 AM, Ard Biesheuvel wrote:
> > On Fri, 11 Oct 2024 at 13:57, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Wed, Sep 04, 2024 at 08:07:13AM +0200, Mauro Carvalho Chehab wrote:
> >>> Jason Tian (1):
> >>>   RAS: Report all ARM processor CPER information to userspace
> >>>
> >>> Mauro Carvalho Chehab (4):
> >>>   efi/cper: Adjust infopfx size to accept an extra space
> >>>   efi/cper: Add a new helper function to print bitmasks
> >>>   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
> >>>   docs: efi: add CPER functions to driver-api
> >>>
> >>>  .../driver-api/firmware/efi/index.rst         | 11 +++-
> >>>  drivers/acpi/apei/ghes.c                      | 27 ++++----
> >>>  drivers/firmware/efi/cper-arm.c               | 52 ++++++++--------
> >>>  drivers/firmware/efi/cper.c                   | 62 ++++++++++++++++++-
> >>>  drivers/ras/ras.c                             | 41 +++++++++++-
> >>>  include/linux/cper.h                          | 12 ++--
> >>>  include/linux/ras.h                           | 16 ++++-
> >>>  include/ras/ras_event.h                       | 48 ++++++++++++--
> >>>  8 files changed, 210 insertions(+), 59 deletions(-)
> >>
> >> With the issues to patch 1 fixed:
> >>
> >> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> >>
> >> I'm presuming this'll go through Ard's tree. Alternatively, I can pick it up
> >> too with Ard's ack.
> >>
> >
> > Either works for me.
> >
> > Mauro: please put all maintainers on cc of the code you are touching - thanks.
>
> What can I do to help this patch move forward?
> I noticed it needs to be rebased as of kernel v6.15.
>
> Would it be helpful if I were to rebase, add all the maintainers to the cc, and
> resubmit ?
>

Yes, please. And make sure you incorporate Boris's feedback on patch
#1 and apply his conditional ack.

Thanks,

