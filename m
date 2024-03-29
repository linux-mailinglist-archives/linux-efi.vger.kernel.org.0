Return-Path: <linux-efi+bounces-903-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A93E89261A
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 22:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2231F227C5
	for <lists+linux-efi@lfdr.de>; Fri, 29 Mar 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F2E13B58D;
	Fri, 29 Mar 2024 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ba6mIC6T"
X-Original-To: linux-efi@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBB38FAD;
	Fri, 29 Mar 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711747946; cv=none; b=qtD8R4iMjzQrvkbLwtXs6OkpbkTFaVY8LW90+5laViqwbttwPwefuS/vbsk10PXLq7WzR77ptbhkWv6KjYlW5Xrbt7aVpHmYYOYW6ULBkgJcXjQia6jgZA3nQ/kTg9mSQYqsBqxu8JqF7g1DpClyWte9b2Ahz8/g5olyDsIRVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711747946; c=relaxed/simple;
	bh=03k3/MoIFh20kQtGBfrG86YnFtiVqYH7W4PbBw36ROQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZHe6ic/YTaBiP87rm3cddpkT7UufUSIt4W+nFMjzOYq9pX9ZI4qUbI5DR0rixTZMHLbwPQX+zxy/XFqIUvojlJE3xjuVbOgPHRG3P98VrPKAcO+ZJv7MWHOr8bmA8eb13/+pOf/caaqf8S/fBHyFP+UFn4DET7oON/9Rf5xjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ba6mIC6T; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8dH4O4z+/RT4LVfi/suZsrGaL+23+8UZ0hz47CF7NNQ=; b=ba6mIC6TKKXVH+seYPfBtBkpoW
	Nnd8NycmJb4NqNVriO5DU0gBLuz8SWPPA8cdWVRDzECz6WFHJytH8oAibrT0YMnqPeQGdUhuxAk+P
	IUGgTw9XovMtYInSDRuoCVYv2DljRoBGb+9GdltFN405lHq+LyidyI/E575M4F5M2WtwCT7HXJGbZ
	z4cbLT2LP4NoQHv/sjFY+6C2G8Ino0qsO8p+ALrWCQ/Bv/qDMl9GIHPDVFk4j6T+Q7O8DGe6Os+tq
	pND4MkNzRcf9W8IFJMrOhyJCIZHvS1fenecUwDcN6Fz/oqdpjDRRCfSqz1AxvWGt+IuNytANrdMVz
	CeM2YYzw==;
Received: from 187-26-72-49.3g.claro.net.br ([187.26.72.49] helo=[192.168.224.24])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rqJpi-00Gm6d-MD; Fri, 29 Mar 2024 22:32:19 +0100
Message-ID: <d7561279-0372-d630-3c81-d6bad965a511@igalia.com>
Date: Fri, 29 Mar 2024 18:32:09 -0300
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
 <2a500ade-a91d-15f2-e5ae-7f261e6a84b4@igalia.com>
 <CAMj1kXHEzDzFk+6jo0UNFQ9RptRS==88XjnvxLiZThZAm6pF-A@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXHEzDzFk+6jo0UNFQ9RptRS==88XjnvxLiZThZAm6pF-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 04:34, Ard Biesheuvel wrote:
> [...]
> 
> I'm just not impressed by the general quality of implementations -
> relying on this when the system is going down is a reasonable last
> resort, perhaps, but if other options are available, I'd prioritize
> those.
> 
> And this is for the oops/panic logs only - other uses of pstore seem
> better served with ordinary file based persistence.

OK, I understand now.
Thanks,


Guilherme



