Return-Path: <linux-efi+bounces-824-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD2687D495
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 20:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20151C2106C
	for <lists+linux-efi@lfdr.de>; Fri, 15 Mar 2024 19:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C475452F97;
	Fri, 15 Mar 2024 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KoVCMDkw"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4F5336A;
	Fri, 15 Mar 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531975; cv=none; b=GNa6Iu47ncYl3Ypk9sCmXG7XezNaYSBrpXp2KhARVOo+6uAa79jkCzSGjFhjW2FRUnGf7GYv/BTpPZCJ3DcPMZ4G/op1dY9Q0NhvJ2BnX8AZNyisAdgLfa7fTQi07EXQkx8/nsGQC3Ghe9Wq5PKeHB7TO2LGUDioqR5YzIZTR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531975; c=relaxed/simple;
	bh=CyO55Dw7XsuAhmq2UFNdyZkwG7l+VK8tbtJ7oWv5oJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrpbP9kR69g3jY4rkLKbSxecBxfP/u8kQv9OfRIRwtjqTcQuc2xX1oXPqWTEsKKWEiEmbBS0D3xpCQ62WUTQI3Crn32/SzmHO2f/5gyY3CIHY2kx/P7hL//g+htv17YYw0lvRLUk6P5+T2aUe72yqqaXazWXJHAmJdZkcSQFXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KoVCMDkw; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CyO55Dw7XsuAhmq2UFNdyZkwG7l+VK8tbtJ7oWv5oJg=; b=KoVCMDkwcTzZ2TVlK0TuGbIFLH
	0ZGDBIl7uNfV912TShCkOCakhWsRklU8BVXnTLYe1VboyhtfiG9M4Xo8ozL35t2cRTX2NSzj/87cN
	6JeUDd0DKUwyTAuU9nfaeLjRPq2EdDOTSegazssCX3PNd+nUYZd4R3wfDoZG30Jp/spkuVgvFyrZ7
	k0nSVX9FYrJ0r14eTtd+WAxlbsxJvLsdzr7avXu7dPPPNBUrVlOeBSfbauG/qxuNC0pxg55Fhq+Fa
	pFxDJV8GJ6wyauQW75TgBLXY0u0NNdNDpzjh4TUcfLGKZecS0lhXKPXQ5Dh6M2gO/VbC05CUs/Dab
	hdsyZyXw==;
Received: from [186.209.63.98] (helo=[172.17.1.0])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rlDVB-00Aw9K-T5; Fri, 15 Mar 2024 20:46:02 +0100
Message-ID: <2a500ade-a91d-15f2-e5ae-7f261e6a84b4@igalia.com>
Date: Fri, 15 Mar 2024 16:45:56 -0300
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] efi: pstore: Request at most 512 bytes for variable
 names
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 linux-hardening@vger.kernel.org
References: <20240315002616.422802-1-timschumi@gmx.de>
 <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXEvQS8e95A55po-nKn8cGou8Dn9nNhidt_QSqL02WawpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 06:16, Ard Biesheuvel wrote:
> [...]
> As an aside, you really want to avoid EFI pstore in general, and
> specifically on such old systems with quirky UEFI implementations.
>

Hi Ard, this comment made me very curious; apart from old quirky UEFI
implementations, what's the reason you see to avoid using efi-pstore in
general ?

Thanks in advance for your insights!
Cheers,


Guilherme

