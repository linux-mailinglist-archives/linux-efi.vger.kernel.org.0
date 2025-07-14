Return-Path: <linux-efi+bounces-4310-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C5B036F5
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 08:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4833B9A2C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2A224B1F;
	Mon, 14 Jul 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uli+yctb"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25F115B971;
	Mon, 14 Jul 2025 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752474005; cv=none; b=O2FlVrIGLqguWI4o6tUeUC2/adbmhAMrFOj6Ai6dFfasJPVJnKHx3qILm1ymVzsEuPR5RjOfOeU2Oz0XH/ubZO14Z1ltGscgzDhPsApDG29CV5BhbnrVUlbysHBcpoKkLzV7NUtixtlToSL2IAn6nXFTe5GIo/9eu6oGrhll+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752474005; c=relaxed/simple;
	bh=606fsEOf3GOJX8AxMnc5SbWlI62YxfGkSD/kQ0qCCvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMb3QGGO76WL5+5A0pEPcjaG3ZkdTvJxYdoat6E1K6j8STtIYyI5lfxbLhNg9ilo49tDa9oyZ7ASN0Qkz5iEEBHdfD25/rVca1Fgnd4XQhhLY1phsKcMpmM93DiMe3RK5jYTe0E04TAhdh/voGfK8dt/k7n+ZpRHdyV7XSJosTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uli+yctb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59805C4CEFC;
	Mon, 14 Jul 2025 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752474005;
	bh=606fsEOf3GOJX8AxMnc5SbWlI62YxfGkSD/kQ0qCCvc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uli+yctbio2KJL40Z0sJCpobKSwWMS/q9w1hC7hZxQO+Y+Yg03V3qCxrNzGbmBH/k
	 xDHWt/WbWnRin3S1wBbDlOUnsd1qGPShPPfsRnU8gPpt5m+va+KWqTlPxVHkID+bA5
	 MPc/KMYSYYLOnAEyZp5ltOLX3deIij8UmOcLkDBpSom6eSqy6g9GV93wcRbjUuKmvN
	 Cisa9PX+i5dXi81XjVqFnQr/GkDJjE0ePHxWYAS/Jb3ioh613e2GxXXC45UvWqxRRI
	 24MWxqdO6M6ayoJpoGGkhfi+RvhPDuunG/Mj3Dv4sHw+1DTDFTfKpJ6xsFQllw8/N6
	 e/WJNUS9XoO8w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553b584ac96so3974943e87.1;
        Sun, 13 Jul 2025 23:20:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg7DoSZEqSmOl8FKJMFnazefNaj9KgaQXMByGmsLbfLkU8RyBwqz4/A2BNccC8yXhY2NU5L6qrQu0=@vger.kernel.org, AJvYcCVzqQVRe97vHs7ytoY0g29srmCsAv1tau6kJsZgp89rV7DJgbk2dNp4zIujtSlj4/L+4vyN4O0XpepU@vger.kernel.org, AJvYcCXoMIhqL8PbiebjMAaoaLcNEjCaSAvDIvWcPm+KoWMtV7FiNl+CM5w87dX8rtr4L/+tqNjR3or4ewEnDbjm@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsreTDzPb9dsxL6f9L6Xv+j67nWD/UkIQofZ2gvhXsOBOcLvp
	MgRem4l6Zj6QHRONUWuFKQCol6k8Vqn3WoNwNAAN7rnJEfAE2OSV1CIEBb+1iUBP7+K05aA/hNg
	HwAY7OVVd1RdhwNtnxMo2daFSlG/Pk50=
X-Google-Smtp-Source: AGHT+IE2y+mnn6gRDYyvRcFjRA9M/TcvC+Yv7itcf8PEq8SUCnfludPIC0L+2CId0IaAy39lcVu+VQplF3E0k6RCiek=
X-Received: by 2002:a05:6512:3048:b0:553:5135:6a0e with SMTP id
 2adb3069b0e04-55a057c3971mr3597796e87.4.1752474003585; Sun, 13 Jul 2025
 23:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com> <20250714060843.4029171-6-ardb+git@google.com>
 <dade7d17-d45d-455e-a43c-01e9ea95c3b4@gmail.com>
In-Reply-To: <dade7d17-d45d-455e-a43c-01e9ea95c3b4@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 14 Jul 2025 16:19:52 +1000
X-Gmail-Original-Message-ID: <CAMj1kXETDd+19i+awMx1v1sE4RXhF-r2a-mTa3rWfus5s4HMmw@mail.gmail.com>
X-Gm-Features: Ac12FXyqdPXKdPkXKcrHisnGj_9A8qao-_Ean6Zn-muhfOH0lpX7Li9QylqqJXw
Message-ID: <CAMj1kXETDd+19i+awMx1v1sE4RXhF-r2a-mTa3rWfus5s4HMmw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] efi-rtc: Remove wakeup functionality
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 16:13, Demi Marie Obenour <demiobenour@gmail.com> wrote:
>
> On 7/14/25 02:08, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The EFI rtc driver is used by non-x86 architectures only, and exposes
> > the get/set wakeup time functionality provided by the underlying
> > platform. This is usually broken on most platforms, and not widely used
> > to begin with [if at all], so let's just remove it.
> systemd uses the underlying functionality: a timer can wake the system up.
> I have no idea if that is implemented in terms of this function, though.

To be clear, you are referring to wake from poweroff at some date/time
in the future, right?

This change does not remove this functionality from the RTC subsystem,
it just ceases to expose it on non-x86 EFI platforms that claim to
support it.

For reference (which I should have included in the cover letter) [0],
there are arm64 server systems which always return an error when
calling this API, and most non-server arm64 systems do not implement
it to begin with.

The patch in question implements one of the workarounds that was
considered, which is to invoke GetWakeupTime() when registering the
RTC, and disable the wakeup functionality if that fails. However, that
call by itself could easily regress other platforms, where
GetWakeupTime() was simply never called before, and where calling it
may tickle other bugs.

Hence this RFC: if nobody uses this API on non-x86 EFI platforms, then
I'd rather not support it to begin with.



[0] https://lore.kernel.org/all/20250710084151.55003-1-feng.tang@linux.alibaba.com/T/#u

