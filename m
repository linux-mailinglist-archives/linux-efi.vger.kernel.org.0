Return-Path: <linux-efi+bounces-5024-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C004BCEF5D
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 05:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F25F19A2644
	for <lists+linux-efi@lfdr.de>; Sat, 11 Oct 2025 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4B1DF985;
	Sat, 11 Oct 2025 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzNmc2ht"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B351DD9AD
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 03:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154040; cv=none; b=iMkgpGamBTt63n1+Xqemi9OtAZICkYQHB1aRCJ4FgsAh3H+wgLXlq61TtYg3poMdtt7pw4LaBxC5Osv+rtjYLcJB0zrf+PKydRTzHXpgHL5W1A9NwRg/mT8vBeOMkSSHY4Vw34Ch2WGp0/iMp+lc0MNITEDsj6hMND6P98jHCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154040; c=relaxed/simple;
	bh=d8gS8wOiKMr+l/ZJJK/wQClNzHRVZjbJoYCPz75pBA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpNoNRFr4hBFmGdoZdLA608ApWcY+c+Qzh4M+cyYTQV8U21lU7vS0UmOTYp2adJhtUOtQcnLxtyvaIcChQQezSGQY1bTMg8lD3xkTEwEQZlGdtbBoQtapdIp8n26R2RqnomTk2N7NbcKcD++h1w8xBdczBs9RBR71EEPEC4/4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzNmc2ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB02C116D0
	for <linux-efi@vger.kernel.org>; Sat, 11 Oct 2025 03:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154039;
	bh=d8gS8wOiKMr+l/ZJJK/wQClNzHRVZjbJoYCPz75pBA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DzNmc2htDKTHCp3aozZ6E5kEpQ/T9k9BWOy4+jwgGV0SIndwfInOWiuXfSFiC5/5t
	 QL0ZrMiCOK0FsZeNjSXSIG3/Br58Maj0goLA9/Q6msU1Q15XtRG+/XCdCPfCh/moCu
	 3wN9SmB4nk5eeZ2n9d7wmFfMO1QGUzW5I1c3d7STbqXTYzS+mpV20pHVAmWvmSxSj4
	 RkOfn0MoXV6y5yHYuCfrLF8mrUT/cWs/nH/BhFqc8TDo0dG4dA+boCphnqx3GOExuE
	 QOttymeUokIXpaUETbAytEn+TzSZ/z6oVLixTt5MXuB/USBSphsTqedUHobjukDNnT
	 j/m2eilL1toDw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so2667059e87.0
        for <linux-efi@vger.kernel.org>; Fri, 10 Oct 2025 20:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWO4YuWCVRJXEWFrpsPx2iRXdjSo+y3Pbp6TA+3F+GtMiw86/TGe6u24GLHdWPJr+5p/sH5/X6Mktw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkYKT44sbG7iBj/YkAFK4HQF0EdlhSRyh7fj6zPlqoF6K65s4
	uUJxC20YiF9bLPEz8tYLNucW2tO5Hf+nmbWeuWifZMB1YMCwuRLMaMLWsNOeu4xsVPcHVw1fOEK
	Xtyp+pCYitbjB4z0c+1m4xykq17b6yg4=
X-Google-Smtp-Source: AGHT+IFLXMYQ5g+Z7hYaE+htkOTZgcAsNtsCxDgeGT8tN/INhUQhJ+SJe8urgMafAAQJ9Ld+ELNhgSE8e7XFB5+/m9g=
X-Received: by 2002:a05:6512:b10:b0:577:9ee:7d57 with SMTP id
 2adb3069b0e04-5906de88ee4mr3575140e87.46.1760154038165; Fri, 10 Oct 2025
 20:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com>
 <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
 <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
 <fec0c03d-9d8c-89a3-886a-1adc22e59b66@loongson.cn> <CAMj1kXFLyBbRL+pAAQ6be6dxqFPiyw_Ug8qNQWaicZQ235HE=A@mail.gmail.com>
 <8091e8fa-3483-af39-2f7a-e4eb62b0944f@loongson.cn> <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
In-Reply-To: <CAAhV-H4+UGLSkbjHbq9MerWfxnq0a13x+uzNfTsCoe1UxjbWsg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 10 Oct 2025 20:40:26 -0700
X-Gmail-Original-Message-ID: <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
X-Gm-Features: AS18NWCSTMnmP5OepZJr1Y4u3ZHVFaMO9Ik-XYJVsvY5QDAPT-bP-GHnlwwanEk
Message-ID: <CAMj1kXH-rK0bRyHXdJ-crAyMyvJHApH0WR7_8Qd8vrSPBLK+yg@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Oct 2025 at 19:54, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> On Sat, Oct 11, 2025 at 9:13=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.=
cn> wrote:
> >
> > On 2025/10/11 =E4=B8=8A=E5=8D=8812:25, Ard Biesheuvel wrote:
> > ...
> > > Why do we need both (1) and (2)?
> >
> > Not both, either (1) or (2).
> > Which one do you prefer? Or any other suggestions?
> >
> > Taking all of the considerations in balance, we should decide
> > what is the proper way.
> As a summary, there are three methods:
> (1) Only link libstub with vmlinux.o during the final vmlinux link.
> (2) Remove the attribute __noreturn for real_kernel_entry() and add while=
 (1).
> (3) Ignore "__efistub_" prefix in objtool.
>
> Josh prefers method (1), I prefer method (3) but also accept method
> (1) if it is not only specific to loongarch.
>

This is a false positive warning in objtool, which complains about a
function that falls through, even though that can never happen in
reality.

To me, it is not acceptable to modify how vmlinux.o is constructed
also for other architectures, in order to hide some of its constituent
parts from objtool, which do not use objtool to begin with.


If you are not willing to fix objtool, I suggest fixing the loongarch
code like this:

--- a/drivers/firmware/efi/libstub/loongarch.c
+++ b/drivers/firmware/efi/libstub/loongarch.c
@@ -10,7 +10,7 @@
 #include "efistub.h"
 #include "loongarch-stub.h"

-typedef void __noreturn (*kernel_entry_t)(bool efi, unsigned long cmdline,
+typedef void (*kernel_entry_t)(bool efi, unsigned long cmdline,
                                          unsigned long systab);

 efi_status_t check_platform_features(void)
@@ -81,4 +81,6 @@

        real_kernel_entry(true, (unsigned long)cmdline_ptr,
                          (unsigned long)efi_system_table);
+
+       return EFI_LOAD_ERROR;
 }

