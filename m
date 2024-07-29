Return-Path: <linux-efi+bounces-1508-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448C493EE67
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 09:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3361F212E6
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jul 2024 07:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A286267;
	Mon, 29 Jul 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBRL7kxS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5D85931;
	Mon, 29 Jul 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238084; cv=none; b=TWFhCORnWmNw47XgpWStFa36RIcNcsmon65IWvvpCWV2xcN7vIXi9KwS+oRDy999SVY7n5U1a0ga4gwd3y7CsVZC0B3vbwu+AHd9kLIM7w4rooTcDgLgLB/pfFnpWc9DVqAcTvjZ2o3l+A32ycpJxkVabwlihyBirwkmEHJcWyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238084; c=relaxed/simple;
	bh=nTe+LEwmiTqq7Wz4+BdXJBXIFgMWqWI6PEk+/MQWfSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsJ4bIv6yYQjNEDZErBTSrzFLuoSrya8RGqWFj+7TpIxTlaXOPuRjxbMoQ2Z+FkAVE1TYu9gGB2iA9DSKMhHs+JEQgjwGcxegpPLSeZ4HAr7fzz9nzSPYt9dpx7U80cZHSGlcrz6q4fmF6/wjjte9o1DEaLiAKpDZ4MZPD9WHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBRL7kxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5369C4AF0A;
	Mon, 29 Jul 2024 07:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722238083;
	bh=nTe+LEwmiTqq7Wz4+BdXJBXIFgMWqWI6PEk+/MQWfSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bBRL7kxSfQNXUNdka0ix/8yVf7BHRiwXNgTER3e7t0qx946gOZTmqLlsz5S0nnMWW
	 Tgxk0Mh6jf4K7nsiiDbD08Pd3dNz+zRmV60TU7jK3UaAp0c9zC0rTaRe+/kZNwnIqB
	 6wsznrqbaApYJll3n/BSFBO60h7EZUiwDPC/2sU27rkzuvDTRm8tDdJ3DOzHPcHsOm
	 0dQKePBvWUXmF+i2ujiOBVx9PA90UgkPDE7YpzGT6JSdainHwQxidDYM9Pp8bE8pPe
	 tyyIh5aj4CbvuTMZKhfEpssCiPUN0GCxQC9ntdn7Z1twWDAAk/+2jUVvukFX0jHmv5
	 57x38QTOa3xGg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ed741fe46so3220025e87.0;
        Mon, 29 Jul 2024 00:28:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVO63eK9deuCYkYxuAhtwz8v8fFXEAr+vQvwpWd4CeEpAF2UGwpXMDKhpj0idN/UZPV/g4BmMUHbMIYYHbIiFlRKTGANJW+C5feGpcqWcky1zCNpeKXOF1z7HLof21siEwOUrFv/4IE
X-Gm-Message-State: AOJu0YwVuWOfged83eWjz6AygZjj4EquUlYZTNrkpkbcb/OX5xKN0jJH
	yVx7HQdciXjIRUtIDNE8KbMdZVQqR8uVN8b15CxnCOepzECtecqXVlBDfqL2TVMxRCAroEXHwIU
	oXSjFkbvZ0FnV/TFcUNh23LE1SWc=
X-Google-Smtp-Source: AGHT+IF6E/EJSyzV/z6BavQ/MNgNZ/Am/TVKHY91KVCycq5PMVyti+hTtB4ojcls+9EnMjH9ZvIbILPAwTFSftdt9IU=
X-Received: by 2002:a05:6512:458:b0:52e:764b:b20d with SMTP id
 2adb3069b0e04-5309b27be39mr4134890e87.28.1722238082058; Mon, 29 Jul 2024
 00:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZqElRH38f_XV3fKK@wunner.de> <20240728220343.40fc64f7@redecorated-mbp>
In-Reply-To: <20240728220343.40fc64f7@redecorated-mbp>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Jul 2024 09:27:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHw0_MicBifz0FdLCOcjjD73AJcM-dyG1J6Ah=BjuQNcw@mail.gmail.com>
Message-ID: <CAMj1kXHw0_MicBifz0FdLCOcjjD73AJcM-dyG1J6Ah=BjuQNcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi/x86: Call set_os() protocol on dual GPU Macs
To: Orlando Chamberlain <orlandoch.dev@gmail.com>
Cc: lukas@wunner.de, gargaditya08@live.com, hdegoede@redhat.com, 
	kekrby@gmail.com, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sharpenedblade@proton.me
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jul 2024 at 14:03, Orlando Chamberlain
<orlandoch.dev@gmail.com> wrote:
>
> On Wed, 24 Jul 2024 18:01:08 +0200, Lukas Wunner Wrote:
> > On Tue, Jul 23, 2024 at 04:25:19PM +0000, Aditya Garg wrote:
> > > On Wed, Jul 17, 2024 at 04:35:15PM +0000, Aditya Garg wrote:
> > > > For the Macs having a single GPU, in case a person uses an eGPU,
> > > > they still need this apple-set-os quirk for hybrid graphics.
> > >
> > > Sending this message again as for some reason it got sent only to
> > > Lukas:
> > >
> > > Full model name: Mac mini (2018) (Macmini8,1)
> > >
> > > The drive link below has the logs:
> > >
> > > https://drive.google.com/file/d/1P3-GlksU6WppvzvWC0A-nAoTZh7oPPxk/view?usp=drive_link
> >
> > Some observations:
> >
> > * dmesg-with-egpu.txt:  It seems the system was actually booted
> >   *without* an eGPU, so the filename appears to be a misnomer.
> >
> > * The two files in the with_apple_set_os_efi directory only contain
> >   incomplete dmesg output.  Boot with log_buf_len=16M to solve this.
> >   Fortunately the truncated log is sufficient to see what's going on.
>
> Hi Lukas, in case it helps, I got the user with the macmini and egpu to
> get logs that don't have the start cut off [0].
>
> >   We could constrain apple_set_os to newer models by checking for
> >   presence of the T2 PCI device [106b:1802].  Alternatively, we could
> >   use the BIOS date (DMI_BIOS_DATE in SMBIOS data) to enforce a
> >   cut-off such that only machines with a recent BIOS use apple_set_os.
>
> It might be simpler to match "iBridge" in the DMI bios_version as this
> indicates that a computer has the T2 (aka iBridge which runs bridgeOS).
> I don't think there have been any issues from when the downstream T2
> kernels had apple-set-os unconditionally so it should be fine to enable
> for all T2 macs at least. This would exclude the T1 Macs with possibly
> missing trackpad dimensions in applespi that you mentioned [1].
>
> On my MacBookPro16,1:
>
> $ cat /sys/class/dmi/id/bios_version
> 1715.60.5.0.0 (iBridge: 19.16.10647.0.0,0)
>
> [0]: https://gist.github.com/Redecorating/8111324065016363223b5ce719e48676/
> [1]: https://lore.kernel.org/all/ZoJPgSlZJ3ZlU2zL@wunner.de/
>

Thanks, this seems useful.

Does this mean we can drop the type1 product name list, and just look
for 'iBridge' in the type0 version string? Or does that list contain
non-T2 hardware as well?

