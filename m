Return-Path: <linux-efi+bounces-593-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D185B561
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 09:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657F3282300
	for <lists+linux-efi@lfdr.de>; Tue, 20 Feb 2024 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69495C60A;
	Tue, 20 Feb 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i50NX79B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C05C5F2;
	Tue, 20 Feb 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418232; cv=none; b=J/MOZ0UvkN+1CdCBN+O0gcliG6at/lnVE7zCNFsVV+lf6s2MJO4Wxe6X2rMypL/uv4JTo9zfZT+X2WfvaDOyTSnfYn+tWddZm19gXQ5RssDuZO5AQWTNcNVP+0xo1rqF/aE3lECvue8q4dwy9eqz4EhaNWT3+h9gEnxsRBIE9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418232; c=relaxed/simple;
	bh=OBNB0k0FytlPxcnFOclq0NEXCoipePnmZTf+6P5ki+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1Knd/iSil2nf78zrOuNKJUwLggdH6Dfma6/jPsoDr7wo08XU/Z/fYU82pVYo8uUzKtZDWBm6k/CheSPudsG35+qGFt1RkAykmLuPF8Hf0RykaVwm5bEY63y25w9C+7pXQunfCViJSrkN47o4K5TECQaBXOSkyb3wIrWaiJYZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i50NX79B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE92C43399;
	Tue, 20 Feb 2024 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418232;
	bh=OBNB0k0FytlPxcnFOclq0NEXCoipePnmZTf+6P5ki+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i50NX79B4MiHC5G0bhTyLsnG5T81WgLR/rEXzybT2Muggw1h7QRUJN9Ea8PIKPNW6
	 0rCr8r8h4wrHIUoVCDYe3qrFjtCClcrUhZtnJ6iIrhyr/iSkipezXZs6K4rISm0o69
	 pqFPqYjOvcWub7OS2xKFSNit0Krz6S68le/Ns3hiGEKfzM4VDBmqcE5MzXu3GguOhP
	 m3WNDCt6Ja31wVE7qwjpl9wGE6K5qCgYUfGiWwqkkucCdN0tl40S96cSOQtiMg6/aM
	 t2M3Io6tI+QDKll2xvkNTBo9W5P1Mw5ZQBlO7TmzR03f58Ki0FANCmJ0bsT+b6AptV
	 Ksp5+h3kABmvA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2305589a2so31738831fa.1;
        Tue, 20 Feb 2024 00:37:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzAaZbO03ZjndUfwMrIoM3lg6vO5CFWlIRYLOX8Td+YYEQ7O7bXLOuLO+H9J0Dqo1v66wMJPxQPKRxcpulKjlr8o8mSP8Zu7yKTVovL7F3pIUzJOGCC7VweES7tUUDLrxu
X-Gm-Message-State: AOJu0YxKRQHLmKKzmKUy3VMGQ/h5/pAufjLC0kRY6TD7+z+ZhZbthNB8
	ocAWgU+m5SgBVubrb6iqJfCmOPBRbUWIoT9eS0p60HHGhZUy1Kuu4T+8nJauZAgqwytN0vLJSOb
	2UF4dhm+rmC7lQFCWKKRLMH9ktoQ=
X-Google-Smtp-Source: AGHT+IH5LJ9Na0gc2WmzLAq7A6Kn2wwh72/gbR9JrDlR3Tzd7hZy2DcPQCEiB5dzVcFR5JF1XwUNgCZYyAi8MXq33dk=
X-Received: by 2002:a2e:870f:0:b0:2d2:4218:6275 with SMTP id
 m15-20020a2e870f000000b002d242186275mr2186989lji.49.1708418230514; Tue, 20
 Feb 2024 00:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXG4HpAHYKwz27_Qy9_Wx+O_QJDmA4CBXcMrvVcrOXhBxw@mail.gmail.com>
 <87plwsj6ar.fsf@xnox-Inspiron-7400.mail-host-address-is-not-set>
In-Reply-To: <87plwsj6ar.fsf@xnox-Inspiron-7400.mail-host-address-is-not-set>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 20 Feb 2024 09:36:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjxtMnJ6MeeE-W73Jw_seRPnQwVDRyBayDzKvaDLFLjw@mail.gmail.com>
Message-ID: <CAMj1kXGjxtMnJ6MeeE-W73Jw_seRPnQwVDRyBayDzKvaDLFLjw@mail.gmail.com>
Subject: Re: x86 efistub stable backports for v6.6
To: xnox <dimitri.ledkov@canonical.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	linux-efi@vger.kernel.org, jan.setjeeilers@oracle.com, pjones@redhat.com, 
	steve@einval.com, julian.klode@canonical.com, bluca@debian.org, 
	jejb@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 02:03, xnox <dimitri.ledkov@canonical.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Thu, 15 Feb 2024 at 12:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Feb 15, 2024 at 10:41:57AM +0100, Ard Biesheuvel wrote:
> >> > On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > >
> >> > > On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> >> > > > (cc stakeholders from various distros - apologies if I missed anyone)
> >> > > >
> >> > > > Please consider the patches below for backporting to the linux-6.6.y
> >> > > > stable tree.
> >> > > >
> >> > > > These are prerequisites for building a signed x86 efistub kernel image
> >> > > > that complies with the tightened UEFI boot requirements imposed by
> >> > > > MicroSoft, and this is the condition under which it is willing to sign
> >> > > > future Linux secure boot shim builds with its 3rd party CA
> >> > > > certificate. (Such builds must enforce a strict separation between
> >> > > > executable and writable code, among other things)
> >> > > >
> > ...
> >> > > And is this not an issue for 6.1.y as well?
> >> > >
> >> >
> >> > It is, but there are many more changes that would need to go into v6.1:
> >> >
...
> >> >  32 files changed, 1204 insertions(+), 1448 deletions(-)
> >> >
> > ...
> >> > If you're happy to take these too, I can give you the proper list, but
> >> > perhaps we should deal with v6.6 first?
> >>
> >> Yeah, let's deal with 6.6 first :)
> >>
> >> What distros are going to need/want this for 6.1.y?  Will normal users
> >> care as this is only for a new requirement by Microsoft, not for older
> >> releases, right?
> >>
> >
> > I will let the distro folks on cc answer this one.
>
> Canonical will want to backport this at least as far back as v4.15 for
> Ubuntu and Ubuntu Pro. So yeah, as far back as possible will be
> apperiated by everybody involved. Since if/when firmware (VMs or
> Hardware) starts to require NX compat, it will be desired to have all
> stable supported kernels with this support built-in.
>

Thanks for the data point, and good luck with backporting this to
v4.15 or earlier. If it helps, I have a branch that backports
LoadFile2 initrd loading support to v5.4 (below), which you will need
to backport first. Going further back than v5.4 is going to be very
messy IMHO.

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-lf2-backport-x86

