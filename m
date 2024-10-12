Return-Path: <linux-efi+bounces-1942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F799B503
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D558B230C5
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964D41C6E;
	Sat, 12 Oct 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqnObH4Z"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D01E495;
	Sat, 12 Oct 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728738948; cv=none; b=KipX2qaQgXetMTXjeB5oax8N8Eo/c3gsw4suGsSZbPlzMTdXm9vd7FoiRryIVlmjS233D4Nmnpe9bh8+idMpBQLp4Gxh5eaY26BTJ9bxcOBUJv0wH0paB9rYweTyZH3lwrBpRjQ4HEy7OCfr7IksupX4OkgqJ+L5ShCg5SSXoGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728738948; c=relaxed/simple;
	bh=xhpmq/jAkz4+lzWho40DMr1lgdzon7t3cdhanbBy6EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRAqGfjklqdtfRPumkrmVqimqqozVDUDmoXwsNCL6xeoZfX8X5Vc+wtEU4/hQadihr+1KwHams2K2HK4Jqbh7kWQ3J+fpGoZemXtVGp+nAElAd3gC5jmsvAYQ21bXdsUGgn/R2bCaZLa5x1tA4Pli3KMoW4bp5fPFMAZLXpiekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqnObH4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816CAC4CED0;
	Sat, 12 Oct 2024 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728738947;
	bh=xhpmq/jAkz4+lzWho40DMr1lgdzon7t3cdhanbBy6EA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lqnObH4ZVyrppPhPGKGTvgNloFhLLC/Wind+gmayL0otPsJXrjp42XoB5WT1diy2A
	 jOSYmwHyRFbghV/wX+Y8fA9cB5XbP3DqGCLXq/EQM2lWodCe/ZG30Sq5gujIoSWq+a
	 13HrwibU73jKy0DNH91HkQcWv84WcrfApcYC2P8ga+fjdS5LS1+srGN9Ss4uOa7anq
	 J4fXb5kH1dNc+8b+xCwaxf/chNeuuZAG//zXPm29ojHzZgsojzUmX5qHSL+B7BugEf
	 qCbM8Tb+tEYvoKUnel1BYwv4BeT85+nGR2/0uqeggXBZXLnVdh0Ro1bGbr0h96jScH
	 osZOwLyDbPBcw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e13375d3so1609482e87.3;
        Sat, 12 Oct 2024 06:15:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXolEcGgKIUtgAeD0M2g+bLmnAOCK2pLc3o9tpoxUiJAR+4p/9r/3H01qNmHbzL5LSV8T0G8wL6rzShokI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOrPlT22/HZpxe2FVHZiWu22/h1eaZDfLfZlsLA0m07xZ53xN
	pi3yBd1JfizLy5YBIVbCl0HE7Dnmfsd98c9DZisTnACCrfswobSl2+TQQ/BMvGVGkUtnVQiXJml
	0JnVsps+SDbiAP27ZdTwh4x6/7VQ=
X-Google-Smtp-Source: AGHT+IGqinu0nCzGIyDmJkUkKWigiOSbL5q4aqBAQM3t9hP0a6MjlCleqcH3TuKXSSec/DEx11BbZ/JSZj/T80SNJ0I=
X-Received: by 2002:a05:6512:3f22:b0:538:9eef:918d with SMTP id
 2adb3069b0e04-539da3c1d59mr2670022e87.11.1728738945842; Sat, 12 Oct 2024
 06:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca> <CAMj1kXFstg+2j9nYCO=_=L3LAd4PYc5vO3OX4EtHfFA90BXv5Q@mail.gmail.com>
 <5364ea9f-9042-3fba-5cb1-c42ae94b0d4b@marek.ca>
In-Reply-To: <5364ea9f-9042-3fba-5cb1-c42ae94b0d4b@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 15:15:34 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfsjPy9UxtC4f6n+FBBYRdyGw6h0b9fkn3_NDxTL7nPg@mail.gmail.com>
Message-ID: <CAMj1kXFfsjPy9UxtC4f6n+FBBYRdyGw6h0b9fkn3_NDxTL7nPg@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi/libstub: fix efi_parse_options() ignoring the
 default command line
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 13:58, Jonathan Marek <jonathan@marek.ca> wrote:
>
> On 10/12/24 3:46 AM, Ard Biesheuvel wrote:
> > Hi Jonathan,
> >
> > Please use a cover letter when sending more than a single patch.
> >
> > On Sat, 12 Oct 2024 at 00:51, Jonathan Marek <jonathan@marek.ca> wrote:
> >>
> >> efi_convert_cmdline() always returns a size of at least 1 because it counts
> >> the NUL terminator, so the "cmdline_size == 0" condition is not possible.
> >>
> >> Change it to compare against 1 to get the intended behavior: to use
> >> CONFIG_CMDLINE when load_options_size is 0.
> >>
> >> Fixes: 60f38de7a8d4 ("efi/libstub: Unify command line param parsing")
> >> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> >> ---
> >>   drivers/firmware/efi/libstub/efi-stub.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
> >> index 958a680e0660d..709ae2d41a632 100644
> >> --- a/drivers/firmware/efi/libstub/efi-stub.c
> >> +++ b/drivers/firmware/efi/libstub/efi-stub.c
> >> @@ -129,7 +129,7 @@ efi_status_t efi_handle_cmdline(efi_loaded_image_t *image, char **cmdline_ptr)
> >>
> >>          if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
> >>              IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
> >> -           cmdline_size == 0) {
> >> +           cmdline_size == 1) {
> >
> > I'd prefer it if we could keep the weirdness local to
> > efi_convert_cmdline(). Would the below fix things too?
> >
> > --- a/drivers/firmware/efi/libstub/efi-stub-helper.c
> > +++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
> > @@ -395,9 +395,7 @@
> >                  }
> >          }
> >
> > -       options_bytes++;        /* NUL termination */
> > -
> > -       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes,
> > +       status = efi_bs_call(allocate_pool, EFI_LOADER_DATA, options_bytes + 1,
> >                               (void **)&cmdline_addr);
> >          if (status != EFI_SUCCESS)
> >                  return NULL;
> >
> > Note that the only other caller of efi_convert_cmdline() in x86-stub.c
> > ignores this value entirely.
> >
>
> Just changing this would just make things more broken, the following
> snprintf would remove the last character of the command line because it
> uses options_bytes.
>

Ugh, you're right. So just use options_bytes - 1 in the assignment then.

> Since this patch has a Fixes: tag, I wanted to make the fix as simple as
> possible. If you think comparing the size to 1 is "weird", the fix could
> instead check if cmdline[0] is non-NUL (or just strlen(cmdline)==0 if
> you don't like that either).
>

Checking the value of the first byte is reasonable I think.

> And then my followup cleanup patch can just remove the cmd_line_len
> argument from efi_convert_cmdline().

Yes that would be fine - it is not really useful in any case.

