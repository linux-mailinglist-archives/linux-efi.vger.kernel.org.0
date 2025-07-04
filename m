Return-Path: <linux-efi+bounces-4125-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A1AF9A04
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CD71CA536F
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7A3074B9;
	Fri,  4 Jul 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ1LHkhl"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FF2F8C4D;
	Fri,  4 Jul 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651084; cv=none; b=YrYD7Q9JRVAlARitJGR6BU6JRfIO9w2LyPZEGAu1+1zmJvXI0gumBBOi6wHAsoi4l/iFy2H0BxPJ84NkFzFJ3eUs5Vg9izlP0w9f1fiXUejL0yd8+FNqyoQawF104A3VMWZZV0R/MbC73frBEaTqP6GoZor74sXa73thajrihss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651084; c=relaxed/simple;
	bh=5LK3c7VkLVR6ZvjLipVvmjr3y3j0efN+nBY9t+tmaME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaVBR/ufMmXuN5rXGV1jwzSX2buZvOAsaqdMeDA/c+etN+pm0gUGqB9k/aoxApPy/FDDpwo/KjYF/guvNrOYypHnxmpNx114azI0FlYf/ghekDE2WMI+cwXoTyqVe9fO7t64I+Rj+FowvHsP8zA2NSdywGE6x/RingzZZMQ/i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ1LHkhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BB6C4CEED;
	Fri,  4 Jul 2025 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651083;
	bh=5LK3c7VkLVR6ZvjLipVvmjr3y3j0efN+nBY9t+tmaME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJ1LHkhldFrwXnH2m1q+LefNuqfgHOHtgAT6fVu7wkltXngPFj1lpf/BCJ2SJmqoe
	 +O1B/QkpYfqt/7l0Bw2pZmza3M3WiaktXSHcMukV1RTpGvzqv4bDOl+znWZqQ1IVw/
	 Z+mLROZLe/qJq5FqUaAKBlo6udbGqu86CfokV3HvizOe5/fFTXPI9a9CdFrs+Zqyl+
	 tGtged31xslSmBAGHv7yotfDiqPviBxd5ZwqDXqefSFRHwjKzUpk7DEvv4RJvJ795Y
	 5ZAvPz1NJEG9POJumcrTamQWg7yXiM4ZMHbC3PDFFrGtjezvsmdMb32gZMdcZ5OeVs
	 3eppQradlIRtA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Breno Leitao <leitao@debian.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	usamaarif642@gmail.com,
	Ard Biesheuvel <ardb@kernel.org>,
	rmikey@meta.com,
	andreyknvl@gmail.com,
	kasan-dev@googlegroups.com,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com,
	kernel-team@meta.com,
	mark.rutland@arm.com
Subject: Re: [PATCH v2] arm64: efi: Fix KASAN false positive for EFI runtime stack
Date: Fri,  4 Jul 2025 18:44:15 +0100
Message-Id: <175163682742.1322301.12219137975972256785.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704-arm_kasan-v2-1-32ebb4fd7607@debian.org>
References: <20250704-arm_kasan-v2-1-32ebb4fd7607@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 04 Jul 2025 05:47:07 -0700, Breno Leitao wrote:
> KASAN reports invalid accesses during arch_stack_walk() for EFI runtime
> services due to vmalloc tagging[1]. The EFI runtime stack must be allocated
> with KASAN tags reset to avoid false positives.
> 
> This patch uses arch_alloc_vmap_stack() instead of __vmalloc_node() for
> EFI stack allocation, which internally calls kasan_reset_tag()
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: efi: Fix KASAN false positive for EFI runtime stack
      https://git.kernel.org/arm64/c/ef8923e6c051

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

