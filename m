Return-Path: <linux-efi+bounces-5386-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7061C3F608
	for <lists+linux-efi@lfdr.de>; Fri, 07 Nov 2025 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DD218837A9
	for <lists+linux-efi@lfdr.de>; Fri,  7 Nov 2025 10:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D313009EE;
	Fri,  7 Nov 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKvIDht7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9A2FD673
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510659; cv=none; b=k0H1SZcq4oXX2Rs7qWmCABy1DaWlwK8il3RDcm7PbOmDLfKsdVquhV5VPt7HCwqqbzFT9agnC4MiH0H0PnjOpvAzG3vVrtSU2AtrR7aTh3OlNy02b/thIYoTv1S7FjjQP+0rmQ5K+8hufbukKM8NNqcJ4VqR7JJVkGMd4GxkpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510659; c=relaxed/simple;
	bh=arlVfPdYe3UiKIacT71hJyo52FEEmenfhFoMLnTXSxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHuAkjltwC8DW3aHzM//WEbTplLHbxAUllalGAWpg3lTnCZDlDRN1xBA/Kn0x7lDuyAiFLV7k5hQHceyL4LHwMQwszejLVv3t0Iuxk8d1lmBTH+VUV6z9e4XEZsLCcFMZZJ9OibXwGz107Bi3tZTGXGMckKJNSiT8lkD0F7StkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKvIDht7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768FDC4CEF5
	for <linux-efi@vger.kernel.org>; Fri,  7 Nov 2025 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510659;
	bh=arlVfPdYe3UiKIacT71hJyo52FEEmenfhFoMLnTXSxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YKvIDht7l4oVHTr7yJEvsNIsb6BKJ3Q54wIifctbIk2EbgxotNt3ffPiqiNncuub0
	 XR76U/PZPV76GMSz6xsvjB30wuQL5sOH7pY2aC70OEoTRomaAV1cOheaqZufrvggXI
	 pM2Sl+2Ds3hS4TTWARTssK3+qY/cOKhDwRjbLGgNab0USzt+xu4oqdwsnKOTEoZ8yE
	 QKbu6E0Cc3Dok0IZ8hM9NuTa7qtA+YPBL45qVB4kRr34Itj9Qe4ERQY5SNNNzZh304
	 qggnqVtkudivimbpGnKG+r3q3gYEpN0tIvjn+FwY9qAjaPABGYyvV7xD8nUCN2YY6u
	 tJWZ6qfVJGUuQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59447ca49afso629011e87.1
        for <linux-efi@vger.kernel.org>; Fri, 07 Nov 2025 02:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWIMLg6FGJJ3qdjxRqVNwfRvo13l8HY9YMEKOx3P8Dk0ti7q5Qks9F7fv9NKEp3O5NLtaST1GDBkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxwa7x1IT6CSC1728exfd+iwTtvx+yc0Dj42+BrcuA+TxUhrR
	J/7m5QC1QeTIPoZb5pGehwnFk9xIjW1HO7i1lwrAHKM/w/pAJbKUMrECo99f2Uxdw0S5Xm0zwHV
	GBt2PRPfUjuN3NMwHaE2Xeeg25Fgebww=
X-Google-Smtp-Source: AGHT+IE/XYYxpOEX/Z7mBSZkdLHtJSOaW05OPzavoiOdoVqrUeqP4sb22fq75J96c7knabnGnpYkV8NFT+EOwV21q0U=
X-Received: by 2002:a05:6512:114b:b0:58a:f865:d7a6 with SMTP id
 2adb3069b0e04-59456ba0021mr819044e87.48.1762510657742; Fri, 07 Nov 2025
 02:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
 <20251029210310.1155449-6-sohil.mehta@intel.com> <3e9c4fdd-88a8-4597-9405-d865fb837d95@intel.com>
 <cac58a25-eda6-4738-966f-a4e42818aa6c@app.fastmail.com> <6dec8398-3f7c-44db-a30d-33593af0217f@intel.com>
 <efd6ec82-5576-41f1-a244-2f80d72e93e4@intel.com> <ee2fce64-91ce-4b78-b2f9-33364ea0c52f@intel.com>
 <20251107090406.GU3245006@noisy.programming.kicks-ass.net>
 <CAMj1kXFQaGaz37MNKXXjhUKy_mP-5teCDj80-hjUPHw4x+TKrA@mail.gmail.com> <20251107101003.GB1618871@noisy.programming.kicks-ass.net>
In-Reply-To: <20251107101003.GB1618871@noisy.programming.kicks-ass.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Nov 2025 11:17:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFQYN8QF5Sd4ObsCziM-0gitGS5D1S1qCscKpQaZVDLA@mail.gmail.com>
X-Gm-Features: AWmQ_bnMcv5ykNOoKNY2OE119Vgn62Zu9BQlLgx3zSXeTiu2CQ91Pez_S2fCPXA
Message-ID: <CAMj1kXHFQYN8QF5Sd4ObsCziM-0gitGS5D1S1qCscKpQaZVDLA@mail.gmail.com>
Subject: Re: [PATCH v11 5/9] x86/efi: Disable LASS while mapping the EFI
 runtime services
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Andy Lutomirski <luto@kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	"Kirill A . Shutemov" <kas@kernel.org>, Xin Li <xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Sean Christopherson <seanjc@google.com>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Nov 2025 at 11:10, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 07, 2025 at 10:22:30AM +0100, Ard Biesheuvel wrote:
>
> > There is also PRM, which is much worse, as it permits devices in the
> > ACPI namespace to call firmware routines that are mapped privileged in
> > the OS address space in the same way. I objected to this at the time,
> > and asked for a facility where we could at least mark such code as
> > unprivileged (and run it as such) but this was ignored, as Intel and
> > MS had already sealed the deal and put this into production. This is
> > much worse than typical EFI routines, as the PRM code is ODM/OEM code
> > rather than something that comes from the upstream EFI implementation.
> > It is basically a dumping ground for code that used to run in SMM
> > because it was too ugly to run anywhere else. </rant>
>
> 'https://uefi.org/sites/default/files/resources/Platform Runtime Mechanism - with legal notice.pdf'
>
> Has on page 16, section 3.1:
>
>   8. PRM handlers must not contain any privileged instructions.
>
> So we should be able to actually run this crap in ring3, right?

How interesting! This wasn't in the draft that I reviewed at the time,
so someone did listen.

So it does seem feasible to drop privileges and reacquire them in
principle, as long as we ensure that all the memory touched by the PRM
services (stack, code, data, MMIO regions) is mapped appropriately in
the EFI memory map.

