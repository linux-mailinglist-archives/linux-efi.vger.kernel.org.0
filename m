Return-Path: <linux-efi+bounces-2304-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC069E6867
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17D418846D4
	for <lists+linux-efi@lfdr.de>; Fri,  6 Dec 2024 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8002C1DC19D;
	Fri,  6 Dec 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpY+buiJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598331DC075
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472223; cv=none; b=KINZYF4ME7wuBLiG1BB+PK3UeYePKFvSHAdIXWsirPAGwH+o6HfcMOwwvzgbeY33Za+85iFkrSAfAZ7pzCqeeukXDO0JG/inyFQZw3dl2bQmXKVRtfRl4eaKyh8G/3ECstMz0MeuU0McoZ9GqfJMqrlxtbvBTw75SShlq+bR61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472223; c=relaxed/simple;
	bh=6nNghHiw9Ny2iA7/s1nkgKR4y1jITF9CyUVwz2YIBNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZJmQC8SdINTZAtxhhUvFSF8EBzTB3oE5bb/KLvZXCMhORneeJn7qmIlHGJFPBKE7cFNr25SA+bOxCC0VlCYiw0+kTZMtOx1Vqffok0H48pewowYkig0W78TFv0I2F/+dvv8mX1nTHIs23ZtvE2EnzPmYpRqZhMuwqGsqy+x4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpY+buiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A1AC4CEDF
	for <linux-efi@vger.kernel.org>; Fri,  6 Dec 2024 08:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733472222;
	bh=6nNghHiw9Ny2iA7/s1nkgKR4y1jITF9CyUVwz2YIBNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZpY+buiJwfsepTBsyKlqL//GRVLdqEu2ejrsPn7EtkEftlJc7MW9j79EjEjKiPalM
	 8iX1SSHt0Uc/Su+b32SMcuL9MTQCAoqZmx/tZGrFkwSU8nfNIPc6Rq4UOVop+MpRw8
	 ixPfAiuYWFWyTLYQzdjVYQr9DptXVnjIzQafRIxdif4lXTlmBMXUSQPtoYVZ9q0HSn
	 2KpEp/L8+KtWRW1V9uRkVMNhZngXCvy70MDNbPmmrPlgv4XaJmvIUATVA6lMe0cBKw
	 Ks4Anqi7WM8DuIcV7DjpHbqqn0wOWsERce2k1ZrV5bWJiTncjiy42htQtQd3h4ZKgJ
	 ULFm03SMwMBig==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc357ea33so16289921fa.0
        for <linux-efi@vger.kernel.org>; Fri, 06 Dec 2024 00:03:42 -0800 (PST)
X-Gm-Message-State: AOJu0YynfcDuCweNhTCUzawDO4fEtBLdBDxW3t9hUCf1GGhpARn5RHYT
	A1TZuF2iJ2dqZoOT4lbtB7QBvWX9WFeEx/VI8+TMkGnd8JtiiipTkv36VQJGNKd1psAHfLEJplQ
	fazMv39mZnpCjS9YGnSMGwDGqz5w=
X-Google-Smtp-Source: AGHT+IFs1dmc+CkTOuV1ePibNJnTyDqJUXT5Eyrn0v7F6bZpycqbliSL8CUt5/3zt0J0zaT/DgOh/nCLPRrsSdv3r1A=
X-Received: by 2002:a2e:ab10:0:b0:300:2848:fc7f with SMTP id
 38308e7fff4ca-3002fc946a2mr5395481fa.25.1733472221190; Fri, 06 Dec 2024
 00:03:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206021000.8953-1-piliu@redhat.com> <20241206021000.8953-2-piliu@redhat.com>
In-Reply-To: <20241206021000.8953-2-piliu@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 6 Dec 2024 09:03:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com>
Message-ID: <CAMj1kXGFnwdQZzb_t5kC8nGyDz+MQ0wq6s2oTGNBmV7ebVgSGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Makefile.zboot: Sign Image before packing into
 EFI-STUB shell
To: Pingfan Liu <piliu@redhat.com>, Peter Jones <pjones@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-efi@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"

(cc Peter, Gerd)

On Fri, 6 Dec 2024 at 03:10, Pingfan Liu <piliu@redhat.com> wrote:
>
> At present, the kexec_file_load of either zboot or UKI kernel relies on
> the user space to parse and extract the Image, and then pass the Image
> through that syscall. During this process, the outmost signature on
> zboot or UKI kernel is stripped and discarded.
>
> On the other hand, a secure boot platform enforces the signature
> verfiication on the kernel image passed through the kexec_file_load
> syscall. To cater to this requirement, this patch applies signature on
> the PE format 'Image' before padding.
>

The whole point of the EFI zboot format was avoiding the need to sign
the compressed payload.

Now, we are back to signing the payload along with the full image
using PE based tools, even though the payload is intended to be booted
as a raw image.

I'm not sure I see the point of this: EFI zboot is a trivial container
format which records the compression type and the start and length of
the payload in its header at a known offset.

Perhaps we should just make EFI zboot gzip-only, rather than
supporting 7 different compression methods because that is what the
legacy decompressors on ARM and x86 support - I struggle to see the
point of that tbh (even though I implemented that myself)

That way, the kernel can authenticate the outer PE zboot image as
usual, and perform the decompression itself, without having to carry
code for all compression formats it might encounter.

(Apologies if we are sending you in circles, but if we get this wrong
now, we're stuck with another kexec-related maintenance nightmare so I
really don't want to commit to something tooo hastily)

-- 
Ard.

