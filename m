Return-Path: <linux-efi+bounces-5686-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9376C87968
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 01:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87EA44E06ED
	for <lists+linux-efi@lfdr.de>; Wed, 26 Nov 2025 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9545C0B;
	Wed, 26 Nov 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta+cvHDO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFC4A0C;
	Wed, 26 Nov 2025 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764116855; cv=none; b=PLw2Fh9A9ea2UjE9DzAG8NrnnO4cInSsmpKR2e26PfmRKcCsUBP8iAPnrDljWOxzJrQpoN0N467LyTEQL2CSf9XBSDmZV8USJnicnbrrhKZtFgBlgbGLsQ/gf9sdjXrTYBHJ/jRMslb5o7KNsLWYLJKVtZmQydxXPIWT8v6eRcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764116855; c=relaxed/simple;
	bh=XTbEEejRVPuiO6YOFsZ6JI/kIqJErz+0cTJOWXOKBe4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tjZhA0sJYg0tw/eAUBNNNVjY7D74ocoDlU3evxwzMKusTajj/nnbCXTAZylD5h+EGR4+vArXvilmodt4N+u4+niL16H4zkffwhVpNEUqDXD0ThRGmnxmFnpCudiV1p8IQICW5zSFDP3T9YhE4jaxxvqIKIE9wt3d0OsNNxsHSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta+cvHDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDFCC4CEF1;
	Wed, 26 Nov 2025 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764116854;
	bh=XTbEEejRVPuiO6YOFsZ6JI/kIqJErz+0cTJOWXOKBe4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ta+cvHDOOKjacx0ul6GVTrh1fIsb3lEWuwNo7hMcHT4mxlAMd1vRg5niu2q+QpIwC
	 idXCCLhAuGYg/ijwiqnlhKSGDFe9YdLMGen7WN3IUZxSDz8zmhHZb3x8nytxgPHlJ5
	 oDQUhiPc1LhmTpOESkL2efVAw4hJQpZLL6vKem/Dcn8v6nKDNQXjqcOB+bZP7tA2Lx
	 i4t4z4AXEca8qYJBhO/e0371Km2d8toyae1Kc1F0SJ6+q/YnvAsKNPi7eZg9G8BP/1
	 KDVwCt03mrz0RRcxLdR8ysenbdkZ4iNp2pr5ZWaGin7nepzX42nKBqRuTk2QP0fLJC
	 arOPh75w+BABQ==
Date: Tue, 25 Nov 2025 17:27:30 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Qiang Ma <maqianga@uniontech.com>
cc: ardb@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    alex@ghiti.fr, linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi/riscv: Remove the useless failure return message
 print
In-Reply-To: <20251031024328.735161-1-maqianga@uniontech.com>
Message-ID: <f9d632d5-22dc-8b14-8a70-37737a78f206@kernel.org>
References: <20251031024328.735161-1-maqianga@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Oct 2025, Qiang Ma wrote:

> In the efi_create_mapping() in arch/riscv/kernel/efi.c,
> the return value is always 0, and this debug message
> is unnecessary. So, remove it.
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>

Considering that Ard doesn't think efi_create_mapping() should be changed 
to remove the return value, and that the ARM version of this code retains 
the debug message, we should probably keep things the way they are.  But 
if you can get a Reviewed-by: or an Acked-by: from Ard, I'd take it.


Thanks for your patch,

- Paul


