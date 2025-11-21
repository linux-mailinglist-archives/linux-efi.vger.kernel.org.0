Return-Path: <linux-efi+bounces-5625-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE5AC76FB7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 03:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5264360699
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D42264CB;
	Fri, 21 Nov 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3dSOGzT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325B1BCA1C;
	Fri, 21 Nov 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690963; cv=none; b=X3bfQOHMAWWDkAg94SWUCwxvSM/iExeOzPjNpoqkZDxrhoMDqmkVSHWihU2keF1MNpSF2J6DhPnTDAUBqBY5n60uOhGQoq2dAwM3Nnfa0jFcGXbm3HJz/Ivke5fvrJrPp3ExLWRBIr2TCUl+7wvjLqlsqUp51XlI6u6hfuk3l2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690963; c=relaxed/simple;
	bh=Bz7xeF2JFxhA+tr4bBYKwtM1aze7r6fWJHliCqTnUpU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LkPcocAkkZihTwp05j5ZWJ6A1Az/BhS3fKsOaA7QdeK8mNYd6xvAuhjARdAfmV5D6kyn07gEoXNDlcsJX2E1ZFpwTUa4EdMHlgji58A6MEuJtmbJoOuytqE2VDrhqQPgFJ3wgFswhfbU+FVLR7oWiB+k4aC6ZjZLpzrOAWba7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3dSOGzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30026C4CEF1;
	Fri, 21 Nov 2025 02:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763690963;
	bh=Bz7xeF2JFxhA+tr4bBYKwtM1aze7r6fWJHliCqTnUpU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=j3dSOGzTqbCddJGVT5roKZn7ficPkxCfcZaQAbSHTo9ZEpPBpOUx6A+7D3iJGElrS
	 xERwOpb0HglzyK+cyiMtdgu+xzC+v5c2uu28ifTlgYK2Oge6TJdh2knqdBtSef+qsa
	 n4EASFxrLwd1zfxuHQhx80lddfRqlhkum8rXwIpnFiTVaQjEI29yJEKBIpe+M/FWR8
	 OLEfnFo43eLM03+3tVi64Nr+UnQNI7VzrHe31zP9rsXTL7AzLiKeGnBkSfiX1Gvg3X
	 9VJ4TWJNC3VVZ1aJwt1vadaOPQj2cIIv/pcsMPa30N8hKbqp7RTHENp04Ckbf6rwHH
	 UvjI8iIQZXrfQ==
Date: Thu, 20 Nov 2025 19:09:18 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
cc: Will Deacon <will@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, 
    Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>, 
    loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
    linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
In-Reply-To: <aRsH7RTpAah4g5Xr@willie-the-truck>
Message-ID: <e36f8b19-c801-c872-381e-7eb40dc5e3e4@kernel.org>
References: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com> <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com> <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com> <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com> <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn> <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii> <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com> <aRsH7RTpAah4g5Xr@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1623710078-1763690962=:1910464"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1623710078-1763690962=:1910464
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 17 Nov 2025, Will Deacon wrote:

> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
> > On Wed, Nov 12, 2025 at 2:00 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > On Mon, Nov 10, 2025 at 03:00:00PM +0800, Huacai Chen wrote:
> > >
> > > > Changing efistub code and changing objtool (ignore __efistub prefix)
> > > > are both workarounds, but I think changing objtool is a little more
> > > > reasonable. Maybe Josh has different ideas?
> > >
> > > I thought the conversation had converged on what Tiezhu mentioned above,
> > > which is to skip objtool on libstub for loongarch, but leave the other
> > > arches alone.  That way objtool behavior is consistent between loongarch
> > > and x86, and objtool doesn't need to ignore any prefixes.
> > >
> > > So basically, the v2 patch minus the arm64/riscv changes.
> > 
> > Hi, ARM64 and RISC-V maintainers,
> > 
> > Would you mind that this patch modifies the three architectures
> > together (they are exactly the same style now)?
> > 
> > Madhavan is the author of ARM64's objtool, I think your opinion is
> > also very important.
> 
> arm64 doesn't (yet) use objtool.
> 
> I defer to Ard on anything relating to the arm64 efistub. Reading the
> start of this thread, it doesn't look like he's convinced and I'm not
> surprised if it's purely an issue with objtool.

Same for RISC-V.


- Paul
--8323329-1623710078-1763690962=:1910464--

