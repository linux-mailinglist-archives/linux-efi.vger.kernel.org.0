Return-Path: <linux-efi+bounces-4343-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7AB0508A
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 06:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2689C3BDA18
	for <lists+linux-efi@lfdr.de>; Tue, 15 Jul 2025 04:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43B425A323;
	Tue, 15 Jul 2025 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGmWjtrW"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054E244691;
	Tue, 15 Jul 2025 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752555264; cv=none; b=pwCWbcY23ZvLhHoIhDZJWzG1hMYthfNZPjgNHgW+FgnuUMHS3XRzdKnuFH02IUyvnGbCC6d6X+qsw4ISeH/ePJ2gjdUcO5qfDiJDy6S1ouj0WkRIwEMOXxow0eA0Hz3PIz5TRYj6NCr2WWvGdopxCvafgN7R05wEdBMb8ffMlUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752555264; c=relaxed/simple;
	bh=OdTKlFbhuPsqLk0J2VIvO1elRV5TGVMWts/aaqiMVrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msSzw4o+/xB0LSfUR5uTXzTALAXyxsauC4WiIpbaQYQHlpgujhyLNT82Nb/S4Mr8nLS59dsl2fTwkpu12lu1S+GzDa3yrBKC4mpxFP+46d+m3BN9KoxiThwPdbU9Ly4MQ9m3O7oNa8nZ+3pWepFyv3su3COBtTzlLKKVWmCqXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGmWjtrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3451C4CEE3;
	Tue, 15 Jul 2025 04:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752555264;
	bh=OdTKlFbhuPsqLk0J2VIvO1elRV5TGVMWts/aaqiMVrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aGmWjtrWIhqp6DYLvch04LJtTQhhflBAyJXC7MhEnC7dsAAe9Mi7FumdUqh1cC22M
	 v9VaXsAz+NruuZHxL02x023MgE6obPt2IT1tAv84zGJa5JyI8wq0p6OU7MXeMrKsq2
	 VijNBsxw9drn1Y4Xdz/KDV7irgfEWxqIldh7/NRWrEHVV/gAk/kh5yRVI5WiPzAG83
	 8Xr1JBNfAUIEWVIsEaONdc5jRTlg4Ka+dGAS6BVR3ThycSI3dXB12j/Fkmepp3aTZA
	 eACkxaIzsQcCTmxs+aktDxtyFqJacg6whzt1eonApyqvcQUkOvYQj9LoWTP2twmQYB
	 pVXGICDWT1r4w==
Date: Tue, 15 Jul 2025 04:54:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
	ardb@kernel.org, kees@kernel.org, Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org, jpoimboe@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v3 11/16] x86,hyperv: Clean up hv_do_hypercall()
Message-ID: <aHXe_n8QNqxxgOBE@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250714102011.758008629@infradead.org>
 <20250714103440.897136093@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714103440.897136093@infradead.org>

On Mon, Jul 14, 2025 at 12:20:22PM +0200, Peter Zijlstra wrote:
> What used to be a simple few instructions has turned into a giant mess
> (for x86_64). Not only does it use static_branch wrong, it mixes it
> with dynamic branches for no apparent reason.
> 
> Notably it uses static_branch through an out-of-line function call,
> which completely defeats the purpose, since instead of a simple
> JMP/NOP site, you get a CALL+RET+TEST+Jcc sequence in return, which is
> absolutely idiotic.
> 
> Add to that a dynamic test of hyperv_paravisor_present, something
> which is set once and never changed.
> 
> Replace all this idiocy with a single direct function call to the
> right hypercall variant.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

