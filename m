Return-Path: <linux-efi+bounces-5472-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60255C4F590
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 19:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C70334D4C8
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695D28C864;
	Tue, 11 Nov 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfOChaSG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32532283124;
	Tue, 11 Nov 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884013; cv=none; b=Wav6t7zSVEEza29rrIQ5WnVrILfUBnXUlCv5DjBnGCd+8dIUIfHC22QB820Rsr5MLF2SvyFLRCMDFV2//KkzdsAx+zQ4AFOluSCYA4QSqfmWT2635L5ZCdGiTrT8U1MiZjGC7qbZm8d6FXO8hnCR36TBBQsWyZmTFs1vUTMGx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884013; c=relaxed/simple;
	bh=YbvVeIxBxMZpmXdjYhUx8nwj49MbsEoFDBh2JqYePf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERQeVJTi6YeJJ9ltTwFzAjk5p0SmC8Y7hxLuYsPXAlATLDB/JuTlwV5jHVNvW7xMH9pGLWfyNe374nk1COM32iszlUN+7ell0hc6jPzj7C9Hbkx4caAOFJLoGXaDk/iJ5YplP90NsSRB+41LzY5oxR8lUCaDvH9AQjTHCf7YVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfOChaSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C089CC4CEF5;
	Tue, 11 Nov 2025 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762884012;
	bh=YbvVeIxBxMZpmXdjYhUx8nwj49MbsEoFDBh2JqYePf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qfOChaSGhMAFuWs2UzChw+LX7w9ddO0Lu3yodA88bbRsfPPZyivrIHB59q36dSaUY
	 IkZFm9AYnKMAgKui34Is98oeSzGTsaXWWlAp4ixzbQ3Lj9HPqHrijnaeJ8lghQ+kH8
	 Xpu8+ZMcIQHYSlqXF+0ef+2js6EBFfdtbZcHBXnXpfSpjMcKgNH56pX/fGq4tLAz6Y
	 tqQsWQzV/e9sCE7nn8JDr0tapUnCcAyaQTRZTTyl66tKX5xaJDFyL4J0njMQE/6eVz
	 q5GEwq1DSFSMfMwFi0A8w8kJd14LTQE2FYBnLfGCSuJrstkzbNLSGEuTzKO6DCNIuT
	 uzmjpi67z64QQ==
Date: Tue, 11 Nov 2025 10:00:10 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
Message-ID: <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii>
References: <jxfb5a2c2qber623l2gwewirwod54bbgfnvt7t7f3jah2ea33g@2uyhy3auzmpx>
 <d9f3352a-1c1f-464a-a8fd-741cd96b5f8e@loongson.cn>
 <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com>
 <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn>
 <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com>
 <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com>
 <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com>
 <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn>
 <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>

On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> On Mon, Nov 10, 2025 at 9:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> > If I understand correctly, I should modify this patch to remove the
> > changes of arm and riscv for now, do the changes only when there is
> > a real problem or requirement some day, right? If no more comments,
> > I will send v3 later.
>
> Now everyone involved agrees that the efistub code is correct, so the
> proper solution is to fix the compiler.

Hm?  I don't see how it's a compiler bug.  It's really just an objtool
limitation.

> Changing efistub code and changing objtool (ignore __efistub prefix)
> are both workarounds, but I think changing objtool is a little more
> reasonable. Maybe Josh has different ideas?

I thought the conversation had converged on what Tiezhu mentioned above,
which is to skip objtool on libstub for loongarch, but leave the other
arches alone.  That way objtool behavior is consistent between loongarch
and x86, and objtool doesn't need to ignore any prefixes.

So basically, the v2 patch minus the arm64/riscv changes.

-- 
Josh

