Return-Path: <linux-efi+bounces-2839-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409DCA47A50
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E8D7A0744
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2025 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634C228C99;
	Thu, 27 Feb 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZlOxCYy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91933227EB2
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652182; cv=none; b=mBjmOkc6O8s4i29ve9jdR8wZWUHwmJZPkTviYLG5AmHxxnBXkOmVI/wNYI/CGGz4UEGuQc4Eyy6HKH7PhVzG3TbudUO8wZDkKCUvMRFJR5B6eRweQGTcNuY2EWd2m5D3NgfzvW0VD0NXR2ElHPbEh1GLlV1peMwqqcBFFxAVvvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652182; c=relaxed/simple;
	bh=aQ9w2vqwJpvxqXhWn8pylIr0UfFSffhXnosGhT8iLOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLKQdihiwoWmk7AEgBE+iZTFB2Pvotm6kisyINQdl4boBu1a0uKhbzY+b1KGV6FmkMCIcB8DOVtN4K7GkLB4Gzy/4fp9rPwZ5md47tmFPqgTKtECorxNWOXg+mA0CrWFB6qCLmVosRkcqvTIscq2n8HMczdTytifBNr6l7Jx4Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZlOxCYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02407C4CEE4
	for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740652182;
	bh=aQ9w2vqwJpvxqXhWn8pylIr0UfFSffhXnosGhT8iLOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XZlOxCYy3ufGxVyJ2vPsXjX/XurfP/EURN4rX0Mhd4ye+JyENSifiZCDA5PuUVryJ
	 Q1GArf9a07kV9KzXN5d3FAl0kF8x+RgD6S7xbnC2eYZAkGCqT4l1JCnJMD5Kp4xY7y
	 g0vksc2+oOAAaH9sjcPi4zkbWo+EC5w4HtT+0mIOaftzpBY6hESsw3RtZswLw0k2T9
	 e6kdjCz3v24ztoU+jpBzaY1X9hiSYJt+bwvIuMVyVNmlOI92u6ZrXGdFT4IuIHeOcq
	 q+KCbqjAknjyIaVRLBUN+6IoPu3PYQnxesGC3XCpCHV0rRJlsEy3VocyXs6tK2R+lZ
	 cDm29/mdDZzaQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54605bfcc72so2224223e87.0
        for <linux-efi@vger.kernel.org>; Thu, 27 Feb 2025 02:29:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/qVPeeWSdElGOzgHlFHjcWyl+amJOkyhucdkMy8Y/qjDIpp8o2Jxkfl5XTzi4TWxoGPcdqhd7wuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAcuqsdIJyeny0zyhryXWQYaoj07LSqnrq1em0KLgNWf4Ps/1
	fOw8WxgCCwGl2MBvCQUkRuBq3C1J5GGNZwcINlJ4n/AzsRU7Sy5rHs52RXw1PaYnbn8bCfw2BSv
	uoT+dqSb/ES07sOxb1HReiVYMcz8=
X-Google-Smtp-Source: AGHT+IGPtOot3yAXLwDaCmB+rL2dXfd1qe5vUM+NsanrGMDwgKgyJcuwldZg97DB1iZHgl3MXolsmEIDwn4sMABSTtA=
X-Received: by 2002:ac2:4f03:0:b0:546:1ea9:6230 with SMTP id
 2adb3069b0e04-549432ccb0dmr1004514e87.1.1740652180324; Thu, 27 Feb 2025
 02:29:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <63837c36eceaf8cf2af7933dccca54ff4dd9f30d.camel@HansenPartnership.com>
 <CAMj1kXFqFHZHntOp78wmhpBzTMoCcSQXVDd1yOVv3Z3VpRj0pw@mail.gmail.com> <NIeHAFFHF2oBnFOiEzczq-JCgaJIzUEcexhq-mAxNYqhqxjnFILSFxotUBWDw6n-uOq34hV4hyKOd5BZzFXxQslovRvatHJAjQOK1GiHuqA=@hughsie.com>
In-Reply-To: <NIeHAFFHF2oBnFOiEzczq-JCgaJIzUEcexhq-mAxNYqhqxjnFILSFxotUBWDw6n-uOq34hV4hyKOd5BZzFXxQslovRvatHJAjQOK1GiHuqA=@hughsie.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 27 Feb 2025 11:29:28 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHFgqTZ_ib2QMbPT7aqU0PndYGhX1tz8Qvgp=-imMjSdw@mail.gmail.com>
X-Gm-Features: AQ5f1Jri7Rl9bXDEeYmxWgnM7uQXGVsxVKHlrTt8YvAnK_nJTGOXxWza2SxVnyA
Message-ID: <CAMj1kXHFgqTZ_ib2QMbPT7aqU0PndYGhX1tz8Qvgp=-imMjSdw@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: allow creation of zero length files
To: Richard Hughes <richard@hughsie.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Thursday, 27 February 2025 at 07:54, Ard Biesheuvel <ardb@kernel.org> wrote:
>

> > Thanks James. Mind resending this with a MUA that doesn't mangle patches?
> >

On Thu, 27 Feb 2025 at 09:40, Richard Hughes <richard@hughsie.com> wrote:
>
> Also, a tiny nit -- "fwupd" is the program that actually deploys the capsule updates -- the "LVFS" is just the webservice that vendors upload firmware to. Thanks.
>

Never mind - I fixed up the patch by hand, and replaced LVFS with
fwupd in the commit message.

Unless more time is needed, I will queue the revert of this patch for v6.15

And for the record, I checked the libefivar sources, and there the
problem does not appear to exist.

