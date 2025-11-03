Return-Path: <linux-efi+bounces-5330-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC1C2A8BE
	for <lists+linux-efi@lfdr.de>; Mon, 03 Nov 2025 09:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB72C3AE082
	for <lists+linux-efi@lfdr.de>; Mon,  3 Nov 2025 08:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498442DC32B;
	Mon,  3 Nov 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjpmhNnd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247362DC321
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157890; cv=none; b=tDCup2H8BYGcXWlGGm/X8tb7vLNt7X1xrySAfdv9RIOQWAUzNMUQYQglN+92rNTeFsBwaXeI5pzdMLObf5YTzc3jxOAubZ3BYjdjO5+GL4QzNoEjPx8ByTATwPuSGzX/zwrKhRmZtXTpkYgyKGQEnrvrzbWLR89twcY3dmROWYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157890; c=relaxed/simple;
	bh=uiB39ufF+tfDfA88lcPIB5aIdPcR36Hd4plmXFCziCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtPL6oxsMsU+YKBjPCyGm3hfeac/DEEcU+0RQNff4nDjVghUL8tuQwuTQPFGplwR7cfkDtK0UupjU4VO/w/8pp10R4airnXqQdoF1YPqJtx43dULpbbBw5yp4uhVwLjYsVbWQAHRMmfnfYZiBp8D1chjDy5OV0D5eRlUSKt9WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjpmhNnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CF7C19422
	for <linux-efi@vger.kernel.org>; Mon,  3 Nov 2025 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157889;
	bh=uiB39ufF+tfDfA88lcPIB5aIdPcR36Hd4plmXFCziCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BjpmhNndz0o/8p0z967p+qJ9MKjA4+dEHZu8X5cGQBcdHVYv5knzY7EzVEfqpZbEO
	 Ym6vGL/gsssOg8VOFbRIxA44HEC6B3epVDvlCfio4HpKJ6cBrCN43JHCQo5AzlaeL9
	 1nQ3vQw23SZuaRTbnB77vOjLjYhoSuYdLiHT8/YVhDyIWrT0umJ/BJimWapyGWLbU/
	 da3QnoKVqPgxhck0WetEf18GMsHKcCMLoseYgpQbNS/3jIHLsGYoSDbfedgaN9HtFZ
	 qFMOT5hAxFzBEKefYBSfQpI57ZX2bbUvsmpg4xiPE+5V0p5xexpUyPEfbCH98tM4BW
	 5xAl9RIl6n+wA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d50e1c82so39339561fa.3
        for <linux-efi@vger.kernel.org>; Mon, 03 Nov 2025 00:18:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+ozTPZioUItqMvJ485APn5z+GWoIveI07XVIU1dO1CCgNFVu8B21EVGCC+AWxv17Rf/yiXZ9LrSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGRkLB2PPX/nyNz19M0xAggBB1da6JlyRmUxAtfGaCkF+1I7Gg
	s2WkK1oRwtTOCwNzHBn4W453Kb23zAacUsf6DHM0iN8+htsT5ozJ+XCfel7DjxZ3hCLe5uMrFv4
	OjruxuOwQSEEdwmbkrOVswPxeHU61m/A=
X-Google-Smtp-Source: AGHT+IF7S5ZgoTe4rMoUNbVKrfXEzbCDIVxbK+YrADaUheDEsv51KpgQ3fYzrqUCKxtjXhiaKE1ixDKZT692raoR9vk=
X-Received: by 2002:a05:651c:551:b0:335:44d4:161b with SMTP id
 38308e7fff4ca-37a18da4e5emr38582791fa.2.1762157888032; Mon, 03 Nov 2025
 00:18:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXFJCukumMNBmP=Js1EFJrCVcw5_jfxp8SA8Ff1k6j+xXA@mail.gmail.com>
 <DU4PR08MB11151404912A3A7BE565BC3E690C6A@DU4PR08MB11151.eurprd08.prod.outlook.com>
In-Reply-To: <DU4PR08MB11151404912A3A7BE565BC3E690C6A@DU4PR08MB11151.eurprd08.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 09:17:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGUcnSkoT-X3LNGjMNyQXs9L1iaBzawf2Sps3mMYdizMg@mail.gmail.com>
X-Gm-Features: AWmQ_bnBXxbzM3w1e33Z6PQlREzwon2I4MFUA40xVxUtFpiXLzMucAy5veRgpK8
Message-ID: <CAMj1kXGUcnSkoT-X3LNGjMNyQXs9L1iaBzawf2Sps3mMYdizMg@mail.gmail.com>
Subject: Re: SMBIOS discovery for DT platforms booting without EFI
To: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Cc: Jose Marinho <Jose.Marinho@arm.com>, Adriana Nicolae <adriana@arista.com>, 
	Rob Herring <robh@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Boot Architecture Mailman List <boot-architecture@lists.linaro.org>, linux-efi <linux-efi@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Once Rob accepts the dtschema patch here, it can be used as a
normative reference.

https://github.com/devicetree-org/dt-schema/pull/177

On Sun, 2 Nov 2025 at 15:48, Samer El-Haj-Mahmoud
<Samer.El-Haj-Mahmoud@arm.com> wrote:
>
> Thanks, Ard for the proposal.
>
> We will work on submitting as a CR to the DMTF SMBIOS working group. It w=
ould be very helpful if there is a normative reference that defines /chosen=
/smbios3-entrypoint.
>
> Thanks,
> --Samer
>
>
> [1] https://github.com/devicetree-org/devicetree-specification/releases/t=
ag/v0.4
>
> > -----Original Message-----
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Sent: Friday, October 31, 2025 8:28 AM
> > To: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>; Jose
> > Marinho <Jose.Marinho@arm.com>
> > Cc: Adriana Nicolae <adriana@arista.com>; Rob Herring <robh@kernel.org>=
;
> > Ilias Apalodimas <ilias.apalodimas@linaro.org>; Boot Architecture Mailm=
an
> > List <boot-architecture@lists.linaro.org>; linux-efi <linux-efi@vger.ke=
rnel.org>;
> > open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
> > <devicetree@vger.kernel.org>; Tom Rini <trini@konsulko.com>
> > Subject: SMBIOS discovery for DT platforms booting without EFI
> >
> > L.S.,
> >
> > Adriana is proposing [0] a method for DT based platforms that boot
> > without EFI to expose the SMBIOS tables via the /chosen DT node.
> >
> > There appears to be consensus between the stakeholders in the u-boot
> > and linux communities that this is a reasonable thing to do, and it
> > looks like this is going to be adopted soon.
> >
> > Adriana has kindly agreed to contributing the u-boot side
> > implementation as well, so all the pieces will be there in terms of
> > code.
> >
> > What is lacking is a contribution to the DMTF spec, which currently
> > only permits the EFI config table method for non-x86 systems. So some
> > wording should be added to paragraph 5.2.2 (SMBIOS 3.9 [1])
> >
> > It currently reads
> >
> > On non-UEFI systems, the 64-bit SMBIOS Entry Point structure can be
> > located by application software by searching for the anchor-string on
> > paragraph (16-byte) boundaries within the physical memory address
> > range 000F0000h to 000FFFFFh.
> >
> > Given that this makes sense only on x86 systems, I suggest we rephrase
> > this along the lines of
> >
> > On non-UEFI systems, the 64-bit SMBIOS Entry Point structure can be
> > located by application software
> > - on x86 systems only, by searching for the anchor-string on paragraph
> > (16-byte) boundaries within the physical memory address range
> > 000F0000h to 000FFFFFh,
> > - on DT based systems, by obtaining the physical memory address of the
> > structure from the /chosen/smbios3-entrypoint property in the device
> > tree.
> >
> > Maybe Rob can suggest a normative reference to be added to section 2?
> >
> > Thanks,
> > Ard.
> >
> >
> >
> >
> > [0]
> > https://lore.kernel.org/all/CAERbo5z6BzHqQxXdxPxmxE_eDR7GGGbt3A8kB0
> > gQiWFBE-28Ug@mail.gmail.com/T/#u
> > [1]
> > https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.
> > 9.0.pdf
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.

