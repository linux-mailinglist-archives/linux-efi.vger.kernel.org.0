Return-Path: <linux-efi+bounces-1433-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925ED92F6B4
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jul 2024 10:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A51C224FF
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jul 2024 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB713D8B5;
	Fri, 12 Jul 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSEFYK/a"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC783EA71;
	Fri, 12 Jul 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771738; cv=none; b=YTihhLHASxVULkEstOgb5cpHkK9mzcATWeE1RWiW2WKCpIsVfxt3qlq3WxVLbVsqjXL9+JR5j2CsUw94s6roXzsdFtdRRM5KlS+Fg7jS6ysqvetzAXZAkx+VQEEuUMjR+EFigG/iGPOc2HVBnujTPdiuAJhEZagzT6y1K6xEajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771738; c=relaxed/simple;
	bh=TroBF5yuJZo4zxtTRrm4Is1Mvq8ay+lM/Llpfpy3bHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSqXG0ErLo1tidkPBaWsIDyA995zaIZcx2VYNsxcXNxiS27fx+gqQBMJ0smHI0fTdYIb+vEP7+DuI1nQ4RYZrBlckL94qw6Re7oKzG1V0iAxUjLSsPNdT/QxExSoLKaL2WqyPK6TopYvXGq/1/tWLn1xi1rJrixZfoA9p4LXLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSEFYK/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675D5C4AF0A;
	Fri, 12 Jul 2024 08:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720771737;
	bh=TroBF5yuJZo4zxtTRrm4Is1Mvq8ay+lM/Llpfpy3bHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PSEFYK/aBueHUWWsAc+qwprVU4TC2zuKY0Ysab3DBHJqYCRoT+P7QMgIW6vyFX4Kz
	 X1qmorhGMrgicqoKy4js3lwkXAywK/YHVCXWv7ToCC08Pi6NMTBpkGi7Z+SUY9gnlg
	 2H66bMFVaudJ/DuGjLiYIuKLaIEezP6uqaI0xuwSxZfUDrj2MQND2QD0UoPSmVcbOT
	 QuhNH34pqy9SLKRjODJieCSIGhQ7iGnhOHU0cELfUUGbC/GFRkaYCX4F0C7TKG1f/N
	 kRGszYoIGHp6/MOO8UUeZG2djetB1qVcjLKNe4vjDIRhsp6VKGF+EkA4TpprS9AE8X
	 ihKBEvjWGxioQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ee92f7137bso17517591fa.1;
        Fri, 12 Jul 2024 01:08:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8WpY4r3bN64vmu18AI92dj6w0NjtmHV1KUE6Z6weHpxyrotK6SozenxV+xafThrquYxnwLD5OiAQfGPjbB5xifAHrw9Y6+3wq3C85PRNuiSrVNgtE2o7e3Vk54RjmzSzASX2+xKNzwqK2Uk3dY6kh7N9kjBU/8RDdFvQYmd3s1jc6PCTdiF9D
X-Gm-Message-State: AOJu0Yyj6ti3mS0yNjRdxqYQHAv07N2KMKBQR5uLKbridOA1Jj0PepEy
	TsQSTLMyGs/DYroD3zJQDZAvYo8D/kimNudr/+WWyY4NM3O8viSTc/RMYZHUQ3p5Okf6iu4fonl
	9OtkEWYA5aAs8WSGfhjW/lGDRSLs=
X-Google-Smtp-Source: AGHT+IEO3l05LOiWeBExFhCboY9TaNGpuCXVWV5x7f7o2rZdfKE2zDxPECLRNUHoj8/ve8Tov3xMnekukPDToxMSC2k=
X-Received: by 2002:a2e:911a:0:b0:2eb:2e0b:72c with SMTP id
 38308e7fff4ca-2eeb30dc843mr82803641fa.16.1720771735762; Fri, 12 Jul 2024
 01:08:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711170727.it.194-kees@kernel.org>
In-Reply-To: <20240711170727.it.194-kees@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 12 Jul 2024 10:08:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHPCVJarDjyb07ZPqHS2PwFwdTPWtF0e1J=Lzb8kv1uSg@mail.gmail.com>
Message-ID: <CAMj1kXHPCVJarDjyb07ZPqHS2PwFwdTPWtF0e1J=Lzb8kv1uSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi: Replace efi_memory_attributes_table_t 0-sized
 array with flexible array
To: Kees Cook <kees@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Baskov Evgeniy <baskov@ispras.ru>, Ingo Molnar <mingo@kernel.org>, Radek Podgorny <radek@podgorny.cz>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jul 2024 at 19:11, Kees Cook <kees@kernel.org> wrote:
>
> Hi,
>
> Update efi_memory_attributes_table_t to use a proper flexible
> array. Renames efi_early_memdesc_ptr() to efi_memdesc_ptr() so it more
> accurately reflects its usage.
>
> Thanks!
>
> -Kees
>
>  v2:
>   - rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
>   - add comment about reading efi_memdesc_ptr() to efi_memory_attributes_table_t
>  v1: https://lore.kernel.org/lkml/20240710225538.work.224-kees@kernel.org/
>
> Kees Cook (2):
>   efi: Rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
>   efi: Replace efi_memory_attributes_table_t 0-sized array with flexible
>     array
>

Thanks, I've queued this up now.

