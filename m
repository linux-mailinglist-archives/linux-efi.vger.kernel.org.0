Return-Path: <linux-efi+bounces-1748-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F897871C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E8561C22049
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC7783CD4;
	Fri, 13 Sep 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpXvA/Pa"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE5F823C8
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249687; cv=none; b=MZPYorLgfcosXFMzzd+TL23YtNpq1+PxzgpsgrTuxnmLCB2rwC+mNq88O+4UjHwajyTv/80rJTmD+muMPyqDWHDgEatCmnaKubtvJB+z/T+aaqWfxicLu2QIoimyvQI2R5Kv1LYPkp/VNDMFBCo4jbQuoBx0z+6bY3lGX6PzAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249687; c=relaxed/simple;
	bh=MCsJAyfqwky5M0sNxL7tWlebUcT9C5zs70BHOztKZDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouaH8LcvJCuK00tVn2lUwouY7M6nYOjiYV7F4adQ/4+OhnicoTJ2CDx+0p4S8W9gzY/FKES3arkS5jbv8eUAS8MeNwZuQM8JvtMlDSiUFyyJlUkePHdk3GhdYBA4takAmrOKAxqpcTvXAzG8jKvbM7LFTlvJFUvNSIn4KaPrLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpXvA/Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858ACC4CEC7
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726249686;
	bh=MCsJAyfqwky5M0sNxL7tWlebUcT9C5zs70BHOztKZDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VpXvA/Paka/YDdxU413YR3ozJ2QpR8kb75Z73XJ98Dxc1IfH7ShaafDOZF1KNMo3N
	 f3Tp1QFMwolLe3GcPIQ2qB3Zhjbu4nUFE2ELY7R9TiJVGkZE2huzfWz97xEKRL/PIM
	 dLkAlsROrRDRIdxK5nrX9mqBvq4X/wE5H9+uaV+PDSXC8RTkhxJ+9bAJO4JOmSVbpc
	 qVc06rmbY+apqhyENy4A4DLkYlTNskWXUDkqToWXUM3K/iX9C7ARecfx8tt7hRIGqy
	 PD614SxnS5MCPI+5V+ZzJWjZKNZ4Lhu88apwWg5KWPZcOHGZJ6rWPc9XDWM1Ev0FBb
	 mj0jU/0HaU61w==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f760f7e25bso25918251fa.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 10:48:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwljhptPUksr6WJkzEvYhVjIYElSJhtAt6nU4IVyQwslWpHSiy/
	4VmQBuUGyDHxpowJUJhmtq5xFj1hNIYPKA24GNSwxVqurlRehUVsXmZutmAl/fz/UKwlx2UnMf2
	4kUArLUIjYFVdvORjCc1dl0TyIwo=
X-Google-Smtp-Source: AGHT+IHQzxk7cXTbueWeoFS+oHsFCrhK+LlFFlYluE3Z5EBV8aqv4gnhbvKdUnOSPOzxyKzjZqSY4XFRHOvOiH6ITsk=
X-Received: by 2002:a2e:be22:0:b0:2f7:663c:48d7 with SMTP id
 38308e7fff4ca-2f787f44965mr46847331fa.39.1726249684875; Fri, 13 Sep 2024
 10:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOociT5+t6gDTDguVB0M6mAwnZwgAEdJZH3-63O5O=1c_t6Hyg@mail.gmail.com>
In-Reply-To: <CAOociT5+t6gDTDguVB0M6mAwnZwgAEdJZH3-63O5O=1c_t6Hyg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 19:47:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEaar69WOf3bW1G+MMij41ZpTAsjqEVLux4Tvvnf=ifew@mail.gmail.com>
Message-ID: <CAMj1kXEaar69WOf3bW1G+MMij41ZpTAsjqEVLux4Tvvnf=ifew@mail.gmail.com>
Subject: Re: "No EFI environment detected" debug message not logged
To: ofthecentury <ofthecentury@gmail.com>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 19:45, ofthecentury <ofthecentury@gmail.com> wrote:
>
> I have a question about this: efi.c file:
> https://github.com/torvalds/linux/commit/7c4146e8885512719a50b641e9277a1712e052ff
> I see "No EFI environment detected" printed on screen before kernel
> boots, but I don't know what log it's saved in. It's not in dmesg, not
> in journalctl. Is it not logged at all?
>

No. It is logged from the decompressor, which runs long before the
kernel can really log anything.

If you see this message (on a recent kernel), it probably also means
that you are not booting from EFI in the first place.

