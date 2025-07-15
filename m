Return-Path: <linux-efi+bounces-4342-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DB8B04EF8
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D655B16FF1B
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293352D3238;
	Tue, 15 Jul 2025 03:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1H6MnsW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152E2D23B1;
	Tue, 15 Jul 2025 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752550169; cv=none; b=m1BX6+SnPVd5WciEwqp0tF2WR3xEnd+rINgip/Jhy2LeNE2gINcAOXCb3aLkVfz+/vatsYa2qV2PpzVpAvTdUSl5MtFhbaom3xEhnv0vLvlRNYDFm8busGIQHvzXKVe+VQbdKFX9wdP2Lmw4e+Rh+MAdOI6wcS/FSVnvwj5mbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752550169; c=relaxed/simple;
	bh=ieqd6xCHgI1ZHPQbWmrk7Nb+/qzuOEd8qzdDp3KdSmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpRxscc8KFZWoUV63G4fHY3mctV/X0JzLO1r4sexI1bOU6Mvp8b/L3Vc/lcFULiqorKZtdU8RH+qLZR8hVliNiWMiDmfSedvHXWtom2b6gvGqS3MZD4EplSBV0ec/7QWBEj34uPZVnKLqibJSF5WIIPOnzHhZKS8la9BDWfD7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1H6MnsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AD8C4CEED;
	Tue, 15 Jul 2025 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752550168;
	bh=ieqd6xCHgI1ZHPQbWmrk7Nb+/qzuOEd8qzdDp3KdSmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b1H6MnsWja4+R/HGgp9tU9geJmQM3bS+T64RZtg6NFD+ynaIvQfKgLfZf9wFIQMFw
	 IEpBUdkrm3FNoiP0THEolt5J0qPGPi+XaiYUIKpViM0PEydXydu69aXClbW1kC0xKD
	 7JUh792Zp8v8r6oGDOmlPdLygPejN/QbXadKp3Cbs1EmM7s5hknoWmpnwwmetGDygw
	 T6eNIrkIRciU2Utnv1UBAZfPOojItTM8l0pnhPXGWHQIvXh4uX/WDMl8i8a/k/dKSg
	 yyRO3jqQ4zi0F9Ugl6CU4fuIXbAGo/rYgZLFmgVhaPTku1dFREHd6pT5oKhurk/jP+
	 JytHwh6zZkQAg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-555024588b1so5616350e87.1;
        Mon, 14 Jul 2025 20:29:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVM+nuIHPjLDlC36gkUNeC/JAqoxQZYbNcPZu/3HXtGdevDdXkGMBftdqh/8lDOUyM2WMz8nhM1OluvrC2Y@vger.kernel.org, AJvYcCVPG17+XdtoGrnek5VQzepLXzh3wWP3pOwfprcBgQ1n6CU1wxRm41JmN3t0EHV2vLcdXh/1QrawYtMJ@vger.kernel.org, AJvYcCWTxZHbSd9gLJHHVgOIoMRw5RUG4jW+Ig63C9jrHpT+htFTv561smO6zG5gz3uwT8cMfOllUtm5Xhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3YDkqPDFp1qfHucJGZ31+I05/YGA2gD4gx0OKbk4AwGeCseK
	oLhZgLNaAnKk8qKxSlK7nXzOt4JkjKg9BnaqOnIcWRwxVMSFJ/fzs5FCUzQKXqwLBcLD/tgo7yY
	TzJw4zqGvpB7ZI7QKE64NmWylZl1HArM=
X-Google-Smtp-Source: AGHT+IFIz1rDkWifGEuRDAIW8VnNdmTc2Z0VIxz+qevBW3febeLf9zJqzx1t6qVV2NjD4iuG6fjmMDCJiXdzlUbsY78=
X-Received: by 2002:a05:6512:39c3:b0:553:2fec:b139 with SMTP id
 2adb3069b0e04-55a044ec444mr5090549e87.24.1752550166947; Mon, 14 Jul 2025
 20:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714060843.4029171-5-ardb+git@google.com> <422e2a72-972f-41f4-a0b3-d69a6cb0c2e2@canonical.com>
In-Reply-To: <422e2a72-972f-41f4-a0b3-d69a6cb0c2e2@canonical.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Jul 2025 13:29:15 +1000
X-Gmail-Original-Message-ID: <CAMj1kXEXpBF8hPaVMU0sDgNysYT66MDRmr3JHO4Lg1sJB_Yteg@mail.gmail.com>
X-Gm-Features: Ac12FXyPeU_gWXO9-8if9ZFnLW7qkSAVnhXpIQ13tyFhKHPmacdG9H_jV_FpMvQ
Message-ID: <CAMj1kXEXpBF8hPaVMU0sDgNysYT66MDRmr3JHO4Lg1sJB_Yteg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Remove unused EFI runtime APIs
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	Feng Tang <feng.tang@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Bibo Mao <maobibo@loongson.cn>, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, x86@kernel.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 18:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 7/14/25 08:08, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Using EFI runtime services to program the RTC to wake up the system is
> > supported in theory, but rarely works in practice. Fortunately, this
> > functionality is rarely [if ever] used to begin with so we can just drop
> > it. (Note that the EFI rtc driver is not used by x86, which programs the
> > CMOS rtc directly)
>
> The main problem I see with firmware offering access to the RTC via UEFI
> services is that two different drivers, the firmware one and the Linux
> one might be trying to access the same busses or registers which might
> lead to unexpected results.
>
> Recently there was a discussion in the RISC-V technical group for the
> server platform specification where the same issue was discussed
> concerning SetTime().
>
> As a UEFI firmware should not care which operating system is booted, it
> should be up to the OS to disable EFI access to the RTC if it has native
> access.
>
> Could we disable all the EFI services for the RTC in Linux dynamically
> when an RTC driver is successfully probed?
>

I don't think this would be the right way to do it.

It also depends on whether ACPI or DT is being used to describe the
platform to the OS.

ACPI does not support describing the RTC device, so it should provide
the EFI services.

DT can describe the RTC device directly, so I think it is acceptable
for such firmware to mark all RTC routines unsupported in the RT_PROP
table, and just expose the RTC device directly.

The OS shouldn't have to reason about these things: it is up to the
platform to describe itself unambiguously.

