Return-Path: <linux-efi+bounces-5529-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B14C63D6E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AE034EAC3B
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CA31E0F7;
	Mon, 17 Nov 2025 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0iH7zKi"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF4128640B;
	Mon, 17 Nov 2025 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763379188; cv=none; b=U7SQP5bK1n/J4QZlT36e9NubCG99fJpYFIjkoblcwu0f6opDhEJVzGulL3yvx16aeYrif7H2D6JLexrP1oWIwugpHOfZQ4urfF3bzsvwRmSi6HwlTLGMseM9bGdrU6GMCoIwEYEHKyonuW9JtqUDMQBtXf9Y0PiLMnBpMoZ6RCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763379188; c=relaxed/simple;
	bh=7c7c0+Y2B/04JUOEwi1O55W3Y0JytX6yoqbHe2m//uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acBKtAYy2zwjbdePSx68JEZJnA3lbuwcZWlmxjaXtf9GWvV26ty9xbyqww6K5vCd2OnERU+dPjHsomibhV8ABeZgSPsnmBqxfYIf2PaI6rwJPqObBP1sUuiwia70cwGnGPBumTE3PaDYqRQcZQzkdpUTWEzEN6NNAJ8YzVVhqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0iH7zKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FFEC4CEFB;
	Mon, 17 Nov 2025 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763379187;
	bh=7c7c0+Y2B/04JUOEwi1O55W3Y0JytX6yoqbHe2m//uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0iH7zKi3zR5ITzvZgCo9KeJonwjYrYbonjxhYepOF3+xHZpaS3i9D0kEds9bBtBm
	 tJVhUeo2NjA866SWv2uwt3B84zpsGt+rFkub8wba2n8v951OWWCU4Ddn/CRqhFholS
	 t3JB2pOs8OAnnfo4XkYh5ksbvyG8Z2wOlp8SyxiDt8FhWpp/46kJIUxDt07hIkoRYi
	 XHgQ9t+WpdVXZLdyBUt/JFVk0g3dfRlmreSb7STQNAVkigTmeYh/PoCPatGNe790Wb
	 Fc0XZYMC40b+xXj9qVj/Dhc27kCOKFThiDS6ouhgXyf3oZzLgiJvVxpO1KCY61s7In
	 tDypGsaVFETGQ==
Date: Mon, 17 Nov 2025 11:33:01 +0000
From: Will Deacon <will@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Ard Biesheuvel <ardb@kernel.org>, loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <aRsH7RTpAah4g5Xr@willie-the-truck>
References: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
 <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
 <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
 <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com>

On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
> On Wed, Nov 12, 2025 at 2:00 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> > > On Mon, Nov 10, 2025 at 9:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > > > If I understand correctly, I should modify this patch to remove the
> > > > changes of arm and riscv for now, do the changes only when there is
> > > > a real problem or requirement some day, right? If no more comments,
> > > > I will send v3 later.
> > >
> > > Now everyone involved agrees that the efistub code is correct, so the
> > > proper solution is to fix the compiler.
> >
> > Hm?  I don't see how it's a compiler bug.  It's really just an objtool
> > limitation.
> >
> > > Changing efistub code and changing objtool (ignore __efistub prefix)
> > > are both workarounds, but I think changing objtool is a little more
> > > reasonable. Maybe Josh has different ideas?
> >
> > I thought the conversation had converged on what Tiezhu mentioned above,
> > which is to skip objtool on libstub for loongarch, but leave the other
> > arches alone.  That way objtool behavior is consistent between loongarch
> > and x86, and objtool doesn't need to ignore any prefixes.
> >
> > So basically, the v2 patch minus the arm64/riscv changes.
> 
> Hi, ARM64 and RISC-V maintainers,
> 
> Would you mind that this patch modifies the three architectures
> together (they are exactly the same style now)?
> 
> Madhavan is the author of ARM64's objtool, I think your opinion is
> also very important.

arm64 doesn't (yet) use objtool.

I defer to Ard on anything relating to the arm64 efistub. Reading the
start of this thread, it doesn't look like he's convinced and I'm not
surprised if it's purely an issue with objtool.

Will

