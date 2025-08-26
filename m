Return-Path: <linux-efi+bounces-4613-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C3CB35A8B
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 13:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8086B7AED5B
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 10:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED11AAE28;
	Tue, 26 Aug 2025 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GULj6IDG"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088B1A23A6;
	Tue, 26 Aug 2025 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206030; cv=none; b=SkIWDXp9vwUhRt7H0CLf7TuqGjS/QL3dObUoaZj+CNT3+uBwXVkgcCYoFXuMjZDtT4QAL8B3fQnMy46xjYm4usHC9Emwc585P/San73HyVwqrd/wX2GkriG52YooF8MT+vhYm7iBYApE1IksXsO9Uf8bZerOc/bgLjk/PE54TNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206030; c=relaxed/simple;
	bh=7iGBMoIJLQqHrnlnq2Od1hLysfTUq5cQkm1Pk2RwI2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2ldShHH4hWS1qpnSIYxx7HrgyALc+n8ZfNaTVMPrc9zEw6BAANRVuFy+xH1FWG2UPktikUv8D/4ySof1d539jSCLJoIzhH+/3dQAH2rYqO/ItjHAxvT+6IPPbbrF1+yZNH7bTHcQ3IiMSBo0uYYI4fTw0kRd9eVKNtVsVE2C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GULj6IDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEF6C4CEF4;
	Tue, 26 Aug 2025 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756206029;
	bh=7iGBMoIJLQqHrnlnq2Od1hLysfTUq5cQkm1Pk2RwI2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GULj6IDGPLlgIEQxsg9XB/4AcilxQlbkqISeAqRaDnsd4ndBRwPO5Fz6B+zZ8wBnX
	 Do3slYszQ5Qco9+61cPmn495NhHeyFK1lK8HlMFJXj5A932NnNrkpowNDMd7zb0U4t
	 flhBeHPF+GRMCvtD60WCCQhDbWpvbO4R+ZqOIfz5kJeVWEJ7If7W0JqkGpSC1oGUTS
	 3aU28qR4BaOzNMQZ1pEc86DpN/Zf7H4F9ERfJp8FfT6GDG/EhQTvFxy1OPdVef7rLZ
	 FAGW16u5cZ3G1CcEIYYS3JYVTWdqQCGL7UFvJl4NimqmCYYJZdVsaTJ1z5P8piUahu
	 6CqBbx880Oa5w==
Date: Tue, 26 Aug 2025 16:30:23 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Masahisa Kojima <kojima.masahisa@socionext.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Hua Qian Li <huaqian.li@siemens.com>
Subject: Re: [PATCH v3 0/4] efi: stmm: Fix for incorrect buffer allocation
 and cleanups
Message-ID: <aK2Tx5yeQeMoLMKn@sumit-X1>
References: <cover.1756138033.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756138033.git.jan.kiszka@siemens.com>

On Mon, Aug 25, 2025 at 06:07:09PM +0200, Jan Kiszka wrote:
> Changes in v3:
>  - improve description of patch 3
> 
> Changes in v2:
>  - simplify page allocation approach
>  - switch to returning EFI_DEVICE_ERROR on ENOMEM
>  - drop efi return value argument from setup_mm_hdr
> 
> One critical fix for the EFI StMM driver, one error return code
> adjustment and two smaller cleanups.
> 
> Note that the suggestion to convert tee_shm_register_kernel_buf to take
> pages instead of buffer addresses is not forgotten, just in the backlog.
> I wanted to avoid that the critical fix has to wait for me finding time
> to refactor the API as well.
> 
> Jan
> 
> Jan Kiszka (4):
>   efi: stmm: Fix incorrect buffer allocation method
>   efi: stmm: Do not return EFI_OUT_OF_RESOURCES on internal errors
>   efi: stmm: Drop unused EFI error from setup_mm_hdr arguments
>   efi: stmm: Drop unneeded null pointer check
> 
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 61 +++++++++++-------------
>  1 file changed, 27 insertions(+), 34 deletions(-)

LGTM, for the series:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

