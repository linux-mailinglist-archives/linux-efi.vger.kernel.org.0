Return-Path: <linux-efi+bounces-1617-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF655962EC9
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB32821EF
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ACD1A707E;
	Wed, 28 Aug 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM/+yUPj"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FD149C53;
	Wed, 28 Aug 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867122; cv=none; b=T0Ay2w/407uyDHrPzR6LMYViDrYGy4mzL+JLmCYy4O17vmVxqsx+xVTtTlwfGXbgl8yJxVGCfo7IJnbdKV1kiaV2nfJme9l60FVKri+9KYezztCKzVb0C1Gk3fzPSGfzT9Di9XDAxFRAdlBeTfnWZNBODXpEoPn/zf48V5oFbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867122; c=relaxed/simple;
	bh=G9QT0vPfao0O0lwDuOgePtuOTxFGY2xhec23X8b5r3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtuR6NiXYjDXDOg2iqkr7ff0CzhoDC1Mz56I1TLsLf6WYGBKwg+/gsygO1PvETMnsq8FB+wahd8hBjagKOM8J7cU+ZzJFg4TYkqg6JG5COHYRR6/N/1PNXm78GyhUA7GoXZ98zIMTpmm5rEGBkM8UoAWGANNnr6Nt1Bsx2WiqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM/+yUPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AF1C4CECC;
	Wed, 28 Aug 2024 17:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724867121;
	bh=G9QT0vPfao0O0lwDuOgePtuOTxFGY2xhec23X8b5r3c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mM/+yUPj34upe6fwknvPELrONW32fk0ywkcuF5Yc/nxTosp3RT0wKHcL76S16MvtH
	 j3IwMhKQu8qVRZjCIpkuB8SK3TEhEAXyfj3dZnJe0tbaqiVP/FsHKEJN2Hsipy4I7h
	 gkJkuLzG0ohDSSP2DeWa0OGl6udyOeDqIku7S/4rHBTeHBRUQENCLcv0vzIOxz+iVS
	 Rgi4GZ+PyNaUSYK2dwtpxpzLKWWwYKn6WAFbuODH77EFEz0Dn0x8CYEvCLCwLKxuuo
	 Ob4RXaQvd7vCsvhYa15myiMQWN3o4BkdOKa9VMf2VyByT3CJHTwhNPT0zImH4j/Mi0
	 jSwH8HGVeoQsg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53346132348so8419245e87.2;
        Wed, 28 Aug 2024 10:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsBvV3zuQt3OefTkidwvoxXPbdz/Rj0+DDAzPGEANS3Lai51YeI1LJmk02HdwHdO5J4Ia4jwo+W3KQ@vger.kernel.org, AJvYcCWpxf5+HfSQbjZc1gVInoLqHmk8zuNIOqr+7ZxHSZAgCho1sdh1wfhsm7PKQODOuVtiHVVG/QmpYbVSVw4=@vger.kernel.org, AJvYcCXa9qKkwthTAmjqayMzosoNOGuzTHo/KQuBZUkoamgVJGMuIaAeYP+oNDzcKAbHTBfP1ultP9U/YJ7ax76BrL4S@vger.kernel.org, AJvYcCXaODFRkmSGHN6XX/7wWJaulI+6OjL2yjZyOX6pM1ARjuHXYFL6+QqER0xdxMwWnFjnFjKu0G+MRF5E32+S@vger.kernel.org, AJvYcCXc9D3ZurPw91QlDdvF5gz9lQOZM1IJuA9lVT8eWhtZjAK5RtRxRrKhcV9WY1qmcApMsL1dtWHHx1aB@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAzcrKhqbS9ua6h8PnrYv2K9Y2UyuKJIcY9iAZ1YIJwfsWFPN
	QxVE05K8OlerwzCKT1rT3GZ2iJU9MOr7W8G7oGSQFSm+ZVI79L7kFJrv0WkJB0CyfGGN8i1BfmI
	u07z8mXlxh667neyALjcmlFw97fE=
X-Google-Smtp-Source: AGHT+IGaVTdJ/LHztg5boQQvEQD2uV+Xdg8ZsjilzNuNZwL1c7aotEe1qcRRan6SrgWsXGUOuRs+QonsXS8FUfmscYw=
X-Received: by 2002:a05:6512:b98:b0:530:bbe7:4db3 with SMTP id
 2adb3069b0e04-5353e5b81e8mr28078e87.39.1724867120119; Wed, 28 Aug 2024
 10:45:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-2-ross.philipson@oracle.com> <CAMj1kXH3Gvr3vDRLDdXuc0s7ZAQYE6+D7tmCRBjJWwWt2fn4-w@mail.gmail.com>
 <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
In-Reply-To: <9d01a6d2-4dd9-4331-8fc9-b01c07cfdbb5@apertussolutions.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:45:09 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Message-ID: <CAMj1kXHn6xeAskWiDLvvA4oG3j9_tqx+iMYJXMqmgvyX4pMzgg@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Stuart Yoder <stuart.yoder@arm.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

(cc Stuart)

On Thu, 21 Mar 2024 at 15:46, Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
>
> Hi Ard!
>
> On 2/15/24 02:56, Ard Biesheuvel wrote:
> > On Wed, 14 Feb 2024 at 23:31, Ross Philipson <ross.philipson@oracle.com> wrote:
> >>
> >> From: Arvind Sankar <nivedita@alum.mit.edu>
> >>
> >> There are use cases for storing the offset of a symbol in kernel_info.
> >> For example, the trenchboot series [0] needs to store the offset of the
> >> Measured Launch Environment header in kernel_info.
> >>
> >
> > Why? Is this information consumed by the bootloader?
>
> Yes, the bootloader needs a standardized means to find the offset of the
> MLE header, which communicates a set of meta-data needed by the DCE in
> order to set up for and start the loaded kernel. Arm will also need to
> provide a similar metadata structure and alternative entry point (or a
> complete rewrite of the existing entry point), as the current Arm entry
> point is in direct conflict with Arm DRTM specification.
>

Digging up an old thread here: could you elaborate on this? What do
you mean by 'Arm entry point' and how does it conflict directly with
the Arm DRTM specification? The Linux/arm64 port predates that spec by
about 10 years, so I would expect the latter to take the former into
account. If that failed to happen, we should fix the spec while we
still can.

Thanks,
Ard.

