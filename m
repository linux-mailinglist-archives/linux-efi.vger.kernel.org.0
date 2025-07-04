Return-Path: <linux-efi+bounces-4124-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF9AF968A
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C1C7BD098
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 15:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5192877C2;
	Fri,  4 Jul 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUn3IriD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85919C54B;
	Fri,  4 Jul 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642035; cv=none; b=TCjFBIExhd9wwyG+gXSH55yJXZE/szaG7aems43uox+PydILuD0QKuo4ND5SfyTjkhNx1iOhOGoLL6K4XhtxlxPd/mDV0+nB49O4Aqgeo3k+jZv+As5J3ffN1yXOxG2G/Ym56fHEB16uaPdKudkyOlemZncdH1uwWXr5JWGqWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642035; c=relaxed/simple;
	bh=dcH2LMCzBXT7aa0Qbuio3lOIk3gZyXtMY3q3240QCzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfkUXawQLNBpdL/Nq5W7vU2azUowgAXERgIkp6DSyjhUCFMWeFdBgm84/M2Xob0krHzfXpWlvVfno1lASahOVru7/Yt5RCrK0wlW55HMQvOmB+doLkscfcnvkakYHAzDIhGZ3ihBCRRCSiltm7/SNGYaEmw97BtYB1D6kV5V3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUn3IriD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C9FC4CEE3;
	Fri,  4 Jul 2025 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751642035;
	bh=dcH2LMCzBXT7aa0Qbuio3lOIk3gZyXtMY3q3240QCzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUn3IriDxtCzaJN8q0gbLBJN3x+VvQCkcbaPXHQL5v1qfAxadfGhKwpWY9EwrKRvR
	 Zwo677Fivdw5E19lXfVtHnBnZ5CDQEua68FJ13HQqaHnABGkq2At8HbV9njJxRrxos
	 X/3KAHvZL5ziKJX0Q0104BaGuCJXAvhSv0WHhhL98X2mL83GCGx5ls1ZvtqvgHof6X
	 ajruNjJ3JN+NGn5KPa6cmXGVl11J2XHIYIgvLeNbw+BIF2Pn2lj+j78BEcrz9R4gfp
	 XoPWNVGTeKC1jh4DC3xjRlr11Nw2a+F7EQtsdvNesF3FlE5v8G0Jvuhk8B39zSmCdS
	 ZRnzx1HzXd5DQ==
Date: Fri, 4 Jul 2025 18:13:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ge Yang <yangge1116@126.com>
Cc: ardb@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, liuzixing@hygon.cn
Subject: Re: [PATCH] efi/tpm: Fix the issue where the CC platforms event log
 header can't be correctly identified
Message-ID: <aGfvr2pBau6z9GLC@kernel.org>
References: <1751510317-12152-1-git-send-email-yangge1116@126.com>
 <aGczaEkhPuOqhRUv@kernel.org>
 <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ab4ebba-1f97-4686-9186-5bcaa3549f54@126.com>

On Fri, Jul 04, 2025 at 10:53:54AM +0800, Ge Yang wrote:
> 
> 
> 在 2025/7/4 9:50, Jarkko Sakkinen 写道:
> > On Thu, Jul 03, 2025 at 10:38:37AM +0800, yangge1116@126.com wrote:
> > > From: Ge Yang <yangge1116@126.com>
> > > 
> > > Since commit d228814b1913 ("efi/libstub: Add get_event_log() support
> > > for CC platforms") reuses TPM2 support code for the CC platforms, when
> > > launching a TDX virtual machine with coco measurement enabled, the
> > > following error log is generated:
> > > 
> > > [Firmware Bug]: Failed to parse event in TPM Final Events Log
> > > 
> > > Call Trace:
> > > efi_config_parse_tables()
> > >    efi_tpm_eventlog_init()
> > >      tpm2_calc_event_log_size()
> > >        __calc_tpm2_event_size()
> > > 
> > > The pcr_idx value in the Intel TDX log header is 1, causing the
> > > function __calc_tpm2_event_size() to fail to recognize the log header,
> > > ultimately leading to the "Failed to parse event in TPM Final Events
> > > Log" error.
> > > 
> > > According to UEFI Spec 2.10 Section 38.4.1: For Tdx, TPM PCR 0 maps to
> > > MRTD, so the log header uses TPM PCR 1. To successfully parse the TDX
> > > event log header, the check for a pcr_idx value of 0 has been removed
> > > here, and it appears that this will not affect other functionalities.
> > 
> > I'm not familiar with the original change but with a quick check it did
> > not change __calc_tpm2_event_size(). Your change is changing semantics
> > to two types of callers:
> > 
> > 1. Those that caused the bug.
> > 2. Those that nothing to do with this bug.
> > 
> > I'm not seeing anything explaining that your change is guaranteed not to
> > have any consequences to "innocent" callers, which have no relation to
> > the bug.
> > 
> 
> Thank you for your response.
> 
> According to Section 10.2.1, Table 6 (TCG_PCClientPCREvent Structure) in the
> TCG PC Client Platform Firmware Profile Specification, determining whether
> an event is an event log header does not require checking the pcrIndex
> field. The identification can be made based on other fields alone.
> Therefore, removing the pcrIndex check here is considered safe
> for "innocent" callers.

Thanks for digging that out. Can you add something to the commit
message? That spec is common knowledge if you are "into the topic"
in the first palace so something along the lines of this would be
perfectly fine:

"The check can be safely removed, as ccording to table 6 at section
10.2.1 of TCG PC client specification the index field does not require
fixing the PCR index to zero."

But then: we still have that constraint there and we cannot predict the
side-effects of removing a constraint, even if it is incorrectly defined
constraint. For comparison, it's much less risky situation when adding
additional constraints, as possible side-effects in the worst case
scenarios can be even theoretically much lighter than in the opposite
situation.

For this reasons it would be perhaps better to limit the fix for the
CC only, and not change the semantics across the board.

BR, Jarkko

