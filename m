Return-Path: <linux-efi+bounces-5296-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0077EC24FF2
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 13:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F352349366
	for <lists+linux-efi@lfdr.de>; Fri, 31 Oct 2025 12:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7E347FE9;
	Fri, 31 Oct 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emKUl3Cr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A7E346E64
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913717; cv=none; b=dsI2ANx6XAM9d+Zj5HWBDSOvXTOzG7ythHv9LZ3uw3X7Megw+3brqUZLiMfPDrCVWerJJ9ik0RvuzysFoXijyHCkV8xhWqVWOI5aODK7ykcdH0VfxRM5JhSOFdR2xkvLRdeTgDbz1yBoOaKWypNpxlyaU0qLZs9LeyNM47mtZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913717; c=relaxed/simple;
	bh=Xot+lC8TdJpuY+76aleIGJRU/xG9gThQs3eGHe+5Vlk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lE3XvwT17gStIDzt6QVmlhn5tDYdR42CPsSh4BH5vdTUzT+8Ny1ZALiZZphs96R2I7AbLqviJWCyENkvPAFGPU/c/2ASuCXlptBIlqF4yDT5CTX/j9XKapDd8vCJCvTUEeYsiN+1PQqNulG+EsizS8brenMW4n8AB90PMcHlv40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emKUl3Cr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64652C4CEF8
	for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913717;
	bh=Xot+lC8TdJpuY+76aleIGJRU/xG9gThQs3eGHe+5Vlk=;
	h=From:Date:Subject:To:Cc:From;
	b=emKUl3CreDIK5dkp0xbV75bhevXCae5cGf5mMHCBuiYISjs7fS7qbmfBgYniO2qTy
	 C1qZcdmVRdoVZVl0KgB6O6FUGBxTJwdItYJduGTLX2QIdeFTj1M86hBK/b8bnturu0
	 lZdNG2DKC9VsRIRXTC7t6hu4RqtN/sf/SBhiUCakbhAAHVCKnSEPPpqs5KkGolnBPY
	 9yYRYe6Ub9JUJ1N2DdwCKc/lv/zJALNTfiU2Slig7kjMe1Es9c1mw/mIupxJoiGbS4
	 CA8SaijZwARJDlLKl0Fjfc9G9koZkA5HZqvy5WhnHuCzT/GxZpgOnoGzTnyJG3Amp7
	 AuEJg/hIgkdhw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378d710caedso21259241fa.3
        for <linux-efi@vger.kernel.org>; Fri, 31 Oct 2025 05:28:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFr0w4rvOkbLLk+irQj1vj/x9/XuVXZHYPjFkpr66Ux8U5krT+nk3oQEAU6DcSNXsaxHQIWfd+v/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCz6dyBqf9JbhtvuVqP/xRLc8KtI4ZcGeos3PTkCrknjM6E8j
	cUc16QyyrhVymuTkE8FLU/AUBUBOG05yIlTA0pXpCzPPCh9b8txrxdYu5hBkj3p3YrPdfWmSKAN
	coX6DODllLGXh/SsWWZjseoTw7exLI+Y=
X-Google-Smtp-Source: AGHT+IFrur7tbbCWoTl5YkgD6BAGrmUfSRnK/sLvDdJzIhzJC62xf4K811jpH+emuzFqXV9RYy+15S3eb+QTl/V5Li8=
X-Received: by 2002:a2e:88d3:0:b0:373:a5ad:639 with SMTP id
 38308e7fff4ca-37a18da8736mr9035611fa.8.1761913715793; Fri, 31 Oct 2025
 05:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 31 Oct 2025 13:28:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFJCukumMNBmP=Js1EFJrCVcw5_jfxp8SA8Ff1k6j+xXA@mail.gmail.com>
X-Gm-Features: AWmQ_bnudCvDhYFZOGKjp2WvpofKqUnrZWX1_mDQYCDEQblEyK0bR8lbART1V8I
Message-ID: <CAMj1kXFJCukumMNBmP=Js1EFJrCVcw5_jfxp8SA8Ff1k6j+xXA@mail.gmail.com>
Subject: SMBIOS discovery for DT platforms booting without EFI
To: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>, Jose Marinho <Jose.Marinho@arm.com>
Cc: Adriana Nicolae <adriana@arista.com>, Rob Herring <robh@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Boot Architecture Mailman List <boot-architecture@lists.linaro.org>, linux-efi <linux-efi@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"

L.S.,

Adriana is proposing [0] a method for DT based platforms that boot
without EFI to expose the SMBIOS tables via the /chosen DT node.

There appears to be consensus between the stakeholders in the u-boot
and linux communities that this is a reasonable thing to do, and it
looks like this is going to be adopted soon.

Adriana has kindly agreed to contributing the u-boot side
implementation as well, so all the pieces will be there in terms of
code.

What is lacking is a contribution to the DMTF spec, which currently
only permits the EFI config table method for non-x86 systems. So some
wording should be added to paragraph 5.2.2 (SMBIOS 3.9 [1])

It currently reads

On non-UEFI systems, the 64-bit SMBIOS Entry Point structure can be
located by application software by searching for the anchor-string on
paragraph (16-byte) boundaries within the physical memory address
range 000F0000h to 000FFFFFh.

Given that this makes sense only on x86 systems, I suggest we rephrase
this along the lines of

On non-UEFI systems, the 64-bit SMBIOS Entry Point structure can be
located by application software
- on x86 systems only, by searching for the anchor-string on paragraph
(16-byte) boundaries within the physical memory address range
000F0000h to 000FFFFFh,
- on DT based systems, by obtaining the physical memory address of the
structure from the /chosen/smbios3-entrypoint property in the device
tree.

Maybe Rob can suggest a normative reference to be added to section 2?

Thanks,
Ard.




[0] https://lore.kernel.org/all/CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0gQiWFBE-28Ug@mail.gmail.com/T/#u
[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.9.0.pdf

