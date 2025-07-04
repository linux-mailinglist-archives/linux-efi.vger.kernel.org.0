Return-Path: <linux-efi+bounces-4110-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61713AF854D
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 03:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0782567BF9
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A791D6195;
	Fri,  4 Jul 2025 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz2ikRJd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1849659;
	Fri,  4 Jul 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751593838; cv=none; b=LKoL19oFG1SBGa/ZWOO0GllR/hchW6LPAjcRkrl/kNt/RGzjYA3ibKLR56L5nCeW6YCEushNt5YRIar6DPYO6SNTtLeB78SSNrzWY18zbFrpZgp+HhtY+xJZA/mVXkaxvicTPMdL7/QAs8FPbjfh4Vxp+lHrV/magbg6Wre1rYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751593838; c=relaxed/simple;
	bh=b8RXlrAo7hrXuI3LoSYLl4lO2EOF9pGHWqba2I8FG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqtVSP9xkwC2ZEqXWmY+8bUkcQpCmYHytWDba22DSHnA7daHzHRgIhoXXnoVcDgY0nx2/bsqccaAZT8GnlGXnEix45ZvIKZ4ZJFRTLtDPd5pYU/kAXWQKZpA/kT8ML59dPX2KbgJuumBEre/7NwcafvKG4UhqkKHNDhwZAYte9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz2ikRJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1726C4CEE3;
	Fri,  4 Jul 2025 01:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751593836;
	bh=b8RXlrAo7hrXuI3LoSYLl4lO2EOF9pGHWqba2I8FG2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hz2ikRJdmfrmw+Hv3aaA49O/CKlM6BruFQaZYRuINIU3f8jUEYQ1pZyk5Ejco+hcx
	 BvC8m6L9vvXggqg6YJrJ29wuBHBgfW5Zn3mB095lTOKkBHSi9JgMku622OG+p5vOjv
	 QnfKul/EOxQgi4uoDac/JxgzTAsHwqRz28sTn1t+2F/4NVV61WoHnKBwzS6N7zZC2c
	 WXWcDT9v1m0bNzJhuRyNGXFEfaHu+7Ac6K4bhCRymYp8n5a4Cy+djsrCwrVUddRODM
	 d4iXN83jiYtY0E9CBp5QZGt1Q7lkBI2ByQQXArGONUuMvdZQpQpx7H1931A3zxFPuP
	 PgycHJCCN2SKQ==
Date: Fri, 4 Jul 2025 04:50:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: yangge1116@126.com
Cc: ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuzixing@hygon.cn
Subject: Re: [PATCH] efi/tpm: Fix the issue where the CC platforms event log
 header can't be correctly identified
Message-ID: <aGczaEkhPuOqhRUv@kernel.org>
References: <1751510317-12152-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751510317-12152-1-git-send-email-yangge1116@126.com>

On Thu, Jul 03, 2025 at 10:38:37AM +0800, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
> for CC platforms") reuses TPM2 support code for the CC platforms, when
> launching a TDX virtual machine with coco measurement enabled, the
> following error log is generated:
> 
> [Firmware Bug]: Failed to parse event in TPM Final Events Log
> 
> Call Trace:
> efi_config_parse_tables()
>   efi_tpm_eventlog_init()
>     tpm2_calc_event_log_size()
>       __calc_tpm2_event_size()
> 
> The pcr_idx value in the Intel TDX log header is 1, causing the
> function __calc_tpm2_event_size() to fail to recognize the log header,
> ultimately leading to the "Failed to parse event in TPM Final Events
> Log" error.
> 
> According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
> MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
> event log header, the check for a pcr_idx value of 0 has been removed
> here, and it appears that this will not affect other functionalities.

I'm not familiar with the original change but with a quick check it did
not change __calc_tpm2_event_size(). Your change is changing semantics
to two types of callers:

1. Those that caused the bug.
2. Those that nothing to do with this bug.

I'm not seeing anything explaining that your change is guaranteed not to
have any consequences to "innocent" callers, which have no relation to
the bug.

> 
> Link: https://uefi.org/specs/UEFI/2.10/38_Confidential_Computing.html#intel-trust-domain-extension
> Fixes: d228814b1913 ("efi/libstub: Add get_event_log() support for CC platforms")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: stable@vger.kernel.org
> ---
>  include/linux/tpm_eventlog.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 891368e..05c0ae5 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -202,8 +202,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>  	event_type = event->event_type;
>  
>  	/* Verify that it's the log header */
> -	if (event_header->pcr_idx != 0 ||
> -	    event_header->event_type != NO_ACTION ||
> +	if (event_header->event_type != NO_ACTION ||
>  	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
>  		size = 0;
>  		goto out;
> -- 
> 2.7.4
> 

BR, Jarkko

