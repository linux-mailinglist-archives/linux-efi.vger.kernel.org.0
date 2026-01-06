Return-Path: <linux-efi+bounces-5945-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D257FCF7E25
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08393314BEA5
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F3432E6B1;
	Tue,  6 Jan 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9AM8XTT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5132E157
	for <linux-efi@vger.kernel.org>; Tue,  6 Jan 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767695016; cv=none; b=C2pg+0Eb1nTUiN5fwZxLbPvsk9oQls7jfJAIMDc9VC+/aMMwSIH/t5fh2AGN44JMa2wM+MkwvB6zXYiuKySNFOj3IGvX8XazGrAGd51VH/ipCAy8LdCnQ6N6KcSqSIm1eXuZQIvdkobdRoVofYpVqWCRzKQhZkKmVuzVjWuwOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767695016; c=relaxed/simple;
	bh=7G/63Ebg037MtWPdMChR2/hajf3uRri9rZlipp0hdvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFdF89SiQdVaa/QqvuuH7+F3Rd3kiixzZcY9P/b095NPDGbPafS/5lt8w62117K39KElhjQDj2aw9ntqOkTiULKKT5wJCyoMQA79mo+AtRpWSZzTTCtTu/n2n7EZcH3dJGPtQwIsuU+e1YDAvMTh9dH1Vax/X9XEC+4NhFBHHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9AM8XTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD662C19425
	for <linux-efi@vger.kernel.org>; Tue,  6 Jan 2026 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767695015;
	bh=7G/63Ebg037MtWPdMChR2/hajf3uRri9rZlipp0hdvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9AM8XTTiEn3d3buU61YhWWO/iV+wvM8AWzOcUCrENr+1LMFqYOQL3NPHjrCv/bBO
	 lUgyeVkx2QEHvJLtH+O6q4kb65VN6uD9XlgWFZtm8IHSI0NfBHL/3AHRuSNYpzJ3+B
	 fjEmae8Ytsd96++7EgqD2b2ccRwJdJHO0ZXVQ3xtgu+hE6nNkrN+8CADjKjDeT8tOd
	 OBhEaxDLawAtthZETP00dUW9XKrubbwoJhRoWpepO2SCAaUoLvQXADGUZ+TVw60qgp
	 YD3uoMQtyx5rvo2vchc+7yAk+ylRk2yvZBQ4bWDd+T/BKX6wiGHZ8mx2O5Nn0Yx9ck
	 Uil0DC1Kcu2nw==
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so811797b3a.1
        for <linux-efi@vger.kernel.org>; Tue, 06 Jan 2026 02:23:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjIRGiwOuDZRnW1F6+3RtfY5wdM9S1sKWtphndhABwxz/6z1cm5FcLjE3HTjpktNjBGWp2RtSbaI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUGWm7rogliX1yPFPQZTPKtjeddAjRmwvQOxHM9KD5bB6cMWh
	SGCCCFFKRurHLmJztL9eokC/CRfUcxvEcnOQzwKA4g9UgNg8K8f3IWAeuD7BJP3ky/1CNb63Crv
	Mmjf2hiMIsA1F8l/5V1IoB4R4MEl137E=
X-Google-Smtp-Source: AGHT+IGRu6tzZVsaq2B/AJ6p/F7Ga3K9ztaebfR7/XzLB4J/0IxzBLoDP96qpOtIr0VbIrLiDGar8eXDw4yLmfZ/NT8=
X-Received: by 2002:a05:6a20:549d:b0:34e:1009:4205 with SMTP id
 adf61e73a8af0-3898227b579mr1971666637.27.1767695015301; Tue, 06 Jan 2026
 02:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105135847.1585034-1-ben.horgan@arm.com> <aVvPIdREAdweYqZf@e129823.arm.com>
 <aVzAvqv8JnjrjJbF@r1chard>
In-Reply-To: <aVzAvqv8JnjrjJbF@r1chard>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 6 Jan 2026 11:23:24 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFpvcjtU-j=bQxMkH7h8yTFxGcjtJ0_cbbYPLWv_RXGMA@mail.gmail.com>
X-Gm-Features: AQt7F2qWXwk26mnOyrsQIoVCqQG-xBmoGdDbnqNwtvhq146Mfo0teG8s7g_Lh_0
Message-ID: <CAMj1kXFpvcjtU-j=bQxMkH7h8yTFxGcjtJ0_cbbYPLWv_RXGMA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/efi: Don't fail check current_in_efi() if preemptible
To: Richard Lyu <richard.lyu@suse.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Ben Horgan <ben.horgan@arm.com>, linux-efi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	will@kernel.org, Mark.Rutland@arm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 08:59, Richard Lyu <richard.lyu@suse.com> wrote:
>
> This change is good to me.
> Reviewed-by: Richard Lyu <richard.lyu@suse.com>
>
> On 2026/01/05 14:48, Yeoreum Yun wrote:
> > LGTM. feel free to add:
> > Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
> >
> > > As EFI runtime services can now be run without disabling preemption remove
> > > the check for non preemptible in current_in_efi(). Without this change,
> > > firmware errors that were previously recovered from by
> > > __efi_runtime_kernel_fixup_exception() will lead to a kernel oops.
> > >
> > > Fixes: a5baf582f4c0 ("arm64/efi: Call EFI runtime services without disabling preemption")
> > > Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> > > ---
> > > On the partner platform I was testing on this issue caused the boot to fail.
> > > ---
> > >  arch/arm64/include/asm/efi.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> > > index aa91165ca140..e8a9783235cb 100644
> > > --- a/arch/arm64/include/asm/efi.h
> > > +++ b/arch/arm64/include/asm/efi.h
> > > @@ -45,7 +45,7 @@ void arch_efi_call_virt_teardown(void);
> > >   * switching to the EFI runtime stack.
> > >   */
> > >  #define current_in_efi()                                           \
> > > -   (!preemptible() && efi_rt_stack_top != NULL &&                  \
> > > +   (efi_rt_stack_top != NULL &&                                    \
> > >      on_task_stack(current, READ_ONCE(efi_rt_stack_top[-1]), 1))
> > >
> > >  #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
> > > --
> > > 2.43.0
> > >
> >

Acked-by: Ard Biesheuvel <ardb@kernel.org>

