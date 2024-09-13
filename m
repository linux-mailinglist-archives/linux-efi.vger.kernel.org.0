Return-Path: <linux-efi+bounces-1770-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B404F978A4C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 23:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9124EB237E6
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1AE13CF86;
	Fri, 13 Sep 2024 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVdMm9m/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E35126C01
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726261296; cv=none; b=BvcHdq0LjpI6+yh91wI45n+HNVZM+xPoDHHbBlTjHUADWie642vdBzZtJK9ZosORPuMlJbWEAKrO7dBu8Hjlv45IPKCnp4nGok2s8WMgVdY4a1ZkH4QuLRQa53Jppt9sdNKVei7T394PX149adAdEP7l2CfWDZoJa3CR3cZg8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726261296; c=relaxed/simple;
	bh=dAYFh2TSjwhSbhMmoRFUgYZCYrmQCo10SvKZt+vL/gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hpS+YGbcESMv/lOslye86ij+nD3FkPDyK7GbuKStc2i0SEvGhBPdEEPyUg+cK9ky5/7vB/P45BGFrtg9iY4sUFmSybNy+1RtoE7JI0BYvG3zoswu4291k4zHAoGdyPyLVswyy2FEI5Gu5J+njt1ikomb6cegpKkO9Ey8Pf27OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVdMm9m/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365c060f47so3167834e87.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726261292; x=1726866092; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAYFh2TSjwhSbhMmoRFUgYZCYrmQCo10SvKZt+vL/gI=;
        b=VVdMm9m/jVUBZ+3gkKCTQABazu+sQ/nBITJCiuS/WuHhNemz+4MA3ihxxUWDKinIAC
         YJkuSC+3NeMjQlGIe3e2PbV4ADPb5u5crVCRPGDrEpjlGkVt39Uf+xOlW+gNdKOcLTjD
         a878HqT4sgTzeGNNGnyk8kwfT1XxdOh/iu+5SO1bbE5HxDqmjxLI7AABqXW2uNxDpfjh
         vp66b1lL4sj+1+vzIZBBFccvIfkrWT0oppyvSla+8HSp2uDQaT0ubodAcLLJExifmWqr
         pz80excoupFDYw9E38wPRW3Xru9IjBEp0cVMyBTUJKEcHaU8V8mNwELEeU172h4a+v6L
         oZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726261292; x=1726866092;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAYFh2TSjwhSbhMmoRFUgYZCYrmQCo10SvKZt+vL/gI=;
        b=h8KTA4VDsOWKQC/tgQ7QmSmak0Xfc81zCSr9ZP1U79QwYL9vMaWGrx+HYF1z95+jPI
         3pOiLpT7C19k14D6laiOjpnsvr0gcAW6kNJN1gWB4zfXQyo74WBoB7CLDFtbLY7nE4JO
         w1VZ0OPXjRqP1M6d5szEeolNULH87T4dtgM3K2/eaZM6J06BUBJZjJQUG1nqE8LFwMAd
         ManTfhU8NPy603shoqOultVQPQykF9aSH+GOcf1AXhhxOlP4mguX+nKFRSsanIDsr+BG
         0GpvFpWV2dtyyK5aKFCBBuQT3cGjKKyZi0Bnr13gE/q0P4QzaLzZU3aCkWbKm1q41AB9
         JXFw==
X-Gm-Message-State: AOJu0YxGPMGMOHUK3yCFE0D+onYDyxLloKeFj52NxDIA5g9ueOvibcO0
	kj01YdwzTsW8+4ib3glX9+tDVDTj+kFW6jBOT870JDst5W2danKpcMfb9cWICnjoMnByjjagdHA
	HfdkrG5TpOuXaDVQhCIXAzPD60oh96A==
X-Google-Smtp-Source: AGHT+IEAzPAYXqMRqAa/iwFx8DdiOYIiG3nIGAmidsFoPuB0TGcr/TOfcl6tAuYzWYKq4FR5L1ngCPpWIq2+3bRshAE=
X-Received: by 2002:a05:6512:220d:b0:535:6a75:8ac8 with SMTP id
 2adb3069b0e04-53678fc24e6mr4975041e87.23.1726261291231; Fri, 13 Sep 2024
 14:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOociT5+t6gDTDguVB0M6mAwnZwgAEdJZH3-63O5O=1c_t6Hyg@mail.gmail.com>
 <CAMj1kXEaar69WOf3bW1G+MMij41ZpTAsjqEVLux4Tvvnf=ifew@mail.gmail.com>
In-Reply-To: <CAMj1kXEaar69WOf3bW1G+MMij41ZpTAsjqEVLux4Tvvnf=ifew@mail.gmail.com>
From: ofthecentury <ofthecentury@gmail.com>
Date: Sat, 14 Sep 2024 02:01:04 +0500
Message-ID: <CAOociT4VWs9E663ZgxfVzM+agFVsHqEtMYuNfoNvCJQRcb7fyQ@mail.gmail.com>
Subject: Re: "No EFI environment detected" debug message not logged
To: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I know it's run before the kernel is functional. Is it the Linux way
not to save logs of anything? At least, for pure inspection of the
entirety of what has been output onto the screen after the bootloader
transfers execution? If it's a debug message, why is it volatile and
how do you expect to debug if it's gone after a split second?

On Fri, Sep 13, 2024 at 10:48=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Fri, 13 Sept 2024 at 19:45, ofthecentury <ofthecentury@gmail.com> wrot=
e:
> >
> > I have a question about this: efi.c file:
> > https://github.com/torvalds/linux/commit/7c4146e8885512719a50b641e9277a=
1712e052ff
> > I see "No EFI environment detected" printed on screen before kernel
> > boots, but I don't know what log it's saved in. It's not in dmesg, not
> > in journalctl. Is it not logged at all?
> >
>
> No. It is logged from the decompressor, which runs long before the
> kernel can really log anything.
>
> If you see this message (on a recent kernel), it probably also means
> that you are not booting from EFI in the first place.

