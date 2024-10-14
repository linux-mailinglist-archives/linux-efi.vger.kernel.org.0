Return-Path: <linux-efi+bounces-1962-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D899C69E
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D6B1F2273D
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF92158A04;
	Mon, 14 Oct 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6GzxhkQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573CA48;
	Mon, 14 Oct 2024 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900069; cv=none; b=CcfcWWfPSeQmnnbPuxlCIpsouF4F8vaL5laap547+4G06c2NDmhKpDHmHGjA8XHKwF8bheS2FSoBBvpYrbS4tSFBwksx7eggG2+1jWe9+L0erHnxGW4lsXUOrUlXA+qdX9BwNoAGPLbKEX/oW9sXHejxUnBUVJ9fIyUSKJXO9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900069; c=relaxed/simple;
	bh=UNS2MVwFWUAjxnME6SOqf6B7sXg8vJ2mbNhPcUcqDDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwPJF78Ol1cfoPNrg/Z/aCe8VNLzCAkUZ0ibALNWyOut4/pCXWZpqX1BqdhhyvSi5c+8oMZBeP1Zd42+SShgo17OAwNhw3IpHudUZn9lp94ZaHZcUmZpa88+T/IAE3maKzYAtRfmew/5pFbyErd71UihjvyMaS+wXU6kcOdFzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6GzxhkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9843EC4CED1;
	Mon, 14 Oct 2024 10:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728900068;
	bh=UNS2MVwFWUAjxnME6SOqf6B7sXg8vJ2mbNhPcUcqDDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a6GzxhkQ4eautPtzLeyU/2aqESv/18Ee0gObqeR5iPOIjpU9OBuR+5FyLX/s2bBhI
	 HwS01+WoWVIK6HT5ZnDbqBLiYASNA+JuQYbxZxDsCjLtgMXnJlyOxmeO5zuSQaDSqw
	 9jOBAzZGMKiGNJPjw08kmkh5xOpx7pl7mYdbIfQ30Y52YfrjsqD/963RAPjpqFlPxV
	 KHl4iSQeP7ge8d+zGsa8v0Tn4PLh9u2lHJ/Apsjkg9jn90QtM/OJnx3KqPMUtpWJlm
	 Qn2ddGaVoCFE54mLxBnyTSgqFtt8EjMa4ze1KJuKKCZzgcLFXlOS9nSRr4i1e7PQOr
	 HDJSJ1F48Obew==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539e1543ab8so3679261e87.2;
        Mon, 14 Oct 2024 03:01:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbpwTcZOWYrP8fnWcPLjSWQVtyiNB8Tz7wInztT9Tn88irFhhSu4Vn5b7STuyk11+fk/9JyjGW0Fyj@vger.kernel.org, AJvYcCW3ROYDzOCjeToxf//49kSNmU2RsyepSZl6dIKa1lQZvF4vLddUpULqKaFKIvrvuxV+Wu6Kgzuapni9wqhu@vger.kernel.org, AJvYcCWzmU1nVG/lmn6HUEo/YdQePBulXOeKzjc08q+SVo/Y9BhXVSBALNtbfEZDPnQa+ZMhPrcBVwBrR+1CnA==@vger.kernel.org, AJvYcCXsD2RK3rgBIRzkJOC+7B0GQKTMdpuy+EdHI4DuBGghSUiSjjp/s1KgCLwRr1xbqVQltYxgA0SqzfSW@vger.kernel.org, AJvYcCXyqmYbGc1Iq+SfgwRk6UeUDRX6zGWGojitfaG/tPOTJpEjs//JbJuuPfL3wztrblfREveWh5CF+QUO@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQpvmDrbhb/a2sJZ3izP6MmPoMwU5QLZMQX4XAJdwSulCQE8f
	rOEbA+6APkcpEAQmdjxw7009YRYq+7GR3EXxUN5MDKsWMgZkWP4JTq2T3vK8uIisI3Y/M/AqBJU
	5oPDY+/yf0x4iklyQJJ7bTNSEXsc=
X-Google-Smtp-Source: AGHT+IHQHJpa3JQRRAOQ2EbKcF3gvrh9bS5qYKnSRZDxhtEZKuUYMLy6xhfIzk3zgOavhyTTW1zVFEtyd3KDITjvTqI=
X-Received: by 2002:a05:6512:3b27:b0:539:8fbd:5218 with SMTP id
 2adb3069b0e04-539e5728316mr3615537e87.56.1728900066993; Mon, 14 Oct 2024
 03:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725429659.git.mchehab+huawei@kernel.org> <20241011115707.GCZwkSk5ybx-s9AqMM@fat_crate.local>
In-Reply-To: <20241011115707.GCZwkSk5ybx-s9AqMM@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Oct 2024 12:00:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGQSgeshrns7-EwTkG_c1dHgaxaVxO_FxWumdFx6m4vRQ@mail.gmail.com>
Message-ID: <CAMj1kXGQSgeshrns7-EwTkG_c1dHgaxaVxO_FxWumdFx6m4vRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fix issues with ARM Processor CPER records
To: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, James Morse <james.morse@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-edac@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 13:57, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Sep 04, 2024 at 08:07:13AM +0200, Mauro Carvalho Chehab wrote:
> > Jason Tian (1):
> >   RAS: Report all ARM processor CPER information to userspace
> >
> > Mauro Carvalho Chehab (4):
> >   efi/cper: Adjust infopfx size to accept an extra space
> >   efi/cper: Add a new helper function to print bitmasks
> >   efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs
> >   docs: efi: add CPER functions to driver-api
> >
> >  .../driver-api/firmware/efi/index.rst         | 11 +++-
> >  drivers/acpi/apei/ghes.c                      | 27 ++++----
> >  drivers/firmware/efi/cper-arm.c               | 52 ++++++++--------
> >  drivers/firmware/efi/cper.c                   | 62 ++++++++++++++++++-
> >  drivers/ras/ras.c                             | 41 +++++++++++-
> >  include/linux/cper.h                          | 12 ++--
> >  include/linux/ras.h                           | 16 ++++-
> >  include/ras/ras_event.h                       | 48 ++++++++++++--
> >  8 files changed, 210 insertions(+), 59 deletions(-)
>
> With the issues to patch 1 fixed:
>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
>
> I'm presuming this'll go through Ard's tree. Alternatively, I can pick it up
> too with Ard's ack.
>

Either works for me.

Mauro: please put all maintainers on cc of the code you are touching - thanks.

