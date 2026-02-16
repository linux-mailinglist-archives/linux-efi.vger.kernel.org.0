Return-Path: <linux-efi+bounces-6148-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADEoM+z0kmko0gEAu9opvQ
	(envelope-from <linux-efi+bounces-6148-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 11:43:56 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72147142708
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 905E13006159
	for <lists+linux-efi@lfdr.de>; Mon, 16 Feb 2026 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769D93002B6;
	Mon, 16 Feb 2026 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkjTq3cG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0F2FFF9B
	for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771238632; cv=pass; b=inD+PjCTAEzEohc3nCp91Bfq+/RFbBOxi5pf5pxsd+yquRRjOs38P9iCsc9t2vLicI5rsmMJtE+KVx7LHhpiO5KWbRR2ZIpqhQ3aPKi+F4LxL3fOnArLPxU/2jdLGVFTPdEV1zPuOQIgOXx5pfkU+6lyQPu0d+poRHqXC5uxOL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771238632; c=relaxed/simple;
	bh=NVFYXNZ6okL6YFmTe2rDD9/sBQsf+RLu5VEz9wgQ6IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoXdegH+Q2f5ATjEY9DtxnUPG6VszG+vWgKFGXEC/G4kqXNrX/sco+PUhIz1Ou1CMTh0zW2XDE+Xt7Sd0bzvpAL//FMixW+6f6J9yyghFWkcrWXdLWYiId40ZIB9Kt+k2YayXAtq0NH6WmQlm1wHwymIdj4pKATOug4nCaOuOrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkjTq3cG; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad79df972so2648039d50.1
        for <linux-efi@vger.kernel.org>; Mon, 16 Feb 2026 02:43:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771238630; cv=none;
        d=google.com; s=arc-20240605;
        b=RqOgtqCaI4iI2n4CNjBhTc1w+ZbJ/IWdBjbhqAE8j3Cdthnwwm57SKWqEhy27xKIfk
         HEgR7bPEeLS2N0EyM0pPWj8+X8T/p+kNMySdTQ7qoI+neiKcBAC2EGefoc0zkbNVUcKU
         gEGI/KhD0hZH69QYUdY+Dm1U84RBIXWmiNyxbAy8dNOIil8Mp1R44D9XKChZuH05j/u9
         +vIwAhNhxv3gtTWy6hkFPBYJmxEg1NLSSUpapq73q7uJ0/pw9x6ccoAIC+09nwNJ6qMs
         OfHqQGRF92IF+JUAogDHOP6talO1XpUYpfvv2wyCk0obx0dmwQHISzZT9ZOVEcKDyH4I
         1a6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NVFYXNZ6okL6YFmTe2rDD9/sBQsf+RLu5VEz9wgQ6IQ=;
        fh=ySsE93qgfAfbcsM7sFn8Fb7+jNkCJ6t9FQZfR8sYbfI=;
        b=izR5QC7UhmpFgpCnnM9evm4mv+ErtFDLFqKcL2cXQ+jqaAZ7phzD8moTLZybrRXPga
         jWf+ikJCHobw1+HCmVpVU3y1ddBVmiUSP2ENyTEj8jJjw6ojj/d8umY67u8qomTihUy9
         WyljeHoaBVsD1lXnTQkOFcIAzsN5yt17dxj2eLvt3IkXH39ztB6Ik8H/MOACr1ggNYj6
         3wi9wISxmyT2DtSyTBLgqLHIEn2qf/S8ZVJH66hFAKNIGyxkxCF2ObLGXyqfBNigjbUa
         LYL/GWxp2BlesxWJoYizIKOwfDFteBSH/FGjgfj8cJ0bKqnddUASfCrpagWc64/QPkER
         iwvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771238630; x=1771843430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NVFYXNZ6okL6YFmTe2rDD9/sBQsf+RLu5VEz9wgQ6IQ=;
        b=dkjTq3cGXxwGOHs/qfG/Uirz2hkOi7E8foUIeFVmpW96xswiCHss0Ig5e4DIfY4wG5
         YSyY4xY8azEU9DBhprcXy3w95AsjZkWSV29cwROQpFHg73VRKiJP9T1rYZPDNqNS2QQR
         9KIXw0x9lJ2N862Et7/gkUHkFYDCJ6QCmRwq3dmgLGDRkjx/aM2dpTFNNSYWasz1xg/F
         p9JssPZ0KKSwaLNPAYk44fHM/T4eNHJiG0UKQXsEYCppy/dW0O5/fispgslz/f1O75n7
         MnjXcndqL/UeGtVrD4cqyCBJ5Y1/lYeXib1DujQUxQ06QW3xsbul9R9T+WNkK6OnTv//
         ureQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771238630; x=1771843430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVFYXNZ6okL6YFmTe2rDD9/sBQsf+RLu5VEz9wgQ6IQ=;
        b=mR/NmyvupOMzK8dYQOENr7vxvee+ppt+N827xVcyS+/dV36Z9BFO7vhcBkykVLRa01
         o9Z/T4cRqWpniLeD8T65RlIx1eiSRUKJ/YjBd3CrHUdLG9MnqyOksoTxpwUMyvH1kqmK
         /0wIw0DXlAJEmi5tOQ84tZcaudV1c6LbSPN8uWQEiJsC0gVMxo5HeZHBYlUCrF3GMmB4
         Xp6ofaKBUBByleGECGPHofkaRxrA3WWSR3qy3znqK96G64ILefSvt+Woa4v//CjIY/Wu
         osk5ZYwzRCPM48NFtb74y4aJxfJRpy88jKWREd/uTEOxLEtwlabLc/3wdtb/T8Yy6mzu
         dpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBN3cy1Z/86jLvlkA3Wn230PavS9gy1UFXViAgAXhvxxw3BsR1/HAIR87C0177ZIh4S1ftzn3bxCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt05Yw1moRiBIiGv8b93EkfGoda/5A8DwYjVpF9FQhpdQtMbLg
	jnWehjAdgaOXPXt3eY6+g6y1b7pHkGHz/gkBH/TukbnLosu/kCXwQTMzVANiyLxoocg11jaQU/V
	8pi+VUofQeRPAIj8yIwc9BFsO9X5FznX3qNA7m0CHmQ==
X-Gm-Gg: AZuq6aJORWckShVGwlOiqhdc2POUbRrcjSrNNVr9SBysGgPQ8XaPdPBjY14Cr4iZPQ0
	gbjB0uzPRSkLibGsXkAg8dZYPORE+2U8fzb8c5HzeJik1F6nC69ZUYVZ8crU1cHCVxncz1cDXlJ
	xUHd89xId8fi9dJDNT12UB+QYrtkUPXFvK3AIQ4CW8dNleEGhwlpNy7rxxD+zKTp4zmN165Q2gx
	e1phroeJ0c/1yEjA5o1PzXtrUKCMyVGrAvKU0Q4GPr555Xc7V0TMSn3sCRQ1xeUd5S+bNhkl8HF
	XgXWiB/aFONVPYeqMUKvPFS5JPBz551Kc6axzhW8AkPpc/Rn1Nn6oi/FsPlizSviwtfNaXmDzrt
	xl2fgwqjRJ4A6wcSSmlrwXwYpvV3IWSt12f32wXQKuG8TO2x637LLTfs+4zO7B5EuHNl/ovHwcu
	WqseZVJ7ajnCtRPxVm5IwBKTd0QmZUzeJocg093yjr2uVTKgxdwUay9GUEj8gRnYVqRtYA7ZD5t
	iXp7+7sMvVXDZJod3G+HuezWq+ysckN7eEtwtJgq+xOFzUN6fTE4nF5oEbQqW1r70OsNKhTz69F
	mTJUK62n1JDEEAFl4w7VIVNConUPzXxlVuqTt+I/nP/t
X-Received: by 2002:a05:690e:e85:b0:64a:e9cc:6b79 with SMTP id
 956f58d0204a3-64c21aa6bf8mr5891327d50.40.1771238630231; Mon, 16 Feb 2026
 02:43:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215110628.34293-2-krzysztof.kozlowski@oss.qualcomm.com>
 <CAC_iWjKQA0k+DTFpTDGieCK0qNL3=BCSiOPOtCo5gvdOtXd-cA@mail.gmail.com> <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
In-Reply-To: <25d66619-23a2-4566-bbc3-83be8eae9d46@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Feb 2026 12:43:14 +0200
X-Gm-Features: AZwV_QhZk8Ve-HVG4LywC7DTLkrzaAYTYg65ke5EPTaHQ49aWW-D7iWhOjZaNwY
Message-ID: <CAC_iWjKXcp8mmUaFphHRjJc+n3RNasVi91+_eP-mm3a9pnmYSg@mail.gmail.com>
Subject: Re: [PATCH] efi: stmm: Constify struct efivar_operations
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6148-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilias.apalodimas@linaro.org,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:dkim,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72147142708
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 at 12:33, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> On 16/02/2026 10:49, Ilias Apalodimas wrote:
> > Hi Krzysztof,
> >
> > On Sun, 15 Feb 2026 at 13:06, Krzysztof Kozlowski
> > <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> >>
> >> The 'struct efivar_operations' is not modified by the driver after
> >> initialization, so it should follow typical practice of being static
> >> const for increased code safety and readability.
> >
> > get_maintainers doesn't include me in the cc list?
>
> I use only get_maintainers and as you can see no. You might want to add
> yourself as maintainer of this driver if that's your part. Or have
> korgalore/lei filters.

Hrrm, that's weird. Running it locally returns a more extended list
which includes me and Sumit Garg.
I'll have a look on what's going on.

Thanks
/Ilias
>
> Best regards,
> Krzysztof

