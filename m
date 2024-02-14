Return-Path: <linux-efi+bounces-526-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED536854C74
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 16:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A942F28A564
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCD5C5EE;
	Wed, 14 Feb 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJsaeAso"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7255BAD9;
	Wed, 14 Feb 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923913; cv=none; b=Zj/usaT48NZ5F2M6vUXAc3uWnsNtVEqdoFZDKEl6lCHM8YL3+C+WUDf5nTmynQLAeWVx7L7QGMTr+XeaR+8+lbIWrb78j8BPKbLJfsVdgMWeUsB8CuTP9O0MN2UZT4wTBiEW2TdHnhuTDprSU3sIXrAuwTjN8ZBmnfIwC3as2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923913; c=relaxed/simple;
	bh=0beHg+xeCcU89JWqpspaJt3VQ1MR2S6le0Zc8/gODUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHttj1pNARVWjPmFae5R376e/23eMxTtNJwkh0TbyWIdZAz/oEX7MADjyKYGgz2+cul4X38Ofvt0W/B5GUY55BerryElB2mVzv3UqeJqP/V4O5HT/rUJvw+ClBKegZ4tc5S+Avu9WLqlxLCInsCQfejYDwGaEqvjVs18kEn8Kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJsaeAso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F7C43399;
	Wed, 14 Feb 2024 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707923913;
	bh=0beHg+xeCcU89JWqpspaJt3VQ1MR2S6le0Zc8/gODUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RJsaeAsonDgUkw6J28v33NDOjgXLBqG+Qnz5iPjr55OGACFX3esFPsSyxOx0pgsT4
	 tVXF3vV10LeqXjooH2wZ3eGOhiDsM22V7TZpO86gujhCpxDxYQX53q2SRjq/XZaeIi
	 GPuFgSKJx7PF3BymSprHjlrPhUJmzzR87ypiRaR/HuNq3kNNFSRlVx+aW1hm6fZD98
	 ycnyTf6EYEOh3WEOJXmT17PfCH7phHlAQrfEEpAVKrEd0g3+wRQCgwqXVHfl4FNSS5
	 T6NGPe2eXV8Bn6kTx7TRKV/0coKlasLrF248AShndYVsRgxp/CPHjGBBgglzzG6HPk
	 AYArEPaUo2agw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-511ac32fe38so705709e87.1;
        Wed, 14 Feb 2024 07:18:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBGBgTv2zMBWF+7rF5FwPDIL5NSApWt+QEJAmlNX0oAw4wBgB69WhRcdEbculRXNAMjyG7AFbxPnccxjS7i+gRJU3NzfHDECNBaGCY
X-Gm-Message-State: AOJu0Yxwe6mvFKJxw0frUaW0DApmyXl/HoiEYIq7g0JryAW6WHbdaLAy
	O/yGUq/iLa3s4yYfQjB6pbQ8apq2LF34O0MQBgEOLLo6Qwwwr1ocuu2RrEVM2z/ybGQXZUJ19Sz
	5vmYagaxFOslUNXZ62L7I9vQcOI4=
X-Google-Smtp-Source: AGHT+IGRdqZTL5CJOYK9nlA9Tb12+L8EUJLu00H0rLa2hHjFL9sQ9/J4nMS09O05rcQZhbqNLpB8otAv4YZPrkHvTmE=
X-Received: by 2002:ac2:5986:0:b0:511:7072:895f with SMTP id
 w6-20020ac25986000000b005117072895fmr2138756lfn.21.1707923911443; Wed, 14 Feb
 2024 07:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123202743.1591165-1-timschumi@gmx.de> <20240126162524.52051-1-timschumi@gmx.de>
 <CAMj1kXGOzk4OnsxL8T7Finx8RzNu23SriY7QokAvKD=BkEvpjw@mail.gmail.com>
 <00d699b5-bf2f-4411-af3b-30ca6fadf66a@gmx.de> <8caa916b-5b40-446a-9a80-68a4cf0fc75f@gmx.de>
In-Reply-To: <8caa916b-5b40-446a-9a80-68a4cf0fc75f@gmx.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Feb 2024 16:18:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEPcayiPM2k_rp=Hqzt1O-Wx3mMJFzvQGBQqrLGu6sq=w@mail.gmail.com>
Message-ID: <CAMj1kXEPcayiPM2k_rp=Hqzt1O-Wx3mMJFzvQGBQqrLGu6sq=w@mail.gmail.com>
Subject: Re: [PATCH v3] efivarfs: Request at most 512 bytes for variable names
To: Tim Schumacher <timschumi@gmx.de>
Cc: linux-efi@vger.kernel.org, jk@ozlabs.org, mjg59@srcf.ucam.org, 
	pjones@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 17:00, Tim Schumacher <timschumi@gmx.de> wrote:
>
> On 26.01.24 19:02, Tim Schumacher wrote:
> > On 26.01.24 17:35, Ard Biesheuvel wrote:
> >> On Fri, 26 Jan 2024 at 17:25, Tim Schumacher <timschumi@gmx.de> wrote:
> >>
> >>> One thing that I just recently noticed is that properly processing
> >>> variables above 512 bytes in size is currently meaningless anyways,
> >>> since the VFS layer only allows file name sizes of up to 255 bytes,
> >>> and 512 bytes of UCS2 will end up being at least 256 bytes of
> >>> UTF-8.
> >>>
> >>
> >> Interesting. Let's add this to the commit log - it makes the case much
> >> stronger, given that it proves that it is impossible for anyone to be
> >> relying on the current maximum being over 512 bytes.
> >
> > It makes the case much stronger for why one wouldn't be able to _create_
> > variables of that length from Linux userspace, creating dentries internally
> > seems to have different restrictions (or at least their name size seems
> > unlimited to me). Therefore, anything external could have still created
> > such variables, and such a variable will also affect any variable that
> > follows, not just itself. They don't have to be processed properly, but
> > they still need to be processed (and they currently aren't processed at all).
> >
>
> I was able to experimentally confirm that creating dentries internally is
> _not_ restricted by the value of NAME_MAX. The test setup was as follows:
>
> - Build and boot a kernel with NAME_MAX bumped to an artificially high
>    value (e.g. 1024). This is supposed to simulate an external user.
> - Create an UEFI variable with a name of length 254 (ends up at length 291
>    with the appended GUID, which is above the normal NAME_MAX limit).
> - Create a "sentinel" UEFI variable with a non-critical name size (e.g. 32)
>    to determine whether iteration has been stopped early during the next boot.
> - Reboot into the same kernel but with an unmodified NAME_MAX limit (i.e. 255).
> - Observe that not only the sentinel variable shows up (i.e. iteration
>    hasn't stopped early), but that even the variable with a file name length of
>    291 shows up and continues to be readable and writable from userspace.
>
> Notably (and unexpectedly), only the _creation_ of efivarfs files with length
> larger than NAME_MAX (from inside userspace) seems to abide by the NAME_MAX
> limit, and ends up bailing out with "File name too long" / ENAMETOOLONG.
> Therefore, please disregard my earlier statement about "processing such
> entries properly is meaningless" that I put into the patch-accompanying message.
> I assumed it would be enforced across all/most common file operations instead
> of just when creating files.
>

Thanks for digging into this. I still think the change is reasonable:
Linux does not permit creating EFI variables that have names longer
than 512 bytes, and I have never seen any such names from any of the
firmware implementations that I have dealt with.

I have queued this up now. Thanks.

