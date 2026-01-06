Return-Path: <linux-efi+bounces-5947-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6705CF8B93
	for <lists+linux-efi@lfdr.de>; Tue, 06 Jan 2026 15:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 052C3300CA1A
	for <lists+linux-efi@lfdr.de>; Tue,  6 Jan 2026 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A862306B37;
	Tue,  6 Jan 2026 14:17:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1710925DB0D
	for <linux-efi@vger.kernel.org>; Tue,  6 Jan 2026 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767709073; cv=none; b=Beo8yn5dWhbVTOujtmEsTfNxQxT5FoHchY4oehSFa1JHH9eWr9r3wD4igTUuYkyRFBvG22ws842gu7WgC9wqpZDXfQGG3f9w1IUxKvT9qLd4iIwuTtCxFaD1Hq+pQ4DyWRvoptDagoAh1FX1r02KI3tqaFrzNAhvQXEAxAJIDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767709073; c=relaxed/simple;
	bh=t2fPc7FRryNZxETkqEICAa2L+eAAKLhkXOfsvANSYQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRGNE/l6flMARCoybjFYMY1pSEMjpVy1g1C/uBL/lciaFjqPqjfyEYbAtF5l8Deqc2RPVF5pZX9pRbGu9wSJCYlQbblRmm3EREaJ+rhZTAJVLWcpsrEiSEEX8K095t3A1jZkALZMh4QL6nnfp25jDujTeRJ2V5JWyac65q/6XbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82DF8497;
	Tue,  6 Jan 2026 06:17:38 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B7BA3F6A8;
	Tue,  6 Jan 2026 06:17:43 -0800 (PST)
Date: Tue, 6 Jan 2026 14:17:41 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ben Horgan <ben.horgan@arm.com>
Cc: ardb@kernel.org, will@kernel.org, YeoReum.Yun@arm.com,
	Mark.Rutland@arm.com
Subject: Re: [PATCH v1] arm64/efi: Don't fail check current_in_efi() if
 preemptible
Message-ID: <176770904603.530757.14500068534558829858.b4-ty@arm.com>
References: <20260105135847.1585034-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105135847.1585034-1-ben.horgan@arm.com>

On Mon, 05 Jan 2026 13:58:47 +0000, Ben Horgan wrote:
> As EFI runtime services can now be run without disabling preemption remove
> the check for non preemptible in current_in_efi(). Without this change,
> firmware errors that were previously recovered from by
> __efi_runtime_kernel_fixup_exception() will lead to a kernel oops.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/efi: Don't fail check current_in_efi() if preemptible
      https://git.kernel.org/arm64/c/dd4d71f587f3

-- 
Catalin

