Return-Path: <linux-efi+bounces-3359-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBB2A93343
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 09:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639627A99E2
	for <lists+linux-efi@lfdr.de>; Fri, 18 Apr 2025 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FB12686B3;
	Fri, 18 Apr 2025 07:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqrv3FBC"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C13253955;
	Fri, 18 Apr 2025 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960356; cv=none; b=ZCGaB8CwOtDXsGpDnqie7r8iUOmqzDnKlsve4pkri/fRjFL4hP391Tf9uVmiKW9M8ExfnTluu6Qc+8+F9aqY7JV//qFX2+n/oKh/1Vgxlua0hPqTFXCEgYn/JV+OrMJKcqonhxS60IJakXMsilqRYAvt9zqtIKDB402Rsr4llSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960356; c=relaxed/simple;
	bh=IGplsZv5NV3fSX3lKlH0s+Mz+pPQO3iP62Vs+r45B2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDyjAlhKwmXOjg+4SWMdqAdZSQljXraJL7jXxGpgl74K3GTEoXYaHWE8iZNKUTLa/pJabmzYmZDYz8MlfB1QgcF2tWpAvVwgeMbgQKbB3DNf1umRmoKq03BGTzqkitS6hCYA+wnOb5dtEBdRuaGPLR993Y3dw59EWemhG+dSUX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqrv3FBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F11C4CEED;
	Fri, 18 Apr 2025 07:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744960354;
	bh=IGplsZv5NV3fSX3lKlH0s+Mz+pPQO3iP62Vs+r45B2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hqrv3FBCUn+C89k4mK7pHBQNthTZbVunPQpPyZfgz3UsSwx+SI14lMjbd285mrB4C
	 4LkdR2pg8WZgGYGRRvb+1QA2+teX7PiPDggB/kVMPd7d4+KU1Ns+WepvJC6gUUt63k
	 i7rQlMdv5UnMh6pXSTBBh5JaxpRoBBzUCTtm/RPa3ChT/Pn8Vi1MdDYfELPYhVHK7m
	 ZWTgDEjTJrZ8RjsycumgUybmvDQp0/dBWxoJq4JuChAEh7WlsnXJTfRp8LtEdyuatX
	 Rmygewq6StcuZq8crGQ8P5VEdhNJqjKxVFL0jygYvQTHYkHmPjtXHzkkl7Rq2E5arH
	 N7F55yX/lunfA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54d65eb26b2so1450592e87.2;
        Fri, 18 Apr 2025 00:12:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKhMXXLDN88Zc3s0ZG1DG3OBkohd+o5SmU5CEtKtLRY7VxJISOzmCadP2YuSRkp12U2+CD0u4wX/ChIzMVMsIonnU=@vger.kernel.org, AJvYcCXIRgaL7dLN71sDH7ZNjR98vdhL98iYcZV4EZI6ZuiuOJbyjKqwoNMMxbeuxKdX6AWj2m2MX8d42rY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZaKTMKY7CMEUv9Hx9bbFGnS97qkGDzmbb+ChYE1cMTHv1htSW
	EthROIZItN/6nOM5BllSG7Z14ZFCwPBVii9BWaQT8pXTiArhGI+2TuIPRbHuEG1tm0jMAGWeueZ
	eP7jWwlc5qhwoAPmpMaWHneTEB8c=
X-Google-Smtp-Source: AGHT+IEtvy8lsnlF0Hom1dwg1kwU6oHxvO0Tzxo4Gbn29xWyXvBOHJzFV4/nSajDqVBWcHr+IyGvj9D3NgxS51oUCm8=
X-Received: by 2002:a05:6512:1598:b0:545:944:aae1 with SMTP id
 2adb3069b0e04-54d6e61be62mr459896e87.12.1744960352856; Fri, 18 Apr 2025
 00:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410132850.3708703-2-ardb+git@google.com> <174448976513.31282.4012948519562214371.tip-bot2@tip-bot2>
 <CAMj1kXFEXZ8cGMwz6N_ToYp0Wf5Vr9UBFRueWx_MtrwbDLq+LQ@mail.gmail.com> <Z_rQ4eu4LYh6jGzY@gmail.com>
In-Reply-To: <Z_rQ4eu4LYh6jGzY@gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 18 Apr 2025 09:12:21 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>
X-Gm-Features: ATxdqUFSZYSzhayH8HR_8vlXz5UCXO7B_Opm4HMpscXP0Yw54leyf23bLKfLlEw
Message-ID: <CAMj1kXGTP31w7vM+jWqpbJPmoyPU9vqOrmvXsueoPnBin0y_hQ@mail.gmail.com>
Subject: Re: [tip: x86/boot] x86/boot/sev: Avoid shared GHCB page for early
 memory acceptance
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Amalie Glaze <dionnaglaze@google.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-efi@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 22:45, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Sat, 12 Apr 2025 at 22:29, tip-bot2 for Ard Biesheuvel
> > <tip-bot2@linutronix.de> wrote:
> > >
> > > The following commit has been merged into the x86/boot branch of tip:
> > >
> >
> > This may be slightly premature. I took some of Tom's code, hence the
> > co-developed-by, but the should really confirm that what I did is
> > correct before we queue this up.
>
> OK, I've zapped it again, especially as the rest of the series wasn't
> ready either, please include the latest version of this patch as part
> of the boot/setup/ series, which hard-relies upon it.
>

I have sent out a v4 here [0].

I am not including it in the next rev of the startup/ refactor series,
given that this change is a fix that also needs to go to stable.
Please apply it as a fix and merge back the branch into tip/x86/boot -
I will rebase the startup/ refactor series on top of that.

Thanks,

[0] https://lore.kernel.org/linux-efi/20250417202120.1002102-2-ardb+git@google.com/T/#u

