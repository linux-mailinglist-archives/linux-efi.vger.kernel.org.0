Return-Path: <linux-efi+bounces-4589-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D2FB307AC
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 23:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 302A84E6ADA
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D608277CA4;
	Thu, 21 Aug 2025 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="umNePAT7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15943214807;
	Thu, 21 Aug 2025 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809891; cv=none; b=WbdoFDVWJWEt2jO7aUcuchksqNZ5zR56UpG1B6xrAwzQRVAFEMpbxakcsqy8GzGhfHkcFCsUHNkOnGiy2UAC9IdiZBlIw+mS92Y+oR99y4IT/rHHWf037rV3BfzBUYpb0TGodYVmZlP83fbTBczV+8U6OOjZhSNfIEHg9nSU2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809891; c=relaxed/simple;
	bh=AFBLWJOwJ4b7vAnIXPiDRB7zDnfWhOvar1ez+tAVaCk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QPTNrCNsug1axRl6RAkfOe8wKiiGock5CTEno7hgE0h/YERcbYtkCkVvFGWFyGb6MUVtmSVR/zrs6yNyIQUlV9q70odX26KY4mGiVDA/nlkVy2pba6mOkAToVeJyOhdFVCZbVByYjgaktmkSOD3vU4lLgMueP6MjWJzAapCAWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=umNePAT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC3C4CEEB;
	Thu, 21 Aug 2025 20:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755809890;
	bh=AFBLWJOwJ4b7vAnIXPiDRB7zDnfWhOvar1ez+tAVaCk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=umNePAT7FP/nR5oaHv1H9T/yjVUYXR+nZuOVPtkysLQ9NhRZuyTdMBoFbF/ziX8K2
	 eV5xKGtgX5CjNLxozP7au3YTYdCUCJ3PXw/HZnwGKHApRpXMIwg+OmbWf3g+D8B0Tb
	 B4ACvmCB5X6wuzLlzZyLIBvwg69IU3jtKrzwqnqE=
Date: Thu, 21 Aug 2025 13:58:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>,
 Baoquan He <bhe@redhat.com>, <kexec@lists.infradead.org>,
 <linux-mm@kvack.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH v3 0/2] efi: Fix EFI boot with kexec handover (KHO)
Message-Id: <20250821135809.c12105ca2a246a9fcb905af1@linux-foundation.org>
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 17:58:58 +0000 Evangelos Petrongonas <epetron@amazon.de> wrote:

> This patch series fixes a kernel panic that occurs when booting with
> both EFI and KHO (Kexec HandOver) enabled.
> 
> The issue arises because EFI's `reserve_regions()` clears all memory
> regions with `memblock_remove(0, PHYS_ADDR_MAX)` before rebuilding them
> from EFI data. This destroys KHO scratch regions that were set up early
> during device tree scanning, causing a panic as the kernel has no valid
> memory regions for early allocations.

Do you think we should backport this into 6.16.x kernels?  If so, is
there a suitable Fixes: target we can include?

