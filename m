Return-Path: <linux-efi+bounces-761-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B74F874D69
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 12:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8091C20D55
	for <lists+linux-efi@lfdr.de>; Thu,  7 Mar 2024 11:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA385643;
	Thu,  7 Mar 2024 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtvOvbZC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4485634
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811020; cv=none; b=eABRhgglPwwTe4p8UdmgcyLl8zJx1Dl2bPxnFFYJil8hm1SoO/3k3ief0nGQ62fFOD/BLv4ydYSUOh5VQ7aVSa2Bxoaeb/REdHneTIwnvkTmnlt4uBy1dcqUC9PL6qGu2P6aW2mBX9I52qbxQ3mcZg3mgNM+SYBuX6lYn4Ddi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811020; c=relaxed/simple;
	bh=gJZhAGpX1oWur/51opNZU6aCpnp5HFVznz42ysvFNqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErK0LgvfHKavuwUtXFoDOSKUwA1Ji4sjj+37vTIl+cY81PUh3MmMfaE118v2JDCMztl21GMdyyekioMEYmojXdWMcwb54X54832e1wja20pFoZdrLU5vwdoYz580OXFB7ID5qNOkyTl6TddTQsTQc0YOaJh6CgyzVlM9LiDNdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtvOvbZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C5C433C7
	for <linux-efi@vger.kernel.org>; Thu,  7 Mar 2024 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709811019;
	bh=gJZhAGpX1oWur/51opNZU6aCpnp5HFVznz42ysvFNqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NtvOvbZCY9OIK6cRmR8OfTbtmasClcNuNtmf5wOs/liqpfUS518RyzhO+G58VGqmb
	 wYETi6Btbt2Sf8Nvr4Wy4yCGjK2c0SsB1VDvgqQlX3W7xJq5ceAkatwQF6yMTMR7aR
	 tz0N6p3CG+xvyZeTLursyUMIQ0TRnz28NWV6rjieCG58jfBg1+1z5tl4NzS34KP2Kg
	 RDmozgIkNHXEPo7n/LmnT5j2510jReypJgXhUBm5yN+K/I3usNkwWcLzvzkwLMuD4v
	 JgnGUvAG48oeUWMVYH33avIsCzeJgDWbUkhquDCfPEdTPg6Oe7Wj7O4UF3H1uz6LeE
	 v0ke1LQ33Sz3A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so10884331fa.0
        for <linux-efi@vger.kernel.org>; Thu, 07 Mar 2024 03:30:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcOPTUzwj9gInPFTi89hu6TrJowMVw1f0tqDLWx/K14/KEhyG2nqeTa47pPQxFhu2R/bXahvR6qWMqToFIOkFeUogizAyWYmO0
X-Gm-Message-State: AOJu0YyAWtGS4OHtUJlw6OZlTcyPR+TCM2HUETc8q5xzHgqK1F/PwrVg
	UNoSKYPth7nRz2jNyDfvZBaBzOMKdW64HWnaZqkrkiiPucacPF6rFPXVu+fgBrlgYdbdjbEUlcZ
	JF6S92I8X7WyABUCouY+LcDWdPr4=
X-Google-Smtp-Source: AGHT+IFeWi5UCr9BnoNzvHdQRREN/a4jFotGDxJEaJr8iVMPtfgoGMFMykcEyN0z6+ANGK/fek4caX3Zz6I7ehExOtw=
X-Received: by 2002:a2e:b247:0:b0:2d2:71cc:253d with SMTP id
 n7-20020a2eb247000000b002d271cc253dmr1136667ljm.25.1709811017571; Thu, 07 Mar
 2024 03:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0229a87e-fb19-4dad-99fc-4afd7ed4099a@collabora.com>
 <CAMj1kXE166VdJLWSWo7_3MDw4V3zSuYRx44Z7yqyj5mQVOdDCA@mail.gmail.com> <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
In-Reply-To: <CAMj1kXGFLwsgPo9Xy_-9gaOUUO=wDd_K12ccYUhP1nWf3KLb0w@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 7 Mar 2024 12:30:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG3ySsqU0v5dnC2V+xiKGxdFnY_WSOFzrqb0sr9gDT7Zw@mail.gmail.com>
Message-ID: <CAMj1kXG3ySsqU0v5dnC2V+xiKGxdFnY_WSOFzrqb0sr9gDT7Zw@mail.gmail.com>
Subject: Re: [Bug Report] Bug in "efi/libstub: Add get_event_log() support for
 CC platforms"
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, 
	"Kuppuswamy Sathyanarayanan," <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:13, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 7 Mar 2024 at 12:08, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Hi Muhammad,
> >
> > Thanks for the report.
> >
> > On Thu, 7 Mar 2024 at 12:02, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> > >
> > > Hi,
> > >
> > > The recent patch:
> > > 276805fb9c305: efi/libstub: Add get_event_log() support for CC platforms
> > > has introduced
> > > #define EFI_CC_EVENT_LOG_FORMAT_TCG_2   0x00000002
> > >
> > > But EFI_TCG2_EVENT_LOG_FORMAT_TCG_2 has the same numerical value:
> > > #define EFI_TCG2_EVENT_LOG_FORMAT_TCG_2   0x2
> > >
> > > Thus there is dead code in efi_retrieve_tcg2_eventlog() i.e, multiple if
> > > conditions with (version == 2) I'm unable to decide on what is wrong and
> > > what is right here. Please have a look.
> > >
> >
> > Why is this a problem? The compiler will recognize this and simplify
> > the conditional. The code as written is semantically correct, the fact
> > that the symbolic constants resolve to the same numerical value is
> > just an implementation detail.
>
> Ah hold on. I see what you mean now:
>
> if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
> final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
> + else if (version == EFI_CC_EVENT_LOG_FORMAT_TCG_2)
> + final_events_table = get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);
>
> Yes, that is broken.

Could we fix it like this perhaps?

--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -75,8 +75,7 @@
         *
         * CC Event log also uses TCG2 format, handle it same as TPM2.
         */
       if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2) {
            /*
             * The TCG2 log format has variable length entries,
             * and the information to decode the hash algorithms
@@ -109,10 +108,11 @@
     * Figure out whether any events have already been logged to the
     * final events structure, and if so how much space they take up
     */
   if (version > EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2)
       final_events_table =
           get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID) ?:
           get_efi_config_table(LINUX_EFI_CC_FINAL_LOG_GUID);

