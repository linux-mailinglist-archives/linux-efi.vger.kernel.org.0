Return-Path: <linux-efi+bounces-5097-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110D0BFEE61
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235753A8CFF
	for <lists+linux-efi@lfdr.de>; Thu, 23 Oct 2025 02:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003120C023;
	Thu, 23 Oct 2025 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JeOKP1jW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B895202960
	for <linux-efi@vger.kernel.org>; Thu, 23 Oct 2025 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761186066; cv=none; b=nxUjPVpCxLMfcjnQksxo3Ijg3ziM91mOvdrQj62/HVYc0bF5AvXGgGhKGbMoGDSOuvK2sh93Mw+iLWslORUCP/LxVrFAc24Zr5X/9jmhDk81u/jRmSts86rSYbW+q0jubd1XcCF7d6+xa85XIj2ikjld2CJqTA+GuYhoOwwxEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761186066; c=relaxed/simple;
	bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSLKMrKAM1HVtl3+9j1GyjNUfCCWzZgD9G2mv0I3wGrCqFaUYJdWrNnGPLiJxWZZLKJ/DckYLGou5UXax6ad4Pln6l8p8mQgi4Q82Heazrrz39RMBAog1NVQll0AzcbL1za7sT50Lf2/76DYuRcSx1N17GfhwVdOZiOJPon5+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JeOKP1jW; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3c99d6ff0deso107851fac.1
        for <linux-efi@vger.kernel.org>; Wed, 22 Oct 2025 19:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761186064; x=1761790864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
        b=JeOKP1jWkH3Q5sVlxkuytJ1976e3xdzNC7Buj5tcUiBp57HIu2pKPbyzNRpNpxglyt
         Xqt5s1ManbIWm75OI6p2fElNN9SjRuDsA8PklE6icmGCympivWXgtiX68QTSjuUQBY+t
         mpJrH54gY5c2NF8ieLSBXGedp8LqLDra2QQ87+VUm7G6IJcSeiAZiiM2kcdtbybXYovQ
         5ZGLAJzudMdyDsoi3dDZwHzG1OcqQyMv68sABuW1JwFz6h7PtEtexNH5q3xO2ja+KC4R
         TKhm2dSA/hIS1O5rH5Pzitn4ZwUvJUAr9Q9XEFhV+oNCF+q3lAOQTA32E1c7pGM2Mt7a
         zoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761186064; x=1761790864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R427Dmu3YODNR2POQX9bpNnQmIqw5THl/CmnS0STWbw=;
        b=qDCGe1lcYQShZ0sM644Xgf/ABvtywzFXZ4maS6B2DCuNtqS2fivu1LVFZmukA1LiuX
         hEPfw4vv+fHA+CSvgmMFVJllPg4ValtptUZi+shXblO00h0t8gHCpikhg+YkeraWWxbt
         ETMvAQEnPsacPuqNqV6kqMZgm/yaZ9N3AhDToK/zb+K6F1cNcjkUkSJd3TQnLC08I/PU
         V3venU4d77hFXNxObZsUO0tfbiVNDUQDEWDfCKhYiePhAB303X+ohA7lhuFnhgT9Cb4i
         6aUdrpY3F1zPcoHCqgC0N/YE9r88AfpjyNAVSz5Agzzx5M7/pffxdOwM7sN2VASsBl32
         jZcA==
X-Forwarded-Encrypted: i=1; AJvYcCXj3wi2pdLDknUFFoAzK35xHLI3Lc1hWePWjN32ljB+UhWi8+kCxSfS3CtLb1npSHts+Pio15QstSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJX3q2Bt9EGqTMwX5v8VSRcmgJuw9RtirM2APwbT9e0sp31L9
	nQk+sKjewTDIwRUMKKRrrv9MLI2WuxbJV+4DLad7cdBvonsfLWgdpOM27U+fq+kA8W5/FDP6T4K
	YD2X90PGVJKLepwAwm1kMM/BlSzap0WO9g4UubxQk
X-Gm-Gg: ASbGncsynBA7rS4N9SyqGPxVBea4rwPLB0/Lurk1sK3x0JOAtMplB5Fj/4QGMFaCwBb
	EKq9r3NIc9TNH02SriAh7+QtJ1ILT7jTLEAHtxrNkIBtDetqx5JX0Bg/xHrY6VO4CCsOjtU6zkk
	+fdkVhDk5c0Lxw6U0ophhKiX3SXhU4WN/K6yONWwIc7GthghNCOs7NrxctSwsslL+2usrvqX+mo
	uB6V1FGcTx/Y9ikCzwqlbHrb2d0/RQASI0MXjGsrdHBDMOVpCbscCFF77qAQFNznXNu45hOdIXi
	CRUx9CWV+F4uxM6Vr67q+dhqXzLCbA==
X-Google-Smtp-Source: AGHT+IHmRLKymahTzphWXAcebUY/vioCOyMVmnPrpkx+yuxscWkWBl0sW3ZAInJO76yoYP2ATwjD1Umq93FfkvRAowM=
X-Received: by 2002:a05:6870:648f:b0:341:33fb:81fe with SMTP id
 586e51a60fabf-3cd88b3151emr2212186fac.4.1761186064007; Wed, 22 Oct 2025
 19:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f006338-e69b-4b3f-b91f-0cc683544011@kernel.org>
 <20251022114527.618908-1-adriana@arista.com> <20251022201953.GA206947-robh@kernel.org>
In-Reply-To: <20251022201953.GA206947-robh@kernel.org>
From: Adriana Nicolae <adriana@arista.com>
Date: Thu, 23 Oct 2025 05:20:53 +0300
X-Gm-Features: AS18NWAnX3tdmQK4mY34lhn-vtbSOeSxTP9A7wJ8Ju2u0pZ_JzhEiwf9-6ikOXI
Message-ID: <CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] DMI: Scan for DMI table from DTS info
To: Rob Herring <robh@kernel.org>
Cc: krzk@kernel.org, jdelvare@suse.com, frowand.list@gmail.com, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, vasilykh@arista.com, 
	arm.ebbr-discuss@arm.com, boot-architecture@lists.linaro.org, 
	linux-efi@vger.kernel.org, uefi-discuss@lists.uefi.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:19=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Wed, Oct 22, 2025 at 04:45:25AM -0700, adriana wrote:
> > Some bootloaders like U-boot, particularly for the ARM architecture,
> > provide SMBIOS/DMI tables at a specific memory address. However, these
> > systems often do not boot using a full UEFI environment, which means th=
e
> > kernel's standard EFI DMI scanner cannot find these tables.
>
> I thought u-boot is a pretty complete UEFI implementation now. If
> there's standard way for UEFI to provide this, then that's what we
> should be using. I know supporting this has been discussed in context of
> EBBR spec, but no one involved in that has been CC'ed here.

Regarding the use of UEFI, the non UEFI boot is used on Broadcom iProc whic=
h
boots initially into a Hardware Security Module which validates U-boot and =
then
loads it. This specific path does not utilize U-Boot's UEFI
implementation or the
standard UEFI boot services to pass tables like SMBIOS.

Because there's no UEFI configuration table available in this boot mode, we=
 need
an alternative mechanism to pass the SMBIOS table address to the kernel. Th=
e
/chosen node seemed like the most straightforward way for the bootloader to
communicate this non-discoverable information.

I wasn't aware of the EBBR discussions covering this. I've added the
boot-architecture and arm.ebbr-discuss lists to the Cc. If there's a prefer=
red
EBBR-compliant way to handle this for non-UEFI boots, I'm happy to adapt
the approach.

>
> > This series adds support for the kernel to find these tables by
> > reading properties from the Device Tree /chosen node. The bootloader
> > can specify the physical addresses using "linux,smbios-table" and
> > "linux,smbios3-table".
>
> /chosen node entries go in chosen.yaml schema in dtschema repository.
> But first, I need to see some agreement this is how we want to support
> this.
>
> Rob

Adriana

