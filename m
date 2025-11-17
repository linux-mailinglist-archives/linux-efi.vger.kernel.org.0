Return-Path: <linux-efi+bounces-5539-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B35C668F4
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 00:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8239B2946B
	for <lists+linux-efi@lfdr.de>; Mon, 17 Nov 2025 23:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFDB2949E0;
	Mon, 17 Nov 2025 23:34:46 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293B16D9C2
	for <linux-efi@vger.kernel.org>; Mon, 17 Nov 2025 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.51.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422486; cv=none; b=rouxIHIHahd9yBtMLDc8yKKsQAWqzDUf3MRkOXUufQbYg8EzFVh5D+r1de8hHpuH1UnOMQltAm1uHG9tBNVPZoaYP85ai9koLsELxiSWfmeD9IgZN3BtOvp8UfONpc+hZ7XmX6GM0BAc7yY0wzCp5751GVDLJAG74RvnC/62ywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422486; c=relaxed/simple;
	bh=DR2LJIdWOcOahT0XY08l8Xc5vbVRm5Cs9aOx/d+jTHg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lTj/pHWomn0zw+dXzKUKmJua5CawMI/wYVksNqNq2YM+MXUgRz6a1/2txigjYgZsmzFBHKWgPZyeMgi9OwQ9dSRvIUHyvwEc8OGDH8h9caSR5Z5U2LXguwgMSjXD6Qnrj/gHkRrTQln0ipjxf5uRRvhNqT9gn4jVXY5Uj4ejoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwsan.com; spf=pass smtp.mailfrom=pwsan.com; arc=none smtp.client-ip=74.50.51.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwsan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwsan.com
Received: (qmail 9620 invoked by uid 1019); 17 Nov 2025 23:28:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Nov 2025 23:28:02 -0000
Date: Mon, 17 Nov 2025 23:28:02 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Will Deacon <will@kernel.org>
cc: Huacai Chen <chenhuacai@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
    Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>, 
    Tiezhu Yang <yangtiezhu@loongson.cn>, Ard Biesheuvel <ardb@kernel.org>, 
    loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
    linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
In-Reply-To: <aRsH7RTpAah4g5Xr@willie-the-truck>
Message-ID: <alpine.DEB.2.21.999.2511172326340.8304@utopia.booyaka.com>
References: <CAAhV-H6m5vszCyiF3qi94cpHBPVuqM2xH93D=gfsQqOSYvC-sA@mail.gmail.com> <33612d85-e70b-26da-8460-ea6b9064ce08@loongson.cn> <CAAhV-H5ZSTFDxvm-W1CrgEoQ5d_jw5yVsfetQ_J_qL5pqLtzgg@mail.gmail.com> <CAMj1kXGk0udgM67wrWqahqK8H0uE8emQj51SmJey+7fE-FTjdA@mail.gmail.com>
 <CAAhV-H4c=vdNWO0v_mYL2xZ9FYjDyRDvt6f_kV4d8Bh=CRJniQ@mail.gmail.com> <CAMj1kXEaxxcWTTANWeEMNjYDymdL5Fxy2B=XBF4RGtteEkfinw@mail.gmail.com> <421c08e1-255b-447b-b5e3-ee6544fbefd2@loongson.cn> <CAAhV-H5KsFShDJ_Cxu+1_ces8oojn8+S-7PLmE7aUj8gX5_GEw@mail.gmail.com>
 <32s3lvzfu6jkyho7qenrqbsm5wkgjnzn2imdp6tfwycmyxpzgu@kg5367uxmxii> <CAAhV-H47fzaKcMhgLWWOTxB+srBsg85-eK0LW1vQXQnvq32-+w@mail.gmail.com> <aRsH7RTpAah4g5Xr@willie-the-truck>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 17 Nov 2025, Will Deacon wrote:

> On Sat, Nov 15, 2025 at 11:16:42AM +0800, Huacai Chen wrote:
>
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

