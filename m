Return-Path: <linux-efi+bounces-4590-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B39B3128E
	for <lists+linux-efi@lfdr.de>; Fri, 22 Aug 2025 11:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1C3A00353
	for <lists+linux-efi@lfdr.de>; Fri, 22 Aug 2025 09:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405AC2E612D;
	Fri, 22 Aug 2025 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWX6GBCs"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177432D7DC3;
	Fri, 22 Aug 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853675; cv=none; b=Y8BGw9oEYVMN4EXbCBkrXcrFlr76Mp7H+YbQ81PJltdvbmLql2Z6D3Ut1xpwdshZToDr0lKvbE3PaRHpnnDHKpKeGvDl6zvTY0YAmUblxRUWwoUfvchR1G5S/WkgizCsiN46WaeCD5pyb97WAkt93qKPsXGEeWUoVF0ifI/yPpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853675; c=relaxed/simple;
	bh=FxrjqFELS+dXUd5ll19YeqCrkQ1FgtMrYB3uOgPx40Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzCnY2XOn+qrVRbt4l70HEw3oRec3KkqD/OQ4NrwwviEXIFmN/XDgyXkJen+yd/IBoX4NCNaPWm5UH+YXV6HqMLsmArk2sypAVaRty/E+CgpXHT4vEehW4BSEy0+au0/sBlTJiKVf/htXGS09HXYlcPM6d01dPgsVwKAAX3qbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWX6GBCs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE31BC4CEF1;
	Fri, 22 Aug 2025 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755853674;
	bh=FxrjqFELS+dXUd5ll19YeqCrkQ1FgtMrYB3uOgPx40Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWX6GBCsVbCpVua+O/aUNMrm00R73ZixmA+onU8syn9mjRksDRiuTN834RIjjX+EM
	 n2BHoZMhaN8uL48N6KPeqlLGcoVTs3iqUD0ePPPi/coLjQvPLgkFg8/5yjVLdMN/u0
	 FPZEZ52cUVa5cOV1tWx45Jtye2+2bLSZ1V3QhTuOQDtFFsqZkCMt2+UH040a5gu3EI
	 uamYnKj76naPun5ZmUXtL3Jrv/1Z22EEVk16NAaNlnHFMuEeEv+676LVLY0ha41Blt
	 +jMvEjz/bvAkJwiv7y7+f3gfuziyCtJ43b6A1k42XtxPT3eLJRot4CE8lR+l1bKXeA
	 XnzLjTcP5A3iA==
Date: Fri, 22 Aug 2025 14:37:47 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: Re: [PATCH 1/3] efi: stmm: Fix incorrect buffer allocation method
Message-ID: <aKgzY27lDreFXxis@sumit-X1>
References: <cover.1755285161.git.jan.kiszka@siemens.com>
 <37ba67b97d55c49a7c6a1597f104b30b31a4a395.1755285161.git.jan.kiszka@siemens.com>
 <CAC_iWjL84EFiKh0ETb7LwYjMRgLAZA8hFKy-YDS4=YQ1LRwg9A@mail.gmail.com>
 <75db5f5e-9e0c-4c48-a3c8-034414276036@siemens.com>
 <aKboY9oBmHJJb2Pc@sumit-X1>
 <2acfbc7b-5222-425b-a1f7-83fc47148920@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acfbc7b-5222-425b-a1f7-83fc47148920@siemens.com>

On Thu, Aug 21, 2025 at 02:56:59PM +0200, Jan Kiszka wrote:
> On 21.08.25 11:35, Sumit Garg wrote:
> > Hi Jan,
> > 
> > On Wed, Aug 20, 2025 at 05:05:43PM +0200, Jan Kiszka wrote:
> >> On 20.08.25 09:29, Ilias Apalodimas wrote:
> >>> (++cc Sumit and Kojima-san on their updated emails)
> >>>
> >>> On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>
> >>>> The communication buffer allocated by setup_mm_hdr is later on passed to
> >>>> tee_shm_register_kernel_buf. The latter expects those buffers to be
> >>>> contiguous pages, but setup_mm_hdr just uses kmalloc. That can cause
> >>>> various corruptions or BUGs, specifically since 9aec2fb0fd5e, though it
> >>>> was broken before as well.
> >>>>
> >>>> Fix this by using alloc_pages_exact instead of kmalloc.
> >>>>
> >>>> Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
> >>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>>> ---
> >>>
> >>> [...]
> >>>
> >>>>         const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
> >>>>         struct efi_mm_communicate_header *mm_hdr;
> >>>> @@ -173,9 +174,12 @@ static void *setup_mm_hdr(u8 **dptr, size_t payload_size, size_t func,
> >>>>                 return NULL;
> >>>>         }
> >>>>
> >>>> -       comm_buf = kzalloc(MM_COMMUNICATE_HEADER_SIZE +
> >>>> -                                  MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> >>>> -                          GFP_KERNEL);
> >>>> +       *nr_pages = roundup(MM_COMMUNICATE_HEADER_SIZE +
> >>>> +                           MM_VARIABLE_COMMUNICATE_SIZE + payload_size,
> >>>> +                           PAGE_SIZE) / PAGE_SIZE;
> >>>> +
> >>>> +       comm_buf = alloc_pages_exact(*nr_pages * PAGE_SIZE,
> >>>> +                                    GFP_KERNEL | __GFP_ZERO);
> >>>
> >>> Rename nr_pages to something else and skip division, multiplying.
> >>> Unless there's a reason I am missing?
> >>> Also doesn't alloc_pages_exact() already rounds things up?
> >>
> >> I was looking at tee_dyn_shm_alloc_helper and the dance it does to
> >> calculate the pages from the size parameter.
> > 
> > The rework of tee_shm_register_kernel_buf() to directly accept kernel
> > pages instead of buffer pointers is already due. If you are willing to
> > fix existing TEE client drivers and the API then I will be happy to
> > review them.
> 
> I'm currently testing the stmm quite a bit but I have no setup/use case
> for the trusted_tee so far. Testing is eating most of the time,
> specifically with these seriously complex firmware security stacks.

For TEE based trusted keys, it is rather a bit straigtforward to run
tests using OP-TEE Qemu build setup where you would only need to patch
the kernel.

Test command:

$ make -j$(nproc) CHECK_TESTS="trusted-keys" check

-Sumit

