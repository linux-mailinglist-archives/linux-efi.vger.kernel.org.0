Return-Path: <linux-efi+bounces-3423-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D117A9787C
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFBD77AC691
	for <lists+linux-efi@lfdr.de>; Tue, 22 Apr 2025 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D15298CDA;
	Tue, 22 Apr 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/D7yWRx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900E27BF6C;
	Tue, 22 Apr 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357208; cv=none; b=AhnwQtnhlYIiIu0f+LDAmcOZP/c9z+jZh1kH3iXl0YQqiOAILkMmujo9LUdQhI4mDSzL46uwdIv2o0tP1cCRoYLS4gHvGumG+4+/DWV9XG+kgjXxAPZ+DYA2rZNXiVbZNfXb8gLU8eVmNay3MhbVLVHZ16hro1W3N0f0mT432+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357208; c=relaxed/simple;
	bh=9Hc5x03Xt6Q8VLLhD3mCqz80+X90ssoJI+f+CleuBKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWULsCDlsA6NjI6l15OKCCNWfvEzxZtYfwUcSg44X/hE+IDYSWO1u10Ug6UH07RR93Mje0vFqb7morL0SfBRrtAB6289RUVc2UH3TV0g42kDHlNORFdF/WQ5jbLIHvN+q3jq8VyDX1Bhcrx5zbSkxVsGYwN34rsl76JJXtxIFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/D7yWRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B45C4CEEE;
	Tue, 22 Apr 2025 21:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745357207;
	bh=9Hc5x03Xt6Q8VLLhD3mCqz80+X90ssoJI+f+CleuBKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h/D7yWRxhbT0Tokd9yCp1wg9xCgigqp3o/yVm8u9b06tDs17VYlkXgDU2aKW+tBEW
	 yCFBWgaWcd9omhGXkDuPp7Lt9n5PqXhp+tTGMo9ams2ktewBPqhsq1gZcpvy0FHL19
	 Kzfr1/T+J+vS0tqDyftCuRmUR5Qdukw/vc+WnDWc8OJCiw4ChzEg9UgCLeqUobbDHt
	 fT9OYOrU03U/lBXrwh75XJJ+nGMz7uFFqrzPHi4ccGmIRSkGGIoHkpoDTdGy1jf0zq
	 7UYuaRvxExEQ/uuuaiRPfMFtyeRRyXUuO5bVqNWk3tNUQfdJkgjjHHwRz4FIW7A464
	 Gfm/LQFCLpQ5w==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30beedb99c9so50351021fa.3;
        Tue, 22 Apr 2025 14:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDUcVVNRQnN2IT6VWNi4mXWG9DG3NwDWkL3fzCUiM8mxQZ9Y8ccXmqKio+OGwWcEr1pwdDRB3n5BFNEbboTY3E@vger.kernel.org, AJvYcCXfx3pDb2VjpVHaNRMIN73R3z9zeaAPpn731wi0CBpnVcijy1OcKQQFlzhvz1ofGjP1cFDl8WaGbeuh@vger.kernel.org, AJvYcCXguiuURkAiuUi5TsxwbleVbpC/BORoTWk8EZlPHxFqa3qN7+EgqbsIcgA64nN/15bC3/X1DgC7rYfT@vger.kernel.org, AJvYcCXr7xnIpX+TISLPgVyUcYwNxC2hLHgCRFp1vpOpoM6ISlYukdYGVcfvqRQLQ7Ok5R7cy7eum11+4JI2CV0=@vger.kernel.org, AJvYcCXtckLoJHtP0/8PhTSLP2vuLkvTE+HOqEftGH7eRZXJldmtA47l0eBGpOG7DzqsvAyQtHkAyxnsxlhvvPfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyopMAqU9lSHwq2Egq0c8g65s3lnz9zXd2VF4SbTELY3tMLgycz
	NKLv2oj0dWyPitlipHC1K3pEU2+dXUzgdUSQekLFbHnaILFO/aeougusmeJyRa3drg/lDv/w54w
	8B1gN+MZ4KnL/mbULwGWMub1+vaw=
X-Google-Smtp-Source: AGHT+IHNjwddJlnhR8ziXrRYCvaKzZHBeDFB7aTS+2S6/Juebmx60PYYbz8oxxdYeTQFH7iZZN2OhK0zcRmnc7XV21k=
X-Received: by 2002:a2e:9586:0:b0:310:749c:f8da with SMTP id
 38308e7fff4ca-310905bac8fmr43410821fa.22.1745357206245; Tue, 22 Apr 2025
 14:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <d96f9c5e-64ed-4c28-a8ad-e22daea19742@intel.com> <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
In-Reply-To: <c05731ae-bcf1-4747-b64c-0f4b79f3587f@citrix.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 22 Apr 2025 23:26:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHNpxTqm5hOcxdKRnE58WLmhJo0Rk5pvVGyAtkkki6bvg@mail.gmail.com>
X-Gm-Features: ATxdqUE-wCQ698lYIM2xY-XaLjiHODMSR6r5gfRYGnF_Ynuwr3onsuyDzkvTRu8
Message-ID: <CAMj1kXHNpxTqm5hOcxdKRnE58WLmhJo0Rk5pvVGyAtkkki6bvg@mail.gmail.com>
Subject: Re: [PATCH v14 00/19] x86: Trenchboot secure dynamic launch Linux
 kernel support
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 20:17, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 21/04/2025 9:52 pm, Dave Hansen wrote:
> > Purely from the amount of interest and review tags and the whole "v14"
> > thing, it doesn't look like this is very important to anyone. Not to be
> > to flippant about it, but if nobody else cares, why should I (or the
> > other x86 maintainers)?
>
> There are several downstreams already using this as a part of their
> overall system security, one example being
> https://www.qubes-os.org/doc/anti-evil-maid/
>
> It's all giant out-of-tree patch series (in multiple projects; Grub,
> Xen, iPXE too).

... and this is the main problem: All the existing protocols and
layering go straight out the window, and are replaced with bespoke
alternatives, for booting but also for secondary bringup, etc etc

Conceptually, the secure launch could be performed under the hood,
e.g., during ExitBootServices() when doing EFI boot, and the OS would
have to be none the wiser (or at least, not need 100s of additional
lines of opaque assembly to be able to operate in this mode).

The fact that all these components need such intrusive changes in
order to orchestrate this pivot to the reduced TCB constitutes a
spectacular failure in design IMO, but AIUI, the software side is not
really at fault here: the layering violations are intrinsic to the
hardware support in the CPU. I'm sure Andy or others on cc can
elaborate on this, as they have done many times already.

So if that is true (I'm not a x86 uarch expert by any measure), then
pushing back on this series on the basis that it is ugly and intrusive
is not really reasonable. From security pov, I think D-RTM is an
important feature and it deserves to be upstream if it is used widely
in the field.

OTOH, if the arm64 implementation (which is still on the drawing
board) bears any resemblance at all to the x86 version, it can be
considered NACKed already.

